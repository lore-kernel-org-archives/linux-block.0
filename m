Return-Path: <prvs=585cc836a=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"paolo.valente@linaro.org" <paolo.valente@linaro.org>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>, "osandov@fb.com"
	<osandov@fb.com>, "holger@applied-asynchrony.com"
	<holger@applied-asynchrony.com>
Subject: Re: [PATCH 2/2] block: kyber: fix domain token leak during requeue
Date: Fri, 23 Feb 2018 17:12:39 +0000
Message-ID: <1519405958.2904.23.camel@wdc.com>
References: <20180223153657.17376-1-ming.lei@redhat.com>
	 <20180223153657.17376-3-ming.lei@redhat.com>
In-Reply-To: <20180223153657.17376-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE4LTAyLTIzIGF0IDIzOjM2ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gV2hl
biByZXF1ZXVpbmcgcmVxdWVzdCwgdGhlIGRvbWFpbiB0b2tlbiBzaG91bGQgaGF2ZSBiZWVuIGZy
ZWVkDQo+IGJlZm9yZSByZS1pbnNlcnRpbmcgdGhlIHJlcXVlc3QgdG8gaW8gc2NoZWR1bGVyLiBP
dGhlcndpc2UsIHRoZQ0KPiBhc3NpZ25lZCBkb21haW4gdG9rZW4gd2lsbCBiZSBsZWFrZWQsIGFu
ZCBJTyBoYW5nIGNhbiBiZSBjYXVzZWQuDQoNClBsZWFzZSBjb25zaWRlciB0byBhZGQgYSAiQ2M6
IHN0YWJsZSIgdGFnIHRvIHRoaXMgcGF0Y2guDQoNCkFueXdheToNCg0KUmV2aWV3ZWQtYnk6IEJh
cnQgVmFuIEFzc2NoZSA8YmFydC52YW5hc3NjaGVAd2RjLmNvbT4NCg0KDQo=
