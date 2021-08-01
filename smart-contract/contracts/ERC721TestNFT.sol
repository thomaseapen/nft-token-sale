pragma solidity 0.8.6 ;

import './IERC721.sol';
import './SafeMath.sol';

contract ERC721TestNFT is IERC721{

    string private _name;
    string private _symbol;
    
 mapping (uint256 => address) internal nftIdOwnerMapping;    

 mapping (address => uint256) private ownerNFTokenCount;

 modifier validNFToken(
    uint256 _tokenId
  )
  {
    require(nftIdOwnerMapping[_tokenId] != address(0), "INVALID NFT");
    _;
  }

  constructor () public {
        _name = "TestNFT";
        _symbol = "TNFT";
 }

 function transferFrom(
    address _from,
    address _to,
    uint256 _tokenId
  )
    external
    override
    validNFToken(_tokenId)
  {
    address tokenOwner = nftIdOwnerMapping[_tokenId];
    require(tokenOwner == _from, "INCORRECT OWNER");
    require(_to != address(0), "ADDRESS NOT FOUND");

    _transfer(_to, _tokenId);
  }

  function _transfer(
    address _to,
    uint256 _tokenId
  )
    internal
  {
    address from = nftIdOwnerMapping[_tokenId];
    _removeNFToken(from, _tokenId);
    _addNFToken(_to, _tokenId);

  }

  function _removeNFToken(
    address _from,
    uint256 _tokenId
  )
    internal
    virtual
  {
    require(nftIdOwnerMapping[_tokenId] == _from, "INCORRECT OWNER");
    ownerNFTokenCount[_from] -= 1;
    delete nftIdOwnerMapping[_tokenId];
  }


  function _addNFToken(
    address _to,
    uint256 _tokenId
  )
    internal
    virtual
  {
    require(nftIdOwnerMapping[_tokenId] == address(0), "NFT DOES NOT EXISTS OR IS OWNED BY SOMEONE ELSE");

    nftIdOwnerMapping[_tokenId] = _to;
    ownerNFTokenCount[_to] += 1;
  }

   function _getOwnerNFTCount(
    address _owner
  )
    internal
    virtual
    view
    returns (uint256)
  {
    return ownerNFTokenCount[_owner];
  }


   function balanceOf(
    address _owner
  )
    external
    override
    view
    returns (uint256)
  {
    require(_owner != address(0), "ADDRESS NOT FOUND");
    return _getOwnerNFTCount(_owner);
  }

  function _addTokenTo(address to, uint256 tokenId) internal {
    require(nftIdOwnerMapping[tokenId] == address(0));
    nftIdOwnerMapping[tokenId] = to;
    ownerNFTokenCount[to] += 1;
}



    function ownerOf(
    uint256 _tokenId
  )
    external
    override
    view
    returns (address _owner)
  {
    _owner = nftIdOwnerMapping[_tokenId];
    require(_owner != address(0), "NFT DOES NOT EXISTS");
  }

  function _mint(address to, uint256 tokenId)  public payable{
    require(to != address(0), "INVALID ADDRESS");
    require(nftIdOwnerMapping[tokenId] == address(0), "NFT EXISTS");
    _addTokenTo(to, tokenId);
}



    
}