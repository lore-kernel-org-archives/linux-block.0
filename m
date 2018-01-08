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
Subject: Re: [PATCH 7/8] blk-mq: remove REQ_ATOM_STARTED
Date: Mon, 8 Jan 2018 23:47:09 +0000
Message-ID: <1515455227.2909.45.camel@wdc.com>
References: <20180108191542.379478-1-tj@kernel.org>
	 <20180108191542.379478-8-tj@kernel.org>
In-Reply-To: <20180108191542.379478-8-tj@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE4LTAxLTA4IGF0IDExOjE1IC0wODAwLCBUZWp1biBIZW8gd3JvdGU6DQo+IEFm
dGVyIHRoZSByZWNlbnQgdXBkYXRlcyB0byB1c2UgZ2VuZXJhdGlvbiBudW1iZXIgYW5kIHN0YXRl
IGJhc2VkDQo+IHN5bmNocm9uaXphdGlvbiwgd2UgY2FuIGVhc2lseSByZXBsYWNlIFJFUV9BVE9N
X1NUQVJURUQgdXNhZ2VzIGJ5DQo+IGFkZGluZyBhbiBleHRyYSBzdGF0ZSB0byBkaXN0aW5ndWlz
aCBjb21wbGV0ZWQgYnV0IG5vdCB5ZXQgZnJlZWQNCj4gc3RhdGUuDQo+IA0KPiBBZGQgTVFfUlFf
Q09NUExFVEUgYW5kIHJlcGxhY2UgUkVRX0FUT01fU1RBUlRFRCB1c2FnZXMgd2l0aA0KPiBibGtf
bXFfcnFfc3RhdGUoKSB0ZXN0cy4gIFJFUV9BVE9NX1NUQVJURUQgbm8gbG9uZ2VyIGhhcyBhbnkg
dXNlcnMNCj4gbGVmdCBhbmQgaXMgcmVtb3ZlZC4NCg0KUmV2aWV3ZWQtYnk6IEJhcnQgVmFuIEFz
c2NoZSA8YmFydC52YW5hc3NjaGVAd2RjLmNvbT4NCg0K
