Return-Path: <prvs=5392d374c=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jbacik@fb.com" <jbacik@fb.com>, "tj@kernel.org" <tj@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>, "clm@fb.com" <clm@fb.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "kernel-team@fb.com" <kernel-team@fb.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "jianchao.w.wang@oracle.com"
	<jianchao.w.wang@oracle.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 3/8] blk-mq: replace timeout synchronization with a RCU
 and generation based scheme
Date: Mon, 8 Jan 2018 23:29:11 +0000
Message-ID: <1515454150.2909.34.camel@wdc.com>
References: <20180108191542.379478-1-tj@kernel.org>
	 <20180108191542.379478-4-tj@kernel.org>
In-Reply-To: <20180108191542.379478-4-tj@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE4LTAxLTA4IGF0IDExOjE1IC0wODAwLCBUZWp1biBIZW8gd3JvdGU6DQo+IEBA
IC0yMzAsNiArMjMyLDI3IEBAIHN0cnVjdCByZXF1ZXN0IHsNCj4gIA0KPiAgCXVuc2lnbmVkIHNo
b3J0IHdyaXRlX2hpbnQ7DQo+ICANCj4gKwkvKg0KPiArCSAqIE9uIGJsay1tcSwgdGhlIGxvd2Vy
IGJpdHMgb2YgLT5nc3RhdGUgY2FycnkgdGhlIE1RX1JRXyogc3RhdGUNCj4gKwkgKiB2YWx1ZSBh
bmQgdGhlIHVwcGVyIGJpdHMgdGhlIGdlbmVyYXRpb24gbnVtYmVyIHdoaWNoIGlzDQo+ICsJICog
bW9ub3RvbmljYWxseSBpbmNyZW1lbnRlZCBhbmQgdXNlZCB0byBkaXN0aW5ndWlzaCB0aGUgcmV1
c2UNCj4gKwkgKiBpbnN0YW5jZXMuDQo+ICsJICoNCj4gKwkgKiAtPmdzdGF0ZV9zZXEgYWxsb3dz
IHVwZGF0ZXMgdG8gLT5nc3RhdGUgYW5kIG90aGVyIGZpZWxkcw0KPiArCSAqIChjdXJyZW50bHkg
LT5kZWFkbGluZSkgZHVyaW5nIHJlcXVlc3Qgc3RhcnQgdG8gYmUgcmVhZA0KPiArCSAqIGF0b21p
Y2FsbHkgZnJvbSB0aGUgdGltZW91dCBwYXRoLCBzbyB0aGF0IGl0IGNhbiBvcGVyYXRlIG9uIGEN
Cj4gKwkgKiBjb2hlcmVudCBzZXQgb2YgaW5mb3JtYXRpb24uDQo+ICsJICovDQo+ICsJc2VxY291
bnRfdCBnc3RhdGVfc2VxOw0KPiArCXU2NCBnc3RhdGU7DQo+ICsNCj4gKwkvKg0KPiArCSAqIC0+
YWJvcnRlZF9nc3RhdGUgaXMgdXNlZCBieSB0aGUgdGltZW91dCB0byBjbGFpbSBhIHNwZWNpZmlj
DQo+ICsJICogcmVjeWNsZSBpbnN0YW5jZSBvZiB0aGlzIHJlcXVlc3QuICBTZWUgYmxrX21xX3Rp
bWVvdXRfd29yaygpLg0KPiArCSAqLw0KPiArCXN0cnVjdCB1NjRfc3RhdHNfc3luYyBhYm9ydGVk
X2dzdGF0ZV9zeW5jOw0KPiArCXU2NCBhYm9ydGVkX2dzdGF0ZTsNCj4gKw0KPiAgCXVuc2lnbmVk
IGxvbmcgZGVhZGxpbmU7DQo+ICAJc3RydWN0IGxpc3RfaGVhZCB0aW1lb3V0X2xpc3Q7DQoNCkRv
ZXMgImdzdGF0ZSIgcGVyaGFwcyBzdGFuZCBmb3IgImdlbmVyYXRpb24gbnVtYmVyIGFuZCBzdGF0
ZSI/IElmIHNvLCBwbGVhc2UNCm1lbnRpb24gdGhpcyBpbiBvbmUgb2YgdGhlIGFib3ZlIGNvbW1l
bnRzLg0KDQpUaGFua3MsDQoNCkJhcnQu
