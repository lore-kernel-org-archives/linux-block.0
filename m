Return-Path: <prvs=6335d9f7e=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "00moses.alexander00@gmail.com"
	<00moses.alexander00@gmail.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: Ensure that a request queue is dissociated from
 the cgroup controller
Date: Thu, 12 Apr 2018 16:03:52 +0000
Message-ID: <beafd7bc4f2fdb7e672ad97e57ff4f82464182da.camel@wdc.com>
References: <20180412015852.26014-1-bart.vanassche@wdc.com>
	 <20180412135149.GX793541@devbig577.frc2.facebook.com>
	 <af6dafea-d754-8a0d-b96b-81716f2ea24d@wdc.com>
	 <20180412153748.GB793541@devbig577.frc2.facebook.com>
In-Reply-To: <20180412153748.GB793541@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVGh1LCAyMDE4LTA0LTEyIGF0IDA4OjM3IC0wNzAwLCBUZWp1biBIZW8gd3JvdGU6DQo+IE9u
IFRodSwgQXByIDEyLCAyMDE4IGF0IDA4OjA5OjE3QU0gLTA2MDAsIEJhcnQgVmFuIEFzc2NoZSB3
cm90ZToNCj4gPiBJIGhhdmUgcmV0ZXN0ZWQgaG90dW5wbHVnZ2luZyBieSByZXJ1bm5pbmcgdGhl
IHNycC10ZXN0IHNvZnR3YXJlLiBJdA0KPiA+IHNlZW1zIGxpa2UgeW91IG92ZXJsb29rZWQgdGhh
dCB0aGlzIHBhdGNoIGRvZXMgbm90IHJlbW92ZSB0aGUNCj4gPiBibGtjZ19leGl0X3F1ZXVlKCkg
Y2FsbCBmcm9tIGJsa19jbGVhbnVwX3F1ZXVlKCk/IElmIGEgZGV2aWNlIGlzDQo+ID4gaG90dW5w
bHVnZ2VkIGl0IGlzIHVwIHRvIHRoZSBibG9jayBkcml2ZXIgdG8gY2FsbA0KPiA+IGJsa19jbGVh
bnVwX3F1ZXVlKCkuIEFuZCBibGtfY2xlYW51cF9xdWV1ZSgpIHdpbGwgY2FsbA0KPiA+IGJsa2Nn
X2V4aXRfcXVldWUoKS4NCj4gDQo+IEhtbS4uLiB3aGF0J2QgcHJldmVudCBibGdfbG9va3VwX2Fu
ZF9jcmVhdGUoKSByYWNpbmcgYWdhaW5zdCB0aGF0Pw0KDQpIZWxsbyBUZWp1biwNCg0KRGlkIHlv
dSBwZXJoYXBzIG1lYW4gYmxrZ19sb29rdXBfY3JlYXRlKCk/IFRoYXQgZnVuY3Rpb24gaGFzIG9u
ZSBjYWxsZXIsDQpuYW1lbHkgYmxrY2dfYmlvX2lzc3VlX2NoZWNrKCkuIFRoZSBvbmx5IGNhbGxl
ciBvZiB0aGF0IGZ1bmN0aW9uIGlzDQpnZW5lcmljX21ha2VfcmVxdWVzdF9jaGVja3MoKS4gQSBw
YXRjaCB3YXMgcG9zdGVkIG9uIHRoZSBsaW51eC1ibG9jayBtYWlsaW5nDQpsaXN0IHJlY2VudGx5
IHRoYXQgc3Vycm91bmRzIHRoYXQgY2FsbCB3aXRoIGJsa19xdWV1ZV9lbnRlcigpIC8gYmxrX3F1
ZXVlX2V4aXQoKS4NCkkgdGhpbmsgdGhhdCBwcmV2ZW50cyB0aGF0IGJsa2NnX2V4aXRfcXVldWUo
KSBpcyBjYWxsZWQgY29uY3VycmVudGx5IHdpdGgNCmJsa2dfbG9va3VwX2NyZWF0ZSgpLg0KDQpC
YXJ0Lg0KDQoNCg0K
