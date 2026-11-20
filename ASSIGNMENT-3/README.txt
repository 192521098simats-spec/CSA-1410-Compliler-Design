ASSIGNMENT 3 – CO3 | FLEX/BISON SOURCE PACKAGE

Files:
- lexer.l       Flex lexical analyser
- parser.y      Bison grammar and semantic actions
- sample_minilang.txt  sample input
- expected_output.txt  reference-format output for the sample
- online_compiler_steps.txt  how to run using an online Flex/Bison compiler

Important honesty note:
The source files are supplied for compilation in a Flex/Bison environment. This workspace
does not contain Flex or Bison, so the attached output panels are clearly marked as
reference/expected output, not falsely represented as screenshots captured from an online
compiler. Compile and run the source in your institution-approved online compiler and
replace the reference panels with genuine screenshots if your faculty requires live-run proof.

Typical local commands:
  bison -d parser.y
  flex lexer.l
  gcc -o minilang parser.tab.c lex.yy.c -lfl
  ./minilang < sample_minilang.txt

Some online environments use `gcc parser.tab.c lex.yy.c -o minilang -lfl`.
