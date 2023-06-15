// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

// The contract inherits the ERC20Pausable and AccessControl contracts
contract BrutToken is ERC20Pausable, AccessControl {
    using SafeMath for uint256;

    // Defines role for minting tokens
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    
    // Defines maximum supply of the token - 1 million
    uint256 public constant MAX_SUPPLY = 1000000 * 10 ** 18;
    
    // Constructor function sets the token name and token symbol
    // It also assigns the initial roles and mints the initial supply of tokens to the creator
    constructor() ERC20("Brut Token", "MTK") {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(MINTER_ROLE, msg.sender);
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    // Function to pause all token transfers
    // Can only be called by an account with the DEFAULT_ADMIN_ROLE
    function pause() public {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Not authorized");
        _pause();
    }

    // Function to unpause all token transfers
    // Can only be called by an account with the DEFAULT_ADMIN_ROLE
    function unpause() public {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Not authorized");
        _unpause();
    }

    // Function to mint new tokens
    // Can only be called by an account with the MINTER_ROLE
    // Total supply must not exceed MAX_SUPPLY after minting
    function mint(address to, uint256 amount) public {
        require(hasRole(MINTER_ROLE, msg.sender), "Not authorized");
        require(totalSupply().add(amount) <= MAX_SUPPLY, "Minting would exceed max supply");
        _mint(to, amount);
    }

    // Function to burn tokens from caller's balance
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }
}
