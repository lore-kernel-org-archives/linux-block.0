Return-Path: <prvs=63851e16a=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "martin@lichtvoll.de" <martin@lichtvoll.de>, "jianchao.w.wang@oracle.com"
	<jianchao.w.wang@oracle.com>, "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "tj@kernel.org" <tj@kernel.org>, "israelr@mellanox.com"
	<israelr@mellanox.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V4 0/2] blk-mq: fix race between completion and
 BLK_EH_RESET_TIMER
Date: Tue, 17 Apr 2018 00:15:59 +0000
Message-ID: <1021b7c1ecaf9a2d3b7165feb3eb3509bd630984.camel@wdc.com>
References: <20180415154357.19788-1-ming.lei@redhat.com>
	 <4563853.Bq5iVV2DL3@merkaba> <20180416004508.GA20345@ming.t460p>
	 <4122070.FIbsgdqFrb@merkaba>
	 <b459a445-1e3a-2734-e669-68142fab03d6@oracle.com>
In-Reply-To: <b459a445-1e3a-2734-e669-68142fab03d6@oracle.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTA0LTE3IGF0IDAwOjA0ICswODAwLCBqaWFuY2hhby53YW5nIHdyb3RlOg0K
PiBkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLW1xLmMgYi9ibG9jay9ibGstbXEuYw0KPiBpbmRleCAx
NmU4M2U2Li5iZTliNDM1IDEwMDY0NA0KPiAtLS0gYS9ibG9jay9ibGstbXEuYw0KPiArKysgYi9i
bG9jay9ibGstbXEuYw0KPiBAQCAtMjA3Nyw2ICsyMDc3LDcgQEAgc3RhdGljIGludCBibGtfbXFf
aW5pdF9yZXF1ZXN0KHN0cnVjdCBibGtfbXFfdGFnX3NldCAqc2V0LCBzdHJ1Y3QgcmVxdWVzdCAq
cnEsDQo+ICANCj4gICAgICAgICBzZXFjb3VudF9pbml0KCZycS0+Z3N0YXRlX3NlcSk7DQo+ICAg
ICAgICAgdTY0X3N0YXRzX2luaXQoJnJxLT5hYm9ydGVkX2dzdGF0ZV9zeW5jKTsNCj4gKyAgICAg
ICBXUklURV9PTkNFKHJxLT5nc3RhdGUsIE1RX1JRX0dFTl9JTkMpOw0KPiAgICAgICAgIHJldHVy
biAwOw0KPiAgfQ0KDQpIZWxsbyBKaWFuY2hhbywNCg0KWW91ciBhcHByb2FjaCBsb29rcyBpbnRl
cmVzdGluZyB0byBtZS4gQ2FuIHlvdSBzZW5kIGFuIG9mZmljaWFsIHBhdGNoIHRvIEplbnM/DQoN
ClRoYW5rcywNCg0KQmFydC4NCg0KDQoNCg0K
