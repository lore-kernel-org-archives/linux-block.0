Return-Path: <prvs=5429ea774=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "osandov@fb.com" <osandov@fb.com>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>
Subject: Re: [PATCH v2 2/2] blk-mq: Fix a race condition in
 blk_mq_mark_tag_wait()
Date: Thu, 11 Jan 2018 17:27:24 +0000
Message-ID: <1515691643.2752.27.camel@wdc.com>
References: <20180110193919.6886-1-bart.vanassche@wdc.com>
	 <20180110193919.6886-3-bart.vanassche@wdc.com>
	 <c796aeee-7e3d-485e-403c-f36ab5254bd0@suse.de>
In-Reply-To: <c796aeee-7e3d-485e-403c-f36ab5254bd0@suse.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVGh1LCAyMDE4LTAxLTExIGF0IDA4OjM5ICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6
DQo+IEknbSBhY3R1YWxseSBub3QgdGhhdCBjb252aW5jZWQgd2l0aCB0aGlzIGNoYW5nZTsgb3Jp
Z2luYWxseSB3ZSBoYWQgYmVlbg0KPiBjaGVja2luZyBpZiBpdCdzIG9uIHRoZSB3YWl0IGxpc3Qs
IGFuZCBvbmx5IF90aGVuXyBjYWxsIGJ0X3dhaXRfcHRyKCkuDQo+IE5vdyB3ZSBjYWxsIGJ0X3dh
aXRfcHRyKCkgYWx3YXlzLCBtZWFuaW5nIHdlIHJ1biBhIGNoYW5jZSBvZiBpbmNyZWFzaW5nDQo+
IHRoZSBiaXRtYXBfdGFncyB3YWl0IHBvaW50ZXIgd2l0aG91dCBhY3R1YWxseSB1c2luZyBpdC4N
Cj4gTG9va2luZyBhdCB0aGUgY29kZSBJJ20gbm90IHN1cmUgdGhpcyBpcyB0aGUgY29ycmVjdCB3
YXkgb2YgdXNpbmcgaXQgLi4uDQoNCkhlbGxvIEhhbm5lcywNCg0KQXJlIHlvdSBwZXJoYXBzIHJl
ZmVycmluZyB0byBzYnFfaW5kZXhfYXRvbWljX2luYygpPyBJIHRoaW5rIGl0J3MgZmluZSB0bw0K
Y2FsbCBidF93YWl0X3B0cigpIGV2ZW4gaWYgdGhlIGNvcnJlc3BvbmRpbmcgd2FpdHF1ZXVlIHdv
bid0IGJlIHVzZWQuIE15DQp1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhlIHB1cnBvc2Ugb2YgaGF2
aW5nIG11bHRpcGxlIHdhaXRxdWV1ZXMgYW5kIG9mDQp1c2luZyB0aGVzZSBpbiBhIHJvdW5kLXJv
YmluIGZhc2hpb24gaXMgdG8gYXZvaWQgdGhhdCBpZiBsZXNzIHRoYW4gb3IgZXF1YWwNCnRvIDgg
KFNCUV9XQUlUX1FVRVVFUykgdGhyZWFkcyBhcmUgd2FpdGluZyBmb3IgYSB0YWcgdGhhdCB0aGVz
ZSB3b24ndCB1c2UNCnRoZSBzYW1lIHdhaXQgcXVldWUuIFNvIGluIHRoZSB1bmxpa2VseSBldmVu
dCBvZiBhbiBlYXJseSByZXR1cm4gdGhlIHdvcnN0DQp0aGF0IGNhbiBoYXBwZW4gaXMgdGhhdCB0
aGVyZSBpcyBtb3JlIGNvbnRlbnRpb24gb24gb25lIG9mIHRoZSBlaWdodCB3YWl0DQpxdWV1ZXMu
IEJ1dCBzaW5jZSB0aGF0IGlzIGFuIHVubGlrZWx5IHNjZW5hcmlvIEkgZG9uJ3QgdGhpbmsgd2Ug
aGF2ZSB0bw0Kd29ycnkgYWJvdXQgdGhpcy4NCg0KQmFydC4=
