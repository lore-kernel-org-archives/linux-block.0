Return-Path: <prvs=5750b75e3=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "sergey.senozhatsky.work@gmail.com" <sergey.senozhatsky.work@gmail.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ngupta@vflare.org" <ngupta@vflare.org>, "snitzer@redhat.com"
	<snitzer@redhat.com>, "hch@lst.de" <hch@lst.de>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "minchan@kernel.org"
	<minchan@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH] block: Move SECTOR_SIZE and SECTOR_SHIFT definitions into
 <linux/blkdev.h>
Date: Tue, 13 Feb 2018 16:17:44 +0000
Message-ID: <1518538663.2796.3.camel@wdc.com>
References: <20180212190535.30057-1-bart.vanassche@wdc.com>
	 <20180213085415.GB1953@jagdpanzerIV>
In-Reply-To: <20180213085415.GB1953@jagdpanzerIV>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTAyLTEzIGF0IDE3OjU0ICswOTAwLCBTZXJnZXkgU2Vub3poYXRza3kgd3Jv
dGU6DQo+IE9uICgwMi8xMi8xOCAxMTowNSksIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gWy4u
XQ0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5oIGIvaW5jbHVkZS9saW51
eC9ibGtkZXYuaA0KPiA+IGluZGV4IGFjNDc0MGNmNzRiZS4uY2YxNzYyNjYwNGMyIDEwMDY0NA0K
PiA+IC0tLSBhL2luY2x1ZGUvbGludXgvYmxrZGV2LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4
L2Jsa2Rldi5oDQo+ID4gQEAgLTEwMjYsMTQgKzEwMjYsMjUgQEAgc3RhdGljIGlubGluZSBpbnQg
YmxrX3JxX2N1cl9ieXRlcyhjb25zdCBzdHJ1Y3QgcmVxdWVzdCAqcnEpDQo+ID4gIA0KPiA+ICBl
eHRlcm4gdW5zaWduZWQgaW50IGJsa19ycV9lcnJfYnl0ZXMoY29uc3Qgc3RydWN0IHJlcXVlc3Qg
KnJxKTsNCj4gPiAgDQo+ID4gKy8qDQo+ID4gKyAqIFZhcmlhYmxlcyBvZiB0eXBlIHNlY3Rvcl90
IHJlcHJlc2VudCBhbiBvZmZzZXQgb3Igc2l6ZSB0aGF0IGlzIGEgbXVsdGlwbGUgb2YNCj4gPiAr
ICogMioqOSBieXRlcy4gSGVuY2UgdGhlc2UgdHdvIGNvbnN0YW50cy4NCj4gPiArICovDQo+ID4g
KyNpZm5kZWYgU0VDVE9SX1NISUZUDQo+ID4gK2VudW0geyBTRUNUT1JfU0hJRlQgPSA5IH07DQo+
ID4gKyNlbmRpZg0KPiA+ICsjaWZuZGVmIFNFQ1RPUl9TSVpFDQo+ID4gK2VudW0geyBTRUNUT1Jf
U0laRSA9IDUxMiB9Ow0KPiA+ICsjZW5kaWYNCj4gDQo+IFNob3VsZG4ndCBTRUNUT1JfU0laRSBk
ZXBlbmQgb24gU0VDVE9SX1NISUZUPw0KPiANCj4gMSA8PCBTRUNUT1JfU0hJRlQNCg0KTm90IHN1
cmUgaWYgdGhhdCBjaGFuZ2Ugd2lsbCByZWFsbHkgbWFrZSBhIGRpZmZlcmVuY2UuIEFueXdheSwg
SSB3aWxsIG1ha2UgdGhhdCBjaGFuZ2UuDQoNCkJhcnQuDQoNCg0KDQo=
