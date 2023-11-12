// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Shivam {
    uint stored;
    function set (uint x) public {
        stored= x;
    }

    function get () public view returns (uint){
        return stored;
    }

}
