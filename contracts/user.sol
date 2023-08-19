pragma solidity ^0.8.0;

contract UserManagement {
    address public owner;

    enum UserRole { None, User, Admin }

    struct UserProfile {
        UserRole role;
        bool exists;
    }

    mapping(address => UserProfile) public users;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createUser(address _userAddress, UserRole _role) public onlyOwner {
        require(!users[_userAddress].exists, "User already exists");
        users[_userAddress] = UserProfile({
            role: _role,
            exists: true
        });
    }

    function updateUserRole(address _userAddress, UserRole _role) public onlyOwner {
        require(users[_userAddress].exists, "User does not exist");
        users[_userAddress].role = _role;
    }

    function getUserRole(address _userAddress) public view returns (UserRole) {
        return users[_userAddress].role;
    }
}
