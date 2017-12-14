Return-Path: <prvs=514719b63=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "peterz@infradead.org" <peterz@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>, "oleg@redhat.com"
	<oleg@redhat.com>, "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"osandov@fb.com" <osandov@fb.com>, "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH 2/6] blk-mq: replace timeout synchronization with a RCU
 and generation based scheme
Date: Thu, 14 Dec 2017 21:42:48 +0000
Message-ID: <1513287766.2475.73.camel@wdc.com>
References: <20171212190134.535941-1-tj@kernel.org>
	 <20171212190134.535941-3-tj@kernel.org> <1513277469.2475.43.camel@wdc.com>
	 <20171214202042.GG3326@worktop>
In-Reply-To: <20171214202042.GG3326@worktop>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVGh1LCAyMDE3LTEyLTE0IGF0IDIxOjIwICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVGh1LCBEZWMgMTQsIDIwMTcgYXQgMDY6NTE6MTFQTSArMDAwMCwgQmFydCBWYW4gQXNz
Y2hlIHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAxNy0xMi0xMiBhdCAxMTowMSAtMDgwMCwgVGVqdW4g
SGVvIHdyb3RlOg0KPiA+ID4gKwl3cml0ZV9zZXFjb3VudF9iZWdpbigmcnEtPmdzdGF0ZV9zZXEp
Ow0KPiA+ID4gKwlibGtfbXFfcnFfdXBkYXRlX3N0YXRlKHJxLCBNUV9SUV9JTl9GTElHSFQpOw0K
PiA+ID4gKwlibGtfYWRkX3RpbWVyKHJxKTsNCj4gPiA+ICsJd3JpdGVfc2VxY291bnRfZW5kKCZy
cS0+Z3N0YXRlX3NlcSk7DQo+ID4gDQo+ID4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGJvdGgg
d3JpdGVfc2VxY291bnRfYmVnaW4oKSBhbmQgd3JpdGVfc2VxY291bnRfZW5kKCkNCj4gPiB0cmln
Z2VyIGEgd3JpdGUgbWVtb3J5IGJhcnJpZXIuIElzIGEgc2VxY291bnQgcmVhbGx5IGZhc3RlciB0
aGFuIGEgc3BpbmxvY2s/DQo+IA0KPiBZZXMgbG90cywgbm8gYXRvbWljIG9wZXJhdGlvbnMgYW5k
IG5vIHdhaXRpbmcuDQo+IA0KPiBUaGUgb25seSBjb25zdHJhaW50IGZvciB3cml0ZV9zZXFsb2Nr
IGlzIHRoYXQgdGhlcmUgbXVzdCBub3QgYmUgYW55DQo+IGNvbmN1cnJlbmN5Lg0KPiANCj4gQnV0
IG5vdyB0aGF0IEkgbG9vayBhdCB0aGlzIGFnYWluLCBUSiwgd2h5IGNhbid0IHRoZSBiZWxvdyBo
YXBwZW4/DQo+IA0KPiAJd3JpdGVfc2VxbG9ja19iZWdpbigpOw0KPiAJYmxrX21xX3JxX3VwZGF0
ZV9zdGF0ZShycSwgSU5fRkxJR0hUKTsNCj4gCWJsa19hZGRfdGltZXIocnEpOw0KPiAJPHRpbWVy
LWlycT4NCj4gCQlyZWFkX3NlcWNvdW50X2JlZ2luKCkNCj4gCQkJd2hpbGUgKHNlcSAmIDEpDQo+
IAkJCQljcHVyZWxheCgpOw0KPiAJCS8vIGxpZmUtbG9jaw0KPiAJPC90aW1lci1pcnE+DQo+IAl3
cml0ZV9zZXFsb2NrX2VuZCgpOw0KDQpIZWxsbyBQZXRlciwNCg0KU29tZSB0aW1lIGFnbyB0aGUg
YmxvY2sgbGF5ZXIgd2FzIGNoYW5nZWQgdG8gaGFuZGxlIHRpbWVvdXRzIGluIHRocmVhZCBjb250
ZXh0DQppbnN0ZWFkIG9mIGludGVycnVwdCBjb250ZXh0LiBTZWUgYWxzbyBjb21taXQgMjg3OTIy
ZWIwYjE4ICgiYmxvY2s6IGRlZmVyDQp0aW1lb3V0cyB0byBhIHdvcmtxdWV1ZSIpLg0KDQpCYXJ0
Lg==
