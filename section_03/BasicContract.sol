// SPDX-License-Identifier: MIT
pragma solidity 0.5.3;

contract HelloWorld {
    // tipo | visibilidade | nome;
    // caracteres;
    string public text;
    // número;
    uint public number;
    // endereço wallet;
    address public userAddress;
    // booleano;
    bool public answer;
    // mapeamento
    mapping (address => uint) public hasInteracted;
    // saldo de cada user
    mapping (address => uint) public balances;


    // memory: guarda o valor da variavel temporariamente, enquanto a função estiver ativa;
    function setText (string memory myText) public {
        text = myText;
        setInteracted();
    }

    // payble valida a função para cobra ether;
    function setNumber (uint myNumber) public payable {
        require(msg.value >= 1 ether, "Insufficient ETH sent!");
        
        balances[msg.sender] += msg.value;
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
        hasInteracted[msg.sender] += 1;
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

    // operações entre dois valores | funções puras não interagem com a blockchain (são de graça);
    function sum(uint numb1, uint numb2) public pure returns(uint) {
        return numb1 + numb2;
    }

    function sub(uint numb1, uint numb2) public pure returns(uint) {
        return numb1 - numb2;
    }

    function mult(uint numb1, uint numb2) public pure returns(uint) {
        return numb1 * numb2;
    }

    // solidity só trabalha com números inteiros;
    function div(uint numb1, uint numb2) public pure returns(uint) {
        return numb1 / numb2;
    }

    function pow(uint numb1, uint numb2) public pure returns(uint) {
        return numb1 ** numb2;
    }

    // funções de consulta dentro da blockchain assume "view";
    function sumStored(uint num1) public view returns(uint) {
        return num1 + number;
    }
}