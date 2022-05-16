// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

//Chainlink imports
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract RandomAvatars is ERC721, ERC721Enumerable, VRFConsumerBaseV2  {
    using Counters for Counters.Counter;

    Counters.Counter private _idCounter; //Keeps track of the minted token
    uint256 public immutable maxSupply; //Where we define the max supply for our tokens

    //Chainlink variables
    VRFCoordinatorV2Interface COORDINATOR;
    // Your subscription ID.
    uint64 s_subscriptionId;

    // Rinkeby coordinator. For other networks,
    // see https://docs.chain.link/docs/vrf-contracts/#configurations
    address vrfCoordinator = 0x6168499c0cFfCaCD319c818142124B7A15E857ab;

    // The gas lane to use, which specifies the maximum gas price to bump to.
    // For a list of available gas lanes on each network,
    // see https://docs.chain.link/docs/vrf-contracts/#configurations
    bytes32 keyHash = 0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc;

    // Depends on the number of requested values that you want sent to the
    // fulfillRandomWords() function. Storing each word costs about 20,000 gas,
    // so 100,000 is a safe default for this example contract. Test and adjust
    // this limit based on the network that you select, the size of the request,
    // and the processing of the callback request in the fulfillRandomWords()
    // function.
    uint32 immutable callbackGasLimit = 200000;

    // The default is 3, but you can set this higher.
    uint16 immutable requestConfirmations = 3;

    // For this example, retrieve 2 random values in one request.
    // Cannot exceed VRFCoordinatorV2.MAX_NUM_WORDS.
    uint32 immutable numWords =  6;

    address s_owner;

    mapping(uint256 => address) requestToSender;
    event RandomnessRequested(uint256 indexed requestId);

    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;

    constructor(uint256 _maxSupply, uint64 subscriptionId) VRFConsumerBaseV2(vrfCoordinator) ERC721("RandomAvatars", "RNDAV") {
        maxSupply = _maxSupply;

        COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
        s_owner = msg.sender;
        s_subscriptionId = subscriptionId;
    }

    function mint() public returns (uint256 requestId) {
        uint256 current = _idCounter.current();
        require(current < maxSupply, "Sorry, no avatars left for minting.");

        // Assumes the Chainlink subscription is funded sufficiently.
        // Will revert if subscription is not set and funded.
        requestId = COORDINATOR.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );

        requestToSender[requestId] = msg.sender;

        emit RandomnessRequested(requestId);
    }

    function getImageUri(uint256 n0, uint256 n1, uint256 n2, uint256 n3, uint256 n4, uint256 n5) internal pure returns (string memory) {
        string memory params;

        {
            params = string(
                abi.encodePacked(
                    "https://api.multiavatar.com/",
                    n0,
                    n1,
                    n2,
                    n3,
                    n4,
                    n5,
                    ".svg"
                )
            );
        }

        return params;
    }

    function createTokenUri(string memory current, string memory uri) internal pure returns(string memory tokenUri) {
    
        string memory json = Base64.encode(
        bytes(
            string(
            abi.encodePacked(
                '{"tokenId": "',
                current,
                '", "description": "Random Avatar NFT Collection Powered by Chainlink VRF, made by Jorge Garcia for the Blockchain Academy Solidity Course", "image": "data:image/svg+xml;base64,',
                Base64.encode(bytes(uri)),
                '"}'
            )
            )
        )
        );

        tokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        return tokenUri;
  }

    function fulfillRandomWords(
        uint256 requestId,
        uint256[] memory randomNumbers
    ) internal override {
        uint256 current = _idCounter.current();
        
        //47 is the last number for our Avatar library
        uint256 n0 = randomNumbers[0] % 47 + 1;
        uint256 n1 = randomNumbers[1] % 47 + 1;
        uint256 n2 = randomNumbers[2] % 47 + 1;
        uint256 n3 = randomNumbers[3] % 47 + 1;
        uint256 n4 = randomNumbers[4] % 47 + 1;
        uint256 n5 = randomNumbers[5] % 47 + 1;

        string memory uri = getImageUri(n0,n1,n2,n3,n4,n5);
        string memory tokenUri = createTokenUri(Strings.toString(current), uri);
        
        _safeMint(requestToSender[requestId], current);
        _setTokenURI(current, tokenUri);
        _idCounter.increment();
    }

    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721URIStorage: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

    modifier onlyOwner() {
        require(msg.sender == s_owner);
        _;
    }

    // The following functions are overrides required by Solidity.
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}