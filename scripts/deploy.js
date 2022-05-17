require('dotenv').config();
const chainlinkId = process.env.CHAINLINK_SUBSCRIPTION_ID

const deploy = async () => {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contract with the account: "+deployer.address);

    const RandomAvatars = await ethers.getContractFactory("RandomAvatars");
    const deployed = await RandomAvatars.deploy(10000, chainlinkId);

    console.log("RandomAvatars is deployed at: "+deployed.address);
};

deploy()
    .then(() => process.exit(0))
    .catch(error => {
        console.log(error);
        process.exit(1);
    });