Steps to deploy the cotract

1.1 Deploy the ERC20(ERC20TestToken) smart contract using a application based wallet address. This smart contract will provide 10000 tokens to the wallet address used for deployment of the contract
1.2 Deploy the NFT token(ERC721TestNFT) smart contract using a application based wallet address
1.3 Deploy the Auction(AuctionContract) smart contract using a application based wallet address

Distributing ERC20TestToken tokens to accounts who wants to bid

2.1 Using ERC20TestToken deployed use the transferFrom method to send tokens from the application based wallet to other addresses. We will use these addresses for the Auction bidding
2.2 REpeat step one for 2-3 addresses which can be used for bidding process

Minting NFTToken:

3.1 Use the mint method to allocate nftTokenId to a wallet address
3.2 We will use this NFT in the Auction process


Auction Smart Contract:

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


Improvements that can be made:

1. ERC20 is a simple smart contract and does not have appropriate controls. We can enhance it using approve feature with transferFrom to ensure the owner of erc20 token can predefine tokens allowed for a specific receiver which ensures that only amounts lower than that can be transferred.
2. ERC721 is also very basic without a lot of functions

Testing:
Currently functionality is tested tusing remix ide. I will try to create a DAPP with web apis for simulation.
