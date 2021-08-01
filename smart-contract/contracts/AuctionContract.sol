pragma solidity 0.8.6;

import "./ERC20TestToken.sol";
import "./ERC721TestNFT.sol";


contract AuctionContract{

    address public owner;
    uint public startBlock;
    uint public endBlock;
    string public ipfsHash;
    uint public bidIncrement;

    ERC20TestToken erc20Token;
    ERC721TestNFT erc721NFT;

    address public highestBidder;
    mapping(address => uint256) public fundsByBidder;
    uint public highestBindingBid;

    bool auctionComplete = false;





function Auction(address _owner, address erc20TokenAddress, address erc721Address , uint _startBlock, uint _endBlock) public {
        require(_startBlock >= _endBlock, "Start time cannot be more than end time") ;
        require (_startBlock < block.number, "Invalid start time") ;
        require (_owner == address(0), "Invalid Owner") ;
        erc20Token = ERC20TestToken(erc20TokenAddress);
        erc721NFT = ERC721TestNFT(erc721Address);
        owner = _owner;
        startBlock = _startBlock;
        endBlock = _endBlock;
}


function placeBid()
        payable
        afterStart
        beforeEnd
        notOwner public
        returns (bool success)
    {
            //Implementation to be added
            return true;
    }

function endBid()
        isOwner public
        returns(bool success){
            auctionComplete = true;
            return true;
        }

modifier afterStart() {
        require(block.number < startBlock, "Auction not started");
        _;
    }

    modifier beforeEnd(){
        require(block.number > endBlock, "Auction time ended");
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