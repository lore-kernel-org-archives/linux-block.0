Return-Path: <prvs=63144aee1=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"maxg@mellanox.com" <maxg@mellanox.com>, "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
Date: Tue, 10 Apr 2018 15:02:11 +0000
Message-ID: <e2762e359649946543ee22cf6ebf0c08410f7963.camel@wdc.com>
References: <20180410013455.7448-1-bart.vanassche@wdc.com>
	 <20180410084133.GB9133@ming.t460p>
	 <b36ea1107be4f32fb04fffdde3ee45a2e0fcc36c.camel@wdc.com>
	 <20180410135541.GA22340@ming.t460p>
	 <7c4a8b019182d5a9259ef20e6462b3f6a533abed.camel@wdc.com>
	 <20180410143007.GB22340@ming.t460p>
In-Reply-To: <20180410143007.GB22340@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTA0LTEwIGF0IDIyOjMwICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
VHVlLCBBcHIgMTAsIDIwMTggYXQgMDI6MDk6MzNQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IFBsZWFzZSBrZWVwIGluIG1pbmQgdGhhdCBhbGwgc3luY2hyb25pemVfcmN1KCkg
ZG9lcyBpcyB0byB3YWl0IGZvciBwcmUtDQo+ID4gZXhpc3RpbmcgUkNVIHJlYWRlcnMgdG8gZmlu
aXNoLiBzeW5jaHJvbml6ZV9yY3UoKSBkb2VzIG5vdCBwcmV2ZW50IHRoYXQgbmV3DQo+ID4gcmN1
X3JlYWRfbG9jaygpIGNhbGxzIGhhcHBlbi4gSXQgaXMgZS5nLiBwb3NzaWJsZSB0aGF0IGFmdGVy
DQo+IA0KPiBUaGF0IGlzIHJpZ2h0LCBhbmQgSSBhbHNvIG1lbnRpb25lZCBub3JtYWwgY29tcGxl
dGlvbiBjYW4gYmUgZG9uZSBiZXR3ZWVuDQo+IDEpIGFuZCByZXNldCBhYm9ydGVkX2dzdGF0ZSBp
biAzKS4NCj4gDQo+ID4gYmxrX21xX3JxX3VwZGF0ZV9hYm9ydGVkX2dzdGF0ZShyZXEsIDApIGhh
cyBiZWVuIGV4ZWN1dGVkIHRoYXQgYSByZWd1bGFyDQo+ID4gY29tcGxldGlvbiBvY2N1cnMuIElm
IHRoYXQgcmVxdWVzdCBpcyBub3QgcmV1c2VkIGJlZm9yZSB0aGUgdGltZXIgdGhhdCB3YXMNCj4g
PiByZXN0YXJ0ZWQgYnkgdGhlIHRpbWVvdXQgY29kZSBleHBpcmVzLCB0aGF0IHJlcXVlc3Qgd2ls
bCBiZSBjb21wbGV0ZWQgdHdpY2UuDQo+IA0KPiBJbiB0aGlzIHBhdGNoLCBibGtfbXFfYWRkX3Rp
bWVyKHJlcSwgTVFfUlFfQ09NUExFVEUsIE1RX1JRX0lOX0ZMSUdIVCkgaXMNCj4gY2FsbGVkIGZv
ciBoYW5kbGluZyBCTEtfRUhfUkVTRVRfVElNRVIuIEFuZCBhZnRlciBycSdzIHN0YXRlIGlzIGNo
YW5nZWQNCj4gdG8gTVFfUlFfSU5fRkxJR0hULCBub3JtYWwgY29tcGxldGlvbiBzdGlsbCBjYW4g
Y29tZSBhbmQgY29tcGxldGUgdGhpcyBycSwNCj4ganVzdCBsaWtlIHRoZSBhYm92ZSB5b3UgZGVz
Y3JpYmVkLCByaWdodD8NCg0KSSBzaG91bGQgaGF2ZSBhZGRlZCB0aGUgZm9sbG93aW5nIGluIG15
IHByZXZpb3VzIGUtbWFpbDogImlmIHRoZSBjb21wbGV0aW9uDQpvY2N1cnMgYWZ0ZXIgYmxrX21x
X2NoZWNrX2V4cGlyZWQoKSBleGFtaW5lZCBycS0+Z3N0YXRlIGFuZCBiZWZvcmUgaXQgdXBkYXRl
ZA0KcnEtPmFib3J0ZWRfZ3N0YXRlIi4gVGhhdCByYWNlIGNhbiBvY2N1ciB3aXRoIHRoZSBjdXJy
ZW50IHVwc3RyZWFtIGJsay1tcQ0KdGltZW91dCBoYW5kbGluZyBjb2RlIGJ1dCBub3QgYWZ0ZXIg
bXkgcGF0Y2ggaGFzIGJlZW4gYXBwbGllZC4NCg0KQmFydC4NCg0KDQo=
