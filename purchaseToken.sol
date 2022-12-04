//SPDX-License-Identifier: MIT
pragma solidity 0.8.16;
import "./ERC20token.sol";


 
contract TokenSale {
    uint tokenPriceInWei = 1 ether;

    
     
    function purchaseCoffeToken(address _token) public payable {
      require(msg.value== tokenPriceInWei , "the cost of coupon is 1 ether");
      CoffeeToken cf = CoffeeToken(_token);
      cf.externaltransfer(payable(msg.sender));
    }
}
