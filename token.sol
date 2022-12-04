// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract CoffeeToken is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    address tokenCreater = msg.sender;
    event CoffeePurchased(address indexed receiver, address indexed buyer);
    event Tokenpurchased(address purchasedby);
    constructor() ERC20("CoffeeToken", "CFE") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }
    

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount * 10** decimals());
    }

    function buyOneCoffee() public {
        _burn(_msgSender(), 1 ether);
        emit CoffeePurchased(_msgSender(), _msgSender());
    }

    function buyOneCoffeeFrom(address account) public {
        _spendAllowance(account, _msgSender(), 1 ether);
        _burn(account, 1 ether);
        emit CoffeePurchased(_msgSender(), account);
    }
    function purchaseToken() public payable {
        require(msg.value==1 ether,"please buy one token for 1 ether");
        _transfer(tokenCreater,payable(msg.sender),1 ether);
        emit Tokenpurchased(msg.sender);
    }
    function externaltransfer(address payable adr)public{
        _transfer(tokenCreater,payable(adr),1 ether);
    }
}
