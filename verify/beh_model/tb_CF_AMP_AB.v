`timescale 1ns / 1ps

module tb_CF_AMP_AB;
    integer errors;
    reg iref1, Vinn, Vinp, iref2, pd, vgnd, vpwr, vpwrlv, enable_hv, en_b, in_sel, iptat, iptat_Ibg_eq, phi_1, phi_1b;
    reg [6:0] ibg_trim;
    reg [1:0] mode;
    reg [4:0] iptat_trim, iptat_prc;
    wire vout;
    wire vneg;

    CF_AMP_AB u (
        .vout(vout), .iref1(iref1), .Vinn(Vinn), .Vinp(Vinp), .iref2(iref2),
        .ibg_trim(ibg_trim), .pd(pd), .mode(mode), .vgnd(vgnd), .vneg(vneg),
        .vpwr(vpwr), .vpwrlv(vpwrlv), .enable_hv(enable_hv), .en_b(en_b),
        .in_sel(in_sel), .iptat(iptat), .iptat_trim(iptat_trim), .iptat_prc(iptat_prc),
        .iptat_Ibg_eq(iptat_Ibg_eq), .phi_1(phi_1), .phi_1b(phi_1b)
    );

    task expect_v;
        input real got;
        input real exp;
        input real tol;
        input [8*24-1:0] tag;
        begin
            if (got < exp - tol || got > exp + tol) begin
                $display("FAIL %s got=%g exp=%g", tag, got, exp);
                errors = errors + 1;
            end else $display("PASS %s %g", tag, got);
        end
    endtask

    initial begin
        errors = 0;
        iref1 = 0; Vinn = 0; Vinp = 0; iref2 = 0; pd = 0; vgnd = 0; vpwr = 1;
        vpwrlv = 1; enable_hv = 0; en_b = 0; in_sel = 0; iptat = 0; iptat_Ibg_eq = 0;
        phi_1 = 0; phi_1b = 1; ibg_trim = 0; mode = 0; iptat_trim = 0; iptat_prc = 0;
        u.u_core.vpwr_v = 1.8;
        u.u_core.vneg_v = 0.0;
        u.u_core.Vinp_v = 0.9;
        u.u_core.Vinn_v = 0.9;
        #1;
        expect_v(u.u_core.vout_v, 0.9, 1e-6, "mid");
        u.u_core.Vinp_v = 1.2;
        u.u_core.Vinn_v = 0.6;
        #1;
        expect_v(u.u_core.vout_v, 1.8, 1e-6, "high");
        if (vout !== 1'b1) begin
            $display("FAIL vout pin");
            errors = errors + 1;
        end
        pd = 1;
        #1;
        expect_v(u.u_core.vout_v, 0.0, 1e-9, "pd");
        pd = 0;
        en_b = 1;
        #1;
        expect_v(u.u_core.vout_v, 0.0, 1e-9, "disabled");
        if (errors == 0) $display("CF_AMP_AB behavioral self-check passed");
        else $display("CF_AMP_AB behavioral self-check FAILED %0d", errors);
        $finish(errors != 0);
    end
endmodule
