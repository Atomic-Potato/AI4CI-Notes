---

excalidraw-plugin: parsed
tags: [excalidraw]

---
==⚠  Switch to EXCALIDRAW VIEW in the MORE OPTIONS menu of this document. ⚠== You can decompress Drawing data with the command palette: 'Decompress current Excalidraw file'. For more info check in plugin settings under 'Saving'


# Excalidraw Data

## Text Elements
Exercise 4 ^slTLFG0P

# I was practicing before i did the lab
# and i did the factorial function recursively
# so understanding this would make the iterative one trivial

.global _start
.text

_start:
        li a0, 5
        jal _factorial

        li a7 1
        ecall

        li a7 10
        ecall

_factorial:
        # Save the return address and current factorial value
        # to the stack
        addi sp, sp, -8
        sw ra, 0(sp)
        sw a0, 4(sp)
        
        # end condition of the recursive function
        li t0, 1
        ble a0, t0, end
        
        # going down the recursive tree
        addi a0, a0, -1
        jal _factorial
        
        # when we are back we multiply our value with the total
        lw s1, 4(sp)
        mul a0, a0, s1
        
        # finishing up and returning
        lw ra, 0(sp)
        addi sp, sp, 8
        jr ra

end:
        li a0, 1
        addi sp, sp, 8
        jr ra  ^moldS5PN

%%
## Drawing
```compressed-json
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
```
%%