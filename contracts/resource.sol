pragma solidity ^0.8.0;

contract ResourceAllocation {
    address public owner;

    mapping(uint256 => mapping(uint256 => address[])) public taskResources;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function allocateResources(uint256 _projectIndex, uint256 _taskIndex, address[] memory _resources) public onlyOwner {
        taskResources[_projectIndex][_taskIndex] = _resources;
    }

    // Additional functions for retrieving allocated resources can be added here
}
