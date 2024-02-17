// SPDX-License-Identifier: -- WISE --

pragma solidity =0.8.24;
import {TransferHelper} from "./TransferHub/TransferHelper.sol";
 /**
 @dev This contract represents WiseLending contracts implementation of TransferHelper which itself inherits the broken callOptionalReturn algorithm (doesnt revert on false)
*/
contract WiseLendImplementation is TransferHelper{ 

    function safeTransfer(address Token, address to, uint value) public {
        _safeTransfer(Token,to,value);
    }

    function safeTransferFrom(address Token, address from,address to, uint value) public {
        _safeTransferFrom(Token,from,to,value);
    }


}