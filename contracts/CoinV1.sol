pragma solidity ^ 0.4 .22;


contract CoinV1 {
  string public constant name = "football fantacy coin";
  string public constant symbol = "FFC";

  // decimal units of currency
  uint public constant decimal = 6;

  //total supply of unit
  uint256 public totalSupply;

  //balances of accounts
  mapping(address => uint256) balances;

  constructor(uint256 initialSupply) public {
    totalSupply = initialSupply;

    //add balance to contract creator
    balances[msg.sender] = totalSupply;
  }



  // transfer from calling account to recepient
  event Transfer(address _from, address _to, uint256 _value); // emit the event
  function transfer(address _to, uint256 _value) public returns(bool success) {
    //check if value is less than sender and return false
    if (_value > 0 && _value > balances[msg.sender]) {
      return false;
    }
    //reduce sender balance and add _to balance
    balances[msg.sender] -= _value;
    balances[_to] += _value;



  }


  // anyone can call this constant function to check the balance of tokens for an address
  function balanceOf(address _someone) public view returns(uint256 balance) {
    return balances[_someone];
  }

}
