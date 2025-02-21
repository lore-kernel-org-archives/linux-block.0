Received: from secgw1.intern.tuwien.ac.at (secgw1.intern.tuwien.ac.at [128.130.30.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DFC8632E;
	Fri, 21 Feb 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.130.30.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152508; cv=none; b=BTitRZCleDrluEFtndUo8HJdQeQFW0zT3o8GanLxwNdXspbpl31l9T1J/UCxESXQOy69ZuQHAg3e5x+LE7AU8dJ+GQCnQU3R1sqM9yLgKunAfPDjGThgRNT2MVPAYu6+2AHr7xKMIrry/5WmNDJvmEG26kuxIdCrkzN2Ilnchbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152508; c=relaxed/simple;
	bh=NHnVmROgJKgOicdXoX3szo0m8m9umbiZAT8YDQYRSB4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=BOtkNCxZEgy8Lq5/+d9noXfVftAL58mJe28llA9hoZJphsD125ABsaRcwebqaiDFyms9VsypQn2m4OUI+qfCq+BU5Y70+dXpmnSCtVNXDApKMyeVWPSgwhGjdNIAtzIEIx8xZTlxrVeJZq6fChiPJfDFM+o44/sWsrxhokEEsKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tuwien.ac.at; spf=pass smtp.mailfrom=tuwien.ac.at; arc=none smtp.client-ip=128.130.30.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tuwien.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuwien.ac.at
Received: from Kiteworks (kwmta1.intern.tuwien.ac.at [128.130.30.91])
	by secgw1.intern.tuwien.ac.at (8.14.7/8.14.7) with ESMTP id 51LFaOsS004695;
	Fri, 21 Feb 2025 16:36:24 +0100
Received: from secgw1.intern.tuwien.ac.at ([128.130.30.71])
          by totemomail.intern.tuwien.ac.at (Totemo SMTP Server) with SMTP ID 272;
          Fri, 21 Feb 2025 15:36:23 +0000 (GMT)
Received: from edge19b.intern.tuwien.ac.at (edge19b.intern.tuwien.ac.at [IPv6:2001:629:1005:30::46])
	by secgw1.intern.tuwien.ac.at (8.14.7/8.14.7) with ESMTP id 51LFaNnc004675
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Feb 2025 16:36:23 +0100
Received: from mbx19b.intern.tuwien.ac.at (2001:629:1005:30::82) by
 edge19b.intern.tuwien.ac.at (2001:629:1005:30::46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Feb 2025 16:36:23 +0100
Received: from t197-243.demo.tuwien.ac.at (128.131.197.243) by
 mbx19b.intern.tuwien.ac.at (2001:629:1005:30::82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Feb 2025 16:36:22 +0100
Date: Fri, 21 Feb 2025 16:41:02 +0100
From: Thomas Haschka <thomas.haschka@tuwien.ac.at>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <James.Bottomley@HansenPartnership.com>, <martin.peterson@oracle.com>
Subject: Patch and bugfix in block/blk-mq.c to regain stability when using
 various SD Cards and Card Readers.
Message-ID: <c2f50eac-3270-8dfa-2440-4c737c366b17@tuwien.ac.at>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1230147017-1740152473=:2986"
X-ClientProxiedBy: mbx19b.intern.tuwien.ac.at (2001:629:1005:30::82) To
 mbx19b.intern.tuwien.ac.at (2001:629:1005:30::82)

--0-1230147017-1740152473=:2986
Content-Type: text/plain; format=flowed; charset="US-ASCII"

Bug Fix: block: Improve stability of SD cards in Microsoft Surface GO 2 and
     	 	possibly other devices.


The commit 65a558f66c308
     block: Improve performance for BLK_MQ_F_BLOCKING drivers

basically made the use of SD cards in my Microsoft Surface GO 2 impossible.
The cards do stop functioning after about 15 minutes. Mostly at io intensive
tasks.

As outlined in https://bugzilla.kernel.org/show_bug.cgi?id=218821
i bisected the problem that yielded an unstable operation of the cardreader
on my Surface GO 2.
I successfully reversed the commit 65a558f66c308 in 6.12.16 using
the attached patch. As I suppose the bug introduced with this commit might
hit other users of sd-cards in similar hardware I suggest this commit shall
be reversed, even if the improved performance might be gone.

All the best,
Thomas Haschka
--0-1230147017-1740152473=:2986
Content-Type: text/plain; charset="US-ASCII";
	name="surface_go_cardreader_patch.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <9b2b82b2-238e-08d9-51c2-0bdfd4ed28c9@tuwien.ac.at>
Content-Description:
Content-Disposition: attachment;
	filename="surface_go_cardreader_patch.patch"

ZGlmZiAnLS1jb2xvcj1hdXRvJyAtdXJwTiBhL2Jsb2NrL2Jsay1tcS5jIGIv
YmxvY2svYmxrLW1xLmMNCi0tLSBhL2Jsb2NrL2Jsay1tcS5jCTIwMjUtMDIt
MjEgMTQ6MDE6NDcuMDAwMDAwMDAwICswMTAwDQorKysgYi9ibG9jay9ibGst
bXEuYwkyMDI1LTAyLTIxIDE1OjUyOjUxLjg0ODA0MTg1MiArMDEwMA0KQEAg
LTE0MTgsNyArMTQxOCw3IEBAIHZvaWQgYmxrX2V4ZWN1dGVfcnFfbm93YWl0
KHN0cnVjdCByZXF1ZXMNCiAJfQ0KIA0KIAlibGtfbXFfaW5zZXJ0X3JlcXVl
c3QocnEsIGF0X2hlYWQgPyBCTEtfTVFfSU5TRVJUX0FUX0hFQUQgOiAwKTsN
Ci0JYmxrX21xX3J1bl9od19xdWV1ZShoY3R4LCBoY3R4LT5mbGFncyAmIEJM
S19NUV9GX0JMT0NLSU5HKTsNCisJYmxrX21xX3J1bl9od19xdWV1ZShoY3R4
LCBmYWxzZSk7DQogfQ0KIEVYUE9SVF9TWU1CT0xfR1BMKGJsa19leGVjdXRl
X3JxX25vd2FpdCk7DQogDQpAQCAtMjMyMiw4ICsyMzIyLDYgQEAgdm9pZCBi
bGtfbXFfcnVuX2h3X3F1ZXVlKHN0cnVjdCBibGtfbXFfaA0KIAkgKi8NCiAJ
V0FSTl9PTl9PTkNFKCFhc3luYyAmJiBpbl9pbnRlcnJ1cHQoKSk7DQogDQot
CW1pZ2h0X3NsZWVwX2lmKCFhc3luYyAmJiBoY3R4LT5mbGFncyAmIEJMS19N
UV9GX0JMT0NLSU5HKTsNCi0NCiAJbmVlZF9ydW4gPSBibGtfbXFfaHdfcXVl
dWVfbmVlZF9ydW4oaGN0eCk7DQogCWlmICghbmVlZF9ydW4pIHsNCiAJCXVu
c2lnbmVkIGxvbmcgZmxhZ3M7DQpAQCAtMjM0Miw3ICsyMzQwLDggQEAgdm9p
ZCBibGtfbXFfcnVuX2h3X3F1ZXVlKHN0cnVjdCBibGtfbXFfaA0KIAkJCXJl
dHVybjsNCiAJfQ0KIA0KLQlpZiAoYXN5bmMgfHwgIWNwdW1hc2tfdGVzdF9j
cHUocmF3X3NtcF9wcm9jZXNzb3JfaWQoKSwgaGN0eC0+Y3B1bWFzaykpIHsN
CisJaWYgKGFzeW5jIHx8IChoY3R4LT5mbGFncyAmIEJMS19NUV9GX0JMT0NL
SU5HKSB8fA0KKwkgICAgIWNwdW1hc2tfdGVzdF9jcHUocmF3X3NtcF9wcm9j
ZXNzb3JfaWQoKSwgaGN0eC0+Y3B1bWFzaykpIHsNCiAJCWJsa19tcV9kZWxh
eV9ydW5faHdfcXVldWUoaGN0eCwgMCk7DQogCQlyZXR1cm47DQogCX0NCkBA
IC0yNDc3LDcgKzI0NzYsNyBAQCB2b2lkIGJsa19tcV9zdGFydF9od19xdWV1
ZShzdHJ1Y3QgYmxrX21xDQogew0KIAljbGVhcl9iaXQoQkxLX01RX1NfU1RP
UFBFRCwgJmhjdHgtPnN0YXRlKTsNCiANCi0JYmxrX21xX3J1bl9od19xdWV1
ZShoY3R4LCBoY3R4LT5mbGFncyAmIEJMS19NUV9GX0JMT0NLSU5HKTsNCisJ
YmxrX21xX3J1bl9od19xdWV1ZShoY3R4LCBmYWxzZSk7DQogfQ0KIEVYUE9S
VF9TWU1CT0woYmxrX21xX3N0YXJ0X2h3X3F1ZXVlKTsNCiANCkBAIC0yNTEz
LDggKzI1MTIsNyBAQCB2b2lkIGJsa19tcV9zdGFydF9zdG9wcGVkX2h3X3F1
ZXVlcyhzdHJ1DQogCXVuc2lnbmVkIGxvbmcgaTsNCiANCiAJcXVldWVfZm9y
X2VhY2hfaHdfY3R4KHEsIGhjdHgsIGkpDQotCQlibGtfbXFfc3RhcnRfc3Rv
cHBlZF9od19xdWV1ZShoY3R4LCBhc3luYyB8fA0KLQkJCQkJKGhjdHgtPmZs
YWdzICYgQkxLX01RX0ZfQkxPQ0tJTkcpKTsNCisJCWJsa19tcV9zdGFydF9z
dG9wcGVkX2h3X3F1ZXVlKGhjdHgsIGFzeW5jKTsNCiB9DQogRVhQT1JUX1NZ
TUJPTChibGtfbXFfc3RhcnRfc3RvcHBlZF9od19xdWV1ZXMpOw0KIA0KQEAg
LTI1NzIsOCArMjU3MCw2IEBAIHN0YXRpYyB2b2lkIGJsa19tcV9pbnNlcnRf
cmVxdWVzdHMoc3RydWMNCiAJbGlzdF9mb3JfZWFjaF9lbnRyeShycSwgbGlz
dCwgcXVldWVsaXN0KSB7DQogCQlCVUdfT04ocnEtPm1xX2N0eCAhPSBjdHgp
Ow0KIAkJdHJhY2VfYmxvY2tfcnFfaW5zZXJ0KHJxKTsNCi0JCWlmIChycS0+
Y21kX2ZsYWdzICYgUkVRX05PV0FJVCkNCi0JCQlydW5fcXVldWVfYXN5bmMg
PSB0cnVlOw0KIAl9DQogDQogCXNwaW5fbG9jaygmY3R4LT5sb2NrKTsNCkBA
IC0yNzM5LDcgKzI3MzUsNyBAQCBzdGF0aWMgdm9pZCBibGtfbXFfdHJ5X2lz
c3VlX2RpcmVjdGx5KHN0DQogDQogCWlmICgocnEtPnJxX2ZsYWdzICYgUlFG
X1VTRV9TQ0hFRCkgfHwgIWJsa19tcV9nZXRfYnVkZ2V0X2FuZF90YWcocnEp
KSB7DQogCQlibGtfbXFfaW5zZXJ0X3JlcXVlc3QocnEsIDApOw0KLQkJYmxr
X21xX3J1bl9od19xdWV1ZShoY3R4LCBycS0+Y21kX2ZsYWdzICYgUkVRX05P
V0FJVCk7DQorCQlibGtfbXFfcnVuX2h3X3F1ZXVlKGhjdHgsIGZhbHNlKTsN
CiAJCXJldHVybjsNCiAJfQ0KIA0KZGlmZiAnLS1jb2xvcj1hdXRvJyAtdXJw
TiBhL2RyaXZlcnMvc2NzaS9zY3NpX2xpYi5jIGIvZHJpdmVycy9zY3NpL3Nj
c2lfbGliLmMNCi0tLSBhL2RyaXZlcnMvc2NzaS9zY3NpX2xpYi5jCTIwMjUt
MDItMjEgMTQ6MDE6NDcuMDAwMDAwMDAwICswMTAwDQorKysgYi9kcml2ZXJz
L3Njc2kvc2NzaV9saWIuYwkyMDI1LTAyLTIxIDE1OjUzOjU0LjY1NDA0NDY5
MSArMDEwMA0KQEAgLTQyOSw4ICs0MjksNyBAQCBzdGF0aWMgdm9pZCBzY3Np
X3NpbmdsZV9sdW5fcnVuKHN0cnVjdCBzDQogCSAqIGJ1dCBpbiBtb3N0IGNh
c2VzLCB3ZSB3aWxsIGJlIGZpcnN0LiBJZGVhbGx5LCBlYWNoIExVIG9uIHRo
ZQ0KIAkgKiB0YXJnZXQgd291bGQgZ2V0IHNvbWUgbGltaXRlZCB0aW1lIG9y
IHJlcXVlc3RzIG9uIHRoZSB0YXJnZXQuDQogCSAqLw0KLQlibGtfbXFfcnVu
X2h3X3F1ZXVlcyhjdXJyZW50X3NkZXYtPnJlcXVlc3RfcXVldWUsDQotCQkJ
ICAgICBzaG9zdC0+cXVldWVjb21tYW5kX21heV9ibG9jayk7DQorCWJsa19t
cV9ydW5faHdfcXVldWVzKGN1cnJlbnRfc2Rldi0+cmVxdWVzdF9xdWV1ZSwg
ZmFsc2UpOw0KIA0KIAlzcGluX2xvY2tfaXJxc2F2ZShzaG9zdC0+aG9zdF9s
b2NrLCBmbGFncyk7DQogCWlmICghc3RhcmdldC0+c3RhcmdldF9zZGV2X3Vz
ZXIpDQo=

--0-1230147017-1740152473=:2986--
