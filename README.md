### Steps to deploy the cotract

1.1 Deploy the ERC20(ERC20TestToken) smart contract using a application based wallet address. This smart contract will provide 10000 tokens to the wallet address used for deployment of the contract
1.2 Deploy the NFT token(ERC721TestNFT) smart contract using a application based wallet address
1.3 Deploy the Auction(AuctionContract) smart contract using a application based wallet address

### Distributing ERC20TestToken tokens to accounts who wants to bid

2.1 Using ERC20TestToken deployed use the transferFrom method to send tokens from the application based wallet to other addresses. We will use these addresses for the Auction bidding
2.2 REpeat step one for 2-3 addresses which can be used for bidding process

### Minting NFTToken:

3.1 Use the mint method to allocate nftTokenId to a wallet address
3.2 We will use this NFT in the Auction process


### Auction Smart Contract:

4.1 Call the Auction method passing following parameters using the application based wallet address used to deploy in step 1.3:
    a. _owner - Wallet address from 3.1
    b. erc20TokenAddress - Smart contract address from 1.1
    c. erc721Address - Smart contract address from 1.2
    d. _duration - Duration in seconds for the Auction to end
    e. minBid - Minimum bid acceptable for the auction
    f. _tokenId - Token id value assigned to the wallet in step 3.1
4.2 Once initialized the bidding can be done by wallet addresses allocated with erc20 token in Step 2.2
4.3 After the duration no more bids be accepted by the smart contract
4.4 The application based wallet address will then call the endBid to transfer the nft and erc20.


### Improvements that can be made:

1. ERC20 is a simple smart contract and does not have appropriate controls. We can enhance it using approve feature with transferFrom to ensure the owner of erc20 token can predefine tokens allowed for a specific receiver which ensures that only amounts lower than that can be transferred.
2. ERC721 is also very basic without a lot of functions
3. Function modifiers on who can operate on which functions can be improved to ensure only systematic wallets are able to modify certain states.

### Testing:

1. Use truffle deploy to deploy to local ganache
2. Replace the following variables in the app.js in nodejs application with the appropriate address
const WALLET_ADDRESS = "0x06556519d0F30c7C1B3B0acD91B7C74E2a363a9c";

const ERC20_SC_ADDRESS = "0x68b8855a8B1515032125cb8567dF74D00348a185";

const ERC2721_SC_ADDRESS = "0x02A5C1Cc0E12C48cb29B5Ed29fAEa4b07c0BfdC2";

const AUCTION_SC_ADDRESS = "0x8F9a72D56cA360c8Ca889264a3c2e6e10CB19dAB";

Note: Deploy all contracts with WALLET_ADDRESS(which is really used by the application)
3. Using postman replace the following addresses in the local variable with any 3 account address for simulating as token owner and buyers
bidder_1

bidder_2

nft_owner
