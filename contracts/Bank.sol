pragma solidity 0.8.1;

import "./IBank.sol";
import "./Interest.sol";

contract Bank is IBank, CompoundInterest {

    function deposit(uint256 amount) external payable returns (bool) {
        stake(amount);
        emit Deposit(msg.sender, msg.value);
        return true;
    }

    function withdraw(uint256 amount) external returns (uint256) {
        uint256 amountToWithdraw = amount;
        if (amount == 0) amountToWithdraw = balanceOf(msg.sender);
        exit(amountToWithdraw);
        emit Withdraw(msg.sender, msg.value);
        return earnedByAmount(msg.sender, amountToWithdraw);
    }

    function getBalance() external view returns (uint256) {
        return earned(msg.sender);
    }
}