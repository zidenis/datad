+++
categories = ["Dart"]
title = "Tudo em Dart são objetos"
date = "2017-05-09T18:08:20-03:00"
slug = "tudo-objeto"
description = "Sobre o porque de Dart ser uma linguagem orientada à objetos pura"
draft = false
publishdate = "2017-04-01"
tags = ["Language","OOP"]

+++

Podemos dizer que Dart é uma linguagem orientada à objetos pura. Isso significa que todos os valores em tempo de execução são objetos, sem exceções. Este axioma (**tudo em Dart são objetos**) resulta em diferenças em relação a outras linguagens comuns. Por exemplo, diferentemente do que ocorre em Java com seus "tipos primitivos", até os dados mais simples como números e os boleanos `true` e `false` são objetos, até mesmo [null]({{< relref "null.md">}}), classes e funções são objetos. 

<!--more-->

Esta é uma característica de projeto da linguagem com objetivo de uniformizar  o tratamento dos dados, simplificando seu entendimento e uso. Isso simplifca, por exemplo, na medida em que não precisamos se preocupar com `boxing`/`unboxing` de tipos primitivos ([leia aqui para entender melhor](https://www.codingblocks.net/programming/steps-to-understanding-boxing-and-unboxing/)).

Sabemos que todo objeto é uma instância de uma classe. Como **tudo em Dart são objetos**, classes também são objetos e, portanto, classes são instâncias de uma classe (metaclasse). Todas as classes em Dart possuem a mesma metaclasse (`Type`). Para evitar uma regressão infinita, a linguagem define que a classe Type é uma instância dela mesmo. 

Para testar se um objeto é de um tipo, usamos o operador `is` ou `is!` . Por exemplo, a expressão `"str" is String` é avaliada como `true`. Mas, para descobrir qual a classe de um objeto podemos utilizar o método `runtimeType` herdado de Object que por padrão retorna uma representação do tipo do objeto em tempo de execução. Veja no exemplo abaixo que `print(s is String)` imprime `true` e `print(s.runtimeType)` imprime `String`. 

<code data-gist-id="d04c2060ae1a405cebd105259c49cab7" data-gist-hide-footer="true" data-gist-hide-line-numbers="true"></code>

Mas, conforme podemos observar na classe `NotDart` do código acima, um objeto pode mentir sobre seu tipo na medida em que classes podem sobrescrever o método `runtimeType`. Isto pode ser útil para criação de objetos tipo `proxy` e abstração de detalhes de implementação. Caso você esteja escrevendo um _software_ que precisa realmente saber qual a classe verdadeira de um objeto, deve-se utilizar `reflection` ([saiba mais](http://stackoverflow.com/a/20253047/5189478))

Como dito anteriormente, funções também são objetos. Todo objeto que declare um método `call()` é considerado uma função que implementa implicitamente a interface da classe `Function` definida no core do SDK. É por isso que no código abaixo a expressão `prettyFunc is Function` é avaliada como `true`.

<code data-gist-id="337e22e8f32079463f6569b33da3d7a1" data-gist-hide-footer="true" data-gist-hide-line-numbers="true"></code>

O método `call()` é tratado de forma especial pela linguagem. A chamada de uma função é traduzida para a chamada do método `call()` do objeto, dessa forma podemos omitir isso em `prettyFunc("C", "Dart is cool", "D");`. Perceba que na classe `Function` é declarado o método `apply()` que pode ser utilizado para chamar uma funções com uma lista de argumentos.



