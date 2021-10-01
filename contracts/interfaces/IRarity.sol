// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

interface IRarity {
    function getApproved(uint) external view returns (address);
    function spend_xp(uint _summoner, uint _xp) external;
    function isApprovedForAll(address owner, address operator) external view returns (bool);
    function ownerOf(uint256 tokenId) external view returns (address owner);
}