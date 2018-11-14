pragma solidity ^0.4.22;
import './coinV1.sol';


contract coinV2 is CoinV1 {
    //Allowances
  //two dimensional associative array
  //index-1 = owner account,  index-2 = spender account

   mapping(address=>mapping(address=> uint256)) allowances;

  constructor(uint intSupply) CoinV1(intSupply) {

        // constructor
    // we have invoked the constructor for the V1, so we are good
  }


  function allowance(address _owner, address _spender) view returns(uint remainig){
      // return the allowance for _spender approved by _owner
      return allowances[_owner][_spender];

  }
  //add approval event
  event Approval(address indexed_owner, address indexed_spender, uint256 _value);

  //approve other address to spend
  function approve(address _spender, uint256 _value) returns(bool success) {
    if(_value <= 0) return false;

    //add allowance to toble
    allowances[msg.sender][_spender] = _value;

    //emit approve event
    emit Approval(msg.sender, _spender, _value);


  }
  function transferFrom(address _from, address _to, uint256 _value)public returns(bool success){
    //check if value is greater than 0
    if(_value <= 0) return false;
    //check if spender is allowed to spend

    if(allowances[_from][msg.sender] < _value) return false;
    // if there are enough tokens from authority

    if(balances[_from] < _value) return false;

    //reduce balance
    balances[_from] -= _value;

    //add balance to spenders wish
    balances[_to] += _value;

    //reduce the allowance 
    allowances[_from][msg.sender] -= _value;

    //emit event
    emit Transfer(_from, _to, _value);


  }
}
