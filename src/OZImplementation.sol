// SPDX-License-Identifier: -- WISE --

pragma solidity =0.8.24;

import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";

// contract OZCallOptionalReturn {

//     /**
//      * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
//      * on the return value: the return value is optional (but if data is returned, it must not be false).
//      * @param token The token targeted by the call.
//      * @param data The call data (encoded using abi.encode or one of its variants).
//      */
//     function _callOptionalReturn(IERC20 token, bytes memory data) private {
//         // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
//         // we're implementing it ourselves. We use {Address-functionCall} to perform this call, which verifies that
//         // the target address contains contract code and also asserts for success in the low-level call.

//         bytes memory returndata = address(token).functionCall(data);
//         if (returndata.length != 0 && !abi.decode(returndata, (bool))) {
//             revert SafeERC20FailedOperation(address(token));
//         }
//     }

//     /**
//      * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
//      * on the return value: the return value is optional (but if data is returned, it must not be false).
//      * @param token The token targeted by the call.
//      * @param data The call data (encoded using abi.encode or one of its variants).
//      *
//      * This is a variant of {_callOptionalReturn} that silents catches all reverts and returns a bool instead.
//      */
//     function _callOptionalReturnBool(IERC20 token, bytes memory data) private returns (bool) {
//         // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
//         // we're implementing it ourselves. We cannot use {Address-functionCall} here since this should return false
//         // and not revert is the subcall reverts.

//         (bool success, bytes memory returndata) = address(token).call(data);
//         return success && (returndata.length == 0 || abi.decode(returndata, (bool))) && address(token).code.length > 0;
//     }

// }

contract OZImplementation {
    using SafeERC20 for IERC20; // token.safeTransfer

    function safeTransfer(IERC20 Token, address to, uint value) public {
       Token.safeTransfer(to,value);
    }

    function safeTransferFrom(IERC20 Token, address from,address to, uint value) public {
        Token.safeTransferFrom(from,to,value);
    }

    //function transfer()
}