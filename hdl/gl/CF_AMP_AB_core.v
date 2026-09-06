// Empty blackbox stub for hierarchical integration LVS.
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
endmodule
