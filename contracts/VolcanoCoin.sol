// SPDX-License-Identifier: None

pragma solidity 0.8.17;

contract VolcanoCoin {

   
    address public owner;
    uint256 public totalSupply = 10000;
    mapping (address => uint256) balances;
    

    struct Payment {
        uint256 amount;
        address recipient;
    }

    Payment payment;

    Payment[] structList;
    mapping (address => Payment[]) public transfers;
    

    modifier onlyOwner {
        if (msg.sender == owner) {
            _;
        }
    }

    event supplySet(uint256, address indexed);

    event transferSet(uint256, address indexed);


    constructor() {

        owner = msg.sender;
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

    function transfer (uint amount, address recipient) public{

        balances[recipient]=amount;
        emit transferSet(amount, recipient);

    }
    

//    function setPayment() public {
//       payment = Payment(300, 0xb9ea346dbdc94caa82569369496175448357d26a);
//    }
//    function getPayment() public view returns (uint) {
//       return payment.amount;
//    }
}   