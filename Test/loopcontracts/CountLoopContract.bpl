// RUN: %boogie "%s" > "%t"
// RUN: %OutputCheck --file-to-check "%t" "%s"
// CHECK-L: Boogie program verifier finished with 1 verified, 0 errors

procedure count(a_to: int) returns (r: int)
	requires a_to >= 0;
	ensures r == a_to;
	{
		var x: int;
		x := 0;
		
		while(x < a_to)
			requires a_to >= x;
			ensures x == a_to;
			{
				x := x + 1;
			}
		r := x;
	}