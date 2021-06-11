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

    // memory: guarda o valor da variavel temporariamente, enquanto a função estiver ativa;
    function setText (string memory myText) public {
        text = myText;
    }

    function setNumber (uint myNumber) public {
        number = myNumber;
    }

    // função que pega o endereço do usuario;
    function setUserAddress () public {
        userAddress = msg.sender;
    }

    // função booleana;
    function setAnswer(bool trueOrFalse) public {
        answer = trueOrFalse;
    }
}