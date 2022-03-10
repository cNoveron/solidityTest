pragma solidity 0.8.0;

import "./IBank.sol";
import "./Interest.sol";

contract Bank is IBank, CompoundInterest {

    function deposit(uint256 amount) external payable returns (bool);

    function withdraw(uint256 amount) external returns (uint256);

    function getBalance() external view returns (uint256);
}