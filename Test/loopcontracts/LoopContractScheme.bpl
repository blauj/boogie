// RUN: %boogie "%s" > "%t"
// RUN: %OutputCheck --file-to-check "%t" "%s"
// CHECK-L: Error BP5006: This loop precondition might not hold on entry.
// CHECK-L: Error BP5006: This loop precondition might not be maintained by the loop.
// CHECK-L: Error BP5006: This loop postcondition might not hold if the loop is never executed.
// CHECK-L: Error BP5006: This loop precondition might not hold on entry.
// CHECK-L: Error BP5003: A postcondition might not hold on this return path.
// CHECK-L: Boogie program verifier finished with 0 verified, 5 errors

function pre(x: int, y: int) : bool;
function post(x: int, y: int, z: int) : bool;
function guard(x: int, y: int) : bool;
function inv(x: int, y: int) : bool;
function freeinv(x: int, y: int) : bool;

function preP(x: int, y: int) : bool;
function postQ(x: int, y: int, z: int) : bool;

procedure body(x: int, y: int) returns (z: int);
procedure before_loop(x: int, y: int) returns (z: int);
procedure after_loop(x: int, y: int) returns (z: int);

procedure pro(a_x: int, a_y: int)
	returns (z: int)
	requires preP(a_x, a_y);
	ensures postQ(a_x, a_y, z);
{
	var x : int;
	var y : int;
	x := a_x;
	y := a_y;
	
	call x := before_loop(x, y);

	while(guard(x, y))
		requires pre(x, y);
		ensures post(before(x), x, y);
		invariant inv(x, y);
		free invariant freeinv(x, y);
	{
		call x := body(x, y);
	}
	
	call z := after_loop(x, y);
}