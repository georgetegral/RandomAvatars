# Random Avatars for Blockchain Academy Solidity Course certification

## Table of Contents
* [Overview](#Overview)
* [Instructions to run this project](#Instructions-to-run-this-project)
    * [Installing Node.js and NPM](#Installing-Node.js-and-NPM)
    * [Running the project with Hardhat](#Running-the-project-with-Hardhat)
* [Future Work](#Future-Work)
* [References](#References)

## Overview
This is the final project for the Blockchain Academy Solidity Course. In this project we mint NFTs using the ERC721 standard using the [Multiavatar](https://api.multiavatar.com/) avatar library for our images, we also integrate Chainlink by using its Chainlink VRF (Verifiable Randomness Function) to get a non-deterministic random number that will determine the avatar that the user mints. We also create a UI for the user for minting the NFT and seeing all minted NFTs.

The project is divided in two repositories.
1. The smart contract for the minting of NFTs. (This repository)
2. The dApp using React.js, built for interaction with the smart contract in a user-friendly way. (Repository available [here](https://github.com/georgetegral/RandomAvatarsInterface))

## Instructions to run this project
To run this project we will use the Hardhat IDE, which needs you to install Node.js and NPM. Finally, we will also need a Chainlink account with Testnet LINK tokens.

### Installing Node.js and NPM
Use the following link to install Node.js in your computer: https://nodejs.org/en/download/, follow the instructions in the website.

At the end, you can verify that the installation was correct by running the following commands

```bash
node -v
npm -v
```

### Running the project with Hardhat



## Future work
For a next iteration of the project we can add a cost for the minting of the NFT, with the funds going to the smart contract so that the owner can withdraw them.

## References
- [Node.js](https://nodejs.org/en/download/)
- [Hardhat](https://hardhat.org/tutorial/creating-a-new-hardhat-project.html)
