// Copyright Peter Robinson 2023
// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import { ImmutableERC721 } from "./token/erc721/preset//ImmutableERC721.sol";


/**
 * Christmas card NFT.
 */
contract XmasERC721 is ImmutableERC721 {
    error NotMintingAnymore();
    error MintedToAddressAlready();

    string public constant NAME = "An Immutable XMAS";
    string public constant SYMBOL = "XMAS";

    bytes32 public constant PAUSER_ROLE = bytes32("PAUSER_ROLE");



    mapping(address => bool) public mintedAlready;

    bool public paused;

    /**
     * @notice 
     * @param _roleAdmin Administrator that configured other roles.
     * @param _mintAdmin Admin that mints tokens.
     * @param _pauserAdmin Admin that pauses minting of new tokens.
     * @param _baseURI The base URI for the collection
     * @param _contractURI The contract URI for the collection
     * @param _operatorAllowlist The address of the operator allowlist
     * @param _royaltyReceiver The address of the royalty receiver
     * @param _feeNumerator The royalty fee numerator
     */
    constructor(
        address _roleAdmin,
        address _mintAdmin,
        address _pauserAdmin,
        string memory _baseURI,
        string memory _contractURI,
        address _operatorAllowlist,
        address _royaltyReceiver,
        uint96 _feeNumerator
    )
        ImmutableERC721(
            _roleAdmin,
            NAME,
            SYMBOL,
            _baseURI,
            _contractURI,
            _operatorAllowlist,
            _royaltyReceiver,
            _feeNumerator
        )
    {
        _grantRole(MINTER_ROLE, _mintAdmin);
        _grantRole(PAUSER_ROLE, _pauserAdmin);
    }


    /**
     * @notice Check before each mint to check that we are still minting and this 
     *    user does not have a token issued yet.
     * @param _from Address to transfer from. Is address(0) if this is a mint.
     * @param _to Address to transfer token to.
     * @ param _firstTokenId Token id to be issued.
     * @ param _batchSize Number of tokens to transfer or mint.
     */
    function _beforeTokenTransfer(address _from, address _to, uint256 /* _firstTokenId */, uint256 /* _batchSize */) internal override virtual {
        if (_from != address(0)) {
            // Not a mint, don't filter.
            return;
        }

        if (paused) {
            revert NotMintingAnymore();
        }

        if (mintedAlready[_to]) {
            revert MintedToAddressAlready();
        }
        mintedAlready[_to] = true;
    }
}
