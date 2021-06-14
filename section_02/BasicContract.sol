// SPDX-License-Identifier: MIT
pragma solidity >=0.5.2 <0.9.0;

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


    // memory: guarda o valor da variavel temporariamente, enquanto a função estiver ativa;
    function setText (string memory myText) public {
        text = myText;
        setInteracted();
    }

    // payble valida a função para cobra ether;
    function setNumber (uint myNumber) public {
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