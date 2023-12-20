// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/XmasERC721.sol";

contract XmasERC721Test is Test {
    XmasERC721 public counter;

    function setUp() public {
        counter = new XmasERC721();
//        counter.setNumber(0);
    }

    function testIncrement() public {
        // counter.increment();
        // assertEq(counter.number(), 1);
    }

    function testSetNumber(uint256 x) public {
        // counter.setNumber(x);
        // assertEq(counter.number(), x);
    }
}
