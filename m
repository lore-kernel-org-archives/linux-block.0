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
	<jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 1/8] blk-mq: move hctx lock/unlock into a helper
Date: Mon, 8 Jan 2018 19:24:03 +0000
Message-ID: <1515439442.2909.2.camel@wdc.com>
References: <20180108191542.379478-1-tj@kernel.org>
	 <20180108191542.379478-2-tj@kernel.org>
In-Reply-To: <20180108191542.379478-2-tj@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE4LTAxLTA4IGF0IDExOjE1IC0wODAwLCBUZWp1biBIZW8gd3JvdGU6DQo+ICtz
dGF0aWMgdm9pZCBoY3R4X3VubG9jayhzdHJ1Y3QgYmxrX21xX2h3X2N0eCAqaGN0eCwgaW50IHNy
Y3VfaWR4KQ0KPiArew0KPiArCWlmICghKGhjdHgtPmZsYWdzICYgQkxLX01RX0ZfQkxPQ0tJTkcp
KQ0KPiArCQlyY3VfcmVhZF91bmxvY2soKTsNCj4gKwllbHNlDQo+ICsJCXNyY3VfcmVhZF91bmxv
Y2soaGN0eC0+cXVldWVfcnFfc3JjdSwgc3JjdV9pZHgpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMg
dm9pZCBoY3R4X2xvY2soc3RydWN0IGJsa19tcV9od19jdHggKmhjdHgsIGludCAqc3JjdV9pZHgp
DQo+ICt7DQo+ICsJaWYgKCEoaGN0eC0+ZmxhZ3MgJiBCTEtfTVFfRl9CTE9DS0lORykpDQo+ICsJ
CXJjdV9yZWFkX2xvY2soKTsNCj4gKwllbHNlDQo+ICsJCSpzcmN1X2lkeCA9IHNyY3VfcmVhZF9s
b2NrKGhjdHgtPnF1ZXVlX3JxX3NyY3UpOw0KPiArfQ0KDQpBIG1pbm9yIGNvbW1lbnQ6IHBsZWFz
ZSBjb25zaWRlciB0byByZW9yZGVyIHRoZXNlIHR3byBmdW5jdGlvbnMgc3VjaCB0aGF0IHRoZQ0K
bG9jayBmdW5jdGlvbiBhcHBlYXJzIGZpcnN0IGFuZCB0aGUgdW5sb2NrIGZ1bmN0aW9uIHNlY29u
ZC4gQW55d2F5Og0KDQpSZXZpZXdlZC1ieTogQmFydCBWYW4gQXNzY2hlIDxiYXJ0LnZhbmFzc2No
ZUB3ZGMuY29tPg0KDQo=
