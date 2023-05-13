//SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract NFTStaking is IERC721Receiver {
//  uint256 day = 86400 ;
  uint256 day = 60 ;
 
 uint256 public totalStaked;
 mapping(address => uint256) public stakingTime;    

  // struct to store a stake's token, owner, and earning values
  struct Stake {
    address owner;
    uint24 tokenId;
    uint48 timestamp;
    uint24 time;
  }

  event NFTStaked(address owner, uint256 tokenId, uint256 value);
  event NFTUnstaked(address owner, uint256 tokenId, uint256 value);
  // event Claimed(address owner, uint256 amount);

  // reference to the Block NFT contract
  ERC721Enumerable nft;

  // maps tokenId to stake
  mapping(uint256 => Stake) public vault; 

   constructor(ERC721Enumerable _nft) { 
    nft = _nft;
  }

  function stake(uint256 tokenId, uint24 time) public {

      require(nft.ownerOf(tokenId) == msg.sender, "not your token");
      require(vault[tokenId].tokenId == 0, 'already staked');
      nft.transferFrom(msg.sender, address(this), tokenId);
      emit NFTStaked(msg.sender, tokenId, block.timestamp);
      totalStaked ++;

      vault[tokenId] = Stake({
        owner: msg.sender,
        tokenId: uint24(tokenId),
        timestamp: uint48(block.timestamp),
        time: uint24(time)
      });
 
  }
 
  function unstake(address account, uint256 tokenId) public {
   
      Stake memory staked = vault[tokenId];
      require(staked.owner == msg.sender, "not an owner");
     require(staked.time * day + staked.timestamp < block.timestamp, "Your Unstaking Time is Not Complete");
     delete vault[tokenId];
           totalStaked --;

      emit NFTUnstaked(account, tokenId, block.timestamp);
      nft.transferFrom(address(this), account, tokenId);
    
  }



  // should never be used inside of transaction because of gas fee
  function balanceOf(address account) public view returns (uint256) {
    uint256 balance = 0;
    uint256 supply = nft.totalSupply();
    for(uint i = 1; i <= supply; i++) {
      if (vault[i].owner == account) {
        balance += 1;
      }
    }
    return balance;
  }

  // should never be used inside of transaction because of gas fee
  function tokensOfOwner(address account) public view returns (uint256[] memory ownerTokens) {

    uint256 supply = nft.totalSupply();
    uint256[] memory tmp = new uint256[](supply);

    uint256 index = 0;
    for(uint tokenId = 1; tokenId <= supply; tokenId++) {
      if (vault[tokenId].owner == account) {
        tmp[index] = vault[tokenId].tokenId;
        index +=1;
      }
    }

    uint256[] memory tokens = new uint256[](index);
    for(uint i = 0; i < index; i++) {
      tokens[i] = tmp[i];
    }

    return tokens;
  }

  function onERC721Received(
        address,
        address from,
        uint256,
        bytes calldata
    ) external pure override returns (bytes4) {
      require(from == address(0x0), "Cannot send nfts to Vault directly");
      return IERC721Receiver.onERC721Received.selector;
    }
  
}