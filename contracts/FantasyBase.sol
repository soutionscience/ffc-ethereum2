pragma solidity ^0.4.22;

import './fantasyAccessControl.sol';

/// @title Base contract for Football Fanatsy Coins. Holds all common structs, events and base variables.
/// @author Rubin Njagi


contract FantasyBase is fantasyAccessControl {


  //event transfer is called anytime a player is traded or bought or ownership of player is transfered
  event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

  //event create is called after new player is created
  event Create(address indexed onwer, uint256 playerId);

  struct Player{
    string name;
  }
 Player [] players;

  //maping from player id to user address. All players have associated user id. New ones have 0 address
  mapping (uint256 => address) public playerIndexToUser;

      // @dev A mapping from owner address to count of tokens that address owns.
    //  Used internally inside balanceOf() to resolve ownership count.
    mapping (address => uint256) ownershipTokenCount;

  //add playerId to approval mapping. A mapping from PlayerIDs to an address that has been approved to call
    ///  transferFrom().


 // transfer ownership of specific player to user address.
 function transfer(address _from, address _to, uint256 _tokenId) internal{

   ownershipTokenCount[_to]++;
 //transfer to owner
   playerIndexToUser[_tokenId] = _to;
    // When creating new players _from is 0x0, but we can't account that address.
    if(_from != address(0)){
      ownershipTokenCount[_from]--;

    }

 Transfer(_from, _to, _tokenId);
 }
 function _createPlayer(string _name, address _owner) internal returns (uint){
   Player memory _player = Player({
       name: _name

   });
   uint256 newPlayerId = players.push(_player) -1;

   //emit transfer of new kittie
  emit Create(_owner, newPlayerId);
   emit  Transfer(0, _owner, newPlayerId);
   return newPlayerId;

 }


}
