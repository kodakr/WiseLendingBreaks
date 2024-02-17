@Vitally,
Firstly, thanks on your reply and challenge of the validity of this submission. It only shows your eagerness for clarity, accuracy & uncover hidden truth.
I now understand i need to be highly specific.

**Aim of callOptionalReturn**
The aim of this algorithm is simply to find a balance amongst ERC20 tokens with different behaviours (especially in return signatures)
This summarily implies that:
- Successful call that return nothing => Do not revert :white_check_mark:
- successful calls that return true => Do not revert :white_check_mark:
- successful calls that return false => Revert :x:
- unsuccessful calls => revert :x:

Note: succes status is just a dummy and doesn't imply your DEFI/ Token operation or interaction returned true (if return sig is implemented) eg: 
the signature `function transferFrom(address from,address to, uint256 amount) public virtual override returns (bool)` only returns true if operations are through. Else returns false.

**Openzepellin callOptionalReturn VS WiseLend callOptionalReturn**

Hence Openzeppellin Calloptionalreturn reverts if return is false (If theres return value and it isnt true). And clearly states that **(but if data is returned, it must not be false)** see below :point_down:
```javascript
 /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address-functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data);
        if (returndata.length != 0 && !abi.decode(returndata, (bool))) {
            revert SafeERC20FailedOperation(address(token));
        }
    }
```
relatively, returned data false bypasses your callOptionalReturn :point_down:
```javascript
function _callOptionalReturn(
        address token,
        bytes memory data
    )
        internal
        returns (bool call)
    {
        (
            bool success,
            bytes memory returndata
        ) = token.call(
            data
        );

        bool results = returndata.length == 0 || abi.decode( //@audit requires empty return data (only) to be true.
            returndata,
            (bool)
        );

        if (success == false) {
            revert();
        }

        call = success
            && results
            && token.code.length > 0;
    }
```

[POC comparison btw OZ implementation and WiseLend Implementation with foundry](https://github.com/kodakr/WiseLendingBreaks/blob/main/test/Counter.t.sol)
 

**Omnisia right or wrong?**
Omnisia: "return of CallOptionalReturn::_callOptionalreturn is always true"

Analysing Omnisia's analysis...

Is this statement true?? Lets see
Three subchecks are required to be all true: `success`,`results`,`token.code.length > 0`.
1. `success`: Always true as will revert if false (Omnisia right):white_check_mark:
2. `token.code.length > 0`: well by virtue of contract's architecture (Omnisia right) :white_check_mark:
3. `results`: what happens when tokens return false (Omnisia wrong):x:
 
- If u no longer validate the call `call = success && results && token.code.length > 0;`, why assign it in first place . Doesn't that make all those security check assignment a joke??
- Thats equivalent of removal.
- If removed, then only check is the dummy `success` (note: `bool results` is just assigned **NOT CHECKED / REQUIRED**:x:) :point_down:
```javascript
bool results = returndata.length == 0 || abi.decode( //@audit not checked.
            returndata,
            (bool)
        );
```

**Actual Impact on protocol**
contracts\TransferHub\CallOptionalReturn.sol is used accross entire codebase for
- safeApproval
- safeTransfer
- safeTransferFrom

1. All safe approvals which returns false would not be detected causing a future DOS on assumed approval
2. All broken safeTransfer will result to fund loss by interacting users (beneficiaries) also upsetting internal accounting
3. critical: protocol looses funds (possibly drained entirely of a particular token)


**Conclusion**
Many projects fail to realise that just as an auditor has <20 days to produce these, a blackhat has >1 yr to work on this juicy bugs. eg:

In this scenario a Blackhat has over 6 months to figure out how to deposit with a smart malicious contract bypassing the safeTransferFrom() which triggers during his deposits. Hence depositing no actual funds but contract accounting updates in his favour. Allowing him to drain contract later.



FIX THAT BUG

Free to throw me your doubts ser.

Till then sir,  Congrats on ur first High Once again. Sending in more.