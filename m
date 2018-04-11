Return-Path: <prvs=63297c413=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nborisov@suse.com" <nborisov@suse.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"shli@fb.com" <shli@fb.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "00moses.alexander00@gmail.com"
	<00moses.alexander00@gmail.com>, "joseph.qi@linux.alibaba.com"
	<joseph.qi@linux.alibaba.com>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Date: Wed, 11 Apr 2018 20:00:29 +0000
Message-ID: <6e2d8be78572fef5fe8f2e0e7ecbdea5839dc198.camel@wdc.com>
References: <20180407102148.GA9729@gmail.com>
	 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
	 <20180411101242.GA2322@gmail.com>
	 <20180411142019.GG793541@devbig577.frc2.facebook.com>
	 <20180411142859.GB2322@gmail.com>
	 <5fafe1cbf6b0111448a81005c1c16feee24a99ad.camel@wdc.com>
	 <20180411190027.GA21274@gmail.com>
	 <b7809887-24e6-3ad7-e8bd-4fe7ea0927c0@wdc.com>
	 <20180411195700.GP793541@devbig577.frc2.facebook.com>
In-Reply-To: <20180411195700.GP793541@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTA0LTExIGF0IDEyOjU3IC0wNzAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiBPbiBXZWQsIEFwciAxMSwgMjAxOCBhdCAwMTo1NToyNVBNIC0wNjAwLCBCYXJ0IFZhbiBBc3Nj
aGUgd3JvdGU6DQo+ID4gT24gMDQvMTEvMTggMTM6MDAsIEFsZXhhbmRydSBNb2lzZSB3cm90ZToN
Cj4gPiA+IEJ1dCB0aGUgcm9vdCBjYXVzZSBvZiBpdCBpcyBpbiBibGtjZ19pbml0X3F1ZXVlKCkg
d2hlbiBibGtnX2NyZWF0ZSgpIHJldHVybnMNCj4gPiA+IGFuIEVSUiBwdHIsIGJlY2F1c2UgaXQg
dHJpZXMgdG8gaW5zZXJ0IGludG8gYSBwb3B1bGF0ZWQgaW5kZXggaW50byBibGtjZy0+YmxrZ190
cmVlLA0KPiA+ID4gdGhlIGVudHJ5IHRoYXQgd2UgZmFpbCB0byByZW1vdmUgYXQgX19ibGtfcmVs
ZWFzZV9xdWV1ZSgpLg0KPiA+IA0KPiA+IEhlbGxvIEFsZXgsDQo+ID4gDQo+ID4gSGFkIHlvdSBj
b25zaWRlcmVkIHNvbWV0aGluZyBsaWtlIHRoZSB1bnRlc3RlZCBwYXRjaCBiZWxvdz8NCj4gDQo+
IEJ1dCBxdWV1ZSBpbml0IHNob3VsZG4ndCBmYWlsIGhlcmUsIHJpZ2h0Pw0KDQpIZWxsbyBUZWp1
biwNCg0KWW91ciBxdWVzdGlvbiBpcyBub3QgZW50aXJlbHkgY2xlYXIgdG8gbWUuIEFyZSB5b3Ug
cmVmZXJyaW5nIHRvIHRoZSBhdG9taWMNCmFsbG9jYXRpb25zIGluIGJsa2dfY3JlYXRlKCkgb3Ig
YXJlIHlvdSBwZXJoYXBzIHJlZmVycmluZyB0byBzb21ldGhpbmcgZWxzZT8NCg0KQmFydC4NCg0K
DQo=
