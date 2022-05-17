const { expect } = require("chai");
require('dotenv').config();
const chainlinkId = process.env.CHAINLINK_SUBSCRIPTION_ID

describe("Random Avatars Contract", () => {
  const setup = async ({ _maxSupply = 10000, subscriptionId = chainlinkId } = {}) => {
    const [owner] = await ethers.getSigners();
    const RandomAvatars = await ethers.getContractFactory("RandomAvatars");
    const deployed = await RandomAvatars.deploy(_maxSupply, subscriptionId);

    return {
      owner,
      deployed
    };
  };

  describe("Deployment", () => {
    it("Sets max supply to passed param", async () => {
      const maxSupply = 10000;

      const { deployed } = await setup({ maxSupply });

      const returnedMaxSupply = await deployed.maxSupply();
      expect(maxSupply).to.equal(returnedMaxSupply);
    });

    it("Should have the correct name and symbol ", async function () {
      const { deployed } = await setup({ });


      expect(await deployed.name()).to.equal("RandomAvatars");
      expect(await deployed.symbol()).to.equal("RNDAV");
    });

  });

});