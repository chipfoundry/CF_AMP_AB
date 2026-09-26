`timescale 1ns / 1ps

// Ideal functional model of analog leaf CF_AMP_AB_core.
// Drop this file in place of hdl/gl/CF_AMP_AB_core.v for simulation.
// Do not add it to OpenLane VERILOG_FILES.
//
// Analog values are Verilog real backdoors (1-bit pins stay digital):
//   Vinp_v, Vinn_v, vout_v, vpwr_v, vneg_v
//
// Assumed protocol (ideal, not silicon-verified):
//   * pd high or en_b high → output off, vout_v = 0
//   * else vout_v = vpwr_v/2 + gain*(Vinp_v - Vinn_v), clamped to vneg_v..vpwr_v
// Mode, input select, trims, chopper clocks, and bias currents are not modeled.

module CF_AMP_AB_core (
    vout,
    iref1,
    Vinn,
    Vinp,
    iref2,
    ibg_trim,
    pd,
    mode,
    vgnd,
    vnb,
    vneg,
    vpb,
    vpwr,
    vpwrlv,
    vpblv,
    enable_hv,
    en_b,
    in_sel,
    iptat,
    iptat_trim,
    iptat_prc,
    iptat_Ibg_eq,
    phi_1,
    phi_1b
);
    output vout;
    input iref1;
    input Vinn;
    input Vinp;
    input iref2;
    input [6:0] ibg_trim;
    input pd;
    input [1:0] mode;
    input vgnd;
    input vnb;
    inout vneg;
    input vpb;
    input vpwr;
    input vpwrlv;
    input vpblv;
    input enable_hv;
    input en_b;
    input in_sel;
    input iptat;
    input [4:0] iptat_trim;
    input [4:0] iptat_prc;
    input iptat_Ibg_eq;
    input phi_1;
    input phi_1b;

    localparam real GAIN = 1.0e3;
    localparam real V_PRESENT = 0.05;

    real Vinp_v;
    real Vinn_v;
    real vout_v;
    real vpwr_v;
    real vneg_v;
    real vraw;

    initial begin
        Vinp_v = 0.9;
        Vinn_v = 0.9;
        vpwr_v = 1.8;
        vneg_v = 0.0;
        vout_v = 0.0;
    end

    always @(*) begin
        if ((pd === 1'b1) || (en_b === 1'b1)) begin
            vout_v = 0.0;
        end else begin
            vraw = (vpwr_v / 2.0) + (GAIN * (Vinp_v - Vinn_v));
            if (vraw > vpwr_v)
                vout_v = vpwr_v;
            else if (vraw < vneg_v)
                vout_v = vneg_v;
            else
                vout_v = vraw;
        end
    end

    assign vout = (vout_v > V_PRESENT) ? 1'b1 : 1'b0;
endmodule
