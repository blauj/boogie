// RUN: %boogie "%s" > "%t"
// RUN: %OutputCheck --file-to-check "%t" "%s"
// CHECK-L: Boogie program verifier finished with 1 verified, 0 errors

function gcd(m: int, n: int): int;
axiom (forall m: int :: m > 0 ==> gcd(m, m) == m);
axiom (forall m, n: int :: m > 0 && n > 0 ==> gcd(m, n) == gcd(n, m));
axiom (forall m, n: int :: m >= n ==> gcd(m, n) == gcd(m - n, n));

procedure euclid(a_m : int, a_n : int) returns (r : int)
	requires a_m > 0 && a_n > 0;
	ensures r == gcd(a_m, a_n);
	{
	  var m,n : int;
	  m := a_m;
	  n := a_n;
	  while (m != n) 
		requires m > 0 && n > 0;
		ensures n == gcd(before(m), before(n));
	  {
		if (m > n) {
		  m := m - n;
		} else {
		  n := n - m;
		}
	  }
	  r := n;
	}