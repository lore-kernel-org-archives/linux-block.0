Return-Path: <prvs=630dc1010=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "mhocko@kernel.org" <mhocko@kernel.org>
CC: "martin@lichtvoll.de" <martin@lichtvoll.de>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hare@suse.com" <hare@suse.com>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>, "willy@infradead.org"
	<willy@infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: Block layer use of __GFP flags
Date: Mon, 9 Apr 2018 15:03:45 +0000
Message-ID: <0dc5f067247d10f7e3c60f544b2a9019c898fbad.camel@wdc.com>
References: <20180408065425.GD16007@bombadil.infradead.org>
	 <aea2f6bcae3fe2b88e020d6a258706af1ce1a58b.camel@wdc.com>
	 <20180408190825.GC5704@bombadil.infradead.org>
	 <63d16891d115de25ac2776088571d7e90dab867a.camel@wdc.com>
	 <20180409090016.GA21771@dhcp22.suse.cz>
In-Reply-To: <20180409090016.GA21771@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE4LTA0LTA5IGF0IDExOjAwICswMjAwLCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+
IE9uIE1vbiAwOS0wNC0xOCAwNDo0NjoyMiwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiBbLi4u
XQ0KPiBbLi4uXQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lkZS9pZGUtcG0uYyBiL2RyaXZl
cnMvaWRlL2lkZS1wbS5jDQo+ID4gaW5kZXggYWQ4YTEyNWRlZmRkLi4zZGRiNDY0YjcyZTYgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pZGUvaWRlLXBtLmMNCj4gPiArKysgYi9kcml2ZXJzL2lk
ZS9pZGUtcG0uYw0KPiA+IEBAIC05MSw3ICs5MSw3IEBAIGludCBnZW5lcmljX2lkZV9yZXN1bWUo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICANCj4gPiAgCW1lbXNldCgmcnFwbSwgMCwgc2l6ZW9m
KHJxcG0pKTsNCj4gPiAgCXJxID0gYmxrX2dldF9yZXF1ZXN0X2ZsYWdzKGRyaXZlLT5xdWV1ZSwg
UkVRX09QX0RSVl9JTiwNCj4gPiAtCQkJCSAgIEJMS19NUV9SRVFfUFJFRU1QVCk7DQo+ID4gKwkJ
CQkgICBCTEtfTVFfUkVRX1BSRUVNUFQsIF9fR0ZQX1JFQ0xBSU0pOw0KPiANCj4gSXMgdGhlcmUg
YW55IHJlYXNvbiB0byB1c2UgX19HRlBfUkVDTEFJTSBkaXJlY3RseS4gSSBndWVzcyB5b3Ugd2Fu
dGVkIHRvDQo+IGhhdmUgR0ZQX05PSU8gc2VtYW50aWMsIHJpZ2h0PyBTbyB3aHkgbm90IGJlIGV4
cGxpY2l0IGFib3V0IHRoYXQuIFNhbWUNCj4gZm9yIG90aGVyIGluc3RhbmNlcyBvZiB0aGlzIGZs
YWcgaW4gdGhlIHBhdGNoDQoNCkhlbGxvIE1pY2hhbCwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3
LiBUaGUgdXNlIG9mIF9fR0ZQX1JFQ0xBSU0gaW4gdGhpcyBjb2RlICh3aGljaCB3YXMNCmNhbGxl
ZCBfX0dGUF9XQUlUIGluIHRoZSBwYXN0KSBwcmVkYXRlcyB0aGUgZ2l0IGhpc3RvcnkuIEluIG90
aGVyIHdvcmRzLCBpdA0Kd2FzIGludHJvZHVjZWQgYmVmb3JlIGtlcm5lbCB2ZXJzaW9uIDIuNi4x
MiAoMjAwNSkuIFNvIEknbSByZWx1Y3RhbnQgdG8gbWFrZQ0Kc3VjaCBhIGNoYW5nZSBpbiB0aGUg
SURFIGNvZGUuIEJ1dCBJIHdpbGwgbWFrZSB0aGF0IGNoYW5nZSBpbiB0aGUgU0NTSSBjb2RlLg0K
DQpCYXJ0Lg0KDQoNCg0K
