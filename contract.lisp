{
  [0] "Chronos"
  (call 0x11d11764cd7f6ecda172e0b72370e6ea7f75f290 0 0 0 32 0 0)
}

{
  ; Split the call data in groups of 32 bytes (2^256 = 2^8^32)
  ; Loop over this list with @i as an index
  (for () (< @i (/ (calldatasize) 32)) [i](+ @i 1) {
    ; Get the current hash
    [hash](calldataload (* @i 32))
    ; If the hash isn't already registered in storage, set a new entry
    (unless @@@hash [[@hash]](timestamp))
  })
}
