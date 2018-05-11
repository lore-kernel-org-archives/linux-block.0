Return-Path: <prvs=66238960d=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "jianchao.w.wang@oracle.com"
	<jianchao.w.wang@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "sebott@linux.ibm.com" <sebott@linux.ibm.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>, "maxg@mellanox.com" <maxg@mellanox.com>,
	"tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH] blk-mq: Rework blk-mq timeout handling again
Date: Fri, 11 May 2018 15:29:26 +0000
Message-ID: <13279046837412fd5cfe845a27e469a23125caf3.camel@wdc.com>
References: <20180510175607.27937-1-bart.vanassche@wdc.com>
	 <73f77c62-25ca-0915-6f5b-452d60258f05@oracle.com>
	 <20180511123519.GA14123@lst.de>
In-Reply-To: <20180511123519.GA14123@lst.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE4LTA1LTExIGF0IDE0OjM1ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gPiBJdCBzaG91bGQgYmUgZHVlIHRvIHVuaW9uIGJsa19kZWFkbGluZV9hbmRfc3RhdGUu
IA0KPiA+ICt1bmlvbiBibGtfZGVhZGxpbmVfYW5kX3N0YXRlIHsNCj4gPiArCXN0cnVjdCB7DQo+
ID4gKwkJdWludDMyX3QgZ2VuZXJhdGlvbjozMDsNCj4gPiArCQl1aW50MzJfdCBzdGF0ZToyOw0K
PiA+ICsJCXVpbnQzMl90IGRlYWRsaW5lOw0KPiA+ICsJfTsNCj4gPiArCXVuc2lnbmVkIGxvbmcg
bGVnYWN5X2RlYWRsaW5lOw0KPiA+ICsJdWludDY0X3QgZGFzOw0KPiA+ICt9Ow0KPiANCj4gWWlr
ZXMuICBPciB3ZSBqdXN0IG1vdmUgaXQgaW50byBhIHNlcGFyYXRlIGZpZWxkLiAgVGhpcyBwYXRj
aCBhbHJlYWR5DQo+IHNocmlua3Mgc3RydWN0IHJlcXVlc3QgYSBsb3QsIHNvIEknZCByYXRoZXIg
ZG8gdGhhdCB0byBrZWVwIGl0IHNpbXBsZS4NCg0KSGVsbG8gQ2hyaXN0b3BoLA0KDQpBcmUgeW91
IHBlcmhhcHMgcmVmZXJyaW5nIHRvIHRoZSBsZWdhY3lfZGVhZGxpbmUgZmllbGQ/IEhhdmUgeW91
IG5vdGljZWQgdGhhdA0KSmlhbmNoYW8gdXNlZCBhIGxlZ2FjeSBibG9jayBsYXllciBmdW5jdGlv
biBpbiBibGstbXEgY29kZSBhbmQgdGhhdCB0aGF0IGlzDQp3aHkgYSB3cm9uZyB2YWx1ZSBmb3Ig
dGhlIGRlYWRsaW5lIGFwcGVhcmVkIGluIHRoZSB0cmFjZSBvdXRwdXQ/DQoNClRoYW5rcywNCg0K
QmFydC4NCg0KDQoNCg==
