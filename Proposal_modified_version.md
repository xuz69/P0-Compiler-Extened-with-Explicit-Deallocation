# CS4TB3 Project Proposal

### Group Members [Group 01]:
1. Yujing Chen, 001303292
2. Ziqing Xu, 400079409
3. Baikai Wang, 400084727

## Brief Description:

The goal is to extend P0 (for WebAssembly) with heap-allocated objects that are explicitly deallocated when no longer needed. 

## Explicit Deallocation:

Explicit deallocation occurs when the program asks for the block which is occupied by a heap-allocated object **p** to be freed. The memory management reclaims the memory block, for example by calling `dispose(p)`.

### Problems:
1. If the memory is freed to early, it may lead to **dangling reference**.
2. If the memory is freed to late or never, it may lead to **space leak**.

### Techniques:
1. **Linked-list** can be used to implement heap manager for managing allocated heap objects and free block.

## How to implement

1. `malloc()` and `dispose()` are two new **stdProc**.
> `malloc()` is the procedure for program to allocate object on the **heap**. For example, `var x : heapobj; x := malloc(100*sizeof(type))` where **x** is a heap-allocated object, type could be **int** or **bool**. Every object on the heap should contain a pointer, the type tag, the size and offset. 
> 
> `dispose()` is the procedure for a program to deallocate a block of memory previously allocated on the heap using `malloc()` functions. For example, `dispose(x)` is called to deallocate **x** and free the memory block on the heap. If **x** is not a heap-allocated object, then the program will raise error. 
2. P0 Grammar should be extended, for example, `statement ::= ident ':=' ident '(' expression '*' 'sizeof' '(' type ')' ')'` should be added.
3. In the scanner module **(SC)**, keywords should be extended with `HEAPOBJ` and  `SIZEOF`.
4. In the symbol table module **(ST)**, entries should be extended with class `Heapobj` for heap-allocated objects.
5. Implementing a linked-list class as heap manager. Each block in the linked-list is an object of class **Heapobj** which contains the type, the size and a pointer which points to the next block of the linked-list. Implementing a linked-list is helpful to test the implementation of `malloc()` and `dispose()`.
6. Since we will implement the generated code in assembly language as a string in textual **WebAssembly**, heap-allocated objects will be managed in the WebAssembly memory by `(import "env" "malloc" (func $malloc (param i32) (result i32)))` and `(import "env" "free" (func $free (param i32)))`. In the CGwat module, `lev` field should be extended for the heap memory, then`genCreateHeapobj()` and `genDeleteHeapobj()` are needed.
> `genCreateHeapobj()`: when `malloc()` is called, it will allocate objects on the heap in WebAssembly memory.
> 
>  `genDeleteHeapobj()`: when `dispose()` is called, it will deallocate objects on the heap in WebAssembly memory.

## Challenge
- Implementing linked-list and managing a linked-list of free blocks on the heap
- Handling dangling reference by raising error
- Extending code generator part with implementing `genCreateHeapobj()` and `genDeleteHeapobj()`.

## Testing

-  One method is to list out all blocks in the linked-list to check if an object is allocated or deallocated successfully. For example, after calling `malloc(p)`, it can be tested by checking whether p is on the linked-list. And after calling `dispose(p)`,  it can also be tested by checking whether p is removed from the linked-list.
-  Another method is to check the WASM instruction of the program.

## Insight

We hope to develop a deeper understanding about P0 compiler structure and the implementation of explicit heap allocation and  deallocation.

## Work Division

|Milestone                      |Goal                         
|-------------------------------|---------------------------|
|Extend P0 grammar for explicit deallocation               | For implementing explicit allocation and deallocation, grammar should be extended, for example, `statement ::= ident ':=' ident '(' expression '*' 'sizeof' '(' type ')' ')'` should be extended for the non-terminal `statement`. The goal is to extend P0 grammar to meet the requirement for the implementation of explicit allocation and deallocation    |
|Extend scanner module         | Add required tokens	    |
|Extend symbol table module          | Extend ST with `Heapobj` class for heap-allocated objects	    |
|Linked-list class               | Implement Linked-list class, each object of linked-list should contain a head which is a `Heapobj` object	    |
|Extend parser module             | Implement the extended P0 grammar	    |
|Extend CGwat module             |Implement `genCreateHeapobj()` and `genDeleteHeapobj()` 	    |
|Testing & Debugging             | Testing whether an object can be allocated or deallocated successfully; Debugging all the errors    |
|Poster & Submission            | Design poster    |
|Submission               |Submit all the source codes, pdf of the poster, tests and documentation. 	    |
|Presentation               | Present this project efficiently 	    |

## Weekly Schedule

|Milestone                      |Date                         
|-------------------------------|---------------------------|
|Extend P0 grammar, SC module, ST module and Linked-list class              |Mar 8 - Mar 13	    | 
|Extend parser module and CGwat module     | Mar 14 - Mar 20    |
|Testing & Debugging            |Mar 21 – Mar 24	    |
|Poster Design              	|Mar 25 – Mar 27	    |
|Submission              	|April 1	    |
|Presentation              	|April 8	    |

## Documentation

This project will be documented by a README file, API documentation and code documentation. In the README file, it contains a brief description of the project, issues that detected during the implementation, and citation and licensing information. The API documentation will include what a function does and what a function returns. In addition, the source code will be documented with comments which are beneficial for others to easily read and re-use the code.

## Resources

### Software:
- Jupyter Notebook
- Nbimporter
- WebAssembly

### Others:
- Guybedford, “guybedford/wasm-intro,” GitHub, 26-May-2017. [Online]. Available: https://github.com/guybedford/wasm-intro. [Accessed: 07-Mar-2020].
- “OpenDSA Data Structures and Algorithms Modules Collection,” 5.6. Heap Memory - OpenDSA Data Structures and Algorithms Modules Collection. [Online]. Available: https://opendsa-server.cs.vt.edu/ODSA/Books/Everything/html/HeapMem.html. [Accessed: 07-Mar-2020].
- Instructions - WebAssembly 1.0. [Online]. Available: https://webassembly.github.io/spec/core/syntax/instructions.html#memory-instructions. [Accessed: 07-Mar-2020].
- “Library Guides: How to Write a Good Documentation: Home,” Home - How to Write a Good Documentation - Library Guides at UC Berkeley. [Online]. Available: https://guides.lib.berkeley.edu/how-to-write-good-documentation. [Accessed: 07-Mar-2020].
