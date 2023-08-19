pragma solidity ^0.8.0;

contract RiskManagement {
    address public owner;

    struct Risk {
        string description;
        uint256 impact; // 1 to 10 scale
        string mitigationPlan;
    }

    mapping(uint256 => Risk[]) public projectRisks;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addRisk(uint256 _projectIndex, string memory _description, uint256 _impact, string memory _mitigationPlan) public onlyOwner {
        Risk memory newRisk = Risk({
            description: _description,
            impact: _impact,
            mitigationPlan: _mitigationPlan
        });
        projectRisks[_projectIndex].push(newRisk);
    }

    // Additional functions for updating and tracking risks can be added here
}
