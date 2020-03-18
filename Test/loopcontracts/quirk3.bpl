// RUN: %boogie "%s" > "%t"
// RUN: %OutputCheck --file-to-check "%t" "%s"
// CHECK-L: (16,5): Error BP5001: This assertion might not hold.

procedure quirk1()
{
    var x: bool;

    while(true)
        ensures x; // holds vacously
    {
        x := false;
        break;
    }

    assert !x; // should in fact verify
}
