// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/XmasERC721.sol";
import "../src/allowlist/OperatorAllowlist.sol";

contract XmasERC721Test is Test {
    error NotMintingAnymore();
    error MintedToAddressAlready();

    XmasERC721 public xmasNFT;

    address public roleAdmin = makeAddr("role");
    address public minterAdmin = makeAddr("minter");
    address public pauserAdmin = makeAddr("pauser");
    address public player1 = makeAddr("player1");
    string public baseURI = "";
    string public contractURI = "";
    OperatorAllowlist public operatorAllowlist;
    address public royaltyReceiver = makeAddr("royalty");
    uint96 public feeNumerator = 2000;


    function setUp() public {

        operatorAllowlist = new OperatorAllowlist(roleAdmin);

        xmasNFT = new XmasERC721(
            roleAdmin,
            minterAdmin,
            pauserAdmin,
            baseURI,
            contractURI,
            address(operatorAllowlist),
            royaltyReceiver,
            feeNumerator
        );
    }

    function testMint() public {
        vm.prank(minterAdmin);
        xmasNFT.mint(player1, 0);
        assertEq(xmasNFT.balanceOf(player1), 1);
    }

    function testMintNotTwice() public {
        vm.prank(minterAdmin);
        xmasNFT.mint(player1, 0);
        vm.expectRevert(MintedToAddressAlready.selector);
        vm.prank(minterAdmin);
        xmasNFT.mint(player1, 1);
    }

    function testPause() public {
        vm.prank(pauserAdmin);
        xmasNFT.pause();
        vm.expectRevert(NotMintingAnymore.selector);
        vm.prank(minterAdmin);
        xmasNFT.mint(player1, 0);
    }

    function testUnPause() public {
        vm.prank(pauserAdmin);
        xmasNFT.pause();
        vm.prank(pauserAdmin);
        xmasNFT.unpause();
        vm.prank(minterAdmin);
        xmasNFT.mint(player1, 0);
    }
}
