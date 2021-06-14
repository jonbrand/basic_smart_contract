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

contract HelloWorld is Ownable {

    using SafeMath for uint;

    // tipo | visibilidade | nome;
    // caracteres;
    string public text;
    // número;
    uint public number;
    // endereço wallet;
    address payable public userAddress;
    // booleano;
    bool public answer;
    // mapeamento
    mapping (address => uint) public hasInteracted;
    // saldo de cada user
    mapping (address => uint) public balances;

    // memory: guarda o valor da variavel temporariamente, enquanto a função estiver ativa;
    function setText (string memory myText) onlyOwner public {
        text = myText;
        setInteracted();
    }

    // payble valida a função para cobra ether;
    function setNumber (uint myNumber) public payable {
        require(msg.value >= 1 ether, "Insufficient ETH sent!");
        
        balances[msg.sender] = balances[msg.sender].sum(msg.value);
        number = myNumber;
        setInteracted();
    }

    // função que pega o endereço do usuario;
    function setUserAddress () public {
        userAddress = msg.sender;
        setInteracted();
    }

    // função booleana;
    function setAnswer(bool trueOrFalse) public {
        answer = trueOrFalse;
        setInteracted();
    }

    // função de quantas vezes o usuário interage com o contrato;
    function setInteracted() private {
        hasInteracted[msg.sender] = hasInteracted[msg.sender].sum(1);
    }

    // transferir fundos entre carteiras
    function sendETH(address payable targetAddress) public payable {
        targetAddress.transfer(msg.value);
    }

    // função de saque de fundos ** utilizando a solução do problema da reentracia ***
    function withdraw() public {
        require(balances[msg.sender] > 0, "Insufficient founds!");

        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        msg.sender.transfer(amount);
    }

    function pow(uint a, uint b) public pure returns(uint) {
        return a ** b;
    }

    // funções de consulta dentro da blockchain assume "view";
    function sumStored(uint numb1) public view returns(uint) {
        return numb1.sum(number);
    }
}