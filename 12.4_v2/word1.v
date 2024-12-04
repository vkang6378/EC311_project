module word1 (
    input wire [4:0] rom_addr,
    output wire [0:159] M1
);

    reg [0:159] rom1[0:31];
    parameter data = {
    160'h0000000000000000000000000000000000000000, 
    160'h0000000000000000000000000000000000000000, 
    160'h00003c000000380001c000000000ee000003c000, 
    160'h0e003c000c063c0001e000f00000ff000003e000, 
    160'h0f003c180f07b80001cffff80000f7800001e038, 
    160'h07803c3c0787b80001c7c0f00000f7800e00e07c, 
    160'h07bffffc078738c001c0c1e0003de3980ffffffe, 
    160'h079c3c60078f39e001c0e3c03fffe33c0f0e0700, 
    160'h07003cf0038ffff001de77c01c3dfffc0f0f0780, 
    160'h000ffff8030e38007fff7f800039c7000f0e0730, 
    160'h00073c00001c380039c03f00303bc7000f0e0778, 
    160'h07003c18001c380001c03f00387bc7000ffffffc, 
    160'hff803c3c03b8383001c07fc01c7fc7300fce0700, 
    160'h77fffffe7ff0387801dffffe0e77c7780f0e0700, 
    160'h0738000077fffffc01ffdffe0f7ffffc0f0e0700, 
    160'h070600e007b9ce0001ff9e7807ffc7000f0e0700, 
    160'h0707fff00781ce0007fc1c3003fdc7000e0fff00, 
    160'h070700f00781ce003fc01c7801f9c7000e0e0700, 
    160'h070700e00781ce007fcffffc01e1c7000e0c0380, 
    160'h070700e00783ce187dc71c0003f1c7300e7fffc0, 
    160'h071fffe007838e1831c01c0003f1c7780e3e07c0, 
    160'h073f00e007878e1801c01c1807f9fffc0e070f80, 
    160'h077700e007870e1801c01c3c0739c7001e078f00, 
    160'h07e7ffe0078f0e3c01dffffe0e3dc7001c03de00, 
    160'h07e700e00f9e0ffc01de1c001e3dc7001c01fc00, 
    160'h07c700e03ff80ffc01c01c003c19c7181c00f800, 
    160'h078700e07cf0000001c01c007819c73c3801fc00, 
    160'h070700e0f87fc0ff3fc01c00f001fffe3807ffc0, 
    160'h03070fe0701ffffe3fc01c00c001c000703f0ffe, 
    160'h000703e00007fff807c01c000001c00071fc03fe, 
    160'h000701c00000000003801c000001c000e7e00078, 
    160'h0000000000000000000000000000000000000000
    };

    integer i;   //初始化，将data的数值输入到rom1中
    initial begin
        for (i = 0;i < 32;i = i +1) 
            rom1[i] = data[(5119-160*i)-:160];
    end

    assign M1 = rom1[rom_addr];
endmodule