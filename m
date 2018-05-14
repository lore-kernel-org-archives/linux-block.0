Return-Path: <prvs=6650905ae=Bart.VanAssche@wdc.com>
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
Date: Mon, 14 May 2018 18:44:48 +0000
Message-ID: <eaee69958fe9eabea2f0a377fc8933ab688c09b9.camel@wdc.com>
References: <20180510175607.27937-1-bart.vanassche@wdc.com>
	 <73f77c62-25ca-0915-6f5b-452d60258f05@oracle.com>
	 <20180511123519.GA14123@lst.de>
	 <13279046837412fd5cfe845a27e469a23125caf3.camel@wdc.com>
	 <beab60f7-5fee-f1d8-12c3-c43d005d6427@oracle.com>
	 <4f773949c3e32a9d65ab09159fb7b6988349e91b.camel@wdc.com>
	 <b7f45d6b-f2a2-a778-9b58-245ecb99e4d9@oracle.com>
In-Reply-To: <b7f45d6b-f2a2-a778-9b58-245ecb99e4d9@oracle.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE4LTA1LTE0IGF0IDEzOjE1ICswODAwLCBqaWFuY2hhby53YW5nIHdyb3RlOg0K
PiBhIDMyYml0IGRlYWRsaW5lIGlzIGluZGVlZCBPSyB0byBqdWRnZSB3aGV0aGVyIGEgcmVxdWVz
dCBpcyB0aW1lb3V0IG9yIG5vdC4NCj4gYnV0IGhvdyBpcyB0aGUgZXhwaXJlcyB2YWx1ZSBkZXRl
cm1pbmVkIGZvciBfX2Jsa19hZGRfdGltZXIgLT4gbW9kX3RpbWVyID8NCj4gYXMgd2Uga25vdywg
d2hlbiBhIHJlcXVlc3QgaXMgc3RhcnRlZCwgd2UgbmVlZCB0byBhcm0gYSB0aW1lciBmb3IgaXQu
DQo+IHRoZSBleHBpcmVzIHZhbHVlIGlzICd1bnNpZ25lZCBsb25nJy4NCg0KVGhpcyBoYXMgYmVl
biBhZGRyZXNzZWQgaW4gdGhlIGp1c3QgcG9zdGVkIHZlcnNpb24gOS4gQ2FuIHlvdSBoYXZlIGEg
bG9vaz8NCkFsdGhvdWdoIEkgaGFkIHRlc3RlZCB0aW1lb3V0IGhhbmRsaW5nIEkgdGhpbmsgdGhp
cyBoYWQgbm90IGNhdXNlZCBteSB0ZXN0cw0KdG8gZmFpbCBiZWNhdXNlIHRoZSBmb2xsb3dpbmcg
Y29kZSBsaW1pdHMgcmVxdWVzdCB0aW1lb3V0IGV4YW1pbmF0aW9uIHRvIDVzDQppbiB0aGUgZnV0
dXJlOg0KDQojZGVmaW5lIEJMS19NQVhfVElNRU9VVAkoNSAqIEhaKQ0KDQp1bnNpZ25lZCBsb25n
IGJsa19ycV90aW1lb3V0KHVuc2lnbmVkIGxvbmcgdGltZW91dCkNCnsNCgl1bnNpZ25lZCBsb25n
IG1heHQ7DQoNCgltYXh0ID0gcm91bmRfamlmZmllc191cChqaWZmaWVzICsgQkxLX01BWF9USU1F
T1VUKTsNCglpZiAodGltZV9hZnRlcih0aW1lb3V0LCBtYXh0KSkNCgkJdGltZW91dCA9IG1heHQ7
DQoNCglyZXR1cm4gdGltZW91dDsNCn0NCg0KVGhhbmtzLA0KDQpCYXJ0Lg0KDQoNCg==
