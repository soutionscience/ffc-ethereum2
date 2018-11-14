pragma solidity ^0.4.22;


/// @title this contract manages the various access controll privellages for the fantasy coin contrac
/// @author Rubin Njagi
contract fantasyAccessControl {

  // this faucet controls access  to the Fantasy Football Coin  contracts
  //There are three main roles:
     //     - The CEO: The CEO can reassign other roles and change the addresses of our dependent smart
    //         contracts. It is also the only role that can unpause the smart contract. It is initially
    //         set to the address that created the smart contract in the fantasyCore constructor.
    //
    //     - The CFO: The CFO can withdraw funds from FantasyCore and its auction contracts.
    //
    //     - The COO: The COO can mint new Captains and promptional Items.

       // The addresses of the accounts (or contracts) that can execute actions within each roles.
    address public ceoAddress;
    address public cfoAddress;
    address public cooAddress;

    /// @dev only ceo modifer restricts modification to only ceo
    modifier onlyCEO(){
      require(msg.sender == ceoAddress);
      _;

    }
    /// @dev only CFO modifer. Restricts access to only CFO
    modifier onlyCFO(){
      require(msg.sender == cfoAddress);
      _;
    }
    ///@dev only COO modifer. Restrics access to only COO

    modifier onlyCOO(){
      require(msg.sender == cooAddress);
      _;
    }
    
  ///@dev only an admin. Restrics to only an admin can do this
        modifier onlyAdmin() {
        require(
            msg.sender == cooAddress ||
            msg.sender == ceoAddress ||
            msg.sender == cfoAddress
        );
        _;
    }

    /// @dev Assigns a new address to act as the CEO. Only available to the current CEO.
    /// @param _newCEO The address of the new CEO.

    function setCEO(address _newCEO) public onlyCEO{
      require(_newCEO != address(0));
      ceoAddress = _newCEO;

    }

     /// @dev Assigns a new address to act as the CFO. Only available to the current CFO.
    /// @param _newCFO The address of the new CFO.

    function setCFO(address _newCFO) public onlyCFO{
      require(_newCFO != address(0));
      cfoAddress = _newCFO;
    }
     /// @dev Assigns a new address to act as the COO. Only available to the current CEO.
    /// @param _newCOO The address of the new COO.
    function setCOO(address _newCOO) public onlyCFO{
      require(_newCOO != address(0));
      cooAddress = _newCOO;

    }
        function withdrawBalance() external onlyCFO {
        cfoAddress.transfer(this.balance);
    }

    //update pause later
}
