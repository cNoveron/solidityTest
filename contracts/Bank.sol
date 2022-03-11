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
        uint256 principalToWithdraw = amount;
        uint256 totalToWithdraw = amount.add(rewards[msg.sender]);
        if (amount == 0) {
            principalToWithdraw = balanceOf(msg.sender);
            totalToWithdraw = balanceOf(msg.sender).add(earned(msg.sender));
        }
        exit(principalToWithdraw);
        emit Withdraw(msg.sender, totalToWithdraw);
        return totalToWithdraw;
    }

    function getBalance() override external view returns (uint256) {
        return balanceOf(msg.sender).add(earned(msg.sender));
    }
}