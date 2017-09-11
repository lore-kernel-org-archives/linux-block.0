Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "neilb@suse.com" <neilb@suse.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "cl@linux.com"
	<cl@linux.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 1/5] percpu-refcount: Introduce
 percpu_ref_switch_to_atomic_nowait()
Date: Mon, 11 Sep 2017 16:09:12 +0000
Message-ID: <1505146151.2802.21.camel@wdc.com>
References: <20170908235226.26622-1-bart.vanassche@wdc.com>
	 <20170908235226.26622-2-bart.vanassche@wdc.com>
	 <20170911131331.GE1774378@devbig577.frc2.facebook.com>
In-Reply-To: <20170911131331.GE1774378@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE3LTA5LTExIGF0IDA2OjEzIC0wNzAwLCBUZWp1biBIZW8gd3JvdGU6DQo+IE9u
IEZyaSwgU2VwIDA4LCAyMDE3IGF0IDA0OjUyOjIyUE0gLTA3MDAsIEJhcnQgVmFuIEFzc2NoZSB3
cm90ZToNCj4gPiBUaGUgYmxrLW1xIGNvcmUga2VlcHMgdHJhY2sgb2YgdGhlIG51bWJlciBvZiBy
ZXF1ZXN0IHF1ZXVlIHVzZXJzDQo+ID4gdGhyb3VnaCBxLT5xX3VzYWdlX2NvdW50LiBNYWtlIGl0
IHBvc3NpYmxlIHRvIHN3aXRjaCB0aGlzIGNvdW50ZXINCj4gPiB0byBhdG9taWMgbW9kZSBmcm9t
IHRoZSBjb250ZXh0IG9mIHRoZSBibG9jayBsYXllciBwb3dlciBtYW5hZ2VtZW50DQo+ID4gY29k
ZSBieSBpbnRyb2R1Y2luZyBwZXJjcHVfcmVmX3N3aXRjaF90b19hdG9taWNfbm93YWl0KCkuDQo+
IA0KPiBEbyB5b3UgZXZlciBoYXZlIHRvIHN3aXRjaCBiYWNrPyAgSWYgc28sIGhvdyBkbyB5b3Ug
a25vdyB3aGV0aGVyIHRoZQ0KPiBwcmV2aW91cyB0cmFuc2l0aW9uIGZpbmlzaGVkPw0KDQpIZWxs
byBUZWp1biwNCg0KVGhlIHdheSBJIHdvdWxkIGxpa2UgdG8gdXNlIHRoaXMgZnVuY3Rpb24gaXMg
dG8gY2hlY2sgZm9yIGNvbXBsZXRpb24gb2YgdGhlDQp0cmFuc2l0aW9uIGJ5IGNhbGxpbmcgcGVy
Y3B1X3JlZl9pc196ZXJvKCkuIFRoYXQgZnVuY3Rpb24gbmFtZWx5IG5vdCBvbmx5DQpjaGVja3Mg
dGhlIHZhbHVlIG9mIHRoZSByZWZjb3VudCBidXQgYWxzbyB3aGV0aGVyIGl0IGlzIGluIGF0b21p
YyBtb2RlLiBTZWUNCmFsc28gIltQQVRDSCA1LzVdIGJsay1tcTogSW1wbGVtZW50IHBvd2VyIG1h
bmFnZW1lbnQgc3VwcG9ydCINCihodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1i
bG9jay9tc2cxNzE0My5odG1sKS4gRG8geW91IHRoaW5rIHRoaXMNCndpbGwgd29yaz8NCg0KVGhh
bmtzLA0KDQpCYXJ0Lg==
