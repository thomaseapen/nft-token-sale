var express = require('express')
const Web3 = require('web3');
let fs = require("fs");
const { isError } = require('util');

const WALLET_ADDRESS = "0x06556519d0F30c7C1B3B0acD91B7C74E2a363a9c";
const ERC20_SC_ADDRESS = "0xeB5979e3De26A17D41c848d9bd15147f7C12A7CE";
const ERC2721_SC_ADDRESS = "0xF6b9F039C1951839b9eD8f2DcBd04df69E44ebd6";
const AUCTION_SC_ADDRESS = "0xa0b0CD9A6a61A4420bB8c83166ad83C05d817c66";

var web3 = new Web3(new Web3.providers.HttpProvider('HTTP://127.0.0.1:7545'));

var CONTRACT_BUILD_BASE_PATH = "../../smart-contract/build/contracts/";

var erc20ContractJson =  JSON.parse(fs.readFileSync(
    CONTRACT_BUILD_BASE_PATH + "ERC20TestToken" + ".json", 'utf8'));
const erc20TestToken = new web3.eth.Contract(erc20ContractJson['abi'], ERC20_SC_ADDRESS);


var erc2721ContractJson =  JSON.parse(fs.readFileSync(
    CONTRACT_BUILD_BASE_PATH + "ERC721TestNFT" + ".json", 'utf8'));
 const erc721TestToken = new web3.eth.Contract(erc2721ContractJson['abi'], ERC2721_SC_ADDRESS);


 var auctionContractJson =  JSON.parse(fs.readFileSync(
    CONTRACT_BUILD_BASE_PATH + "AuctionContract" + ".json", 'utf8'));
 const auctionToken = new web3.eth.Contract(auctionContractJson['abi'], AUCTION_SC_ADDRESS);

var app = express()

app.get('/getERC20Supply', function (req, res) {
    
    const supply =  erc20TestToken.methods.totalSupply().call({from: WALLET_ADDRESS}, (error, result) => {
        if (!error) {
            res.send(result);
            
        }else{
            console.log('error', error)
            res.send(error.message);
        }
      });
    
  })


  app.get('/transferERC20', function (req, res) {
    
    const supply =  erc20TestToken.methods.transferFrom(WALLET_ADDRESS, req.query.address, req.query.token).send({from: WALLET_ADDRESS}, (error, result) => {
        if (!error) {
            res.send('Success');
            
        }else{
            console.log('error', error)
            res.send(error.message);
        }
      });
    
  })


  app.get('/balanceERC20', function (req, res) {
    
   const supply =  erc20TestToken.methods.balanceOf(req.query.address).call({from: WALLET_ADDRESS}, (error, result) => {
        if (!error) {
            res.send(result);
        }else{
            console.log('error', error)
            res.send(error.message);
        }
      });
    
  })


  app.get('/mintERC721', function (req, res) {
    
    const supply =  erc721TestToken.methods._mint(req.query.address, req.query.tokenId).send({from: WALLET_ADDRESS}, (error, result) => {
         if (!error) {
             res.send('success');
         }else{
            console.log('error', error)
            res.send(error.message);
        }
       });
     
   })

   app.get('/getTokenOwnerERC721', function (req, res) {
    
    const supply =  erc721TestToken.methods.ownerOf(req.query.tokenId).call({from: WALLET_ADDRESS}, (error, result) => {
         if (!error) {
             res.send(result);
         }else{
            console.log('error', error)
            res.send(error.message);
        }
       });
     
   })

   app.get('/startAuction', function (req, res) {
    
    auctionToken.methods.Auction(req.query.tokenOwnerAddress, ERC20_SC_ADDRESS, ERC2721_SC_ADDRESS, req.query.duration, req.query.minBid, req.query.tokenId).send({from: WALLET_ADDRESS, gas: 5000000,}, (error, result) => {
         if (!error) {
             console.log(res)
             res.send('Auction started');
         }else{
                console.log(error)
                res.send(error.message);
        }
       });
     
   })

  

       app.get('/bidForAuction', function (req, res) {
    
        auctionToken.methods.placeBid(req.query.bidAmount).send({from: req.query.bidderWalletAddress, gas: 5000000}, (error, result) => {
             if (!error) {
                 res.send('Bid Successful');
             }else{
                 console.log('error', error)
                 res.send(error.message);
             }
           });
     
        })


        app.get('/endAuction', function (req, res) {
    
            auctionToken.methods.endBid().send({from: WALLET_ADDRESS, gas: 5000000}, (error, result) => {
                 if (!error) {
                     res.send('Auction Ended');
                 }else{
                     console.log('error', error)
                     res.send(error.message);
                 }
               });
         
            })
 


  app.listen(8881, () => {
    console.log(`Example app listening at http://localhost:8881`)
  })