# BrutToken - An ERC20 Token with a Limited Supply

This repository contains the Solidity smart contract code for "MyToken", an ERC20 token that has been built on the Celo blockchain. 

## Design Choices 

This contract inherits from the `ERC20Pausable` and `AccessControl` contracts from OpenZeppelin, which are standard for secure smart contract development. 

The `ERC20Pausable` contract allows pausing of token transfers, which can be useful for various reasons, including during an initial coin offering (ICO), or in case a bug or exploit is discovered.

The `AccessControl` contract provides a system of access control which can be used for fine-grained permissions. In this case, it has been used to restrict minting privileges to addresses with the `MINTER_ROLE`. 

The token has a maximum supply limit of 1 million tokens. The `mint` function checks that this limit is not exceeded.

The `burn` function has been added to allow users to destroy their tokens if they wish. This function reduces the total supply of the token.

## How to Test

After cloning this repository and deploying the contract to your local blockchain or testnet, you can test each function as follows:

- **constructor**: After deployment, check that the contract creator has the total supply of 1 million tokens in their balance. You can also verify that the token name, symbol, and decimal values are correctly set.

- **pause** and **unpause**: Try calling these functions from accounts with and without the `DEFAULT_ADMIN_ROLE`. When the contract is paused, all token transfers should fail, and when it's unpaused, transfers should succeed.

- **mint**: Try minting tokens from an account with the `MINTER_ROLE`. Ensure that minting is not allowed that would result in total supply exceeding the maximum limit. Also, try minting from an account without the `MINTER_ROLE` and make sure it fails.

- **burn**: Try burning tokens from various accounts. Check that the token balance and total supply decrease appropriately. Ensure that burning more tokens than an account balance should fail.

Remember to run these tests using a suite like Truffle or Hardhat. The tests can be written in Javascript using the web3.js or ethers.js libraries, which allow you to interact with your contract. You could also use [Remix](https://remix.ethereum.org/) to deploy and test the contract.

**Note**: Real assets on a blockchain require extreme care and extensive testing. This repository doesn't cover aspects such as security, efficiency, and upgradability, which are essential for real-world token contracts. 

Thank You!
