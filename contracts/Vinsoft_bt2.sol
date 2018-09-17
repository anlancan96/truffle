pragma solidity ^0.4.18;

library SafeMath {
    function add(uint a, uint b) internal pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }
    function sub(uint a, uint b) internal pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }
    function mul(uint a, uint b) internal pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }
    function div(uint a, uint b) internal pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}

contract Vinsoft_bt2 {
    using SafeMath for *;
     
    struct Zombie {
        string name;
        uint DNA;
        uint level;
        uint readyTime;
        uint winCount;
        uint lossCount;
    }

    mapping(address => mapping(uint8 => Zombie)) myZombie;
    mapping(address => uint8) numberOfZomibe;
    mapping(address => uint) balances;

    function random() private view returns (uint8) {
       return uint8(uint256(keccak256(block.timestamp, block.difficulty))%251);
    }

    function newZombie (string _name, uint _readyTime) public {
        numberOfZomibe[msg.sender] += 1;
        var index = numberOfZomibe[msg.sender];
        myZombie[msg.sender][index].name = _name;
        myZombie[msg.sender][index].DNA = random();
        myZombie[msg.sender][index].level = 1;
        myZombie[msg.sender][index].winCount = 0;
        myZombie[msg.sender][index].lossCount = 0;
        myZombie[msg.sender][index].readyTime = _readyTime;
    }
    
    function countZombie (address _addr) public view returns (uint8) {
        return numberOfZomibe[_addr];
    }
    
    
    function isReadyAttack(address _addr, uint8 _index) public view returns (bool) {
        if(now < myZombie[_addr][_index].readyTime) {
            return true;
        } else {
            return false;
        }
    }
    
    function modifierNameMyZomibe (address _addr, uint8 _index, string _name) public {
        myZombie[msg.sender][_index].name = _name;
    }
    
    
    function modifierDNAMyZomibe (address _addr, uint8 _index, uint _DNA) public {
        myZombie[msg.sender][_index].DNA = _DNA;
    }
    
    function mixMyZomibeToNewZombie (address _addr, uint8 _index1, uint8 _index2) public {
        myZombie[msg.sender][_index1].DNA = myZombie[msg.sender][_index1].DNA.add(myZombie[msg.sender][_index2].DNA);
        myZombie[msg.sender][_index1].level = myZombie[msg.sender][_index1].level.add(myZombie[msg.sender][_index2].level);
        myZombie[msg.sender][_index1].winCount = myZombie[msg.sender][_index1].winCount.add(myZombie[msg.sender][_index2].winCount);
        myZombie[msg.sender][_index1].lossCount = myZombie[msg.sender][_index1].lossCount.add(myZombie[msg.sender][_index2].lossCount);
        delete myZombie[msg.sender][_index2];
    }
    
    function increaseLevelMyZombie (address _addr, uint8 _index, uint _value) public payable {
        require(_value > 0 && balances[_addr] >= _value );
        myZombie[_addr][_index].level = myZombie[_addr][_index].level.add(1);
        balances[_addr] = balances[_addr].sub(_value);
    }
    
    
    function infoZombie (address _addr, uint8 _index) public view returns(string, uint, uint, uint, uint, uint) {
        return
            (
                myZombie[_addr][_index].name, 
                myZombie[_addr][_index].DNA, 
                myZombie[_addr][_index].level, 
                myZombie[_addr][_index].winCount, 
                myZombie[_addr][_index].lossCount, 
                myZombie[_addr][_index].readyTime
            );
    }
    
    
    function listOfMyZombie (address _addr) public view returns(uint256[] memory arr) {
        var count = numberOfZomibe[_addr];
        for(uint8 i = 0; i <= count; i++) {
            arr[i] = i;
        }
        
        return arr;
    }
}