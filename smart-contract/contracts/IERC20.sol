pragma solidity 0.8.6;

interface IERC20 {


    function totalSupply() external view  returns (uint256);

    function balanceOf(address account) external view   returns (uint256);

    function transferFrom(address sender, address recipient, uint256 amount) external  payable returns (bool);

   
}