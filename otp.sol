// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract OTPPaymentGateway {
    address public owner;
    uint256 public otp;
    bool public isOTPValid;
    address public pendingRecipient;
    
    event OTPGenerated(address indexed user, uint256 otp);
    event OTPValidated(address indexed user, uint256 otp);
    event PaymentProcessed(address indexed user, address indexed recipient, uint256 amount);

    IERC20 public goerliEthToken;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor(address _goerliEthToken) {
        owner = msg.sender;
        goerliEthToken = IERC20(_goerliEthToken);
    }

    receive() external payable {
        // Fallback function to handle Ether sent to the contract
    }

    function generateOTP() external onlyOwner {
        otp = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, blockhash(block.number - 1))));
        isOTPValid = false; // Reset validation status when a new OTP is generated
        emit OTPGenerated(msg.sender, otp);
    }

    function validateOTP(uint256 _otp) external onlyOwner {
        require(!isOTPValid, "OTP already validated");
        require(_otp == otp, "Invalid OTP");
        
        isOTPValid = true;
        emit OTPValidated(msg.sender, _otp);
    }

    function setRecipient(address _recipient) external onlyOwner {
        require(_recipient != address(0), "Invalid recipient address");
        require(isOTPValid, "OTP must be validated before setting the recipient");

        pendingRecipient = _recipient;
    }

    function processTransaction() external onlyOwner {
        require(isOTPValid, "OTP must be validated before processing the transaction");
        require(pendingRecipient != address(0), "Recipient address not set");

        uint256 transferAmount = 2 * 10**15; // 0.002 ETH in Wei (assuming 18 decimal places)

        // Set a very high gas limit (use a value suitable for your scenario)
        (bool success, ) = payable(pendingRecipient).call{value: transferAmount, gas: 5000000}("");
        require(success, "Payment failed");

        emit PaymentProcessed(msg.sender, pendingRecipient, transferAmount);
        isOTPValid = false; // Reset validation status after processing the transaction
        pendingRecipient = address(0); // Reset pending recipient after processing the transaction
    }
}
