Return-Path: <prvs=514719b63=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "kernel-team@fb.com" <kernel-team@fb.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "osandov@fb.com" <osandov@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 1/6] blk-mq: protect completion path with RCU
Date: Thu, 14 Dec 2017 17:01:06 +0000
Message-ID: <1513270860.2475.14.camel@wdc.com>
References: <20171212190134.535941-1-tj@kernel.org>
	 <20171212190134.535941-2-tj@kernel.org>
In-Reply-To: <20171212190134.535941-2-tj@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE3LTEyLTEyIGF0IDExOjAxIC0wODAwLCBUZWp1biBIZW8gd3JvdGU6DQo+ICsJ
fSBlbHNlIHsNCj4gKwkJc3JjdV9pZHggPSBzcmN1X3JlYWRfbG9jayhoY3R4LT5xdWV1ZV9ycV9z
cmN1KTsNCj4gKwkJaWYgKCFibGtfbWFya19ycV9jb21wbGV0ZShycSkpDQo+ICsJCQlfX2Jsa19t
cV9jb21wbGV0ZV9yZXF1ZXN0KHJxKTsNCj4gKwkJc3JjdV9yZWFkX3VubG9jayhoY3R4LT5xdWV1
ZV9ycV9zcmN1LCBzcmN1X2lkeCk7DQoNCkhlbGxvIFRlanVuLA0KDQpUaGUgbmFtZSBxdWV1ZV9y
cV9zcmN1IHdhcyBjaG9zZW4gdG8gcmVmbGVjdCB0aGUgb3JpZ2luYWwgdXNlIG9mIHRoYXQgc3Ry
dWN0dXJlLA0KbmFtZWx5IHRvIHByb3RlY3QgLnF1ZXVlX3JxKCkgY2FsbHMuIFlvdXIgcGF0Y2gg
c2VyaWVzIGJyb2FkZW5zIHRoZSB1c2Ugb2YgdGhhdA0Kc3JjdSBzdHJ1Y3R1cmUgc28gSSB3b3Vs
ZCBhcHByZWNpYXRlIGl0IGlmIGl0IHdvdWxkIGJlIHJlbmFtZWQsIGUuZy4gaW50byAic3JjdSIu
DQpTZWUgYWxzbyBjb21taXQgNmE4M2U3NGQyMTRhICgiYmxrLW1xOiBJbnRyb2R1Y2UgYmxrX21x
X3F1aWVzY2VfcXVldWUoKSIpLg0KDQpUaGFua3MsDQoNCkJhcnQu
