pragma solidity ^0.8.0;

contract DisputeResolution {
    address public owner;

    struct Dispute {
        string description;
        address initiator;
        address resolver;
        bool resolved;
    }

    mapping(uint256 => Dispute[]) public projectDisputes;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function initiateDispute(uint256 _projectIndex, string memory _description) public {
        Dispute memory newDispute = Dispute({
            description: _description,
            initiator: msg.sender,
            resolver: address(0),
            resolved: false
        });
        projectDisputes[_projectIndex].push(newDispute);
    }

    function resolveDispute(uint256 _projectIndex, uint256 _disputeIndex, address _resolver) public onlyOwner {
        Dispute storage dispute = projectDisputes[_projectIndex][_disputeIndex];
        require(!dispute.resolved, "Dispute already resolved");
        dispute.resolved = true;
        dispute.resolver = _resolver;
    }

    // Additional functions for retrieving disputes and dispute details can be added here
}
