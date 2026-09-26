#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
OUT="${TMPDIR:-/tmp}/cf_amp_ab_tb"
iverilog -g2005 -o "$OUT" \
  "$ROOT/hdl/gl/CF_AMP_AB.v" \
  "$ROOT/verify/beh_model/CF_AMP_AB_core.v" \
  "$ROOT/verify/beh_model/tb_CF_AMP_AB.v"
vvp "$OUT"
