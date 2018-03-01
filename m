Return-Path: <prvs=591f9e40c=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jthumshirn@suse.de" <jthumshirn@suse.de>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hare@suse.de" <hare@suse.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
Subject: Re: [PATCH 04/11] block: Protect queue flag changes with the queue
 lock
Date: Thu, 1 Mar 2018 15:19:08 +0000
Message-ID: <1519917546.3204.4.camel@wdc.com>
References: <20180228192823.5191-1-bart.vanassche@wdc.com>
	 <20180228192823.5191-5-bart.vanassche@wdc.com>
	 <20180301085137.6g3hgobf6kj2bosy@linux-x5ow.site>
In-Reply-To: <20180301085137.6g3hgobf6kj2bosy@linux-x5ow.site>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVGh1LCAyMDE4LTAzLTAxIGF0IDA5OjUxICswMTAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IE9uIFdlZCwgRmViIDI4LCAyMDE4IGF0IDExOjI4OjE2QU0gLTA4MDAsIEJhcnQgVmFu
IEFzc2NoZSB3cm90ZToNCj4gPiAgc3RhdGljIGJvb2wgYmxrX3BvbGxfc3RhdHNfZW5hYmxlKHN0
cnVjdCByZXF1ZXN0X3F1ZXVlICpxKQ0KPiA+ICB7DQo+ID4gLQlpZiAodGVzdF9iaXQoUVVFVUVf
RkxBR19QT0xMX1NUQVRTLCAmcS0+cXVldWVfZmxhZ3MpIHx8DQo+ID4gLQkgICAgdGVzdF9hbmRf
c2V0X2JpdChRVUVVRV9GTEFHX1BPTExfU1RBVFMsICZxLT5xdWV1ZV9mbGFncykpDQo+ID4gKwlp
ZiAoYmxrX3F1ZXVlX2ZsYWdfdGVzdF9hbmRfc2V0KFFVRVVFX0ZMQUdfUE9MTF9TVEFUUywgcSkp
DQo+IA0KPiBJcyB0aGlzIG9uZSByZWFsbHkgbmVlZGVkIG9yIGp1c3QgZm9yIHN5bW1ldHJ5PyBF
dmVuIGlmIHNvbWV0aGluZw0KPiB3b3VsZCBjaGFuZ2UgdGhlIHF1ZXVlX2ZsYWdzIGFmdGVyIHRo
ZSBmaXJzdCB0ZXN0X2JpdCgpIGNhbGwsIHRoZQ0KPiB0ZXN0X2FuZF9zZXRfYml0KCkgd291bGQg
c3RpbGwgZG8gdGhlIHJpZ2h0IHRoaW5nLCB3b3VsZG4ndCBpdD8NCg0KSGVsbG8gSm9oYW5uZXMs
DQoNClNpbmNlIGJsa19wb2xsX3N0YXRzX2VuYWJsZSgpIGlzIGNhbGxlZCBmcm9tIHRoZSBob3Qg
cGF0aCAocG9sbGluZyBjb2RlKSBJDQp0aGluayB3ZSBuZWVkIHRoZSBvcHRpbWl6YXRpb24gb2Yg
Y2FsbGluZyB0ZXN0X2JpdCgpIGJlZm9yZSBjYWxsaW5nDQp0ZXN0X2FuZF9zZXRfYml0KCkuIEkg
d2lsbCByZXN0b3JlIHRoZSB0ZXN0X2JpdCgpIGNhbGwuDQoNCkJhcnQu
