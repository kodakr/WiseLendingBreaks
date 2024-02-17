// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import {TokenReturningFalse} from "../src/Token.sol";
//==============
import {OZImplementation} from "../src/OZImplementation.sol";
import {WiseLendImplementation} from "../src/WiseLendImplementation.sol";

contract CounterTest is Test {
    OZImplementation openzeppelinImplementation;
    WiseLendImplementation wiseLendImplementationContract;
    TokenReturningFalse token;
    address wiseLendUser;
    uint256 public constant MINTED = 100_000;

    function setUp() public {
        openzeppelinImplementation = new OZImplementation();
        wiseLendImplementationContract = new WiseLendImplementation();
        token = new TokenReturningFalse();
        wiseLendUser = makeAddr("wiseLendUser");

        token.mint(wiseLendUser, MINTED);
    }

    function test_Breaks_On_False_Return_for_Openzeppelin() public {
        vm.expectRevert();
        openzeppelinImplementation.safeTransferFrom(token, wiseLendUser, address(this), 100); // Reverts on false!!!
    }

    function test_Breaks_On_False_Return_For_Wiselend() public {
        vm.expectRevert();
        wiseLendImplementationContract.safeTransferFrom(address(token), wiseLendUser, address(this), 100);  // Doesnt Revert as Expected
    }
}
