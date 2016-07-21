Return-Path: <florian-ewald.mueller@profitbricks.com>
MIME-Version: 1.0
From: =?UTF-8?Q?Florian=2DEwald_M=C3=BCller?= <florian-ewald.mueller@profitbricks.com>
Date: Thu, 21 Jul 2016 20:09:27 +0200
Message-ID: <CAHJVUej82MtyPdVXdU82Hj=HgdXRuqng5nQxgrznUBq8rB0Rng@mail.gmail.com>
Subject: [PATCH linux-4.7-rc7] blk_stack_limits() setting discard_granularity
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: multipart/mixed; boundary=001a11c164701dadf305382939eb
List-ID: <linux-block@vger.kernel.org>

--001a11c164701dadf305382939eb
Content-Type: multipart/alternative; boundary=001a11c164701dadef05382939e9

--001a11c164701dadef05382939e9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

blk_stack_limits() can set discard_granularity bigger than
max_discard_sectors (in bytes).
This makes blk_bio_discard_split() non-functional and can lead to data
corruption.

--=20

Florian-Ewald Mueller

Architecture Board


*ProfitBricks GmbH*
Greifswalder Str. 207
D - 10405 Berlin


Tel:       +49 30 577 008 331
Fax:      +49 30 577 008 598
Email:   florian-ewald.mueller@profitbricks.com
<firstname.lastname@profitbricks.com>
URL:     http://www.profitbricks.de <https://www.profitbricks.de/>

Sitz der Gesellschaft: Berlin.
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B.
Gesch=C3=A4ftsf=C3=BChrer: Andreas Gauger, Achim Weiss.

Please consider the environment before printing this email.

--001a11c164701dadef05382939e9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>blk_stack_limits() can set discard_granularity bigger=
 than max_discard_sectors (in bytes).</div><div>This makes blk_bio_discard_=
split() non-functional and can lead to data corruption.</div><div><br></div=
>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><=
div dir=3D"ltr"><span><div><p style=3D"margin:0cm 0cm 0.0001pt;font-size:12=
pt;font-family:&quot;Times New Roman&quot;,serif"><span lang=3D"EN-US" styl=
e=3D"font-size:10pt">Florian-Ewald Mueller</span></p></div><div><p style=3D=
"margin:0cm 0cm 0.0001pt;font-size:12pt;font-family:&quot;Times New Roman&q=
uot;,serif"><font size=3D"3"><span style=3D"font-size:13px">Architecture Bo=
ard</span></font></p></div><div><p style=3D"margin:0cm 0cm 0.0001pt;font-si=
ze:12pt;font-family:&quot;Times New Roman&quot;,serif"><span lang=3D"EN-US"=
 style=3D"font-size:8pt;color:rgb(34,34,34)"><br></span><b><span style=3D"f=
ont-size:8pt;color:rgb(34,34,34)">ProfitBricks GmbH</span></b><span style=
=3D"font-size:8pt;color:rgb(34,34,34)"><br>Greifswalder Str. 207<br>D - 104=
05 Berlin</span><span style=3D"color:rgb(34,34,34)"><u></u><u></u></span></=
p></div><div><p style=3D"margin:0cm 0cm 0.0001pt;font-size:12pt;font-family=
:&quot;Times New Roman&quot;,serif"><span style=3D"font-size:8pt;color:rgb(=
34,34,34)"><br>Tel: =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0+49 30 577 008 331<br>Fa=
x: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+49 30 577 008 598<br>Email: =C2=A0=C2=A0<=
/span><a href=3D"mailto:firstname.lastname@profitbricks.com" style=3D"color=
:rgb(17,85,204)" target=3D"_blank">florian-ewald.mueller@profitbricks.com</=
a><span style=3D"font-size:8pt;color:rgb(34,34,34)"><br>URL: =C2=A0 =C2=A0=
=C2=A0</span><a href=3D"https://www.profitbricks.de/" style=3D"color:rgb(17=
,85,204)" target=3D"_blank">http://www.profitbricks.de</a><span style=3D"fo=
nt-size:8pt;color:rgb(34,34,34)"><br><br>Sitz der Gesellschaft: Berlin.<br>=
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B.<br>Gesch=C3=A4ft=
sf=C3=BChrer: Andreas Gauger, Achim Weiss.<br><br></span><span lang=3D"EN-U=
S" style=3D"font-size:8pt;color:green">Please consider the environment befo=
re printing this email.<u></u><u></u></span></p><p style=3D"margin:0cm 0cm =
0.0001pt;font-size:12pt;font-family:&quot;Times New Roman&quot;,serif"><spa=
n lang=3D"EN-US" style=3D"font-size:8pt;color:green"><u></u>=C2=A0</span></=
p></div></span></div></div>
</div>

--001a11c164701dadef05382939e9--

--001a11c164701dadf305382939eb
Content-Type: text/x-patch; charset=US-ASCII;
	name="blk_stack_limits-discard_granularity.patch"
Content-Disposition: attachment;
	filename="blk_stack_limits-discard_granularity.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iqwmifpe0

RnJvbTogRmxvcmlhbi1Fd2FsZCBNdWVsbGVyIDxmbG9yaWFuLWV3YWxkLm11ZWxsZXJAcHJvZml0
YnJpY2tzLmNvbT4KU3ViamVjdDogW1BBVENIXSBibGtfc3RhY2tfbGltaXRzKCkKYmxrX3N0YWNr
X2xpbWl0cygpIGNhbiBzZXQgZGlzY2FyZF9ncmFudWxhcml0eSBiaWdnZXIgdGhhbiBtYXhfZGlz
Y2FyZF9zZWN0b3JzIChpbiBieXRlcykuClRoaXMgbWFrZXMgYmxrX2Jpb19kaXNjYXJkX3NwbGl0
KCkgbm9uLWZ1bmN0aW9uYWwgYW5kIGNhbiBsZWFkIHRvIGRhdGEgY29ycnVwdGlvbi4KClNpZ25l
ZC1vZmYtYnk6IEZsb3JpYW4tRXdhbGQgTXVlbGxlciA8Zmxvcmlhbi1ld2FsZC5tdWVsbGVyQHBy
b2ZpdGJyaWNrcy5jb20+CgotLS0gbGludXgtNC43LXJjNy9ibG9jay9ibGstc2V0dGluZ3MuYy5v
cmlnCTIwMTYtMDctMjEgMTk6Mzk6NDQuODMxMzUxMzk2ICswMjAwCisrKyBsaW51eC00LjctcmM3
L2Jsb2NrL2Jsay1zZXR0aW5ncy5jCTIwMTYtMDctMjEgMTk6NDA6MDQuNTgyOTY4NDk2ICswMjAw
CkBAIC02MjYsOCArNjI2LDEwIEBAIGludCBibGtfc3RhY2tfbGltaXRzKHN0cnVjdCBxdWV1ZV9s
aW1pdHMKIAkJCQkJCQkgYi0+bWF4X2h3X2Rpc2NhcmRfc2VjdG9ycyk7CiAJCXQtPmRpc2NhcmRf
Z3JhbnVsYXJpdHkgPSBtYXgodC0+ZGlzY2FyZF9ncmFudWxhcml0eSwKIAkJCQkJICAgICBiLT5k
aXNjYXJkX2dyYW51bGFyaXR5KTsKKwkJaWYgKHVubGlrZWx5KHQtPmRpc2NhcmRfZ3JhbnVsYXJp
dHkgPiAodC0+bWF4X2Rpc2NhcmRfc2VjdG9ycyA8PCA5KSkpCisJCQl0LT5kaXNjYXJkX2dyYW51
bGFyaXR5ID0gdC0+bWF4X2Rpc2NhcmRfc2VjdG9ycyA8PCA5OwogCQl0LT5kaXNjYXJkX2FsaWdu
bWVudCA9IGxjbV9ub3RfemVybyh0LT5kaXNjYXJkX2FsaWdubWVudCwgYWxpZ25tZW50KSAlCi0J
CQl0LT5kaXNjYXJkX2dyYW51bGFyaXR5OworCQkJKHQtPmRpc2NhcmRfZ3JhbnVsYXJpdHkgPyA6
IDEpOwogCX0KIAogCXJldHVybiByZXQ7Cg==
--001a11c164701dadf305382939eb--
