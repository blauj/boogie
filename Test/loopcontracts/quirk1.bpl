// RUN: %boogie "%s" > "%t"
// RUN: %OutputCheck --file-to-check "%t" "%s"
// CHECK-L: Boogie program verifier finished with 1 verified, 0 errors

procedure quirk1()
{
    var x: bool;

    while(true)
        ensures x; // holds vacously
    {
        x := false;
        break;
    }
}

