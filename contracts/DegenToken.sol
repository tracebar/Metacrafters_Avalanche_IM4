// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";  
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {

    string public redeem_shop;
    int256 public cost;
    string internal error_m = "Only 3 items available in the shop";

    constructor() ERC20("Degen", "DGN") {
        redeem_shop = "You have the following items in your shop which you are able to redeem: 1.Ford, 2.Fiat, 3.MG";
    }

        function mint(address to, uint256 amount) public onlyOwner {
            _mint(to, amount);
        }

        function burn(uint256 amount) public override{ 
            _burn(msg.sender, amount);
        }

        function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
            _transfer(_msgSender(), recipient, amount);
            return true;
        }

        function redeem(uint256 item_serial) public payable{
        
        if(item_serial < 0 && item_serial > 4){
            revert(error_m);
        }
        require(balanceOf(msg.sender) >= 10);
        _burn(msg.sender, (item_serial*2));
        }
        
}
