// Structural PG wrapper. Analog leaf is CF_AMP_AB_core.
// Customer rails are vpwr/vgnd; well taps vpb/vnb/vpbe are tied inside.
module CF_AMP_AB (
    vout,
    iref1,
    Vinn,
    Vinp,
    iref2,
    ibg_trim,
    pd,
    mode,
    vgnd,
    vneg,
    vpwr,
    vpwrlv,
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
    inout vneg;
    input vpwr;
    input vpwrlv;
    input enable_hv;
    input en_b;
    input in_sel;
    input iptat;
    input [4:0] iptat_trim;
    input [4:0] iptat_prc;
    input iptat_Ibg_eq;
    input phi_1;
    input phi_1b;
    CF_AMP_AB_core u_core (
        .vout(vout),
        .iref1(iref1),
        .Vinn(Vinn),
        .Vinp(Vinp),
        .iref2(iref2),
        .ibg_trim(ibg_trim),
        .pd(pd),
        .mode(mode),
        .vgnd(vgnd),
        .vnb(vgnd),
        .vneg(vneg),
        .vpb(vpwr),
        .vpwr(vpwr),
        .vpwrlv(vpwrlv),
        .vpblv(vpwrlv),
        .enable_hv(enable_hv),
        .en_b(en_b),
        .in_sel(in_sel),
        .iptat(iptat),
        .iptat_trim(iptat_trim),
        .iptat_prc(iptat_prc),
        .iptat_Ibg_eq(iptat_Ibg_eq),
        .phi_1(phi_1),
        .phi_1b(phi_1b)
    );
endmodule
