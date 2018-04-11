Return-Path: <prvs=63297c413=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2] blk-mq: Avoid that submitting a bio concurrently with
 device removal triggers a crash
Date: Wed, 11 Apr 2018 02:22:18 +0000
Message-ID: <f97e1ce5ceaa1195114b6813907033e36b591447.camel@wdc.com>
References: <20180410204554.28914-1-bart.vanassche@wdc.com>
	 <20180411021222.GD4494@ming.t460p>
In-Reply-To: <20180411021222.GD4494@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTA0LTExIGF0IDEwOjEyICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
VHVlLCBBcHIgMTAsIDIwMTggYXQgMDI6NDU6NTRQTSAtMDYwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+ICsJc3RydWN0IHJlcXVlc3RfcXVldWUgKnEgPSBiaW8tPmJpX2Rpc2stPnF1ZXVl
Ow0KPiA+ICAJYmxrX3FjX3QgcmV0ID0gQkxLX1FDX1RfTk9ORTsNCj4gPiAgDQo+ID4gKwlpZiAo
YmxrX3F1ZXVlX2VudGVyKHEsIGZsYWdzKSA8IDApIHsNCj4gDQo+IFNhbWUgaXNzdWUgd2l0aCBW
MSwgdGhlIHF1ZXVlIHBvaW50ZXIgaGFzIHRvIGJlIGNoZWNrZWQgYmVmb3JlIGNhbGxpbmcNCj4g
YmxrX3F1ZXVlX2VudGVyKCkuDQoNCkkgdGhpbmsgaXQncyB0aGUgcmVzcG9uc2liaWxpdHkgb2Yg
dGhlIGNhbGxlciB0byBrZWVwIGEgcmVmZXJlbmNlIG9uIHRoZQ0KcmVxdWVzdCBxdWV1ZS4NCg0K
QmFydC4NCg0KDQo=
