pragma solidity ^0.8.0;

contract TaskManagement {
    address public owner;

    enum TaskStatus { NotStarted, InProgress, Completed }

    struct Task {
        string name;
        address assignedTo;
        uint256 duration; // in hours
        uint256 startTime;
        TaskStatus status;
        uint256[] dependencies;
    }

    Task[] public tasks;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createTask(string memory _taskName, address _assignedTo, uint256 _duration, uint256[] memory _dependencies) public onlyOwner {
        Task memory newTask = Task({
            name: _taskName,
            assignedTo: _assignedTo,
            duration: _duration,
            startTime: 0,
            status: TaskStatus.NotStarted,
            dependencies: _dependencies
        });
        tasks.push(newTask);
    }

    function updateTaskStatus(uint256 _taskIndex, TaskStatus _status) public onlyOwner {
        require(_taskIndex < tasks.length, "Task index out of bounds");
        tasks[_taskIndex].status = _status;
        if (_status == TaskStatus.InProgress) {
            tasks[_taskIndex].startTime = block.timestamp;
        }
    }

    function completeTask(uint256 _taskIndex) public onlyOwner {
        require(_taskIndex < tasks.length, "Task index out of bounds");
        tasks[_taskIndex].status = TaskStatus.Completed;
    }

    // Additional functions for assigning tasks, checking dependencies, and more can be added here
}
