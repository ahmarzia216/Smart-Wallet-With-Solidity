// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract consumer{
    function deposit() payable public {}
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}

contract Smartwallet{
    address payable public owner;
    mapping( address=> uint ) public  allowance;
    mapping(address => bool) public isallowed;
    mapping (address=> bool) public guardians;
    address payable nextowner;
    mapping (address=>mapping (address=> bool)) nextownerguardian;
    uint guardiancount;
    uint public constant confirmationsFromGuardiansForReset = 3;

    constructor(){
        owner = payable (msg.sender);
    }
    receive() external payable { }

    function setGuardians(address _guardian, bool _isguardian) public {
        require( msg.sender == owner,"You are not the owner, Aborting");
        guardians[_guardian] = _isguardian;

    }
    function setNewOwner(address payable  _newowner) public {
        require(guardians[msg.sender],"You are not guardian, aborting");
        require(nextownerguardian[_newowner][msg.sender] == false,"You already entered, aborting");
        if(_newowner != nextowner){
            nextowner = _newowner;
            guardiancount = 0;
    }  
            guardiancount++;
    }
    function setAllowance(address _person, uint _amount) public {
        require( msg.sender == owner,"You are not the owner, Aborting");
        allowance[_person] = _amount;
        if(_amount > 0){
            isallowed[_person] = true;
        }
        else isallowed[_person] = false;
    }

    function transfer(address payable _to, uint _amount,bytes memory _payload) public returns(bytes memory) {
      //  require(msg.sender == owner,"You are not owner, aborting");
        if(msg.sender != owner){
            require(allowance[msg.sender] >= _amount,"You are not able to send more then you allowed, Aborting");
            require(isallowed[msg.sender] ,"You are not allowd,Aborting");
            allowance[msg.sender] -= _amount;
        }

        (bool success, bytes memory returndata)= _to.call{value:_amount}(_payload);
        require(success,"Not successfull , aborting");
        return returndata;
    }
}