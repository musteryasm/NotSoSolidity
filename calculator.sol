
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract Calculator{
    uint public result;

    function add(uint num) public returns (uint ) {
        return result+=num;
    }

    function subtract(uint num) public returns (uint) {
       return result-=num;
    }

    function multiply(uint num) public returns (uint) {
       return result*=num;
    }

    function modulo(uint num) public returns (uint) {
       return result%=num;
    }

    function divide(uint num) public returns (uint) {
       return result/=num;
    }

    function _allclear() public returns (uint) {
        return result=0;
    }

    }
