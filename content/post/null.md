+++
slug = "null"
description = "Detalha as características do Null na linguagem Dart"
tags = ["Language", "OOP"]
categories = ["Dart"]
title = "Entendendo o que é Null em Dart"
publishdate = "2017-04-30"
date = "2017-04-30T10:02:37-03:00"

+++

`null` apresenta particularidades em Dart que o diferencia da implementação em outras linguagens de programação como C, Java e Javascript. A começar por `null` ser um objeto como qualquer outro (em Dart tudo é um objeto) enquanto que em Java, por exemplo, ele é um valor literal. São questões sutís que precisamos ficar atentos na hora de programar, conforme veremos.

<!--more-->

A expressão `null` é uma palavra reservada da linguagem que representa o objeto _null_. Esse objeto é a **única instância** da classe `Null`, implementada na [_Dart SDK Core Library_](https://github.com/dart-lang/sdk/blob/master/sdk/lib/core/null.dart) conforme código abaixo (simples, não?). Ou seja, não é possível instanciar um novo objeto dessa classe. A linguagem também não permite que a classe `Null` seja herdada (`extends`) ou tenha sua interface reusada (`implements`).

<code data-gist-id="5cf8f8ae92e359fcee5d0a5f2b54f046" data-gist-line="5,6,14-17,19,22,23" data-gist-hide-footer="true" data-gist-hide-line-numbers="true"></code>

Um detalhe -- o diabo mora neles -- a partir da [versão 1.22](https://github.com/dart-lang/sdk/blob/master/CHANGELOG.md#language-1) o tipo `Null` é um tipo `bottom` da linguagem. Ou seja, é considerado subtipo de **todos** os outros tipos. Na prática, o objeto `null` sempre foi tratado na linguagem como sendo do tipo `bottom`, tanto é que `null` pode ser atribuído a variáveis de qualquer tipo (exemplo `int variavelA = null;`). 

É importante notar que **toda** nova variável alocada é inicialmente uma referência para `null`. Isso garante que o usuário nunca encontre uma variável não inicializada em memória, o que poderia resultar em comportamentos indeterminados, assim como pode ocorrer na linguagem C.

<code data-gist-id="946a4c92c987c399fff5f22b9caf976b" data-gist-hide-footer="true" data-gist-hide-line-numbers="true"></code>

Mas é por conta dessa referência para `null` que esbarramos nos famigerados erros `NullPointerException` (Java) ou `Uncaught TypeError` (Dart). A necessidade de tratar essas ocorrências é tão frequente que Dart a partir da [versão 1.12](http://news.dartlang.org/2015/08/dart-112-released-with-null-aware.html) fornece operadores especiais, chamados de `null-aware operators`. Eles ajudam a reduzir a quantidade de código, tornando-o mais legível e expressivo. 

 * **`??` _if-null operator_**

A expressão `exp1 ?? exp2` resulta no valor de `exp1` caso `exp1 != null` ou no valor de `exp2` caso `exp1 == null`. 

<code data-gist-id="648ac7ea9b3ed11b04a39d6ad45bad90" data-gist-hide-footer="true" data-gist-hide-line-numbers="true"></code>

 * **`??=` _null-aware assignment_**

Esse é um operador que combina o operador de atribuição `=` com a condição `== null` de forma que a atribuição só é realizada se a variável for nula. Ou seja, a declaração `variable ??= exp` faz com que o valor de `exp` seja atribuído a `variable` somente se `variable == null`. 

<code data-gist-id="d539247177490033fe7945912beffbe3" data-gist-hide-footer="true" data-gist-hide-line-numbers="true"></code>

 * **`?.` _conditional member access_**

Este operador realiza o acesso a um membro do objeto (propriedade ou método) desde que o objeto não seja igual a `null`. Ou seja, `obj?.prop` é avaliada como `obj.prop` se `obj != null` ou como `null` se `obj == null`, e o método `obj?.met()` chama o método `met()`somente se `obj != null`.

<code data-gist-id="78cd3ae0723e073b5caf5104e611f40d" data-gist-hide-footer="true" data-gist-hide-line-numbers="true"></code>

Ainda assim, essa é uma questão tão importante que uma provável evolução da linguagem é o suporte a tipos não-nuláveis (`non-nullable types`). De fato, tipos não-nulos podem ser o padrão (_Non Nullable by Default_ - NNBD) da linguagem, uma mudança impactante que quebraria a compatibilidade (_breaking change_) com os códigos atuais e, portanto, deve fazer parte apenas com Dart 2.0.