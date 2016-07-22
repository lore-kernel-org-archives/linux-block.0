Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35379 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbcGVOt5 (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 22 Jul 2016 10:49:57 -0400
Received: by mail-oi0-f49.google.com with SMTP id l72so166024287oig.2
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2016 07:49:57 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Florian=2DEwald_M=C3=BCller?=
	<florian-ewald.mueller@profitbricks.com>
Date: Fri, 22 Jul 2016 16:49:37 +0200
Message-ID: <CAHJVUehBe1zKvp==CUs0YkmRt5sT8qOES6bPnaeNKKsfuZ3Zrw@mail.gmail.com>
Subject: [PATCH linux-4.7-rc7] blk_stack_limits() setting discard_granularity
To: linux-block@vger.kernel.org
Content-Type: multipart/mixed; boundary=001a1147220a5046a505383a8cf9
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--001a1147220a5046a505383a8cf9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

blk_stack_limits() can set discard_granularity bigger than
max_discard_sectors (in bytes).
This makes blk_bio_discard_split() non-functional and can lead to data
corruption.

--=20

Florian-Ewald Mueller

Architecture Board


ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin


Tel:       +49 30 577 008 331
Fax:      +49 30 577 008 598
Email:   florian-ewald.mueller@profitbricks.com
URL:     http://www.profitbricks.de

Sitz der Gesellschaft: Berlin.
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B.
Gesch=C3=A4ftsf=C3=BChrer: Andreas Gauger, Achim Weiss.

Please consider the environment before printing this email.

--001a1147220a5046a505383a8cf9
Content-Type: text/x-patch; charset=US-ASCII;
	name="blk_stack_limits-discard_granularity.patch"
Content-Disposition: attachment;
	filename="blk_stack_limits-discard_granularity.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iqxuzwpq0

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
aXNjYXJkX2dyYW51bGFyaXR5KTsKKwkJaWYgKHQtPmRpc2NhcmRfZ3JhbnVsYXJpdHkgPiAodC0+
bWF4X2Rpc2NhcmRfc2VjdG9ycyA8PCA5KSkKKwkJCXQtPmRpc2NhcmRfZ3JhbnVsYXJpdHkgPSB0
LT5tYXhfZGlzY2FyZF9zZWN0b3JzIDw8IDk7CiAJCXQtPmRpc2NhcmRfYWxpZ25tZW50ID0gbGNt
X25vdF96ZXJvKHQtPmRpc2NhcmRfYWxpZ25tZW50LCBhbGlnbm1lbnQpICUKLQkJCXQtPmRpc2Nh
cmRfZ3JhbnVsYXJpdHk7CisJCQkodC0+ZGlzY2FyZF9ncmFudWxhcml0eSA/IDogMSk7CiAJfQog
CiAJcmV0dXJuIHJldDsK
--001a1147220a5046a505383a8cf9--
