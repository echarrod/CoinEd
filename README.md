# CoinEd

Task from Blockchain Connector workshop
[https://www.theblockchainconnector.com/workshop/tasks.html](https://www.theblockchainconnector.com/workshop/tasks.html)

## A simple token contract
Create a Token contract based on [Simple Coin](https://www.theblockchainconnector.com/workshop/contracts/SimpleCoin.sol)

It will need
- to have a name
- to hold balances of tokens for accounts
- to have a symbol
- to store a total supply

## Extending your contracts

- Add owner functionality, try inheriting from Ownable
- Try adding more detailed events to your contract
- Add a modifier to limit the amount of tokens that can be transfered, then add a function to set the limit .
- Can you add modifiers to the functions SimpleCoin to restrict access to the contracts to a whitelist of addresses ?
ERC20 compliant token
- To create an ERC20 compliant token base your token on [ERC20 Coin](https://www.theblockchainconnector.com/workshop/contracts/ERC20Coin.sol)
- Add the extra functions to your simple token contract

You can check your answer against [ERC20 Standard](https://theethereum.wiki/w/index.php/ERC20_Token_Standard)