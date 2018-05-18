Return-Path: <prvs=669a0b661=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "huhai@kylinos.cn" <huhai@kylinos.cn>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: blk-mq: make sure that correct hctx->dispatch_from is set
Date: Fri, 18 May 2018 15:10:09 +0000
Message-ID: <a59b0cd1a5bddf8f00eda21e3eaadfe02db52311.camel@wdc.com>
References: <tencent_47349987636D0D2B620828E0@qq.com>
	 <6c265e65-d248-f6e0-1be4-e4223f1a4ed6@kernel.dk>
	 <07c44734-2aeb-79b2-6404-893b575debd5@kernel.dk>
	 <tencent_128A9294097C7C620337BAAF@qq.com>
In-Reply-To: <tencent_128A9294097C7C620337BAAF@qq.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE4LTA1LTE4IGF0IDIyOjQ2ICswODAwLCBodWhhaSB3cm90ZToNCj4gWWVzLCBp
dCBpcyBtb3JlIHJlYWRhYmxlDQo+IA0KPiBGaW5hbGx5LCB0aGFuayB5b3UgZm9yIHJlbWluZGlu
ZyBtZS4gTmV4dCB0aW1lIEknbGwgY2hhbmdlIGdtYWlsIHRvIHN1Ym1pdCBwYXRjaC4NCg0KSGVs
bG8gSHVoYWksDQoNClBsZWFzZSBoYXZlIGEgbG9vayBhdCBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mv
ZW1haWwtY2xpZW50cy5yc3QuDQoNClRoYW5rcywNCg0KQmFydC4NCg0KDQoNCg0KDQoNCg0KDQo=
