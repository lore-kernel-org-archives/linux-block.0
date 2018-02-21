Return-Path: <prvs=583440fc3=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq: Fix race between resetting the timer and
 completion handling
Date: Wed, 21 Feb 2018 18:53:05 +0000
Message-ID: <1519239184.4060.7.camel@wdc.com>
References: <1518024428.2870.35.camel@wdc.com>
	 <20180207173531.GC695913@devbig577.frc2.facebook.com>
	 <1518027251.2870.53.camel@wdc.com>
	 <20180207200724.GD695913@devbig577.frc2.facebook.com>
	 <1518047297.2870.80.camel@wdc.com> <1518052193.2870.90.camel@wdc.com>
	 <20180208153940.GM695913@devbig577.frc2.facebook.com>
	 <1518107501.3611.19.camel@wdc.com>
	 <20180213212044.GS695913@devbig577.frc2.facebook.com>
	 <1518627534.3147.6.camel@wdc.com>
	 <20180218131144.GX695913@devbig577.frc2.facebook.com>
In-Reply-To: <20180218131144.GX695913@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gU3VuLCAyMDE4LTAyLTE4IGF0IDA1OjExIC0wODAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiBPbiBXZWQsIEZlYiAxNCwgMjAxOCBhdCAwNDo1ODo1NlBNICswMDAwLCBCYXJ0IFZhbiBBc3Nj
aGUgd3JvdGU6DQo+ID4gV2l0aCB0aGlzIHBhdGNoIGFwcGxpZWQgdGhlIHRlc3RzIEkgcmFuIHNv
IGZhciBwYXNzLg0KPiANCj4gQWgsIGdyZWF0IHRvIGhlYXIuICBUaGFua3MgYSBsb3QgZm9yIHRl
c3RpbmcuICBDYW4geW91IHBsZWFzZSB2ZXJpZnkNCj4gdGhlIGZvbGxvd2luZz8gIEl0J3MgdGhl
IHNhbWUgYXBwcm9hY2ggYnV0IHdpdGggUkNVIHN5bmMgYmF0Y2hpbmcuDQoNCkhlbGxvIFRlanVu
LA0KDQpBZnRlciBoYXZpbmcgbWVyZ2VkIGtlcm5lbCB2NC4xNi1yYzIgaW50byBteSBrZXJuZWwg
dHJlZSBhbmQgYWZ0ZXIgaGF2aW5nDQphcHBsaWVkIHBhdGNoICJBdm9pZCB0aGF0IEFUQSBlcnJv
ciBoYW5kbGluZyBoYW5ncyINCihodHRwczovL3d3dy5tYWlsLWFyY2hpdmUuY29tL2xpbnV4LXNj
c2lAdmdlci5rZXJuZWwub3JnL21zZzcxMTQ1Lmh0bWwpIEkNCmhhdmUgbm90IGJlZW4gYWJsZSB0
byByZXByb2R1Y2UgdGhlIHJlcG9ydGVkIGNyYXNoIC0gbmVpdGhlciB3aXRoIHRoZSBwYXRjaA0K
YXBwbGllZCB0aGF0IHdhcyBwb3N0ZWQgb24gRmVicnVhcnkgMTN0aCBub3Igd2l0aG91dCB0aGF0
IHBhdGNoLiBUaGlzIG1ha2VzDQptZSB3b25kZXIgd2hldGhlciB3ZSBzaG91bGQgZHJvcCB0aGUg
ZGlzY3Vzc2VkIHBhdGNoZXMgdW5sZXNzIHNvbWVvbmUgY29tZXMNCnVwIHdpdGggYSByZXByb2R1
Y2libGUgdGVzdCBjYXNlPw0KDQpUaGFua3MsDQoNCkJhcnQuDQoNCg0K
