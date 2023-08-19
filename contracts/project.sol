pragma solidity ^0.8.0;

contract ProjectCreation {
    address public owner;

    struct Task {
        string name;
        uint256 duration; // in hours
        uint256 startTime;
        uint256[] dependencies;
        address[] resources;
    }

    struct Milestone {
        string name;
        uint256 timestamp;
        bool reached;
    }

    struct Project {
        string projectName;
        Task[] tasks;
        Milestone[] milestones;
    }

    Project[] public projects;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createProject(string memory _projectName) public onlyOwner {
        Project memory newProject;
        newProject.projectName = _projectName;
        projects.push(newProject);
    }

    function addTask(uint256 _projectIndex, string memory _taskName, uint256 _duration, uint256[] memory _dependencies) public onlyOwner {
        Project storage project = projects[_projectIndex];
        Task memory newTask = Task({
            name: _taskName,
            duration: _duration,
            startTime: 0,
            dependencies: _dependencies,
            resources: new address[](0)
        });
        project.tasks.push(newTask);
    }

    function addMilestone(uint256 _projectIndex, string memory _milestoneName, uint256 _timestamp) public onlyOwner {
        Project storage project = projects[_projectIndex];
        Milestone memory newMilestone = Milestone({
            name: _milestoneName,
            timestamp: _timestamp,
            reached: false
        });
        project.milestones.push(newMilestone);
    }

    function allocateResource(uint256 _projectIndex, uint256 _taskIndex, address _resource) public onlyOwner {
        Project storage project = projects[_projectIndex];
        Task storage task = project.tasks[_taskIndex];
        task.resources.push(_resource);
    }

    // Additional functions for updating task status, milestone completion, and more can be added here
}
