Return-Path: <prvs=667b6aabf=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "sebott@linux.ibm.com" <sebott@linux.ibm.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"maxg@mellanox.com" <maxg@mellanox.com>, "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH v9 2/2] blk-mq: Rework blk-mq timeout handling again
Date: Wed, 16 May 2018 16:17:42 +0000
Message-ID: <8058d72fef475caffa78c962bc4220f5f8fa3dde.camel@wdc.com>
References: <20180515225124.20428-1-bart.vanassche@wdc.com>
	 <20180515225124.20428-6-bart.vanassche@wdc.com>
	 <20180516125110.GA32078@lst.de>
In-Reply-To: <20180516125110.GA32078@lst.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTA1LTE2IGF0IDE0OjUxICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gSSd2ZSBiZWVuIGxvb2tpbmcgYXQgdGhpcyBjYXJlZnVsbHksIGFuZCBJIGRvbid0IHRo
aW5rIHdlIG5lZWQgY21weGNoZzY0DQo+IGF0IGFsbCwgYW5kIHdlIGRvbid0IG5lZWQgYW55d2hl
cmUgbmVhciBhcyBtYW55IGNtcHhjaGcgb3BlcmF0aW9ucyBlaXRoZXIuDQo+IA0KPiBUaGUgb25s
eSByZWFzb24gdG8gaW5jbHVkZSB0aGUgZGVhZGxpbmUgaW4gdGhlIGF0b21pYyBvcGVyYXRpb24g
aXMgdGhlDQo+IGJsa19hYm9ydF9yZXF1ZXN0IGNhc2UsIGFzIHRoZSBibGtfbXFfYWRkX3RpbWVy
IG5ldmVyIG1vZGlmaWVzIHRoZQ0KPiBkZWFkbGluZSBvZiBhIHJlcXVlc3QgdGhhdCBzb21lb25l
IGNvdWxkIGJlIHJhY2luZyB3aXRoLiAgU28gaWYgd2UNCj4gaW50cm9kdWNlIGEgbmV3IGFib3J0
ZWQgc3RhdGUgZm9yIHVzZSBieSBibGtfYWJvcnRfcmVxdWVzdCB3ZSBjYW4gbW9kaWZ5DQo+IHRo
ZSBkZWFkbGluZSBzZXBhcmF0ZWx5IChhbmQgaW4gZmFjdCBoYXZlIGEgY29tbW9uIGZpZWxkIHdp
dGggdGhlIGxlZ2FjeQ0KPiBwYXRoKS4NCg0KVGhlcmUgaXMgYW5vdGhlciByZWFzb24gdGhlIGRl
YWRsaW5lIGlzIGluY2x1ZGVkIGluIHRoZSBhdG9taWMgb3BlcmF0aW9uLA0KbmFtZWx5IHRvIGhh
bmRsZSByYWNlcyBiZXR3ZWVuIHRoZSBCTEtfRUhfUkVTRVRfVElNRVIgY2FzZSBpbiBibGtfbXFf
cnFfdGltZWRfb3V0KCkNCmFuZCBibGtfbXFfY29tcGxldGVfcmVxdWVzdCgpLiBJIGRvbid0IHRo
aW5rIHRoYXQgcmFjZSBpcyBhZGRyZXNzZWQgcHJvcGVybHkgYnkNCnlvdXIgcGF0Y2guIEkgd2ls
bCBzZWUgd2hhdCBJIGNhbiBkbyB0byBhZGRyZXNzIHRoYXQgcmFjZSB3aXRob3V0IHVzaW5nIDY0
LWJpdA0KYXRvbWljIG9wZXJhdGlvbnMuDQoNCkJhcnQuDQoNCg0KDQo=
