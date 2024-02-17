// SPDX-License-Identifier: -- WISE --

pragma solidity =0.8.24;
import {TransferHelper} from "./TransferHub/TransferHelper.sol";

contract WiseLendImplementation is TransferHelper{ 

    function safeTransfer(address Token, address to, uint value) public {
        _safeTransfer(Token,to,value);
    }

    function safeTransferFrom(address Token, address from,address to, uint value) public {
        _safeTransferFrom(Token,from,to,value);
    }


}