Return-Path: <prvs=673874c89=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "keith.busch@linux.intel.com" <keith.busch@linux.intel.com>
CC: "hch@lst.de" <hch@lst.de>, "keith.busch@intel.com"
	<keith.busch@intel.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 0/3] blk-mq: Timeout rework
Date: Tue, 22 May 2018 16:30:41 +0000
Message-ID: <56564c0694eb3a21dfdcfbc6c3053774f026d371.camel@wdc.com>
References: <20180521231131.6685-1-keith.busch@intel.com>
	 <9ca27e059fbd12a976e1e2f1ee1aa5c8ca579ad0.camel@wdc.com>
	 <20180522140653.GP5528@localhost.localdomain>
In-Reply-To: <20180522140653.GP5528@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTA1LTIyIGF0IDA4OjA2IC0wNjAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
T24gTW9uLCBNYXkgMjEsIDIwMTggYXQgMTE6Mjk6MjFQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hl
IHdyb3RlOg0KPiA+IENhbiB5b3UgZXhwbGFpbiB3aHkgdGhlIE5WTWUgZHJpdmVyIG5lZWRzIHJl
ZmVyZW5jZSBjb3VudGluZyBvZiByZXF1ZXN0cyBidXQNCj4gPiBubyBvdGhlciBibG9jayBkcml2
ZXIgbmVlZHMgdGhpcz8gQWRkaXRpb25hbGx5LCB3aHkgaXMgaXQgdGhhdCBmb3IgYWxsIGJsb2Nr
DQo+ID4gZHJpdmVycyBleGNlcHQgTlZNZSB0aGUgY3VycmVudCBibG9jayBsYXllciBBUEkgaXMg
c3VmZmljaWVudA0KPiA+IChibGtfZ2V0X3JlcXVlc3QoKS9ibGtfZXhlY3V0ZV9ycSgpL2Jsa19t
cV9zdGFydF9yZXF1ZXN0KCkvDQo+ID4gYmxrX21xX2NvbXBsZXRlX3JlcXVlc3QoKS9ibGtfbXFf
ZW5kX3JlcXVlc3QoKSk/DQo+IA0KPiBJJ20gcHJldHR5IHN1cmUgTlZNZSBpc24ndCB0aGUgb25s
eSBkcml2ZXIgd2hlcmUgYSBjYWxsIHRvDQo+IGJsa19tcV9jb21wbGV0ZV9yZXF1ZXN0IHNpbGVu
dGx5IGZhaWxzIHRvIHRyYW5zaXRpb24gdGhlIHJlcXVlc3QgdG8NCj4gQ09NUExFVEUsIGZvcmNp
bmcgdW5uZWNlc3NhcnkgZXJyb3IgaGFuZGxpbmcuIFRoaXMgcGF0Y2ggaXNuJ3Qgc28NCj4gbXVj
aCBhYm91dCBOVk1lIGFzIGl0IGlzIGFib3V0IHJlbW92aW5nIHRoYXQgc2lsZW50IGV4Y2VwdGlv
biBmcm9tIHRoZQ0KPiBibG9jayBBUEkuDQoNCkhlbGxvIEtlaXRoLA0KDQpQbGVhc2UgaGF2ZSBh
IGxvb2sgYXQgdjEzIG9mIHRoZSB0aW1lb3V0IGhhbmRsaW5nIHJld29yayBwYXRjaCB0aGF0IEkg
cG9zdGVkLg0KVGhhdCBwYXRjaCBzaG91bGQgbm90IGludHJvZHVjZSBhbnkgbmV3IHJhY2UgY29u
ZGl0aW9ucyBhbmQgc2hvdWxkIGFsc28gaGFuZGxlDQp0aGUgc2NlbmFyaW8gZmluZSBpbiB3aGlj
aCBibGtfbXFfY29tcGxldGVfcmVxdWVzdCgpIGlzIGNhbGxlZCB3aGlsZSB0aGUgTlZNZQ0KdGlt
ZW91dCBoYW5kbGluZyBmdW5jdGlvbiBpcyBpbiBwcm9ncmVzcy4NCg0KVGhhbmtzLA0KDQpCYXJ0
Lg0KDQoNCg0K
