Return-Path: <prvs=6236fbcb6=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "kernel-team@fb.com" <kernel-team@fb.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] blk-mq: Fix request handover from timeout path to
 normal execution
Date: Mon, 2 Apr 2018 21:56:41 +0000
Message-ID: <afef8f4812b357deeadc0999f4c85d7b0049b738.camel@wdc.com>
References: <20180402190053.GC388343@devbig577.frc2.facebook.com>
	 <20180402190120.GD388343@devbig577.frc2.facebook.com>
	 <b52fa22c-c7fa-5ebd-35cb-527786e6d08e@wdc.com>
	 <20180402211047.GF388343@devbig577.frc2.facebook.com>
In-Reply-To: <20180402211047.GF388343@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE4LTA0LTAyIGF0IDE0OjEwIC0wNzAwLCBUZWp1biBIZW8gd3JvdGU6DQo+IE9u
IE1vbiwgQXByIDAyLCAyMDE4IGF0IDAyOjA4OjM3UE0gLTA3MDAsIEJhcnQgVmFuIEFzc2NoZSB3
cm90ZToNCj4gPiBPbiAwNC8wMi8xOCAxMjowMSwgVGVqdW4gSGVvIHdyb3RlOg0KPiA+ID4gKwkg
KiBBcyBub3RoaW5nIHByZXZlbnRzIGZyb20gY29tcGxldGlvbiBoYXBwZW5pbmcgd2hpbGUNCj4g
PiA+ICsJICogLT5hYm9ydGVkX2dzdGF0ZSBpcyBzZXQsIHRoaXMgbWF5IGxlYWQgdG8gaWdub3Jl
ZCBjb21wbGV0aW9ucw0KPiA+ID4gKwkgKiBhbmQgZnVydGhlciBzcHVyaW91cyB0aW1lb3V0cy4N
Cj4gPiA+ICsJICovDQo+ID4gPiArCWlmIChycS0+cnFfZmxhZ3MgJiBSUUZfTVFfVElNRU9VVF9S
RVNFVCkNCj4gPiA+ICsJCWJsa19tcV9ycV91cGRhdGVfYWJvcnRlZF9nc3RhdGUocnEsIDApOw0K
PiA+IA0KPiA+IEhlbGxvIFRlanVuLA0KPiA+IA0KPiA+IFNpbmNlIHRoaXMgcGF0Y2ggZml4ZXMg
b25lIHJhY2UgYnV0IGludHJvZHVjZXMgYW5vdGhlciByYWNlLCBpcyB0aGlzDQo+ID4gcGF0Y2gg
cmVhbGx5IGFuIGltcHJvdmVtZW50Pw0KPiANCj4gT2gsIHRoYXQncyBub3QgYSBuZXcgcmFjZS4g
IFRoYXQncyB0aGUgc2FtZSBub24tY3JpdGljYWwgcmFjZSB3aGljaA0KPiBhbHdheXMgZXhpc3Rl
ZC4gIEl0J3MganVzdCBiZWluZyBkb2N1bWVudGVkLg0KDQpUaGlzIHBhdGNoIGluY3JlYXNlcyB0
aGUgdGltZSBkdXJpbmcgd2hpY2ggLmFib3J0ZWRfZ3N0YXRlID09IC5nc3RhdGUgaWYgdGhlDQp0
aW1lb3V0IGlzIHJlc2V0LiBEb2VzIHRoYXQgaW5jcmVhc2UgdGhlIGNoYW5jZSB0aGF0IGEgY29t
cGxldGlvbiB3aWxsIGJlIG1pc3NlZA0KaWYgdGhlIHJlcXVlc3QgdGltZW91dCBpcyByZXNldD8N
Cg0KVGhhbmtzLA0KDQpCYXJ0Lg0KDQoNCg==
