// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface rarity_xp_proxy {
    function spend_xp(uint adventurer, uint amount) external returns (bool);
}

contract xpSpender {
    rarity_xp_proxy _xp;

    constructor(address _xpProxyAddress) {
        _xp = rarity_xp_proxy(_xpProxyAddress);
    }

    function spendXP(uint _summoner, uint256 _amount) external {
        _xp.spend_xp(_summoner, _amount);
    }
}