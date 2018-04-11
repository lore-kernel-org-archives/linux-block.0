Return-Path: <prvs=63297c413=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nborisov@suse.com" <nborisov@suse.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"shli@fb.com" <shli@fb.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "00moses.alexander00@gmail.com"
	<00moses.alexander00@gmail.com>, "joseph.qi@linux.alibaba.com"
	<joseph.qi@linux.alibaba.com>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Date: Wed, 11 Apr 2018 20:23:05 +0000
Message-ID: <f9527dc23ae63e4a58e3fabda0320c8bce7714ae.camel@wdc.com>
References: <20180407102148.GA9729@gmail.com>
	 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
	 <20180411101242.GA2322@gmail.com>
	 <20180411142019.GG793541@devbig577.frc2.facebook.com>
	 <20180411142859.GB2322@gmail.com>
	 <5fafe1cbf6b0111448a81005c1c16feee24a99ad.camel@wdc.com>
	 <20180411190027.GA21274@gmail.com>
	 <b7809887-24e6-3ad7-e8bd-4fe7ea0927c0@wdc.com>
	 <20180411195700.GP793541@devbig577.frc2.facebook.com>
	 <6e2d8be78572fef5fe8f2e0e7ecbdea5839dc198.camel@wdc.com>
	 <20180411200245.GQ793541@devbig577.frc2.facebook.com>
In-Reply-To: <20180411200245.GQ793541@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTA0LTExIGF0IDEzOjAyIC0wNzAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiBPbiBXZWQsIEFwciAxMSwgMjAxOCBhdCAwODowMDoyOVBNICswMDAwLCBCYXJ0IFZhbiBBc3Nj
aGUgd3JvdGU6DQo+ID4gT24gV2VkLCAyMDE4LTA0LTExIGF0IDEyOjU3IC0wNzAwLCB0akBrZXJu
ZWwub3JnIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBBcHIgMTEsIDIwMTggYXQgMDE6NTU6MjVQTSAt
MDYwMCwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiA+ID4gPiBPbiAwNC8xMS8xOCAxMzowMCwg
QWxleGFuZHJ1IE1vaXNlIHdyb3RlOg0KPiA+ID4gPiA+IEJ1dCB0aGUgcm9vdCBjYXVzZSBvZiBp
dCBpcyBpbiBibGtjZ19pbml0X3F1ZXVlKCkgd2hlbiBibGtnX2NyZWF0ZSgpIHJldHVybnMNCj4g
PiA+ID4gPiBhbiBFUlIgcHRyLCBiZWNhdXNlIGl0IHRyaWVzIHRvIGluc2VydCBpbnRvIGEgcG9w
dWxhdGVkIGluZGV4IGludG8gYmxrY2ctPmJsa2dfdHJlZSwNCj4gPiA+ID4gPiB0aGUgZW50cnkg
dGhhdCB3ZSBmYWlsIHRvIHJlbW92ZSBhdCBfX2Jsa19yZWxlYXNlX3F1ZXVlKCkuDQo+ID4gPiA+
IA0KPiA+ID4gPiBIZWxsbyBBbGV4LA0KPiA+ID4gPiANCj4gPiA+ID4gSGFkIHlvdSBjb25zaWRl
cmVkIHNvbWV0aGluZyBsaWtlIHRoZSB1bnRlc3RlZCBwYXRjaCBiZWxvdz8NCj4gPiA+IA0KPiA+
ID4gQnV0IHF1ZXVlIGluaXQgc2hvdWxkbid0IGZhaWwgaGVyZSwgcmlnaHQ/DQo+ID4gDQo+ID4g
SGVsbG8gVGVqdW4sDQo+ID4gDQo+ID4gWW91ciBxdWVzdGlvbiBpcyBub3QgZW50aXJlbHkgY2xl
YXIgdG8gbWUuIEFyZSB5b3UgcmVmZXJyaW5nIHRvIHRoZSBhdG9taWMNCj4gPiBhbGxvY2F0aW9u
cyBpbiBibGtnX2NyZWF0ZSgpIG9yIGFyZSB5b3UgcGVyaGFwcyByZWZlcnJpbmcgdG8gc29tZXRo
aW5nIGVsc2U/DQo+IA0KPiBIbW0uLiBtYXliZSBJJ20gY29uZnVzZWQgYnV0IEkgdGhvdWdodCB0
aGF0IHRoZSBmYWN0IHRoYXQNCj4gYmxrY2dfaW5pdF9xdWV1ZSgpIGZhaWxzIGl0c2VsZiBpcyBh
bHJlYWR5IGEgYnVnLCB3aGljaCBoYXBwZW5zDQo+IGJlY2F1c2UgYSBwcmV2aW91c2x5IGRlc3Ry
b3llZCBxdWV1ZSBsZWZ0IGJlaGluZCBibGtncy4NCg0KSGVsbG8gVGVqdW4sDQoNCkkgaGFkIG1p
c3NlZCB0aGUgc3RhcnQgb2YgdGhpcyB0aHJlYWQgc28gSSB3YXMgbm90IGF3YXJlIG9mIHdoaWNo
IHByb2JsZW0gQWxleA0Kd2FzIHRyeWluZyB0byBzb2x2ZS4gSW4gdGhlIGRlc2NyaXB0aW9uIG9m
IHYxIG9mIHRoaXMgcGF0Y2ggSSByZWFkIHRoYXQgQWxleA0KdGhpbmtzIHRoYXQgaGUgcmFuIGlu
dG8gYSBzY2VuYXJpbyBpbiB3aGljaCBibGtfcXVldWVfYWxsb2Nfbm9kZSgpIGFzc2lnbnMgYQ0K
cS0+aWQgdGhhdCBpcyBzdGlsbCBpbiB1c2UgYnkgYW5vdGhlciByZXF1ZXN0IHF1ZXVlPyBUaGF0
J3Mgd2VpcmQuIFRoZSBmb2xsb3dpbmcNCmNvZGUgc3RpbGwgb2NjdXJzIGluIF9fYmxrX3JlbGVh
c2VfcXVldWUoKToNCg0KCWlkYV9zaW1wbGVfcmVtb3ZlKCZibGtfcXVldWVfaWRhLCBxLT5pZCk7
DQoNCkl0J3Mgbm90IGNsZWFyIHRvIG1lIGhvdyB0aGF0IHJlbW92ZSBjYWxsIGNvdWxkIGhhcHBl
biAqYmVmb3JlKiBxLT5pZCBpcyByZW1vdmVkDQpmcm9tIHRoZSBibGtjZyByYWRpeCB0cmVlLg0K
DQpCYXJ0Lg0KDQoNCg0K
