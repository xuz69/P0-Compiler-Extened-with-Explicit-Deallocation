(module
(import "P0lib" "write" (func $write (param i32)))
(import "P0lib" "writeln" (func $writeln))
(import "P0lib" "read" (func $read (result i32)))
(global $i (mut i32) i32.const 0)
(func $program
i32.const 2
global.set $i
loop
global.get $i
i32.const 0
i32.gt_s
if
i32.const 0
i32.const 20
i32.store
br 1
end
end
global.get $i
i32.const 1
i32.sub
global.set $i
)
(memory 1)
(start $program)
)