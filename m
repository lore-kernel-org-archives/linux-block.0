Return-Path: <prvs=5750b75e3=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jthumshirn@suse.de" <jthumshirn@suse.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ngupta@vflare.org" <ngupta@vflare.org>, "snitzer@redhat.com"
	<snitzer@redhat.com>, "hch@lst.de" <hch@lst.de>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "sergey.senozhatsky.work@gmail.com"
	<sergey.senozhatsky.work@gmail.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "minchan@kernel.org" <minchan@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH] block: Move SECTOR_SIZE and SECTOR_SHIFT definitions into
 <linux/blkdev.h>
Date: Tue, 13 Feb 2018 16:15:36 +0000
Message-ID: <1518538535.2796.0.camel@wdc.com>
References: <20180212190535.30057-1-bart.vanassche@wdc.com>
	 <1518511392.3592.4.camel@suse.de>
In-Reply-To: <1518511392.3592.4.camel@suse.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTAyLTEzIGF0IDA5OjQzICswMTAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IE9uIE1vbiwgMjAxOC0wMi0xMiBhdCAxMTowNSAtMDgwMCwgQmFydCBWYW4gQXNzY2hl
IHdyb3RlOg0KPiA+ICsvKg0KPiA+ICsgKiBWYXJpYWJsZXMgb2YgdHlwZSBzZWN0b3JfdCByZXBy
ZXNlbnQgYW4gb2Zmc2V0IG9yIHNpemUgdGhhdCBpcyBhDQo+ID4gbXVsdGlwbGUgb2YNCj4gPiAr
ICogMioqOSBieXRlcy4gSGVuY2UgdGhlc2UgdHdvIGNvbnN0YW50cy4NCj4gPiArICovDQo+ID4g
KyNpZm5kZWYgU0VDVE9SX1NISUZUDQo+ID4gK2VudW0geyBTRUNUT1JfU0hJRlQgPSA5IH07DQo+
ID4gKyNlbmRpZg0KPiA+ICsjaWZuZGVmIFNFQ1RPUl9TSVpFDQo+ID4gK2VudW0geyBTRUNUT1Jf
U0laRSA9IDUxMiB9Ow0KPiA+ICsjZW5kaWYNCj4gDQo+IENhbiB5b3UgcGxlYXNlIG1ha2UgYSAj
ZGVmaW5lIG91dCBvZiB0aGVzZSBlbnVtcz8gSSBrbm93IGdkYiBjYW4gY29wZQ0KPiBiZXR0ZXIg
d2l0aCBlbnVtcyB0aGFuIGRlZmluZXMgYnV0IElJUkMgYWRkaW5nIC1nZ2RiMyB0byB0aGUgQ0ZM
QUdTDQo+IHNvbHZlcyB0aGlzIGlzc3VlLg0KPiANCj4gQXBhcnQgZnJvbSB0aGF0Og0KPiBSZXZp
ZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqdGh1bXNoaXJuQHN1c2UuZGU+DQoNCk9LLCBJ
IHdpbGwgY2hhbmdlIHRoZSBlbnVtcyBpbnRvIGRlZmluZXMuDQoNClRoYW5rcyBmb3IgdGhlIHJl
dmlldy4NCg0KQmFydC4NCg0KDQo=
