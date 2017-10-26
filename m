Return-Path: <prvs=465790858=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"mst@redhat.com" <mst@redhat.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "dann.frazier@canonical.com"
	<dann.frazier@canonical.com>
Subject: Re: [PATCH v2] virtio_blk: Fix an SG_IO regression
Date: Thu, 26 Oct 2017 04:33:49 +0000
Message-ID: <1508992426.8734.3.camel@wdc.com>
References: <20171025095617.7315-1-bart.vanassche@wdc.com>
	 <11a35a46-dc51-c32f-cb64-793d9dd02c53@kernel.dk>
	 <1508959556.5073.1.camel@wdc.com>
	 <83926138-e6aa-6792-5275-31f5c1330c90@kernel.dk>
	 <20171025193752.GA6164@lst.de>
In-Reply-To: <20171025193752.GA6164@lst.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE3LTEwLTI1IGF0IDIxOjM3ICswMjAwLCBoY2hAbHN0LmRlIHdyb3RlOg0KPiBI
b25lc3RseSBJIHRoaW5rIHRoZSByaWdodCBmaXggaXMgdG8ganVzdCBraWxsIHRoZSBTQ1NJIHBh
c3N0aHJvdWdoDQo+IGluIHZpcnRpby4gIEl0IGhhcyBiZWVuIHJlcGxhY2VkIGJ5IHZpcnRpby1z
Y3NpIGEgbG9uZyB0aW1lIGFnbywgYW5kDQo+IGhhcyBiZWVuIGRpc2FibGVkIGJ5IGRlZmF1bHQg
aW4gcWVtdSBmb3IgYSBsb25nIHRpbWUgKGFuZCBJIGRvbid0DQo+IHRoaW5rIGFueSBvdGhlciBo
eXBlcnZpc29yIGV2ZXIgc3VwcG9ydGVkIGl0KS4NCj4gDQo+IEl0IHNob3VsZCBuZXZlciBoYXZl
IGJlZW4gYWRkZWQgKHNheWluZyB0aGF0IGFzIHRoZSBwZXJzb24gd2hvIGFkZGVkDQo+IGl0KS4N
Cg0KSGVsbG8gQ2hyaXN0b3BoLA0KDQpTb3JyeSBidXQgSSdtIG5vdCBmYW1pbGlhciBlbm91Z2gg
d2l0aCB0aGUgdmlydGlvX2JsayBkcml2ZXIgdG8gZG8gdGhhdA0KcmVtb3ZhbCBteXNlbGYuIFNp
bmNlIHRoZSBwYXRjaCBhdCB0aGUgc3RhcnQgb2YgdGhpcyBlLW1haWwgdGhyZWFkIGhhcw0KYSAi
Q2M6IHN0YWJsZSIgdGFnLCBjYW4geW91IHN1Ym1pdCBzdWNoIGEgcGF0Y2ggYWZ0ZXIgdGhpcyBw
YXRjaCB3ZW50DQppbj8NCg0KVGhhbmtzLA0KDQpCYXJ0Lg==
