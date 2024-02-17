// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import {TokenReturningFalse} from "../src/Token.sol";
//==============
import {OZImplementation} from "../src/OZImplementation.sol";
import {WiseLendImplementation} from "../src/WiseLendImplementation.sol";
//=======Mitigation files
import {MitigatedWiseLend} from "../src/Mitigation/MitigatedWiseLend.sol";

contract CounterTest is Test {
    // contract implementing safeTransferFrom with OZ library 
    OZImplementation openzeppelinImplementation; 

    // contract implementing WiseLend Buggy callOptionalReturn
    WiseLendImplementation wiseLendImplementationContract; 

    //Meme Token contract returning False only (For testing how OZ and Wiselend callOptionalReturn each handle false return)
    TokenReturningFalse token; 

    //Mitigated wiselend contract
    MitigatedWiseLend mitigatedWiselend;


    address wiseLendUser;
    uint256 public constant MINTED = 100_000;

    function setUp() public {
        openzeppelinImplementation = new OZImplementation();
        wiseLendImplementationContract = new WiseLendImplementation();
        mitigatedWiselend = new MitigatedWiseLend();
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

    function test_Breaks_On_False_Return_for__WiseLend_Mitigated() public {
        vm.expectRevert();
        mitigatedWiselend.safeTransferFrom(address(token), wiseLendUser, address(this), 100); // Reverts on false!!!
    }
}
