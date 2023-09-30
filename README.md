# Smart-Wallet-With-Solidity

These are the requirements:

The wallet has one owner
The wallet should be able to receive funds, no matter what
It is possible for the owner to spend funds on any kind of address, no matter if its a so-called Externally Owned Account (EOA - with a private key), or a Contract Address.
It should be possible to allow certain people to spend up to a certain amount of funds.
It should be possible to set the owner to a different address by a minimum of 3 out of 5 guardians, in case funds are lost.



You get a lot more flexibility than with your traditional private-key based wallet. You can implement things like:

Multi-Signature Transaction Whitelisting, where it needs m-out-of-n people to agree to a transaction
Emergency operations, like account freezing, or withdrawal limits per day/month, ...
Whitelisting and Account Sharing
Account Recovery by using m-out-of-n people to reset an owner, or re-authorize a new person.
And for the sophisticated DeFi Traders out there, there are functions that help save gas costs, bundle transactions and templates to execute transactions to deleverage positions etc...
