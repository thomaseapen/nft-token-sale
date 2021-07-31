pragma solidity 0.8.6;
library SafeMath {

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {

      assert(b <= a);

      return a - b;

    }


    function add(uint256 a, uint256 b) internal pure returns (uint256) {

      uint256 c = a + b;

      assert(c >= a);

      return c;

    }

}