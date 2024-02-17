// SPDX-License-Identifier: -- WISE --

pragma solidity =0.8.24;
import {ERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract TokenReturningFalse  is ERC20{
    constructor()ERC20 ("ReturnFalseToken","RFT"){}

    function mint(address rec,uint amount) public {
            _mint(rec, amount);
    }

    function transfer(address, uint256 ) public pure override returns (bool) {
        return false; // should alwas return false (For testing)
        
    }

    function approve(address, uint256 ) public pure override returns (bool) {
        return false;
    }

    function transferFrom(
        address,
        address ,
        uint256
    ) public pure override returns (bool) {
        return false;
    }

    
}