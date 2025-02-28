# The C_ Programming Dialect

## A traditional introduction

The C_ dialect provides a set of abstractions for the C programming language. Its reference implementation is a proof of concept that is intended to conform with *ISO/IEC 9899:2024* (commonly known as C23), which is the current revision of the C standard. The design is based on a header-only architecture, making it open source by nature; it does not require a separate front-end for C compilers or installation of any additional software. At a high level, the reference implementation is essentially a preprocessing-based transpiler which converts C_ code to C code. Since it is possible to emulate almost the entirety of C_ using C (C23), we do not refer to C_ as a new programming language, but consider it a dialect of C.

C_ was created with an aim to simplify programming, while also making it harder for things to go wrong; the latter is a more ambitious goal, and the extent of its fulfillment largely rests on the programmer. C_ facilitates "abstraction-oriented programming", which blends several concepts from functional programming and object-oriented programming paradigms. Proper use of the right abstractions reduces the chances of bugs.

## Talk is cheap, show me how to run the code

The best approach to explore a new programming language (or dialect in this case) is to get started by running sample programs. The [examples/](https://github.com/cHaR-shinigami/c_/tree/main/examples) directory contains several code snippets that demonstate the usage and workings of C_ features. It contains three sub-directories: [.include/](https://github.com/cHaR-shinigami/c_/tree/main/examples/.include), [include/](https://github.com/cHaR-shinigami/c_/tree/main/examples/.include), and [compile/](https://github.com/cHaR-shinigami/c_/tree/main/examples/.include). **The most important task is to make sure that our compiler is able to *locate* the header files**. The sample examples have been tested with `gcc` (version 14) and `clang` (version 19), both of which support similar options. For Unix-based systems, if we assume that `examples/` is present in the home directory, then the following options can be used:

`gcc/clang -xc -std=c23 -iprefix "$HOME"/examples/.include -iwithprefix/ellipsis -iwithprefix/dialect -iwithprefix/library -iprefix "$HOME"/examples/include -iwithprefix/.`

If one is using bash shell, then things can be simplified with a command alias placed in `~/.bashrc` or `~/.bash_aliases` file; here is an example using `gcc`.

`alias cc_="gcc -xc -std=c23 -iprefix '$HOME'/examples/.include -iwithprefix/ellipsis -iwithprefix/dialect -iwithprefix/library -iprefix '$HOME'/examples/include -iwithprefix/.`

The file [discount.c_](https://github.com/cHaR-shinigami/c_/blob/main/examples/compile/discount.c_) contains an introductory example, which can be compiled as: `cc_ lib.c_ discount.c_` (assuming `compile/` is the current directory). If things go well, we can run the executable as `./a.out 4` (the program expects number of items as a command-line argument). Executing the script [build.sh](https://github.com/cHaR-shinigami/c_/blob/main/examples/build.sh) creates an additional directory named `object/` to store object files; it enables several warnings and optimizations for the compiler (`gcc` or `clang`), whose details can be found in the documentation.

**Note**: Some of the code may not compile with older versions of `gcc` and `clang`, due to the use of C23 features whose support was added in recent versions.

## If a library is worth writing, it is also worth documenting

The full documentation has been prepared in LaTeX and the accompanying file [c_.pdf](https://github.com/cHaR-shinigami/c_/blob/main/c_.pdf) is the generated outcome: it specifies the syntax, constraints, and semantics of various features in C_, without describing the implementation details. Programmers are free to write their own implementation of C_ that conforms to or refines the abstract semantics described in this document.

The intent of documenting C_ in terms of its abstract semantics is two-fold: firstly, readers need not get bogged down to implementation details, which can often be an unnecessary distraction. The second reason is more important: this approach isolates the abstract behavior from any particular concrete implementation, which allows a future scope of providing more efficient translators for C_. Any serious discrepancy between the reference implementation and contents of the documentation is unintentional, and may be considered as a "bug".
