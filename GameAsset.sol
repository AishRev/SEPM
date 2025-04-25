// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title GameAsset
 * @dev This contract allows the creation and management of NFTs representing game assets.
 */
contract GameAsset is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;
    
    /**
     * @notice Constructor sets the name, symbol, and initial owner
     * @param initialOwner The address that will be the contract owner
     */
    constructor(address initialOwner) ERC721("GameAsset", "GASSET") Ownable(initialOwner) {}

    /**
     * @notice Mints a new NFT representing a game asset
     * @dev Only the contract owner can mint new assets
     * @param to The address receiving the NFT
     * @param tokenURI The metadata URI pointing to the asset
     * @return tokenId The unique ID of the minted asset
     */
    function mintAsset(address to, string memory tokenURI) external onlyOwner returns (uint256) {
        uint256 tokenId = nextTokenId;
        _mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        nextTokenId++;
        return tokenId;
    }

    /**
     * @notice Burns an existing game asset
     * @dev Only the owner of the token can burn it
     * @param tokenId The ID of the token to burn
     */
    function burnAsset(uint256 tokenId) external {
        require(ownerOf(tokenId) == msg.sender, "Not the asset owner");
        _burn(tokenId);
    }
}
