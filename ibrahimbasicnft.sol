// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract IbrahimNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor(address initialOwner) ERC721("IbrahimNFT", "IBN") Ownable(initialOwner) {}

    // 🧩 Base URI — folder containing your metadata files
    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/bafybeibx3dieo6tb6yygcelgsu4ebcrlmh7ckas7sdle3ixpxn6uk7syfi/";
    }

    // 🪙 Mint NFTs
    function mintNFT(address recipient, uint256 numberOfTokens) public onlyOwner {
        for (uint256 i = 1; i <= numberOfTokens; i++) {
            _tokenIds.increment();
            uint256 newItemId = _tokenIds.current();

            _safeMint(recipient, newItemId);

            // ✅ Only add the filename and .json, not the whole base URI again
            string memory newTokenURI = string(abi.encodePacked(Strings.toString(newItemId), ".json"));
            _setTokenURI(newItemId, newTokenURI);
        }
    }
}
