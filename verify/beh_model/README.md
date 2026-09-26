# CF_AMP_AB behavioral model

Ideal functional model for digital simulation. It is **not** SPICE-accurate
and it is **not** silicon-verified. Do not add this file to OpenLane
`VERILOG_FILES`.

## Files

| File | Replaces |
|---|---|
| `CF_AMP_AB_core.v` | `hdl/gl/CF_AMP_AB_core.v` |

Keep the customer wrap in `hdl/gl/CF_AMP_AB.v`. Do **not** compile the empty
`hdl/gl/CF_AMP_AB_core.v` stub in the same sim (duplicate module name).

```bash
./verify/beh_model/run_tb.sh
```

## Behavior

Ideal class-AB amplifier. `vout_v` sits at mid-rail for equal inputs and saturates toward `vpwr_v` when `Vinp_v` exceeds `Vinn_v`. `pd` or `en_b` high turns the output off.
