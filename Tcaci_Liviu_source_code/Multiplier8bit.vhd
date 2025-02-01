library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplier8bit is
    Port (
        A: in  STD_LOGIC_VECTOR(7 downto 0); -- Operandul A (8 biți)
        B: in  STD_LOGIC_VECTOR(7 downto 0); -- Operandul B (8 biți)
        P: out STD_LOGIC_VECTOR(15 downto 0) -- Produsul rezultat (16 biți)
    );
end Multiplier8bit;

architecture Behavioral of Multiplier8bit is
    -- Componenta AdderSubtractor1bit
    component AdderSubtractor1bit
        Port (
            A: in  STD_LOGIC;
            B: in  STD_LOGIC;
            Cin: in  STD_LOGIC;
            Op: in  STD_LOGIC;
            Result: out STD_LOGIC;
            Cout: out STD_LOGIC
        );
    end component;

    signal p0,p1,p2,p3,p4,p5,p6,p7 : std_logic_vector(7 downto 0);
    ------------First step  signals ---------
    signal s11,s12,s13,s14,s15,s16,s17,s18,s19 : std_logic;
    signal c10,c11,c12,c13,c14,c15,c16,c17,c18,c19 : std_logic;
    ------------Second step  signals ---------
    signal s21,s22,s23,s24,s25,s26,s27,s28,s29,s210 : std_logic;
    signal c20,c21,c22,c23,c24,c25,c26,c27,c28,c29,c210 : std_logic;
    ------------Third step  signals ---------
    signal s31,s32,s33,s34,s35,s36,s37,s38,s39,s310,s311 : std_logic;
    signal c30,c31,c32,c33,c34,c35,c36,c37,c38,c39,c310,c311 : std_logic;
    ------------Fourth step  signals ---------
    signal s41,s42,s43,s44,s45,s46,s47,s48,s49,s410,s411,s412 : std_logic;
    signal c40,c41,c42,c43,c44,c45,c46,c47,c48,c49,c410,c411,c412 : std_logic;
    ------------Fifth step  signals ---------
    signal s51,s52,s53,s54,s55,s56,s57,s58,s59,s510,s511,s512,s513 : std_logic;
    signal c50,c51,c52,c53,c54,c55,c56,c57,c58,c59,c510,c511,c512,c513 : std_logic;
    ------------Sixth step  signals ---------
    signal s61,s62,s63,s64,s65,s66,s67,s68,s69,s610,s611,s612,s613,s614 : std_logic;
    signal c60,c61,c62,c63,c64,c65,c66,c67,c68,c69,c610,c611,c612,c613,c614 : std_logic;
    ------------Seventh step  signals ---------
    signal s71,s72,s73,s74,s75,s76,s77,s78,s79,s710,s711,s712,s713,s714,s715 : std_logic;
    signal c70,c71,c72,c73,c74,c75,c76,c77,c78,c79,c710,c711,c712,c713,c714,c715 : std_logic;

begin
    ----------First line------
    p0(0)<=b(0) and a(0);
    p0(1)<=b(0) and a(1);
    p0(2)<=b(0) and a(2);
    p0(3)<=b(0) and a(3);
    p0(4)<=b(0) and a(4);
    p0(5)<=b(0) and a(5);
    p0(6)<=b(0) and a(6);
    p0(7)<=b(0) and a(7);
    ----------Second line------
    p1(0)<=b(1) and a(0);
    p1(1)<=b(1) and a(1);
    p1(2)<=b(1) and a(2);
    p1(3)<=b(1) and a(3);
    p1(4)<=b(1) and a(4);
    p1(5)<=b(1) and a(5);
    p1(6)<=b(1) and a(6);
    p1(7)<=b(1) and a(7);

    ----------Third line------
    p2(0)<=b(2) and a(0);
    p2(1)<=b(2) and a(1);
    p2(2)<=b(2) and a(2);
    p2(3)<=b(2) and a(3);
    p2(4)<=b(2) and a(4);
    p2(5)<=b(2) and a(5);
    p2(6)<=b(2) and a(6);
    p2(7)<=b(2) and a(7);

    ----------Fourth line------
    p3(0)<=b(3) and a(0);
    p3(1)<=b(3) and a(1);
    p3(2)<=b(3) and a(2);
    p3(3)<=b(3) and a(3);
    p3(4)<=b(3) and a(4);
    p3(5)<=b(3) and a(5);
    p3(6)<=b(3) and a(6);
    p3(7)<=b(3) and a(7);

    ----------Fifth line------
    p4(0)<=b(4) and a(0);
    p4(1)<=b(4) and a(1);
    p4(2)<=b(4) and a(2);
    p4(3)<=b(4) and a(3);
    p4(4)<=b(4) and a(4);
    p4(5)<=b(4) and a(5);
    p4(6)<=b(4) and a(6);
    p4(7)<=b(4) and a(7);

    ----------Sixth line------
    p5(0)<=b(5) and a(0);
    p5(1)<=b(5) and a(1);
    p5(2)<=b(5) and a(2);
    p5(3)<=b(5) and a(3);
    p5(4)<=b(5) and a(4);
    p5(5)<=b(5) and a(5);
    p5(6)<=b(5) and a(6);
    p5(7)<=b(5) and a(7);

    ----------Seventh line------
    p6(0)<=b(6) and a(0);
    p6(1)<=b(6) and a(1);
    p6(2)<=b(6) and a(2);
    p6(3)<=b(6) and a(3);
    p6(4)<=b(6) and a(4);
    p6(5)<=b(6) and a(5);
    p6(6)<=b(6) and a(6);
    p6(7)<=b(6) and a(7);

    ----------Eighth line------
    p7(0)<=b(7) and a(0);
    p7(1)<=b(7) and a(1);
    p7(2)<=b(7) and a(2);
    p7(3)<=b(7) and a(3);
    p7(4)<=b(7) and a(4);
    p7(5)<=b(7) and a(5);
    p7(6)<=b(7) and a(6);
    p7(7)<=b(7) and a(7);

    ---------First -------
    f11: AdderSubtractor1bit port map(p0(0), '0', '0', '0', s11, c11);
    f12: AdderSubtractor1bit port map(p0(1), p1(0), c11, '0', s12, c12);
    f13: AdderSubtractor1bit port map(p0(2), p1(1), c12, '0', s13, c13);
    f14: AdderSubtractor1bit port map(p0(3), p1(2), c13, '0', s14, c14);
    f15: AdderSubtractor1bit port map(p0(4), p1(3), c14, '0', s15, c15);
    f16: AdderSubtractor1bit port map(p0(5), p1(4), c15, '0', s16, c16);
    f17: AdderSubtractor1bit port map(p0(6), p1(5), c16, '0', s17, c17);
    f18: AdderSubtractor1bit port map(p0(7), p1(6), c17, '0', s18, c18);
    f19: AdderSubtractor1bit port map('0', p1(7), c18, '0', s19, c19);
    ------Second
    f21: AdderSubtractor1bit port map(s11, '0', '0', '0', s21, c21);
    f22: AdderSubtractor1bit port map(s12, '0', c21, '0', s22, c22);
    f23: AdderSubtractor1bit port map(s13, p2(0), c22, '0', s23, c23);
    f24: AdderSubtractor1bit port map(s14, p2(1), c23, '0', s24, c24);
    f25: AdderSubtractor1bit port map(s15, p2(2), c24, '0', s25, c25);
    f26: AdderSubtractor1bit port map(s16, p2(3), c25, '0', s26, c26);
    f27: AdderSubtractor1bit port map(s17, p2(4), c26, '0', s27, c27);
    f28: AdderSubtractor1bit port map(s18, p2(5), c27, '0', s28, c28);
    f29: AdderSubtractor1bit port map(s19, p2(6), c28, '0', s29, c29);
    f210: AdderSubtractor1bit port map(c19, p2(7), c29, '0', s210, c210);
    ---------Third
    f31: AdderSubtractor1bit port map(s21, '0', '0', '0', s31, c31);
    f32: AdderSubtractor1bit port map(s22, '0', c31, '0', s32, c32);
    f33: AdderSubtractor1bit port map(s23, '0', c32, '0', s33, c33);
    f34: AdderSubtractor1bit port map(s24, p3(0), c33, '0', s34, c34);
    f35: AdderSubtractor1bit port map(s25, p3(1), c34, '0', s35, c35);
    f36: AdderSubtractor1bit port map(s26, p3(2), c35, '0', s36, c36);
    f37: AdderSubtractor1bit port map(s27, p3(3), c36, '0', s37, c37);
    f38: AdderSubtractor1bit port map(s28, p3(4), c37, '0', s38, c38);
    f39: AdderSubtractor1bit port map(s29, p3(5), c38, '0', s39, c39);
    f310: AdderSubtractor1bit port map(s210, p3(6), c39, '0', s310, c310);
    f311: AdderSubtractor1bit port map(c210, p3(7), c310, '0', s311, c311);

    ---------Fourth
    f41: AdderSubtractor1bit port map(s31, '0', '0', '0', s41, c41);
    f42: AdderSubtractor1bit port map(s32, '0', c41, '0', s42, c42);
    f43: AdderSubtractor1bit port map(s33, '0', c42, '0', s43, c43);
    f44: AdderSubtractor1bit port map(s34, '0', c43, '0', s44, c44);
    f45: AdderSubtractor1bit port map(s35, p4(0), c44, '0', s45, c45);
    f46: AdderSubtractor1bit port map(s36, p4(1), c45, '0', s46, c46);
    f47: AdderSubtractor1bit port map(s37, p4(2), c46, '0', s47, c47);
    f48: AdderSubtractor1bit port map(s38, p4(3), c47, '0', s48, c48);
    f49: AdderSubtractor1bit port map(s39, p4(4), c48, '0', s49, c49);
    f410: AdderSubtractor1bit port map(s310, p4(5), c49, '0', s410, c410);
    f411: AdderSubtractor1bit port map(s311, p4(6), c410, '0', s411, c411);
    f412: AdderSubtractor1bit port map(c311, p4(7), c411, '0', s412, c412);

    ---------Fifth
    f51: AdderSubtractor1bit port map(s41, '0', '0', '0', s51, c51);
    f52: AdderSubtractor1bit port map(s42, '0', c51, '0', s52, c52);
    f53: AdderSubtractor1bit port map(s43, '0', c52, '0', s53, c53);
    f54: AdderSubtractor1bit port map(s44, '0', c53, '0', s54, c54);
    f55: AdderSubtractor1bit port map(s45, '0', c54, '0', s55, c55);
    f56: AdderSubtractor1bit port map(s46, p5(0), c55, '0', s56, c56);
    f57: AdderSubtractor1bit port map(s47, p5(1), c56, '0', s57, c57);
    f58: AdderSubtractor1bit port map(s48, p5(2), c57, '0', s58, c58);
    f59: AdderSubtractor1bit port map(s49, p5(3), c58, '0', s59, c59);
    f510: AdderSubtractor1bit port map(s410, p5(4), c59, '0', s510, c510);
    f511: AdderSubtractor1bit port map(s411, p5(5), c510, '0', s511, c511);
    f512: AdderSubtractor1bit port map(s412, p5(6), c511, '0', s512, c512);
    f513: AdderSubtractor1bit port map(c412, p5(7), c512, '0', s513, c513);

    ---------Sixth
    f61: AdderSubtractor1bit port map(s51, '0', '0', '0', s61, c61);
    f62: AdderSubtractor1bit port map(s52, '0', c61, '0', s62, c62);
    f63: AdderSubtractor1bit port map(s53, '0', c62, '0', s63, c63);
    f64: AdderSubtractor1bit port map(s54, '0', c63, '0', s64, c64);
    f65: AdderSubtractor1bit port map(s55, '0', c64, '0', s65, c65);
    f66: AdderSubtractor1bit port map(s56, '0', c65, '0', s66, c66);
    f67: AdderSubtractor1bit port map(s57, p6(0), c66, '0', s67, c67);
    f68: AdderSubtractor1bit port map(s58, p6(1), c67, '0', s68, c68);
    f69: AdderSubtractor1bit port map(s59, p6(2), c68, '0', s69, c69);
    f610: AdderSubtractor1bit port map(s510, p6(3), c69, '0', s610, c610);
    f611: AdderSubtractor1bit port map(s511, p6(4), c610, '0', s611, c611);
    f612: AdderSubtractor1bit port map(s512, p6(5), c611, '0', s612, c612);
    f613: AdderSubtractor1bit port map(s513, p6(6), c612, '0', s613, c613);
    f614: AdderSubtractor1bit port map(c513, p6(7), c613, '0', s614, c614);

    ---------Seventh
    f71: AdderSubtractor1bit port map(s61, '0', '0', '0', s71, c71);
    f72: AdderSubtractor1bit port map(s62, '0', c71, '0', s72, c72);
    f73: AdderSubtractor1bit port map(s63, '0', c72, '0', s73, c73);
    f74: AdderSubtractor1bit port map(s64, '0', c73, '0', s74, c74);
    f75: AdderSubtractor1bit port map(s65, '0', c74, '0', s75, c75);
    f76: AdderSubtractor1bit port map(s66, '0', c75, '0', s76, c76);
    f77: AdderSubtractor1bit port map(s67, '0', c76, '0', s77, c77);
    f78: AdderSubtractor1bit port map(s68, p7(0), c77, '0', s78, c78);
    f79: AdderSubtractor1bit port map(s69, p7(1), c78, '0', s79, c79);
    f710: AdderSubtractor1bit port map(s610, p7(2), c79, '0', s710, c710);
    f711: AdderSubtractor1bit port map(s611, p7(3), c710, '0', s711, c711);
    f712: AdderSubtractor1bit port map(s612, p7(4), c711, '0', s712, c712);
    f713: AdderSubtractor1bit port map(s613, p7(5), c712, '0', s713, c713);
    f714: AdderSubtractor1bit port map(s614, p7(6), c713, '0', s714, c714);
    f715: AdderSubtractor1bit port map(c614, p7(7), c714, '0', s715, c715);

    p(0)<=s71;
    p(1)<=s72;
    p(2)<=s73;
    p(3)<=s74;
    p(4)<=s75;
    p(5)<=s76;
    p(6)<=s77;
    p(7)<=s78;
    p(8)<=s79;
    p(9)<=s710;
    p(10)<=s711;
    p(11)<=s712;
    p(12)<=s713;
    p(13)<=s714;
    p(14)<=s715;
    p(15)<=c715;

end Behavioral;