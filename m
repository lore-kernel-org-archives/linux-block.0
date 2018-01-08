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
Date: Mon, 8 Jan 2018 21:06:55 +0000
Message-ID: <1515445614.2909.18.camel@wdc.com>
References: <20180108191542.379478-1-tj@kernel.org>
	 <20180108191542.379478-4-tj@kernel.org>
In-Reply-To: <20180108191542.379478-4-tj@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE4LTAxLTA4IGF0IDExOjE1IC0wODAwLCBUZWp1biBIZW8gd3JvdGU6DQo+ICtz
dGF0aWMgdm9pZCBibGtfbXFfcnFfdXBkYXRlX2Fib3J0ZWRfZ3N0YXRlKHN0cnVjdCByZXF1ZXN0
ICpycSwgdTY0IGdzdGF0ZSkNCj4gK3sNCj4gKwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiArDQo+
ICsJbG9jYWxfaXJxX3NhdmUoZmxhZ3MpOw0KPiArCXU2NF9zdGF0c191cGRhdGVfYmVnaW4oJnJx
LT5hYm9ydGVkX2dzdGF0ZV9zeW5jKTsNCj4gKwlycS0+YWJvcnRlZF9nc3RhdGUgPSBnc3RhdGU7
DQo+ICsJdTY0X3N0YXRzX3VwZGF0ZV9lbmQoJnJxLT5hYm9ydGVkX2dzdGF0ZV9zeW5jKTsNCj4g
Kwlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7DQo+ICt9DQoNClBsZWFzZSBhZGQgYSBjb21tZW50
IHRoYXQgZXhwbGFpbnMgdGhlIHB1cnBvc2Ugb2YgbG9jYWxfaXJxX3NhdmUoKSBhbmQNCmxvY2Fs
X2lycV9yZXN0b3JlKCkuIFBsZWFzZSBhbHNvIGV4cGxhaW4gd2h5IHlvdSBjaG9zZSB0byBkaXNh
YmxlIGludGVycnVwdHMNCmluc3RlYWQgb2YgZGlzYWJsaW5nIHByZWVtcHRpb24uIEkgdGhpbmsg
dGhhdCBkaXNhYmxpbmcgcHJlZW1wdGlvbiBzaG91bGQgYmUNCnN1ZmZpY2llbnQgc2luY2UgdGhp
cyBpcyB0aGUgb25seSBjb2RlIHRoYXQgdXBkYXRlcyBycS0+YWJvcnRlZF9nc3RhdGUgYW5kDQpz
aW5jZSB0aGlzIGZ1bmN0aW9uIGlzIGFsd2F5cyBjYWxsZWQgZnJvbSB0aHJlYWQgY29udGV4dC4N
Cg0KPiBAQCAtODAxLDYgKzg0MCwxMiBAQCB2b2lkIGJsa19tcV9ycV90aW1lZF9vdXQoc3RydWN0
IHJlcXVlc3QgKnJlcSwgYm9vbCByZXNlcnZlZCkNCj4gIAkJX19ibGtfbXFfY29tcGxldGVfcmVx
dWVzdChyZXEpOw0KPiAgCQlicmVhazsNCj4gIAljYXNlIEJMS19FSF9SRVNFVF9USU1FUjoNCj4g
KwkJLyoNCj4gKwkJICogQXMgbm90aGluZyBwcmV2ZW50cyBmcm9tIGNvbXBsZXRpb24gaGFwcGVu
aW5nIHdoaWxlDQo+ICsJCSAqIC0+YWJvcnRlZF9nc3RhdGUgaXMgc2V0LCB0aGlzIG1heSBsZWFk
IHRvIGlnbm9yZWQNCj4gKwkJICogY29tcGxldGlvbnMgYW5kIGZ1cnRoZXIgc3B1cmlvdXMgdGlt
ZW91dHMuDQo+ICsJCSAqLw0KPiArCQlibGtfbXFfcnFfdXBkYXRlX2Fib3J0ZWRfZ3N0YXRlKHJl
cSwgMCk7DQo+ICAJCWJsa19hZGRfdGltZXIocmVxKTsNCj4gIAkJYmxrX2NsZWFyX3JxX2NvbXBs
ZXRlKHJlcSk7DQo+ICAJCWJyZWFrOw0KDQpJcyB0aGUgcmFjZSB0aGF0IHRoZSBjb21tZW50IHJl
ZmVycyB0byBhZGRyZXNzZWQgYnkgb25lIG9mIHRoZSBsYXRlciBwYXRjaGVzPw0KDQpUaGFua3Ms
DQoNCkJhcnQu
