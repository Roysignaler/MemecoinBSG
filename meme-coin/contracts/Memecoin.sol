// SPDX-License-Identifier: GPL-3.0
// Specifies the license type for the contract
pragma solidity ^0.8.0;
// Specifies the compiler version to be used

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// Imports the ERC20 token standard from the OpenZeppelin library
import "@openzeppelin/contracts/access/Ownable.sol";
// Imports the Ownable contract from the OpenZeppelin library
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
// Imports the ERC20Burnable contract from the OpenZeppelin library

contract MemeCoin is ERC20, Ownable, ERC20Burnable {
    // Defines the MemeCoin contract as a subclass of ERC20, Ownable, and ERC20Burnable
    event tokensBurned(address indexed owner, uint256 amount, string message);
    // Event emitted when tokens are burned
    event tokensMinted(address indexed owner, uint256 amount, string message);
    // Event emitted when tokens are minted
    event additionalTokensMinted(
        address indexed owner,
        uint256 amount,
        string message
    );
    // Event emitted when additional tokens are minted

    constructor() ERC20("FoxCoin", "FXC") {
        // Constructor that initializes the token name and symbol, and mints an initial supply of tokens
        _mint(msg.sender, 1000 * 10 ** decimals());
        // Mints 1000 tokens and assigns them to the contract deployer's address
        emit tokensMinted(
            msg.sender,
            1000 * 10 ** decimals(),
            "Initial supply of tokens minted."
        );
        // Emits an event indicating that the initial tokens were minted
    }

    function mint(address to, uint256 amount) public onlyOwner {
        // Function to mint additional tokens
        _mint(to, amount);
        // Mints the specified amount of tokens and assigns them to the provided address
        emit additionalTokensMinted(
            msg.sender,
            amount,
            "Additional tokens minted."
        );
        // Emits an event indicating that additional tokens were minted
    }

    function burn(uint256 amount) public override onlyOwner {
        // Function to burn tokens
        _burn(msg.sender, amount);
        // Burns the specified amount of tokens from the contract deployer's address
        emit tokensBurned(msg.sender, amount, "Tokens burned.");
        // Emits an event indicating that tokens were burned
    }
}
