// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./interfaces/IRarity.sol";

contract rarity_xp_proxy {
    rarity constant _rm = rarity(0xce761D788DF608BD21bdd59d6f4B54b2e27F25Bb);
    string constant public name = "Rarity XP Proxy";
    mapping(uint => mapping (address => uint)) public allowance;

    event Approval(uint indexed adventurer, address indexed operator, uint amount);
    
    function _isApprovedOrOwner(uint _summoner) internal view returns (bool) {
        return (_rm.getApproved(_summoner) == msg.sender || _rm.ownerOf(_summoner) == msg.sender);
    }
    
    function isApprovedForAll(address owner) public view returns (bool) {
        return _rm.isApprovedForAll(owner, address(this));
    }

    function approve(uint adventurer, address operator, uint amount) external returns (bool) {
        require(_isApprovedOrOwner(adventurer));
        allowance[adventurer][operator] = amount;

        emit Approval(adventurer, operator, amount);
        return true;
    }

    function spendXp(uint adventurer, uint amount) external returns (bool) {
        address operator = msg.sender;
        uint spenderAllowance = allowance[adventurer][operator];

        if (spenderAllowance != type(uint).max) {
            uint newAllowance = spenderAllowance - amount;
            allowance[adventurer][operator] = newAllowance;

            emit Approval(adventurer, operator, amount);
        }

        _rm.spend_xp(adventurer, amount);
        return true;
    }
}
