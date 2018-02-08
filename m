Return-Path: <prvs=570d9c77a=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq: Fix race between resetting the timer and
 completion handling
Date: Thu, 8 Feb 2018 17:48:32 +0000
Message-ID: <1518112111.3611.42.camel@wdc.com>
References: <1518027251.2870.53.camel@wdc.com>
	 <20180207200724.GD695913@devbig577.frc2.facebook.com>
	 <1518047297.2870.80.camel@wdc.com> <1518052193.2870.90.camel@wdc.com>
	 <20180208153940.GM695913@devbig577.frc2.facebook.com>
	 <1518107501.3611.19.camel@wdc.com>
	 <20180208170010.GP695913@devbig577.frc2.facebook.com>
	 <1518109843.3611.25.camel@wdc.com>
	 <20180208171934.GQ695913@devbig577.frc2.facebook.com>
	 <1518111465.3611.36.camel@wdc.com>
	 <20180208174017.GR695913@devbig577.frc2.facebook.com>
In-Reply-To: <20180208174017.GR695913@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVGh1LCAyMDE4LTAyLTA4IGF0IDA5OjQwIC0wODAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiBIZWgsIHNvcnJ5IGFib3V0IG5vdCBiZWluZyBjbGVhci4gIFdoYXQgSSdtIHRyeWluZyB0byBz
YXkgaXMgdGhhdA0KPiBzY21kLT5kZXZpY2UgIT0gTlVMTCAmJiBkZXZpY2UtPmhvc3QgPT0gTlVM
TC4gIE9yIHdhcyB0aGlzIHdoYXQgeW91DQo+IHdlcmUgc2F5aW5nIGFsbCBhbG9uZz8NCg0KV2hh
dCBJIGFncmVlIHdpdGggaXMgdGhhdCB0aGUgcmVxdWVzdCBwb2ludGVyIChyZXEgYXJndW1lbnQp
IGlzIHN0b3JlZCBpbiAlcmRpDQphbmQgdGhhdCBtb3YgMHgxYjAoJXJkaSksJXJheCBsb2FkcyBz
Y21kLT5kZXZpY2UgaW50byAlcmF4LiBTaW5jZSBSSVAgPT0NCnNjc2lfdGltZXNfb3V0KzB4MTcs
IHNpbmNlIHRoZSBpbnN0cnVjdGlvbiBhdCB0aGF0IGFkZHJlc3MgdHJpZXMgdG8gZGVyZWZlcmVu
Y2UNCiVyYXggYW5kIHNpbmNlIHRoZSByZWdpc3RlciBkdW1wIHNob3dzIHRoYXQgJXJheCA9PSBO
VUxMIEkgdGhpbmsgdGhhdCBtZWFucyB0aGF0DQpzY21kLT5kZXZpY2UgPT0gTlVMTC4NCg0KVGhh
bmtzLA0KDQpCYXJ0Lg0KDQoNCg0KDQo=
