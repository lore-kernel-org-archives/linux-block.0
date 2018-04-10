Return-Path: <prvs=63144aee1=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "tj@kernel.org" <tj@kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "maxg@mellanox.com" <maxg@mellanox.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
Date: Tue, 10 Apr 2018 13:01:01 +0000
Message-ID: <1131f89179501c54c04d61d81bc46a83ba87df27.camel@wdc.com>
References: <20180410013455.7448-1-bart.vanassche@wdc.com>
	 <f6fcc94b-412c-1552-477e-ba0b0927006c@oracle.com>
In-Reply-To: <f6fcc94b-412c-1552-477e-ba0b0927006c@oracle.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTA0LTEwIGF0IDE1OjU5ICswODAwLCBqaWFuY2hhby53YW5nIHdyb3RlOg0K
PiBJZiB5ZXMsIGhvdyBkb2VzIHRoZSB0aW1lb3V0IGhhbmRsZXIgZ2V0IHRoZSBmcmVlZCByZXF1
ZXN0IHdoZW4gdGhlIHRhZyBoYXMgYmVlbiBmcmVlZCA/DQoNCkhlbGxvIEppYW5jaGFvLA0KDQpI
YXZlIHlvdSBub3RpY2VkIHRoYXQgdGhlIHRpbWVvdXQgaGFuZGxlciBkb2VzIG5vdCBjaGVjayB3
aGV0aGVyIG9yIG5vdCB0aGUgcmVxdWVzdA0KdGFnIGlzIGZyZWVkPyBBZGRpdGlvbmFsbHksIEkg
ZG9uJ3QgdGhpbmsgaXQgd291bGQgYmUgcG9zc2libGUgdG8gYWRkIHN1Y2ggYSBjaGVjaw0KdG8g
dGhlIHRpbWVvdXQgY29kZSB3aXRob3V0IGludHJvZHVjaW5nIGEgbmV3IHJhY2UgY29uZGl0aW9u
Lg0KDQpCYXJ0Lg0KDQoNCg==
