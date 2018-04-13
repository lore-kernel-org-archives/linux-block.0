Return-Path: <prvs=6348fa43e=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "josef@toxicpanda.com" <josef@toxicpanda.com>
CC: "kernel-team@fb.com" <kernel-team@fb.com>, "jbacik@fb.com"
	<jbacik@fb.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"alex@iss-integration.com" <alex@iss-integration.com>, "nbd@other.debian.org"
	<nbd@other.debian.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/3] nbd: del_gendisk after we cleanup the queue
Date: Fri, 13 Apr 2018 16:25:33 +0000
Message-ID: <1f0ebe74a96c6515716a25b49ea588f9ee28e137.camel@wdc.com>
References: <20180413160334.5496-1-josef@toxicpanda.com>
	 <0a8b3a85910e7bbe0103120e85844e96341d73ec.camel@wdc.com>
	 <20180413162132.xudowhvxyijbzqqa@destiny>
In-Reply-To: <20180413162132.xudowhvxyijbzqqa@destiny>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE4LTA0LTEzIGF0IDEyOjIxIC0wNDAwLCBKb3NlZiBCYWNpayB3cm90ZToNCj4g
T24gRnJpLCBBcHIgMTMsIDIwMTggYXQgMDQ6MTY6MThQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hl
IHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAxOC0wNC0xMyBhdCAxMjowMyAtMDQwMCwgSm9zZWYgQmFj
aWsgd3JvdGU6DQo+ID4gPiBUaGlzIGZpeGVzIGEgdXNlIGFmdGVyIGZyZWUgYnVnLCB3ZSBuZWVk
IHRvIGRvIHRoZSBkZWxfZ2VuZGlzayBhZnRlciB3ZQ0KPiA+ID4gY2xlYW51cCB0aGUgcXVldWUg
b24gdGhlIGRldmljZS4NCj4gPiANCj4gPiBIZWxsbyBKb3NlZiwNCj4gPiANCj4gPiBXaGljaCB1
c2UtYWZ0ZXItZnJlZSBidWcgZG9lcyB0aGlzIHBhdGNoIGZpeD8gQXJlIHlvdSBhd2FyZSB0aGF0
IG1vc3QgYmxvY2sNCj4gPiBkcml2ZXJzIGNhbGwgYmxrX2NsZWFudXBfcXVldWUoKSBiZWZvcmUg
Y2FsbGluZyBkZWxfZ2VuZGlzaygpPyBXaHkgZG8geW91DQo+ID4gdGhpbmsgdGhhdCB0aGUgbmJk
IGRyaXZlciBzaG91bGQgdXNlIHRoZSBvcHBvc2l0ZSBvcmRlcj8NCj4gDQo+IEknbSBjb25mdXNl
ZCwgdGhhdCdzIHdoYXQgdGhpcyBwYXRjaCBkb2VzLiAgQmVmb3JlIEkgaGFkIGRlbF9nZW5kaXNr
KCkgZmlyc3QgYW5kDQo+IHRoZW4gdGhlIGJsa19jbGVhbnVwX3F1ZXVlKCksIHdoaWNoIHdhcyBi
dWdnaW5nIG91dCB3aGVuIEkgd2FzIHRlc3Rpbmcgc3R1ZmYNCj4gd2l0aCBhIG51bGwgcG9pbnRl
ciBkZXJlZiB3aGVuZXZlciBJIHJtbW9kJ2VkIHRoZSBuYmQuICBTd2FwcGluZyBpdCB0byB0aGUg
d2F5DQo+IGV2ZXJ5Ym9keSBlbHNlIGRpZCBpdCBmaXhlZCB0aGUgcHJvYmxlbS4gIFRoYW5rcywN
Cg0KSGVsbG8gSm9zZWYsDQoNCk9vcHMsIEkgc3dhcHBlZCAiYmxrX2NsZWFudXBfcXVldWUoKSIg
YW5kICJkZWxfZ2VuZGlzaygpIiBpbiBteSBlLW1haWwuDQoNCkNhbiB5b3Ugc2hhcmUgdGhlIGNh
bGwgc3RhY2sgb2YgdGhlIE5VTEwgcG9pbnRlciBkZXJlZiBhbmQgYWxzbyB0aGUgdHJhbnNsYXRp
b24NCm9mIHRoZSBjcmFzaCBhZGRyZXNzIGludG8gYSBzb3VyY2UgY29kZSBsaW5lPw0KDQpUaGFu
a3MsDQoNCkJhcnQuDQoNCg0K
