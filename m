Return-Path: <prvs=6650905ae=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "jianchao.w.wang@oracle.com"
	<jianchao.w.wang@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "sebott@linux.ibm.com" <sebott@linux.ibm.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "maxg@mellanox.com" <maxg@mellanox.com>, "tj@kernel.org"
	<tj@kernel.org>
Subject: Re: [PATCH] blk-mq: Rework blk-mq timeout handling again
Date: Mon, 14 May 2018 04:03:43 +0000
Message-ID: <4f773949c3e32a9d65ab09159fb7b6988349e91b.camel@wdc.com>
References: <20180510175607.27937-1-bart.vanassche@wdc.com>
	 <73f77c62-25ca-0915-6f5b-452d60258f05@oracle.com>
	 <20180511123519.GA14123@lst.de>
	 <13279046837412fd5cfe845a27e469a23125caf3.camel@wdc.com>
	 <beab60f7-5fee-f1d8-12c3-c43d005d6427@oracle.com>
In-Reply-To: <beab60f7-5fee-f1d8-12c3-c43d005d6427@oracle.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE4LTA1LTE0IGF0IDA5OjM3ICswODAwLCBqaWFuY2hhby53YW5nIHdyb3RlOg0K
PiBJbiBhZGRpdGlvbiwgb24gYSA2NGJpdCBzeXN0ZW0sIGhvdyBkbyB5b3Ugc2V0IHVwIHRoZSB0
aW1lciB3aXRoIGEgMzJiaXQgZGVhZGxpbmUgPw0KDQpJZiB0aW1lb3V0IGhhbmRsaW5nIG9jY3Vy
cyBsZXNzIHRoYW4gKDEgPDwgMzEpIC8gSFogc2Vjb25kcyBhZnRlciBhIHJlcXVlc3QgaGFzIGJl
ZW4NCnN1Ym1pdHRlZCB0aGVuIGEgMzItYml0IHZhcmlhYmxlIGlzIHN1ZmZpY2llbnQgdG8gc3Rv
cmUgdGhlIGRlYWRsaW5lLiBJZiB5b3Ugd2FudCB0bw0KdmVyaWZ5IHRoZSBpbXBsZW1lbnRhdGlv
biwgcGxlYXNlIGhhdmUgYSBsb29rIGF0IHRoZSBpbnQzMl90IHZhcmlhYmxlcyBpbg0KYmxrX21x
X2NoZWNrX2V4cGlyZWQoKS4NCg0KQmFydC4NCg0KDQo=
