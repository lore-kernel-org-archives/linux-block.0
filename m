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
Subject: Re: [PATCH 6/8] blk-mq: remove REQ_ATOM_COMPLETE usages from blk-mq
Date: Mon, 8 Jan 2018 23:36:20 +0000
Message-ID: <1515454580.2909.39.camel@wdc.com>
References: <20180108191542.379478-1-tj@kernel.org>
	 <20180108191542.379478-7-tj@kernel.org>
In-Reply-To: <20180108191542.379478-7-tj@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE4LTAxLTA4IGF0IDExOjE1IC0wODAwLCBUZWp1biBIZW8gd3JvdGU6DQo+IEFm
dGVyIHRoZSByZWNlbnQgdXBkYXRlcyB0byB1c2UgZ2VuZXJhdGlvbiBudW1iZXIgYW5kIHN0YXRl
IGJhc2VkDQo+IHN5bmNocm9uaXphdGlvbiwgYmxrLW1xIG5vIGxvbmdlciBkZXBlbmRzIG9uIFJF
UV9BVE9NX0NPTVBMRVRFIGV4Y2VwdA0KPiB0byBhdm9pZCBmaXJpbmcgdGhlIHNhbWUgdGltZW91
dCBtdWx0aXBsZSB0aW1lcy4NCj4gDQo+IFJlbW92ZSBhbGwgUkVRX0FUT01fQ09NUExFVEUgdXNh
Z2VzIGFuZCB1c2UgYSBuZXcgcnFfZmxhZ3MgZmxhZw0KPiBSUUZfTVFfVElNRU9VVF9FWFBJUkVE
IHRvIGF2b2lkIGZpcmluZyB0aGUgc2FtZSB0aW1lb3V0IG11bHRpcGxlDQo+IHRpbWVzLiAgVGhp
cyByZW1vdmVzIGF0b21pYyBiaXRvcHMgZnJvbSBob3QgcGF0aHMgdG9vLg0KPiANCj4gdjI6IFJl
bW92ZWQgYmxrX2NsZWFyX3JxX2NvbXBsZXRlKCkgZnJvbSBibGtfbXFfcnFfdGltZWRfb3V0KCku
DQo+IA0KPiB2MzogQWRkZWQgUlFGX01RX1RJTUVPVVRfRVhQSVJFRCBmbGFnLg0KDQpJIHRoaW5r
IGl0J3MgdW5mb3J0dW5hdGUgdGhhdCB0aGlzIHBhdGNoIHNwcmVhZHMgdGhlIHJlcXVlc3Qgc3Rh
dGUgb3ZlciB0d28NCnN0cnVjdCByZXF1ZXN0IG1lbWJlcnMsIG5hbWVseSB0aGUgbG93ZXIgdHdv
IGJpdHMgb2YgZ3N0YXRlIGFuZCB0aGUNClJRRl9NUV9USU1FT1VUX0VYUElSRUQgZmxhZyBpbiBy
ZXEtPnJxX2ZsYWdzLiBQbGVhc2UgY29uc2lkZXIgdG8gZHJvcCB0aGUNClJRRl9NUV9USU1FT1VU
X0VYUElSRUQgZmxhZyBhbmQgdG8gcmVwcmVzZW50IHRoZSAidGltZW91dCBoYXMgYmVlbiBwcm9j
ZXNzZWQiDQpzdGF0ZSBhcyBhIE1RX1JRXyogc3RhdGUgaW4gZ3N0YXRlLiBUaGF0IHdpbGwgYXZv
aWQgdGhhdCBldmVyeSBzdGF0ZSB1cGRhdGUNCmhhcyB0byBiZSByZXZpZXdlZCB3aGV0aGVyIG9y
IG5vdCBwZXJoYXBzIGFuIHVwZGF0ZSBvZiB0aGUNClJRRl9NUV9USU1FT1VUX0VYUElSRUQgZmxh
ZyBpcyBtaXNzaW5nLg0KDQpUaGFua3MsDQoNCkJhcnQu
