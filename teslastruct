
// SPDX-License-Identifier: MIT
pragma solidity ^0.8;


contract Tesla{

    struct tesla{
        string model;
        uint year;
        string color;
        uint mileage;
    }

    tesla[] public teslas;

    function addTesla (string memory model, uint year, string memory color, uint mileage) public {
        
        tesla memory newTesla= tesla({
            model: model,
            year: year,
            color: color,
            mileage: mileage

        });
        teslas.push (newTesla);

    }
}
