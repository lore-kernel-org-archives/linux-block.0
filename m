Return-Path: <prvs=673874c89=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "keith.busch@linux.intel.com" <keith.busch@linux.intel.com>
CC: "hch@lst.de" <hch@lst.de>, "keith.busch@intel.com"
	<keith.busch@intel.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Date: Tue, 22 May 2018 16:29:07 +0000
Message-ID: <d73bd0b081dbf2156e7b20df4f85e1db38785b0b.camel@wdc.com>
References: <20180521231131.6685-1-keith.busch@intel.com>
	 <20180521231131.6685-4-keith.busch@intel.com>
	 <e7a287827b4c00151bb7714deca7ea6453177504.camel@wdc.com>
	 <20180522141507.GQ5528@localhost.localdomain>
In-Reply-To: <20180522141507.GQ5528@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTA1LTIyIGF0IDA4OjE1IC0wNjAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
VGhpcyBzaG91bGRuJ3QgYmUgaW50cm9kdWNpbmcgYW55IG5ldyBjb25jb3JyZW50IGNhbGxzIHRv
DQo+IF9fYmxrX21xX2NvbXBsZXRlX3JlcXVlc3QgaWYgdGhleSBkb24ndCBhbHJlYWR5IGV4aXN0
LiBUaGUgdGltZW91dCB3b3JrDQo+IGNhbGxzIGl0IG9ubHkgaWYgdGhlIGRyaXZlcidzIHRpbWVv
dXQgcmV0dXJucyBCTEtfRUhfSEFORExFRCwgd2hpY2ggbWVhbnMNCj4gdGhlIGRyaXZlciBpcyBj
bGFpbWluZyB0aGUgY29tbWFuZCBpcyBub3cgZG9uZSwgYnV0IHRoZSBkcml2ZXIgZGlkbid0IGNh
bGwNCj4gYmxrX21xX2NvbXBsZXRlX3JlcXVlc3QgYXMgaW5kaWNhdGVkIGJ5IHRoZSByZXF1ZXN0
J3MgSU5fRkxJR0hUIHN0YXRlLg0KPiANCj4gSW4gb3JkZXIgdG8gZ2V0IGEgc2Vjb25kIGNhbGwg
dG8gX19ibGtfbXFfY29tcGxldGVfcmVxdWVzdCgpLCB0aGVuLA0KPiB0aGUgZHJpdmVyIHdvdWxk
IGhhdmUgdG8gZW5kIHVwIGNhbGxpbmcgYmxrX21xX2NvbXBsZXRlX3JlcXVlc3QoKQ0KPiBpbiBh
bm90aGVyIGNvbnRleHQuIEJ1dCB0aGVyZSdzIG5vdGhpbmcgc3RvcHBpbmcgdGhhdCBmcm9tIGhh
cHBlbmluZw0KPiB0b2RheSwgYW5kIHdvdWxkIGJlIGJhZCBpZiBhbnkgZHJpdmVyIGFjdHVhbGx5
IGRpZCB0aGF0OiB0aGUgcmVxdWVzdA0KPiBtYXkgaGF2ZSBiZWVuIHJlLWFsbG9jYXRlZCBhbmQg
aXNzdWVkIGFzIGEgbmV3IGNvbW1hbmQsIGFuZCBjYWxsaW5nDQo+IGJsa19tcV9jb21wbGV0ZV9y
ZXF1ZXN0KCkgdGhlIHNlY29uZCB0aW1lIGludHJvZHVjZXMgZGF0YSBjb3JydXB0aW9uLg0KDQpI
ZWxsbyBLZWl0aCwNCg0KUGxlYXNlIGhhdmUgYW5vdGhlciBsb29rIGF0IHRoZSBjdXJyZW50IGNv
ZGUgdGhhdCBoYW5kbGVzIHJlcXVlc3QgdGltZW91dHMNCmFuZCBjb21wbGV0aW9ucy4gVGhlIGN1
cnJlbnQgaW1wbGVtZW50YXRpb24gZ3VhcmFudGVlcyB0aGF0IG5vIGRvdWJsZQ0KY29tcGxldGlv
bnMgY2FuIG9jY3VyIGJ1dCB5b3VyIHBhdGNoIHJlbW92ZXMgZXNzZW50aWFsIGFzcGVjdHMgb2Yg
dGhhdA0KaW1wbGVtZW50YXRpb24uDQoNClRoYW5rcywNCg0KQmFydC4=
