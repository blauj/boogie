// RUN: %boogie -noinfer -typeEncoding:m -useArrayTheory "%s" > "%t"
// RUN: %diff "%s.expect" "%t"
var {:layer 0,1} a:[int]int;

function {:builtin "MapConst"} MapConstBool(bool) : [int]bool;
function {:inline} {:linear "tid"} TidCollector(x: int) : [int]bool
{
  MapConstBool(false)[x := true]
}

procedure Allocate() returns ({:linear "tid"} xls: int);

procedure {:yields} {:layer 0,1} Write(idx: int, val: int);
ensures {:atomic} |{A: a[idx] := val; return true; }|;

procedure {:yields} {:layer 1} main() 
{
    var {:linear "tid"} i: int;
    var {:linear "tid"} j: int;
    call i := Allocate();
    call j := Allocate();
    par i := t(i) | j := t(j);
    par i := u(i) | j := u(j);
}

procedure {:yields} {:layer 1} t({:linear_in "tid"} i': int) returns ({:linear "tid"} i: int)
{
    i := i';

    yield;
    call Write(i, 42);
    call Yield(i);
    assert {:layer 1} a[i] == 42;
}

procedure {:yields} {:layer 1} u({:linear_in "tid"} i': int) returns ({:linear "tid"} i: int) 
{
    i := i';

    yield;
    call Write(i, 42);
    yield;
    assert {:layer 1} a[i] == 42;
}

procedure {:yields} {:layer 1} Yield({:linear "tid"} i: int)
ensures {:layer 1} old(a)[i] == a[i];
{
    yield;
    assert {:layer 1} old(a)[i] == a[i];
}