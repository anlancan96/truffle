pragma solidity ^0.4.18;

contract Vinsoft_bt01 {
    address public myAddress;
    string public name;
    uint8 public age;

    constructor(string _name, uint8 _age) {
        name = _name;
        age = _age;
        myAddress = msg.sender;
    }
    
    function getInfomation() public view returns (address _addr, string _name, uint8 _age) {
        return (myAddress, name, age);
    }

    modifier requireOwner {
        require(msg.sender == myAddress, "not owner");
        _;
    }

    function setMyInfomation (string _name, uint8 _age) public requireOwner {
        name = _name;
        age = _age;
    }
}