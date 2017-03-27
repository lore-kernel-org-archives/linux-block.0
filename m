Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Omar Sandoval <osandov@osandov.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "Damien.LeMoal@wdc.com"
	<Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 1/2] blk-stat: convert blk-stat bucket callback to signed
Date: Mon, 27 Mar 2017 16:00:08 +0000
Message-ID: <4CED8A46-D6F9-48AB-B3C9-C2546C1855FC@raithlin.com>
References: <1490494692-2416-1-git-send-email-sbates@raithlin.com>
 <1490494692-2416-2-git-send-email-sbates@raithlin.com>
 <20170326024922.GA6814@vader>
In-Reply-To: <20170326024922.GA6814@vader>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

VGhhbmtzIGZvciB0aGUgcmV2aWV3IE9tYXIhDQoNCj4+ICANCj4+IC11bnNpZ25lZCBpbnQgYmxr
X3N0YXRfcnFfZGRpcihjb25zdCBzdHJ1Y3QgcmVxdWVzdCAqcnEpDQo+PiAraW50IGJsa19zdGF0
X3JxX2RkaXIoY29uc3Qgc3RydWN0IHJlcXVlc3QgKnJxKQ0KPj4gIHsNCj4+IC0JcmV0dXJuIHJx
X2RhdGFfZGlyKHJxKTsNCj4+ICsJcmV0dXJuIChpbnQpcnFfZGF0YV9kaXIocnEpOw0KPg0KPlRo
ZSBjYXN0IGhlcmUgaGVyZSBpc24ndCBuZWNlc3NhcnksIGxldCdzIGxlYXZlIGl0IG9mZi4NCj4N
Cg0KT0ssIEkgd2lsbCBhZGQgdGhhdCBpbiB0aGUgcmVzcGluIQ0KDQo+PiAgfQ0KPj4gIEVYUE9S
VF9TWU1CT0xfR1BMKGJsa19zdGF0X3JxX2RkaXIpOw0KPj4gIA0KPj4gQEAgLTEwMCw2ICsxMDAs
OCBAQCB2b2lkIGJsa19zdGF0X2FkZChzdHJ1Y3QgcmVxdWVzdCAqcnEpDQo+PiAgCWxpc3RfZm9y
X2VhY2hfZW50cnlfcmN1KGNiLCAmcS0+c3RhdHMtPmNhbGxiYWNrcywgbGlzdCkgew0KPj4gIAkJ
aWYgKGJsa19zdGF0X2lzX2FjdGl2ZShjYikpIHsNCj4+ICAJCQlidWNrZXQgPSBjYi0+YnVja2V0
X2ZuKHJxKTsNCj4+ICsJCQlpZiAoYnVja2V0IDwgMCkNCj4+ICsJCQkJY29udGludWU7DQo+DQo+
WW91IGFsc28gbmVlZCB0byBjaGFuZ2UgdGhlIGRlY2xhcmF0aW9uIG9mIGJ1Y2tldCB0byBpbnQg
YWJvdmUuDQo+DQoNClVtbW1tLCBpdCBpcyBhbHJlYWR5IGlzIGFuIGludOKApg0KDQpTdGVwaGVu
DQoNCg0K
