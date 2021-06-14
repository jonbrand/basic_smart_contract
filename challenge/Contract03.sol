// SPDX-License-Identifier: MIT
pragma solidity 0.5.3;

library SafeMath {
     /* operações entre (uint8) dois valores com retorno de erro "Overflow 
    | funções puras não interagem com a blockchain (são de graça); */
    function sum(uint a, uint b) internal pure returns(uint) {
        uint c = a + b;
        require(c >= a, "Sum Overflow!");

        return c;
    }

    // operação de subtração com o retorno de "Underflow"
    function sub(uint a, uint b) internal pure returns(uint) {
        require(b <= a, "Sub Undeflow!");
        uint c = a - b;

        return c;
    }

    // operação de multiplicação com o retorno de "Overflow" e tratamento com valores 0
    function mult(uint a, uint b) internal pure returns(uint) {
        if(a == 0) {
            return 0;
        }
        
        uint c = a * b;
        require(c / a == b, "Mult Overflow!");
        
        return c;
    }

    // operação de divisão
    function div(uint a, uint b) internal pure returns(uint) {
        uint c = a / b;
        
        return c;
    }
}

contract Ownable {
    // contém o dono do contrato
    address payable public owner;

    event OwnershipTransferred(address newOwner);

    /* a conta que fizer o deploy do contrato vai ser o dono do contrato | a função constructor
    só é chamada uma vez na vida do contrato */
    constructor() public {
        owner = msg.sender;
    }

    // validação se o endereço do user é do dono do contrato;
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner!");
        _;
    }

    function transferOwnership(address payable newOwner) onlyOwner public {
        owner = newOwner;

        emit OwnershipTransferred(owner);
    }
}

contract Challenge01 is Ownable {
    using SafeMath for uint;

    uint price =  25 finney;
    mapping(address => uint) public balances;

    event NewPrice(uint newPrice);

    function setNumber (uint number) public payable returns(string memory) {
        require(number <= 10, "Number out of range.");
        require(msg.value == price, "Insufficient ETH sent!");
        
        doublePrice();

        if (number > 5) {
            return "É maior que cinco!";
        }

        return "É menor ou igual a cinco!";
    }

    function doublePrice() private {
        price = price.mult(2);

        emit NewPrice(price);
    }

    function withdraw(uint myAmount) onlyOwner public {
        require(address(this).balance >= myAmount, "Insufficient founds.");

        owner.transfer(myAmount);
    }
}