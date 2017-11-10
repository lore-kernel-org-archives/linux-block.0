Return-Path: <prvs=4801c944a=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v3 2/8] crypto: scompress - use sgl_alloc() and sgl_free()
Date: Fri, 10 Nov 2017 16:43:45 +0000
Message-ID: <1510332224.2905.4.camel@wdc.com>
References: <20171103222339.26540-1-bart.vanassche@wdc.com>
	 <20171103222339.26540-3-bart.vanassche@wdc.com>
In-Reply-To: <20171103222339.26540-3-bart.vanassche@wdc.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE3LTExLTAzIGF0IDE1OjIzIC0wNzAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
DQo+IFVzZSB0aGUgc2dsX2FsbG9jKCkgYW5kIHNnbF9mcmVlKCkgZnVuY3Rpb25zIGluc3RlYWQg
b2Ygb3BlbiBjb2RpbmcNCj4gdGhlc2UgZnVuY3Rpb25zLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
QmFydCBWYW4gQXNzY2hlIDxiYXJ0LnZhbmFzc2NoZUB3ZGMuY29tPg0KPiBDYzogQXJkIEJpZXNo
ZXV2ZWwgPGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc+DQo+IENjOiBIZXJiZXJ0IFh1IDxoZXJi
ZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU+DQoNCkhlbGxvIEFyZCBhbmQgSGVyYmVydCwNCg0KV291
bGQgaXQgYmUgcG9zc2libGUgZm9yIG9uZSBvZiB5b3UgdG8gc2hhcmUgeW91ciBvcGluaW9uIGFi
b3V0IHRoaXMgcGF0Y2g/DQoNClRoYW5rcywNCg0KQmFydC4=
