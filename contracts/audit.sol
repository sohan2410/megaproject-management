pragma solidity ^0.8.0;

contract AuditAndCompliance {
    address public owner;

    struct ActionLog {
        uint256 timestamp;
        string action;
        address user;
    }

    mapping(uint256 => ActionLog[]) public projectLogs;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function logAction(uint256 _projectIndex, string memory _action, address _user) public onlyOwner {
        ActionLog memory newAction = ActionLog({
            timestamp: block.timestamp,
            action: _action,
            user: _user
        });
        projectLogs[_projectIndex].push(newAction);
    }

    // Additional functions for retrieving logs and compliance checking can be added here
}
