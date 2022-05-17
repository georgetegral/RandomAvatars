# Random Avatars for Blockchain Academy Solidity Course certification

## Table of Contents
* [Overview](#Overview)
* [Instructions to run this project](#Instructions-to-run-this-project)
    * [Installing Node.js and NPM](#Installing-Node.js-and-NPM)
    * [Running the project with Hardhat](#Running-the-project-with-Hardhat)
    * [Setting up your environment](#Setting-up-your-environment)
    * [Getting a wallet's signer private key](#Getting-a-wallet's-signer-private-key)
    * [Getting an Infura project ID](#Getting-an-Infura-project-ID)
    * [Getting a Chainlink Subscription ID](#Getting-a-Chainlink-subscription-ID)
* [Future Work](#Future-Work)
* [References](#References)

## Overview
This is the final project for the Blockchain Academy Solidity Course. In this project we mint NFTs using the ERC721 standard using the [Multiavatar](https://api.multiavatar.com/) avatar library for our images, we also integrate Chainlink by using its Chainlink VRF (Verifiable Randomness Function) to get a non-deterministic random number that will determine the avatar that the user mints. We also create a UI for the user for minting the NFT and seeing all minted NFTs. Everything runs on the Rinkeby test network.

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
First we have to install hardhat in our system. You can install Hardhat with the following command:

```bash
npm install --save-dev hardhat
    ethers -D
```

After installing Hardhat, install the project dependencies using the following command:

```bash
npm install
```

The following dependencies should be installed:
- @nomiclabs/hardhat-waffle
- @nomiclabs/hardhat-ethers
- chai
- dotenv
- ethereum-waffle
- ethers
- hardhat
- @chainlink/contracts
- @openzeppelin/contracts

### Setting up your environment
You will need to define your environment variables in an .env file, you will need this 3 values:
1. DEPLOYER_SIGNER_PRIVATE_KEY
2. INFURA_PROJECT_ID
3. CHAINLINK_SUBSCRIPTION_ID

In the project files you will find an .env.example so that you only paste the required values, we will now get the necessary values.

### Getting a wallet's signer private key
To sign transactions and deploy the smart contract, you will need to input your wallet's private key in the .env file.

To do this, you need the Metamask extension, if you don't have one yet, you can download it [here](https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn). Please setup your wallet and save your private key before continuing.

To get the signer private key open the Metamask extension and go to your account -> "The 3 dots menu" -> Account details -> Export Private Key -> Input your password -> Copy your signer private key.

The key should start with "0x", if you have it then paste it in your .env file after DEPLOYER_SIGNER_PRIVATE_KEY. We are ready to continue with the next step.

### Getting an Infura project ID
We are going to need to create a free Infura project, go to the [Infura website](https://infura.io/) and set up a free account, after creating your account please go to the Dashboard and create a new project, after creating it look at the keys section, in "Endpoints" select Rinkeby, and finally copy the Project ID and paste it in your .env file after INFURA_PROJECT_ID.

We are ready for the next step.

### Getting a Chainlink Subscription ID
asd


## Future work
For a next iteration of the project we can add a cost for the minting of the NFT, with the funds going to the smart contract so that the owner can withdraw them.

## References
- [Node.js](https://nodejs.org/en/download/)
- [Hardhat](https://hardhat.org/tutorial/creating-a-new-hardhat-project.html)
- [Metamask Extension Download](https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn)
