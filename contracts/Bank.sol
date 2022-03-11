pragma solidity 0.8.1;

import "./IBank.sol";
import "./Interest.sol";

contract Bank is IBank, CompoundInterest {
    using SafeMath for uint256;

    function deposit(uint256 amount) override external payable returns (bool) {
        stake(amount);
        emit Deposit(msg.sender, msg.value);
        return true;
    }

    function withdraw(uint256 amount) override external returns (uint256) {
        uint256 amountToWithdraw = amount;
        if (amount == 0) amountToWithdraw = balanceOf(msg.sender);
        exit(amountToWithdraw);
        emit Withdraw(msg.sender, amount);
        return amount.add(earnedByAmount(msg.sender, amountToWithdraw));
    }

    function getBalance() override external view returns (uint256) {
        return balanceOf(msg.sender).add(earned(msg.sender));
    }
}