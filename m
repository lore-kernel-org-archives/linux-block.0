Return-Path: <prvs=514719b63=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "kernel-team@fb.com" <kernel-team@fb.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "osandov@fb.com" <osandov@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 4/6] blk-mq: make blk_abort_request() trigger timeout path
Date: Thu, 14 Dec 2017 18:56:55 +0000
Message-ID: <1513277814.2475.45.camel@wdc.com>
References: <20171212190134.535941-1-tj@kernel.org>
	 <20171212190134.535941-5-tj@kernel.org>
In-Reply-To: <20171212190134.535941-5-tj@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE3LTEyLTEyIGF0IDExOjAxIC0wODAwLCBUZWp1biBIZW8gd3JvdGU6DQo+ICB2
b2lkIGJsa19hYm9ydF9yZXF1ZXN0KHN0cnVjdCByZXF1ZXN0ICpyZXEpDQo+ICB7DQo+IC0JaWYg
KGJsa19tYXJrX3JxX2NvbXBsZXRlKHJlcSkpDQo+IC0JCXJldHVybjsNCj4gIA0KPiAgCWlmIChy
ZXEtPnEtPm1xX29wcykgew0KPiAtCQlibGtfbXFfcnFfdGltZWRfb3V0KHJlcSwgZmFsc2UpOw0K
PiArCQlyZXEtPmRlYWRsaW5lID0gamlmZmllczsNCj4gKwkJbW9kX3RpbWVyKCZyZXEtPnEtPnRp
bWVvdXQsIDApOw0KPiAgCX0gZWxzZSB7DQo+ICsJCWlmIChibGtfbWFya19ycV9jb21wbGV0ZShy
ZXEpKQ0KPiArCQkJcmV0dXJuOw0KPiAgCQlibGtfZGVsZXRlX3RpbWVyKHJlcSk7DQo+ICAJCWJs
a19ycV90aW1lZF9vdXQocmVxKTsNCj4gIAl9DQoNClRoaXMgcGF0Y2ggbWFrZXMgYmxrX2Fib3J0
X3JlcXVlc3QoKSBhc3luY2hyb25vdXMgZm9yIGJsay1tcS4gSGF2ZSBhbGwgY2FsbGVycw0KYmVl
biBhdWRpdGVkIHRvIHZlcmlmeSB3aGV0aGVyIHRoaXMgY2hhbmdlIGlzIHNhZmU/DQoNClRoYW5r
cywNCg0KQmFydC4=
