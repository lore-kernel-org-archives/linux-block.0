Return-Path: <florian-ewald.mueller@profitbricks.com>
MIME-Version: 1.0
From: =?UTF-8?Q?Florian=2DEwald_M=C3=BCller?= <florian-ewald.mueller@profitbricks.com>
Date: Thu, 21 Jul 2016 20:13:53 +0200
Message-ID: <CAHJVUegKFKO8tBUb5OKqJJJh4QBSUCyz-A0cSeGL2XX6zXPitA@mail.gmail.com>
Subject: [PATCH linux-4.7-rc7] blk_stack_limits() setting discard_granularity
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: multipart/mixed; boundary=001a113d5c76040f3405382949a8
List-ID: <linux-block@vger.kernel.org>

--001a113d5c76040f3405382949a8
Content-Type: multipart/alternative; boundary=001a113d5c76040f2e05382949a6

--001a113d5c76040f2e05382949a6
Content-Type: text/plain; charset=UTF-8

blk_stack_limits() can set discard_granularity bigger than
max_discard_sectors (in bytes).
This makes blk_bio_discard_split() non-functional and can lead to data
corruption.

Florian-Ewald Mueller

--001a113d5c76040f2e05382949a6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>blk_stack_limits() can set discard_granularity bigger=
 than max_discard_sectors (in bytes).</div><div>This makes blk_bio_discard_=
split() non-functional and can lead to data corruption.</div><div><br></div=
><div>Florian-Ewald Mueller</div></div>

--001a113d5c76040f2e05382949a6--

--001a113d5c76040f3405382949a8
Content-Type: text/x-patch; charset=US-ASCII;
	name="blk_stack_limits-discard_granularity.patch"
Content-Disposition: attachment;
	filename="blk_stack_limits-discard_granularity.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iqwmznwq0

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
--001a113d5c76040f3405382949a8--
