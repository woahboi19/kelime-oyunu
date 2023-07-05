enum Harfler{
a("A", 1),
b("B", 3),
c("C", 4),
_c("Ç", 4),
d("D", 3),
e("E", 1),
f("F", 7),
g("G", 5),
_g("Ğ", 8),
h("H", 5),
_i("I", 2),
i("İ", 1),
j("J", 10),
k("K", 1),
l("L", 1),
m("M", 2),
n("N", 1),
o("O", 2),
_o("Ö", 7),
p("P", 5),
r("R", 1),
s("S", 2),
_s("Ş", 4),
t("T", 1),
u("U", 2),
_u("Ü", 3),
v("V", 7),
y("Y", 3),
z("Z", 4);
final String harf;
final int puan;
const Harfler(this.harf, this.puan);
}