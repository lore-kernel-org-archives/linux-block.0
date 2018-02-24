Return-Path: <prvs=586c790fd=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"paolo.valente@linaro.org" <paolo.valente@linaro.org>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>, "osandov@fb.com"
	<osandov@fb.com>, "holger@applied-asynchrony.com"
	<holger@applied-asynchrony.com>
Subject: Re: [PATCH 1/2] blk-mq: don't call io sched's .requeue_request when
 requeueing rq to ->dispatch
Date: Sat, 24 Feb 2018 01:08:56 +0000
Message-ID: <1519404794.2904.15.camel@wdc.com>
References: <20180223153657.17376-1-ming.lei@redhat.com>
	 <20180223153657.17376-2-ming.lei@redhat.com>
In-Reply-To: <20180223153657.17376-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE4LTAyLTIzIGF0IDIzOjM2ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gX19i
bGtfbXFfcmVxdWV1ZV9yZXF1ZXN0KCkgY292ZXJzIHR3byBjYXNlczoNCj4gDQo+IC0gb25lIGlz
IHRoYXQgdGhlIHJlcXVldWVkIHJlcXVlc3QgaXMgYWRkZWQgdG8gaGN0eC0+ZGlzcGF0Y2gsIHN1
Y2ggYXMNCj4gYmxrX21xX2Rpc3BhdGNoX3JxX2xpc3QoKQ0KPiANCj4gLSBhbm90aGVyIGNhc2Ug
aXMgdGhhdCB0aGUgcmVxdWVzdCBpcyByZXF1ZXVlZCB0byBpbyBzY2hlZHVsZXIsIHN1Y2ggYXMN
Cj4gYmxrX21xX3JlcXVldWVfcmVxdWVzdCgpLg0KPiANCj4gV2Ugc2hvdWxkIGNhbGwgaW8gc2No
ZWQncyAucmVxdWV1ZV9yZXF1ZXN0IGNhbGxiYWNrIG9ubHkgZm9yIHRoZSAybmQNCj4gY2FzZS4N
Cg0KSSB0aGluayBpdCB3b3VsZCBoYXZlIGJlZW4gbW9yZSBjbGVhciBpZiBpdCB3b3VsZCBoYXZl
IGJlZW4gbWVudGlvbmVkIHRoYXQNCmJsa19tcV9zY2hlZF9yZXF1ZXVlX3JlcXVlc3QoKSBtdXN0
IG9ubHkgYmUgY2FsbGVkIGZvciByZXF1ZXN0cyB0aGF0IGhhdmUNCmJlZW4gc3RhcnRlZC4gQW55
d2F5LCBpZiB5b3UgYWRkIHRoZSBmb2xsb3dpbmcgdG8gdGhpcyBwYXRjaDoNCg0KRml4ZXM6IGJk
MTY2ZWYxODNjMiAoImJsay1tcS1zY2hlZDogYWRkIGZyYW1ld29yayBmb3IgTVEgY2FwYWJsZSBJ
TyBzY2hlZHVsZXJzIikNCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQoNCnRoZW4geW91IGNh
biBhbHNvIGFkZDoNCg0KUmV2aWV3ZWQtYnk6IEJhcnQgVmFuIEFzc2NoZSA8YmFydC52YW5hc3Nj
aGVAd2RjLmNvbT4NCg0KDQoNCg==
