pragma solidity 0.8.6 ;

/**
 * @dev ERC-721 non-fungible token standard.

 */
interface IERC721
{

  function transferFrom(
    address _from,
    address _to,
    uint256 _tokenId
  )
    external;

  
  
  function balanceOf(
    address _owner
  )
    external
    view
    returns (uint256);

 
  function ownerOf(
    uint256 _tokenId
  )
    external
    view
    returns (address);

 

 
}