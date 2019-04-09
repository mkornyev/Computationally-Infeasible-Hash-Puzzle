pragma solidity ^0.5.0;

contract TimeAdaptivePuzzle {
  address payable owner;
  uint reward; 
  uint startTime;
  uint currTime;
  uint elapsed;
  uint difficulty;
  uint leadingZeroes;

  //Sets the difficulty (# of leading hash zeroes)
  constructor(uint startDiff) public payable {
      owner = msg.sender; // Set contract owner 
      reward = msg.value; // Set wager  
      difficulty = startDiff;
      startTime = now;
      leadingZeroes = 0; 
  }

  //Verifies hash has valid # of leading zeroes 
  function claim(uint256 nonce) public {
    currTime = now; 
    //elapsed (hours) = seconds * 1min/60sec * 1hr/60min
    elapsed = ((currTime - startTime) / 60 / 60 ); 
    
    //Diminish difficulty & reward by a factor of 2 for each hour elapsed 
    if (elapsed != 0) {
        difficulty = difficulty / (2*(elapsed));
        reward = reward / (2*(elapsed));
    } 
    
    //////////////////////////////////////////////////////
    // TESTING SECTION: for the count_zeroes function   //
    // Or in case you can't solve the puzzle            //
    //                                                  //
    // bytes32 input = '\t'; //"0x09 = hex ascii value" //
    // input = input >> 4; // "0x009"                   //
    // input = input >> 8; // "0x0009"                  //
    // input = input >> 12; // "0x00009"                //
    // return count_zeroes(input);                      //
    //////////////////////////////////////////////////////
    
    //If nonce is a valid solution 
    if ( difficulty <= count_zeroes(sha256(toBytes(nonce))) ) { 
        msg.sender.transfer(reward); // Send reward 
        selfdestruct(owner);         // Destroy the contract and rid of remainder  
    }
  }
  
  function count_zeroes(bytes32 hash) public returns(uint) {
    uint i = 0; 
    leadingZeroes = 0; 
    while (i < 256)
    {
        //Check for leading zeroes in a 256 bit hash  
        if (hash >> (255 - i) == 0 ){
            leadingZeroes = leadingZeroes + 1;
        }
        i = i + 4; 
    }
    return leadingZeroes;
  }
  
  function toBytes(uint256 int_input) public pure returns (bytes memory byte_output) {
    byte_output = new bytes(32);
    assembly { mstore(add(byte_output, 32), int_input) } //Thanks to https://ethereum.stackexchange.com/questions/42659/
  }
  
  function () external payable {
  }
}