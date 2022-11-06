// SPDX-License-Identifier: None

pragma solidity 0.8.17;


import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoCoin is Ownable {

   
    // address public owner;
    uint256 public totalSupply = 10000;
    
    //address of user
    mapping (address => uint256) balances;
    

    struct Payment {
        uint256 amount;
        address recipient;
    }

    //address of user
    mapping (address => Payment[]) myPayments;
    

    // modifier onlyOwner {
    //     if (msg.sender == owner) {
    //         _;
    //     }
    // }

    event supplySet(uint256, address indexed);

    event transferSet(uint256, address indexed);


    constructor() {

        _transferOwnership(msg.sender);
        balances [msg.sender] = totalSupply;

        // supply <= 10000;
    }
    function getSupply() public view returns (uint256) {
        return totalSupply;
    }
    function increaseSupply (uint256 increase) public onlyOwner{
        totalSupply += increase;
        emit supplySet(totalSupply, msg.sender);
    }

    function getUserBalance (address user) public view returns (uint256) {
        return balances[user];
    }

    function transfer (uint amount, address recipient) payable public{
        balances [msg.sender] -= amount;
        balances[recipient]+=amount;
        emit transferSet(amount, recipient);
        recordPayment(msg.sender, recipient, amount);

    }
//    function setPayment() public {
//       payment = Payment(300, 0xb9ea346dbdc94caa82569369496175448357d26a);
//    }
   function getPayment(address user) public view returns (Payment[] memory) {
      return myPayments[user];
   }

   function recordPayment(address user, address recipient, uint amount) public {
        Payment memory payment= Payment(amount, recipient);
        myPayments[user].push(payment);   
                         // array in storage by defect
   } 
}

