Received: from outbound.baidu.com (mx14.baidu.com [220.181.3.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF10F4FC8FA;
	Tue, 29 Sep 2026 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675658; cv=none; b=UB+C4AggBq7rryNUj53icmOOu1Tuuox/mmRSL2r71OigpI1celNRzflBL5ICXCimlzKU5zD/wpOOSBKTqNUhiSnEpze2j8pCq196uEW/uc9qzXjGLUZZbikRr4vQDl22m/kv5X54Uek51j99+9M1i+yLwDGQUQ7v/j7O3mo00VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675658; c=relaxed/simple;
	bh=VUIBHRTw5WOaMZ8kpJ70cqMnvCHykFCiPPcRBqZDdUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p164vofeqihiZWSMiemqg24wAnn0HVC2QizmihKfHEDSyTBrCuKD0UtKlTWKU+bbxTgIT7L2BkxlKRz7m/i935ZgF3hEQLrhtqD48sXJ33uHytIYvGnZckq0nBk8AcT+Q0KNRUUQS0BBAGjiQo7ZauTPi6dHaDDk92GZFA5z+hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=muRQDqn2; arc=none smtp.client-ip=220.181.3.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="muRQDqn2"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.46
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Ming Lei <tom.leiming@gmail.com>
CC: Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBbUEFUQ0hdIHVibGs6IHVzZSBnbG9iYWwgaW5k?=
 =?gb2312?Q?ex_for_reported_zones?=
Thread-Topic: [????] Re: [PATCH] ublk: use global index for reported zones
Thread-Index: AQHdT+AwmaOdPayA5UiJ0vz00ipqW7bkwGcAgACP+sA=
Date: Tue, 29 Sep 2026 09:51:51 +0000
Message-ID: <899fc8e55bbf4622a4a75b8d367d8cd0@baidu.com>
References: <20260929070012.2325-1-lirongqing@baidu.com>
 <aruBzOsvpYoWAO51@fedora-laptop>
In-Reply-To: <aruBzOsvpYoWAO51@fedora-laptop>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1790675515;
	bh=VUIBHRTw5WOaMZ8kpJ70cqMnvCHykFCiPPcRBqZDdUY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=muRQDqn2EjzzJLRi9BzRYwYR4eJreSUrCALLWkp13g+2O/MJq7IXES7FfGjzPCmg4
	 sXcyo+fGM2vId2n9949Ls+nME7R4ix2zAEnawjfLfcvEb9krfXr4ASbyrcZ51MtmzF
	 g48GDhennTRxdIEDmQ1XQqM9JDFmJ1U+Sj3v1hk71GOywg9Z/NRSiVGXdiUz1jm6Os
	 V2ie/tTFGFKvOh2N6ezD5aCAmTtDqC2pt33SKPQL9WPpc0lCezTDm+1bB4Q4qU5LLu
	 wApthaCPzCd080NvXwYzQ8hXfnK3PsxGTnD3uJNoNrQHmOsop0RNRFRkm4KQNU+eTa
	 x2SpprQLPg5gg==

DQpuZXMoKSBtYXkgc3BsaXQgYSB6b25lIHJlcG9ydCBpbnRvIG11bHRpcGxlIHJlcXVlc3RzDQo+
ID4gd2hlbiB0aGUgbnVtYmVyIG9mIHpvbmVzIGV4Y2VlZHMgdGhlIHRlbXBvcmFyeSBidWZmZXIg
Y2FwYWNpdHkuIFRoZQ0KPiA+IGluZGV4IHBhc3NlZCB0byBkaXNrX3JlcG9ydF96b25lKCkgbXVz
dCByZWZlciB0byB0aGUgem9uZSBwb3NpdGlvbiBpbg0KPiA+IHRoZSB3aG9sZSByZXBvcnQsIHJh
dGhlciB0aGFuIHRoZSBwb3NpdGlvbiB3aXRoaW4gdGhlIGN1cnJlbnQgcmVxdWVzdC4NCj4gPg0K
PiA+IEN1cnJlbnRseSwgdGhlIHBlci1yZXF1ZXN0IGxvb3AgaW5kZXggaXMgdXNlZCBhcyB0aGUg
Y2FsbGJhY2sgaW5kZXgsDQo+ID4gY2F1c2luZyBlYWNoIGNodW5rIGFmdGVyIHRoZSBmaXJzdCBv
bmUgdG8gcmVzdGFydCBmcm9tIHplcm8uIFRoaXMgY2FuDQo+ID4gbWFrZSB1c2Vyc3BhY2UgY2Fs
bGJhY2tzIHJlY2VpdmUgZHVwbGljYXRlIHpvbmUgaW5kaWNlcyBhbmQgbWF5IHJlc3VsdA0KPiA+
IGluIGJsa19yZXZhbGlkYXRlX2Rpc2tfem9uZXMoKSB1cGRhdGluZyBpbmNvcnJlY3QgZW50cmll
cyBpbiBpdHMgem9uZQ0KPiA+IHN0YXRlIGFycmF5Lg0KPiA+DQo+ID4gVXNlIHRoZSBudW1iZXIg
b2Ygem9uZXMgYWxyZWFkeSByZXBvcnRlZCBhcyB0aGUgYmFzZSBpbmRleCBmb3IgZWFjaA0KPiA+
IHJlcXVlc3Qgc28gdGhhdCB6b25lIGluZGljZXMgcmVtYWluIGNvbnRpbnVvdXMgYWNyb3NzIGFs
bCBjaHVua3MuDQo+ID4NCj4gPiBGaXhlczogMjk4MDJkN2NhMzNiICgidWJsazogZW5hYmxlIHpv
bmVkIHN0b3JhZ2Ugc3VwcG9ydCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogTGkgUm9uZ1FpbmcgPGxp
cm9uZ3FpbmdAYmFpZHUuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Jsb2NrL3VibGtfZHJ2
LmMgfCAzICsrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9jay91YmxrX2Rydi5jIGIv
ZHJpdmVycy9ibG9jay91YmxrX2Rydi5jIGluZGV4DQo+ID4gNjZlYjU1ZS4uMDA3ZTcwMyAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Jsb2NrL3VibGtfZHJ2LmMNCj4gPiArKysgYi9kcml2ZXJz
L2Jsb2NrL3VibGtfZHJ2LmMNCj4gPiBAQCAtNjQ5LDYgKzY0OSw3IEBAIHN0YXRpYyBpbnQgdWJs
a19yZXBvcnRfem9uZXMoc3RydWN0IGdlbmRpc2sgKmRpc2ssDQo+IHNlY3Rvcl90IHNlY3RvciwN
Cj4gPiAgCQl1bnNpZ25lZCBpbnQgcmVtYWluaW5nX3pvbmVzID0gbnJfem9uZXMgLSBkb25lX3pv
bmVzOw0KPiA+ICAJCXVuc2lnbmVkIGludCB6b25lc19pbl9yZXF1ZXN0ID0NCj4gPiAgCQkJbWlu
X3QodW5zaWduZWQgaW50LCByZW1haW5pbmdfem9uZXMsIG1heF96b25lc19wZXJfcmVxdWVzdCk7
DQo+ID4gKwkJdW5zaWduZWQgaW50IGJhdGNoX3N0YXJ0ID0gZG9uZV96b25lczsNCj4gPiAgCQlz
dHJ1Y3QgcmVxdWVzdCAqcmVxOw0KPiA+ICAJCXN0cnVjdCB1YmxrX3pvbmVkX3JlcG9ydF9kZXNj
IGRlc2M7DQo+ID4gIAkJYmxrX3N0YXR1c190IHN0YXR1czsNCj4gPiBAQCAtNjg3LDcgKzY4OCw3
IEBAIHN0YXRpYyBpbnQgdWJsa19yZXBvcnRfem9uZXMoc3RydWN0IGdlbmRpc2sgKmRpc2ssDQo+
IHNlY3Rvcl90IHNlY3RvciwNCj4gPiAgCQkJaWYgKCF6b25lLT5sZW4pDQo+ID4gIAkJCQlicmVh
azsNCj4gPg0KPiA+IC0JCQlyZXQgPSBkaXNrX3JlcG9ydF96b25lKGRpc2ssIHpvbmUsIGksIGFy
Z3MpOw0KPiA+ICsJCQlyZXQgPSBkaXNrX3JlcG9ydF96b25lKGRpc2ssIHpvbmUsIGJhdGNoX3N0
YXJ0ICsgaSwgYXJncyk7DQo+IA0KPiBgZG9uZV96b25lc2AgY2FuIGJlIHBhc3NlZCBkaXJlY3Rs
eSwgdGhlbiB3ZSBjYW4gc2F2ZSBvbmUgbG9jYWwgdmFyaWFibGUsDQo+IG90aGVyd2lzZSwgdGhp
cyBwYXRjaCBsb29rcyBmaW5lOg0KPiANCg0KVGhhbmtzLCBJIHdpbGwgc2VuZCB2Mg0KDQpbTGks
Um9uZ3FpbmddIA0KDQoNCj4gUmV2aWV3ZWQtYnk6IE1pbmcgTGVpIDx0b20ubGVpbWluZ0BnbWFp
bC5jb20+DQo+IA0KPiANCj4gVGhhbmtzLA0KPiBNaW5nDQo=
