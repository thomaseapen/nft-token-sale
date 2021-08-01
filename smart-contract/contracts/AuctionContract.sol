pragma solidity 0.8.6;

import "./ERC20TestToken.sol";
import "./ERC721TestNFT.sol";


contract AuctionContract{

    address public owner;
    uint public startBlock;
    uint public endBlock;
    string public ipfsHash;
    uint public tokenId;
    
    ERC20TestToken erc20Token;
    ERC721TestNFT erc721NFT;

    address public highestBidderAddress;
    mapping(address => uint256) public fundsByBidder;
    uint public highestBindingBid;
    
    //Flag to allow same smart contract to be reinitialized for another bid
    bool public newAuctionReady = true;

    bool auctionComplete = false;

//Event recording for all bids placed even if they might not be accepted
 event LogBid(address bidder, uint bid, address highestBidder, uint highestBid);


function Auction(address _owner, address erc20TokenAddress, address erc721Address , uint _duration, uint minBid, uint _tokenId) public {
        require(newAuctionReady, "Another Auction in progress");
        require(_duration >= 60, "Duration for Auction cannot be less than a minute") ;
        newAuctionReady = false;
        auctionComplete = false;
        erc20Token = ERC20TestToken(erc20TokenAddress);
        erc721NFT = ERC721TestNFT(erc721Address);
        require(erc721NFT.ownerOf(_tokenId) == _owner, "Token does not belong to owner");
        owner = _owner;
        startBlock = block.timestamp ;
        endBlock = startBlock + _duration;
        highestBindingBid = minBid;
        highestBidderAddress = owner;
        tokenId = _tokenId;
}


function placeBid(uint bidAmount)
        payable
        afterStart
        beforeEnd
        notOwner public
        returns (bool success)
    {
            //Emit the event for logging of bids
            emit LogBid(msg.sender, bidAmount, highestBidderAddress, highestBindingBid);
            require(highestBindingBid < bidAmount, "Bid Lower than or equal to highest bid");
            require(erc20Token.balanceOf(msg.sender) >= bidAmount, "Balance not present");
            //Need to improve using Allowance for approve/allow flows for ERC20 token
            highestBindingBid = bidAmount;
            highestBidderAddress = msg.sender;
            return true;
    }

function endBid()
        isOwner public
        returns(bool success){
            //Transfer money to owner
            erc20Token.transferFrom(highestBidderAddress, owner , highestBindingBid);
            erc721NFT.transferFrom(owner, highestBidderAddress, tokenId);
            auctionComplete = true;
            newAuctionReady = true;
            return true;
        }

modifier afterStart() {
        require(block.timestamp >= startBlock, "Auction not started");
        _;
    }

    modifier beforeEnd(){
        require(block.timestamp <= endBlock, "Auction time ended");
        require(auctionComplete == false, "Auction ended");
        _;
    }

    

    modifier notOwner {
        require(msg.sender != owner, "Owner cannot bid");
        _;
    }

    modifier isOwner {
        require(msg.sender == owner, "Not the owner");
        _;
    }



}