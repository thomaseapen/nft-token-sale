pragma solidity 0.8.6;

import './IERC20.sol';
import './SafeMath.sol';

contract ERC20TestToken is IERC20 {


    string public constant name = "ERCTestToken";

    string public constant symbol = "ERCTEST";

    


    mapping(address => uint256) balances;


    mapping(address => mapping (address => uint256)) allowed;


    uint256 totalSupply_ = 10 ether;


    using SafeMath for uint256;


    constructor()  payable{

    balances[msg.sender] = totalSupply_;

    }


    function totalSupply() public override view returns (uint256) {

    return totalSupply_;

    }


    function balanceOf(address tokenOwner) public override view returns (uint256) {

        return balances[tokenOwner];

    }


    function transferFrom(address sender, address receiver, uint256 numTokens) public  payable override returns (bool) {

        require(numTokens <= balances[sender]);

        balances[sender] = balances[sender].sub(numTokens);

        balances[receiver] = balances[receiver].add(numTokens);

        return true;

    }
    
    


    


    

}