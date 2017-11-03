Return-Path: <prvs=473169c3e=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>, "roman.penyaev@profitbricks.com"
	<roman.penyaev@profitbricks.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "osandov@fb.com" <osandov@fb.com>,
	"hare@suse.com" <hare@suse.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Date: Fri, 3 Nov 2017 00:48:12 +0000
Message-ID: <1509670091.2636.0.camel@wdc.com>
References: <7921fc66-16de-200b-cc0f-02cf52ef9002@kernel.dk>
	 <20171101014611.GA8200@ming.t460p>
	 <59F9FE28-F31A-47FD-A3FD-90CE1DB38FB2@kernel.dk>
	 <20171101020312.GA9527@ming.t460p>
	 <e6c4aa07-6427-bbee-ba14-fcba5e4f29ac@kernel.dk>
	 <1509638224.2484.14.camel@wdc.com> <20171102233835.GA27370@ming.t460p>
	 <1509666235.2484.23.camel@wdc.com> <20171102234801.GB27370@ming.t460p>
	 <1509666897.2484.25.camel@wdc.com> <20171103001541.GF27370@ming.t460p>
In-Reply-To: <20171103001541.GF27370@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE3LTExLTAzIGF0IDA4OjE1ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
VGh1LCBOb3YgMDIsIDIwMTcgYXQgMTE6NTQ6NTdQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IE9uIEZyaSwgMjAxNy0xMS0wMyBhdCAwNzo0OCArMDgwMCwgTWluZyBMZWkgd3Jv
dGU6DQo+ID4gPiBDb3VsZCB5b3UgcGxlYXNlIHNoYXJlIHlvdXIgc3JwLXRlc3RzIHNjcmlwdD8g
SSBtYXkgZmluZCBhIElCL1NSUCBzeXN0ZW0NCj4gPiA+IHRvIHNlZSBpZiBJIGNhbiByZXByb2R1
Y2UgdGhpcyBpc3N1ZSBhbmQgZmlndXJlIG91dCBvbmUgc29sdXRpb24uDQo+ID4gDQo+ID4gUGxl
YXNlIGhhdmUgYSBsb29rIGF0IGh0dHBzOi8vZ2l0aHViLmNvbS9idmFuYXNzY2hlL3NycC10ZXN0
Lg0KPiANCj4gQ291bGQgeW91IHByb3ZpZGUgbWUgdGhlIGV4YWN0IGNvbW1hbmQgbGluZSBmb3Ig
dGhlIHJlcHJvZHVjdGlvbj8NCj4gDQo+IEkgc2ltcGx5IHJ1biAuL3J1bl90ZXN0cywgYW5kIGxv
b2tzIGl0IGRvZXNuJ3Qgd29yay4NCj4gDQo+IFtyb290QCBzcnAtdGVzdF0jIC4vcnVuX3Rlc3Rz
DQo+IGRmOiDigJgvaG9tZS9taW5nL2dpdC9zcnAtdGVzdC9tbnQy4oCZOiBObyBzdWNoIGZpbGUg
b3IgZGlyZWN0b3J5DQo+IGRmOiDigJgvaG9tZS9taW5nL2dpdC9zcnAtdGVzdC9tbnQy4oCZOiBO
byBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQo+IFVubW91bnRpbmcgL2hvbWUvbWluZy9naXQvc3Jw
LXRlc3QvbW50MiBmcm9tDQo+IHVtb3VudDogL2hvbWUvbWluZy9naXQvc3JwLXRlc3QvbW50Mjog
bW91bnRwb2ludCBub3QgZm91bmQNCj4gZGY6IOKAmC9ob21lL21pbmcvZ2l0L3NycC10ZXN0L21u
dDLigJk6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCj4gRXJyb3I6IHVubW91bnRpbmcgL2hv
bWUvbWluZy9naXQvc3JwLXRlc3QvbW50MiBmYWlsZWQNCg0KVGhpcyBtZWFucyB0aGF0IEkgaGF2
ZSB0byBhZGQgdGhlIGZvbGxvd2luZyB0byB0aGUgUkVBRE1FIGRvY3VtZW50Og0KDQpSdW4gIm1r
ZGlyIG1udDEgbW50MiBtbnQzIiBiZWZvcmUgc3RhcnRpbmcgdGhlIHRlc3RzLg0KDQpCYXJ0Lg==
