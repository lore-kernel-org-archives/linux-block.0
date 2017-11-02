Return-Path: <prvs=4723aae07=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>, "roman.penyaev@profitbricks.com"
	<roman.penyaev@profitbricks.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "osandov@fb.com" <osandov@fb.com>,
	"hare@suse.com" <hare@suse.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Date: Thu, 2 Nov 2017 23:43:55 +0000
Message-ID: <1509666235.2484.23.camel@wdc.com>
References: <20171027044330.11921-1-ming.lei@redhat.com>
	 <7921fc66-16de-200b-cc0f-02cf52ef9002@kernel.dk>
	 <20171101014611.GA8200@ming.t460p>
	 <59F9FE28-F31A-47FD-A3FD-90CE1DB38FB2@kernel.dk>
	 <20171101020312.GA9527@ming.t460p>
	 <e6c4aa07-6427-bbee-ba14-fcba5e4f29ac@kernel.dk>
	 <1509638224.2484.14.camel@wdc.com> <20171102233835.GA27370@ming.t460p>
In-Reply-To: <20171102233835.GA27370@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE3LTExLTAzIGF0IDA3OjM4ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
VGh1LCBOb3YgMDIsIDIwMTcgYXQgMDM6NTc6MDVQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IE9uIFdlZCwgMjAxNy0xMS0wMSBhdCAwODoyMSAtMDYwMCwgSmVucyBBeGJvZSB3
cm90ZToNCj4gPiA+IEZpeGVkIHRoYXQgdXAsIGFuZCBhcHBsaWVkIHRoZXNlIHR3byBwYXRjaGVz
IGFzIHdlbGwuDQo+ID4gDQo+ID4gSGVsbG8gSmVucywNCj4gPiANCj4gPiBSZWNlbnRseSBJIG5v
dGljZWQgdGhhdCBhIHRlc3Qgc3lzdGVtIHNwb3JhZGljYWxseSBoYW5ncyBkdXJpbmcgYm9vdCAo
RGVsbA0KPiA+IFBvd2VyRWRnZSBSNzIwIHRoYXQgYm9vdHMgZnJvbSBhIGhhcmQgZGlzayBjb25u
ZWN0ZWQgdG8gYSBNZWdhUkFJRCBTQVMgYWRhcHRlcikNCj4gPiBhbmQgYWxzbyB0aGF0IHNycC10
ZXN0cyBzeXN0ZW1hdGljYWxseSBoYW5ncy4gUmV2ZXJ0aW5nIHRoZSB0d28gcGF0Y2hlcyBmcm9t
DQo+ID4gdGhpcyBzZXJpZXMgZml4ZXMgYm90aCBpc3N1ZXMuIEknbSBub3Qgc3VyZSB0aGVyZSBp
cyBhbm90aGVyIHNvbHV0aW9uIHRoYW4NCj4gPiByZXZlcnRpbmcgdGhlIHR3byBwYXRjaGVzIGZy
b20gdGhpcyBzZXJpZXMuDQo+IA0KPiBUaGVuIHdlIG5lZWQgdG8gZmluZCB0aGUgcm9vdCBjYXVz
ZSwgaW5zdGVhZCBvZiB1c2luZyBzb3J0IG9mIHdvcmthcm91bmQNCj4gYXMgYmVmb3JlLg0KPiAN
Cj4gRm9yIFNDU0ksIHRoZSByZXN0YXJ0IGlzIGFsd2F5cyBydW4gZnJvbSBzY3NpX2VuZF9yZXF1
ZXN0KCksIGFuZCB0aGlzDQo+IGtpbmQgb2YgcmVzdGFydCBmcm9tIGFsbCBoY3R4IGlzbid0IG5l
Y2Vzc2FyeSBhdCBhbGwuDQoNClllcywgd2UgbmVlZCB0byBmaW5kIHRoZSByb290IGNhdXNlLCBi
dXQgYWZ0ZXIgdGhlc2UgdHdvIHBhdGNoZXMgaGF2ZSBlaXRoZXINCmJlZW4gcmV2ZXJ0ZWQgb3Ig
aGF2ZSBiZWVuIHJlbW92ZWQgZnJvbSB0aGUgZm9yLTQuMTUgcXVldWUuIE90aGVyd2lzZSBpZiBh
DQpiaXNlY3QgbGFuZHMgaW4gdGhlIG1pZGRsZSBvZiB0aGVzZSB0d28gcGF0Y2hlcyBhbmQgdGhl
IGZpeCBmb3IgdGhlc2UgcGF0Y2hlcw0KdGhhdCB3b3VsZCBiZSB2ZXJ5IGZydXN0cmF0aW5nIGZv
ciB0aGUgcGVyc29uIHdobyBpcyBydW5uaW5nIHRoZSBiaXNlY3QuDQoNCkJhcnQu
