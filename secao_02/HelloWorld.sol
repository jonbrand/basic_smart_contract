// SPDX-License-Identifier: MIT
pragma solidity >=0.5.2 <0.9.0;

contract HelloWorld {
    // tipo | visibilidade | nome
    string public text;

    // memory: guarda o valor da variavel temporariamente, enquanto a função estiver ativa;
    function setText (string memory myText) public {
        text = myText;
    }
}