# Hash-Based Ethereum Smart Contract 

The contract allows the user to place a wager and difficulty that diminish exponentionally every hour.

# Getting started

Pay a wager to the constructor, along with a specified difficulty. 

* A difficulty is the number of leading zeroes necessary for any hash output. (An input of 0 would constitute an infinite number of hash inputs)

Have your friends try and find nonces that result in leading zeroes, and test them in the claim() function. 

* BOTH the contract reward and difficulty decrease by a factor of 2 every hour. If the reward has diminished, the remainder is sent to the contract owner.

Dont forget to test the contract here: https://remix.ethereum.org

# mk 
