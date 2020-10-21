# Extend P0 with Explicit Allocation and Deallocation

## Description:

The original version of P0 compiler only supports variables allocated on the stack or are global, which makes the compilation of generated code particularly simple. The goal of this project is to extend P0 (for WebAssembly) with heap-allocated objects that are explicitly deallocated when no longer needed. In this project, both P0 grammar and Code Generator for WASM are extended.

## Explicit Allocation and Deallocation:
- Explicit allocation occurs when the program asks for an object pointed by a Pointer **p** to be allocated on the heap. The memory management will find the block to store the object, for example by calling `new(p)`.
- Explicit deallocation occurs when the program asks for the block which is occupied by a heap-allocated object **p** to be freed. The memory management reclaims the memory block, for example by calling `dispose(p)`.

##  Prerequisites:
- WABT, the WebAssembly Binary Toolkit
- pywasm, a WebAssembly interpreter written in Python
	> Two packages should be installed if the notebook is run locally

## How to Run:
1.  Open ```Project_test.ipynb```
2. Click ```Kernel``` and select ```Restart & Run All```
	> Test cases are included in this notebook
	> Check the output of each case test

## Usage:
### Pointer Type
 Examples:
-  ` type p = ^integer;`
-   ` type p1 = ^array [1..5] of integer;`
-   ` type p2 = ^record t : integer; ... end;`
	  
### Variable of Pointer type
Examples:
- `var x : p`
- `var y : p1`
	
### New Function
> `new(p)`
##### Description: 
> allocate the object pointed by p to the heap explicitly
##### Parameter: 
> p : the pointer type variable
##### Returns:
> the address (integer) of the allocate block on the heap.

### Dispose Function
> `dispose(p)`
##### Description: 
> free the block occupied by the object pointed by p on the heap explicitly
##### Parameter: 
> p : the pointer type variable
##### Returns:
> None

### Examples:
```
Int[1]: 
compileString("""
program p;
  type p = ^integer;
  type p1 = array [1..3] of ^record tt : array [1..5] of integer end;
  type i = integer;
  var x : p;
  var y : p1;
  var z : i;
  begin
     z := 6;
     new(x);
     x^ := z;
     write(x^); {print 6}
     new(y[1]);
     y[1].tt[1]^ := 10;
     z := y[1].tt[1]^;
     write(z);
     dispose(x)
  end
""", dstfn = "test.wat")
```
** Generated code is written in "test.wat"
```
Out[1]: 
(module
(import "P0lib" "write" (func $write (param i32)))
(import "P0lib" "writeln" (func $writeln))
(import "P0lib" "read" (func $read (result i32)))
(global $z (mut i32) i32.const 0)
(func $program
i32.const 6
global.set $z
i32.const 0
i32.const 16
i32.store
i32.const 0
i32.load
global.get $z
i32.store
i32.const 0
i32.load
i32.load
call $write
i32.const 4
i32.const 20
i32.store
i32.const 4
i32.load
i32.const 10
i32.store
i32.const 4
i32.load
i32.load
global.set $z
global.get $z
call $write
i32.const 16
i32.const 0
i32.store
i32.const 0
i32.const 20000
i32.store
)
(memory 1)
(start $program)
)

```
```
Int[2]: !wat2wasm test.wat
```
```
Int[3]: runpywasm("test.wasm")
```
```
Out[3]:
6
10
```
```
Int[4]: print(heap.start) #print out the linked-list
```
```
Out[4]: 
adr is 16, size is 4, is_alloc: False, nxt: 
adr is 20, size is 20, is_alloc: True, nxt: 
None
```


## Contributors:
- Yujing Chen [001303292]
- Ziqing Xu [400079409]
- Baikai Wang [400084727]

## Resources:
- Jupyter Notebook
- Course material of P0 compiler

## Citation:
- [1]“WebAssembly Specification¶,” WebAssembly Specification - WebAssembly 1.0. [Online]. Available: https://webassembly.github.io/spec/core/index.html.
- [2] “Pascal - Pointers,” Tutorialspoint. [Online]. Available: https://www.tutorialspoint.com/pascal/pascal_pointers.htm. 
- [3] “Pascal - Memory Management,” Tutorialspoint. [Online]. Available: https://www.tutorialspoint.com/pascal/pascal_memory.htm.


