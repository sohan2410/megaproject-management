pragma solidity ^0.8.0;

contract BudgetAndPayment {
    address public owner;

    struct TaskBudget {
        uint256 allocatedBudget; // in wei
        uint256 spentBudget; // in wei
    }

    mapping(uint256 => mapping(uint256 => TaskBudget)) public projectTaskBudgets;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function allocateBudget(uint256 _projectIndex, uint256 _taskIndex, uint256 _budget) public onlyOwner {
        projectTaskBudgets[_projectIndex][_taskIndex].allocatedBudget = _budget;
    }

    function spendBudget(uint256 _projectIndex, uint256 _taskIndex, uint256 _amount) public onlyOwner {
        TaskBudget storage taskBudget = projectTaskBudgets[_projectIndex][_taskIndex];
        require(taskBudget.allocatedBudget >= taskBudget.spentBudget + _amount, "Budget exceeded");
        taskBudget.spentBudget += _amount;
    }

    // Additional functions for managing payments and budget distribution can be added here
}
