Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DEC149C62;
	Thu, 13 Jun 2024 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292471; cv=none; b=DUKeTOdKPljkEShxttnvBQ72VR7Od3nnbG4q2tAjQ6tZ2+d7KsoUVUxk2XoPaC4rpVeSEKiUl04JkuO/Gwkaiqr319L62sPB6sZmmGDburhPc/iMZPBLjjZMyRbk4zyLhZ4K2FH2AUmkFYI+SUx5sXg+KDLMn5EIy4izTd5KvAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292471; c=relaxed/simple;
	bh=bQ660pxtdIjgMERM5Asqw1peHn2lkv1vDHRwV60M9dQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=puaJNc4Y74d9NvVuyHydgeA2pROSfGL2DGDplAUgsm739vV8uPJ3MGxcd0xo9fJ4Gvb9dvGEbc1FSuOgneCtk29UioT9x/7uYEI8MoMSN7qDbtyel9gHZc/zJPE3TILh1BE4uG7kbELp04DpShbF8j5AlyMl568jxcSVoQS39Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from msexch01.omp.ru (10.188.4.12) by msexch02.omp.ru (10.188.4.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 13 Jun
 2024 18:27:37 +0300
Received: from msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753]) by
 msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753%5]) with mapi id 15.02.1258.012;
 Thu, 13 Jun 2024 18:27:37 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: "kbusch@kernel.org" <kbusch@kernel.org>
CC: Karina Yankevich <k.yankevich@omp.ru>, "lvc-patches@linuxtesting.org"
	<lvc-patches@linuxtesting.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Sergey Shtylyov
	<s.shtylyov@omp.ru>
Subject: Re: [bug report] block: integer overflow in __bvec_gap_to_prev()
Thread-Topic: [bug report] block: integer overflow in __bvec_gap_to_prev()
Thread-Index: AQHavAr58l5gsx+jFUKOz/Vibcz91rHCegYAgAMoCoA=
Date: Thu, 13 Jun 2024 15:27:37 +0000
Message-ID: <e5e80f92f59c9fea9f9e33bae355d0031ca9e93b.camel@omp.ru>
References: <9d8ac82ab63a64583f753878dd03e3503c68ffbe.camel@omp.ru>
	 <ZmhqFLdCW6aXriqP@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZmhqFLdCW6aXriqP@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: msexch02.omp.ru, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 6/13/2024 12:34:00 PM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F29CAD7932F9842B7209AF7BC38C94F@omp.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI0LTA2LTExIGF0IDA5OjE1IC0wNjAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
T24gVHVlLCBKdW4gMTEsIDIwMjQgYXQgMDI6MjM6NDhQTSArMDAwMCwgUm9tYW4gU21pcm5vdiB3
cm90ZToNCj4gPiBIZWxsby4NCj4gPiANCj4gPiBUaGVyZSBpcyBhIGNhc2Ugb2YgaW50ZWdlciBv
dmVyZmxvdyBpbiBfX2J2ZWNfZ2FwX3RvX3ByZXYoKToNCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDC
oMKgKChicHJ2LT5idl9vZmZzZXQgKyBicHJ2LT5idl9sZW4pICYgbGltLT52aXJ0X2JvdW5kYXJ5
X21hc2spOw0KPiA+IA0KPiA+IGJpb192ZWMgY2FuIGNyb3NzIG11bHRpcGxlIHBhZ2VzOg0KPiA+
IA0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAxOTAyMTUxMTEzMjQuMzAxMjkt
MS1taW5nLmxlaUByZWRoYXQuY29tL3QvDQo+ID4gDQo+ID4gU28sIGluIGNhc2UgYmlvIGhhcyBv
bmUgYmlvX3ZlYyBidl9sZW4gY2FuIGhhdmUgYSBtYXhpbXVtIHZhbHVlIG9mIFVJTlRfTUFYLg0K
PiA+IFRoZSBjaGVjayBoYXBwZW5zIGluIGJpb19mdWxsKCkuIEluIHRoZSBjYXNlIHdoZW4gYnZf
bGVuIGlzIGVxdWFsIHRvDQo+ID4gVUlOVF9NQVggYW5kIGJ2X29mZnNldCBpcyBncmVhdGVyIHRo
YW4gemVybywgYW4gb3ZlcmZsb3cgbWF5IG9jY3VyLg0KPiANCj4gRG9lcyBpdCBtYXR0ZXI/IFRo
ZSBsb3dlciBiaXRzIGNoZWNrZWQgYWdhaW5zdCB0aGUgbWFzayBzaG91bGQgYmUgdGhlDQo+IHNh
bWUgcmVnYXJkbGVzcyBvZiBvdmVyZmxvdy4NCg0KDQpUaGVyZSBhcmUgc2V2ZXJhbCBvdGhlciBw
bGFjZXMgd2hlcmUgdGhpcyBraW5kIG9mIHRoaW5nIGhhcHBlbnM6DQoNCmh0dHBzOi8vZWxpeGly
LmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvYmxvY2svYmxrLW1lcmdlLmMjTDI5Mg0K
aHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9ibG9jay9ibGsu
aCNMMzMxDQoNCkkgdGhpbmsgaW4gdGhvc2UgY2FzZXMgb3ZlcmZsb3cgd291bGQgbWFrZSBhIGRp
ZmZlcmVuY2UuDQoNCkkgYWxzbyBmb3VuZCBhIGNvbW1lbnQgYmVmb3JlIF9fYmlvX2FkZF9wYWdl
KCkuIEl0IHNheXMgdGhhdCB0aGUNCmNhbGxlciBzaG91bGQgd2F0Y2ggb3V0IGZvciBmcmVlIHNw
YWNlIGluIGJpbzoNCg0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3Nv
dXJjZS9ibG9jay9iaW8uYyNMMTA3NQ0KDQpCdXQgd2hhdCBoYXBwZW5zIGlmIGl0IGRvZXNuJ3Qg
a2VlcCBhIGNoZWNrIG9uIGl0PyBTdWNoIGNvZGUNCndvbid0IGdldCBpbnRvIHRoZSBrZXJuZWw/
DQo=
