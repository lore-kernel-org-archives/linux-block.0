Return-Path: <prvs=5392d374c=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jbacik@fb.com" <jbacik@fb.com>, "tj@kernel.org" <tj@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>, "clm@fb.com" <clm@fb.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "hoeppner@linux.vnet.ibm.com" <hoeppner@linux.vnet.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "sth@linux.vnet.ibm.com"
	<sth@linux.vnet.ibm.com>, "kernel-team@fb.com" <kernel-team@fb.com>,
	"asamymuthupa@micron.com" <asamymuthupa@micron.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 5/8] blk-mq: make blk_abort_request() trigger timeout path
Date: Mon, 8 Jan 2018 22:10:01 +0000
Message-ID: <1515449400.2909.31.camel@wdc.com>
References: <20180108191542.379478-1-tj@kernel.org>
	 <20180108191542.379478-6-tj@kernel.org>
In-Reply-To: <20180108191542.379478-6-tj@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE4LTAxLTA4IGF0IDExOjE1IC0wODAwLCBUZWp1biBIZW8gd3JvdGU6DQo+IEBA
IC0xNTYsMTIgKzE1NiwxMiBAQCB2b2lkIGJsa190aW1lb3V0X3dvcmsoc3RydWN0IHdvcmtfc3Ry
dWN0ICp3b3JrKQ0KPiAgICovDQo+ICB2b2lkIGJsa19hYm9ydF9yZXF1ZXN0KHN0cnVjdCByZXF1
ZXN0ICpyZXEpDQo+ICB7DQo+IC0JaWYgKGJsa19tYXJrX3JxX2NvbXBsZXRlKHJlcSkpDQo+IC0J
CXJldHVybjsNCj4gLQ0KPiAgCWlmIChyZXEtPnEtPm1xX29wcykgew0KPiAtCQlibGtfbXFfcnFf
dGltZWRfb3V0KHJlcSwgZmFsc2UpOw0KPiArCQlyZXEtPmRlYWRsaW5lID0gamlmZmllczsNCj4g
KwkJbW9kX3RpbWVyKCZyZXEtPnEtPnRpbWVvdXQsIDApOw0KPiAgCX0gZWxzZSB7DQo+ICsJCWlm
IChibGtfbWFya19ycV9jb21wbGV0ZShyZXEpKQ0KPiArCQkJcmV0dXJuOw0KPiAgCQlibGtfZGVs
ZXRlX3RpbWVyKHJlcSk7DQo+ICAJCWJsa19ycV90aW1lZF9vdXQocmVxKTsNCj4gIAl9DQoNCk90
aGVyIHJlcS0+ZGVhZGxpbmUgd3JpdGVzIGFyZSBwcm90ZWN0ZWQgYnkgcHJlZW1wdF9kaXNhYmxl
KCksDQp3cml0ZV9zZXFjb3VudF9iZWdpbigmcnEtPmdzdGF0ZV9zZXEpLCB3cml0ZV9zZXFjb3Vu
dF9lbmQoJnJxLT5nc3RhdGVfc2VxKQ0KYW5kIHByZWVtcHRfZW5hYmxlKCkuIEkgdGhpbmsgaXQn
cyBmaW5lIHRoYXQgdGhlIGFib3ZlIHJlcS0+ZGVhZGxpbmUgc3RvcmUNCmRvZXMgbm90IGhhdmUg
dGhhdCBwcm90ZWN0aW9uIGJ1dCBJIGFsc28gdGhpbmsgdGhhdCB0aGF0IGRlc2VydmVzIGEgY29t
bWVudC4NCg0KVGhhbmtzLA0KDQpCYXJ0Lg==
