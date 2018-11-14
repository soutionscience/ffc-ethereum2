pragma solidity ^ 0.4.22;
//factory to create multiple leagues
import "./League.sol";

contract leagueFactory is League{
    address[] public deployedLeagues;
    
    function deployLeague() public{
        var newLeague = new League(msg.sender);
        deployedLeagues.push(newLeague);
        
    }
    function GetAllLeagues() public view returns (address[]){
        return deployedLeagues;
    }
}