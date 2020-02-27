// RUN: %boogie "%s" > "%t"
// RUN: %OutputCheck --file-to-check "%t" "%s"
// CHECK-L: (15,4): Error BP5006: This loop postcondition might not hold if the loop is never executed.

procedure count(a_to: int) returns (r: int)
	requires a_to >= 0;
	ensures r == a_to;
	{
		var x: int;
		x := 0;
		
		while(x < a_to)
			requires a_to >= x;
			ensures x == a_to;
			ensures x > a_to;
			{
				x := x + 1;
			}
		r := x;
	}