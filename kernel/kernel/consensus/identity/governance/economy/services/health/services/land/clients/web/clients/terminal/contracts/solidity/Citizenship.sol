// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.20;

/// @title Citizenship
/// @notice Onboards citizens via bond deposit + covenant
contract Citizenship {
    address public governor;
    mapping(address => bool) public citizens;
    uint256 public constant BOND_AMOUNT = 100 * 1e18; // 100 DNET

    event CitizenOnboarded(address indexed citizen, uint256 timestamp);

    constructor() {
        governor = msg.sender;
    }

    /// @notice Become a citizen by locking bond
    /// @dev Reverts if already citizen or insufficient bond
    function onboard() external payable {
        require(msg.value >= BOND_AMOUNT, "Bond too low");
        require(!citizens[msg.sender], "Already citizen");
        citizens[msg.sender] = true;
        emit CitizenOnboarded(msg.sender, block.timestamp);
    }
}
