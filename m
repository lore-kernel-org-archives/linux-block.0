Return-Path: <prvs=570d9c77a=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq: Fix race between resetting the timer and
 completion handling
Date: Thu, 8 Feb 2018 17:37:46 +0000
Message-ID: <1518111465.3611.36.camel@wdc.com>
References: <1518024428.2870.35.camel@wdc.com>
	 <20180207173531.GC695913@devbig577.frc2.facebook.com>
	 <1518027251.2870.53.camel@wdc.com>
	 <20180207200724.GD695913@devbig577.frc2.facebook.com>
	 <1518047297.2870.80.camel@wdc.com> <1518052193.2870.90.camel@wdc.com>
	 <20180208153940.GM695913@devbig577.frc2.facebook.com>
	 <1518107501.3611.19.camel@wdc.com>
	 <20180208170010.GP695913@devbig577.frc2.facebook.com>
	 <1518109843.3611.25.camel@wdc.com>
	 <20180208171934.GQ695913@devbig577.frc2.facebook.com>
In-Reply-To: <20180208171934.GQ695913@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVGh1LCAyMDE4LTAyLTA4IGF0IDA5OjE5IC0wODAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiBIZWxsbywgQmFydC4NCj4gDQo+IE9uIFRodSwgRmViIDA4LCAyMDE4IGF0IDA1OjEwOjQ1UE0g
KzAwMDAsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gPiBJIHRoaW5rICJkZXJlZmVyZW5jaW5n
IGEgcG9pbnRlciIgbWVhbnMgcmVhZGluZyB0aGUgbWVtb3J5IGxvY2F0aW9uIHRoYXQgcG9pbnRl
ciBwb2ludHMNCj4gPiBhdD8gQW55d2F5LCBJIHRoaW5rIHdlIGJvdGggaW50ZXJwcmV0IHRoZSBj
cmFzaCByZXBvcnQgaW4gdGhlIHNhbWUgd2F5LCBuYW1lbHkgdGhhdCBpdA0KPiA+IG1lYW5zIHRo
YXQgc2NtZC0+ZGV2aWNlID09IE5VTEwuDQo+IA0KPiBObywgd2hhdCBJJ20gdHJ5aW5nIHRvIHNh
eSBpcyB0aGF0IGl0J3MgaXMgdGhlIGRldmljZS0+aG9zdCByZWZlcmVuY2UNCj4gbm90IHRoZSBz
Y21kLT5kZXZpY2UgcmVmZXJlbmNlLg0KDQpBZ2FpbiwgSSB0aGluayB0aGF0IG1lYW5zIHRoYXQg
d2UgYWdyZWUgYWJvdXQgdGhlIGludGVycHJldGF0aW9uIG9mIHRoZSBjcmFzaA0KcmVwb3J0LiBU
aGUgYmlnIHF1ZXN0aW9uIGhlcmUgaXMgd2hhdCB0aGUgbmV4dCBzdGVwIHNob3VsZCBiZSB0byBh
bmFseXplIHRoaXMNCmZ1cnRoZXIgYW5kL29yIHRvIGF2b2lkIHRoYXQgdGhpcyBjcmFzaCBjYW4g
b2NjdXI/DQoNClRoYW5rcywNCg0KQmFydC4NCg0KDQoNCg0KDQo=
