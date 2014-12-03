clearinfo
@test(124)
@test(-14324)
@test(0.5)
@test(-085.3)

procedure test (.n)
  .base = 16
  @dec2n(.n, .base)
  @n2dec(dec2n.n$, .base)
  assert n2dec.n - .n < 0.000001
  appendInfoLine: .n, " -> ", dec2n.n$, " -> ", n2dec.n
endproc
