//SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract RiftersCollection is ERC721, ERC721Enumerable, Pausable, Ownable {
    using Counters for Counters.Counter;
    using Strings for uint256;

    Counters.Counter private _tokenIdCounter;
  string public baseURI;
    string public constant baseExtension = ".json";
     address private owners;
          error RifterCollection__QueryForNonExistentToken();


    constructor() ERC721("RiftersCollection", "RC") {
        safeMint(msg.sender,5);
         owners = msg.sender;
         baseURI ="https://gateway.pinata.cloud/ipfs/Qmcfe1Nrx1oPRwTBX8kaYSPCexaa2xrjof86x9uK793gW2/";
    }

    // function _baseURI() internal pure override returns (string memory) {
    //     return "ipfs://QmNyzQZGn44if9mztYJWMKicLpDcHanLEyppDpBmKsL7JP";
    // }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function safeMint(address to , uint nft) public onlyOwner {
    for(uint i=0 ; i < nft; i++){
            _tokenIdCounter.increment();
         uint256 tokenId = _tokenIdCounter.current();
    
       _safeMint(to, tokenId);
    }
    }
     function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        if (!_exists(tokenId)) revert RifterCollection__QueryForNonExistentToken();

        string memory currentBaseURI = _baseURI();
        return
            bytes(currentBaseURI).length > 0
                ? string(
                    abi.encodePacked(
                        currentBaseURI,
                        tokenId.toString(),
                        baseExtension
                    )
                )
                : "";
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        whenNotPaused
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }
      function claimNFT(
        address from,
        address to,
        uint256 tokenId
    ) public {
        //solhint-disable-next-line max-line-length

        _transfer(from, to, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}