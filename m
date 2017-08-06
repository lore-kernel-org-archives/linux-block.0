Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/6] blk-mq: enable checking two part inflight counts at
 the same time
Date: Sun, 6 Aug 2017 00:17:40 +0000
Message-ID: <1501978658.7361.4.camel@wdc.com>
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
	 <1501859062-11120-6-git-send-email-axboe@kernel.dk>
	 <1501875874.2757.28.camel@wdc.com>
	 <305d965b-ab49-6a5f-9e6f-13fdcbfb87e3@kernel.dk>
In-Reply-To: <305d965b-ab49-6a5f-9e6f-13fdcbfb87e3@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE3LTA4LTA0IGF0IDEzOjU2IC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBP
biAwOC8wNC8yMDE3IDAxOjQ0IFBNLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+ID4gT24gRnJp
LCAyMDE3LTA4LTA0IGF0IDA5OjA0IC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiA+ID4gQEAg
LTk4LDExICs5OCwxMyBAQCBzdGF0aWMgdm9pZCBibGtfbXFfY2hlY2tfaW5mbGlnaHQoc3RydWN0
IGJsa19tcV9od19jdHggKmhjdHgsDQo+ID4gPiAgCQlyZXR1cm47DQo+ID4gPiAgDQo+ID4gPiAg
CS8qDQo+ID4gPiAtCSAqIENvdW50IGFzIGluZmxpZ2h0IGlmIGl0IGVpdGhlciBtYXRjaGVzIHRo
ZSBwYXJ0aXRpb24gd2UgYXNrZWQNCj4gPiA+IC0JICogZm9yLCBvciBpZiBpdCdzIHRoZSByb290
DQo+ID4gPiArCSAqIENvdW50IGFzIGluZmxpZ2h0IGlmIGl0IG1hdGNoZXMgdGhlIHBhcnRpdGlv
biwgY291bnQgc2VwYXJhdGVseQ0KPiA+ID4gKwkgKiAoYnV0IGFsbCkgaWYgd2UgZ290IGFza2Vk
IGZvciB0aGUgcm9vdA0KPiA+ID4gIAkgKi8NCj4gPiA+IC0JaWYgKHJxLT5wYXJ0ID09IG1pLT5w
YXJ0IHx8IG1pLT5wYXJ0LT5wYXJ0bm8pDQo+ID4gPiArCWlmIChycS0+cGFydCA9PSBtaS0+cGFy
dCkNCj4gPiA+ICAJCW1pLT5pbmZsaWdodFswXSsrOw0KPiA+ID4gKwlpZiAobWktPnBhcnQtPnBh
cnRubykNCj4gPiA+ICsJCW1pLT5pbmZsaWdodFsxXSsrOw0KPiA+ID4gIH0NCj4gPiANCj4gPiBI
ZWxsbyBKZW5zLA0KPiA+IA0KPiA+IFNhbWUgcXVlc3Rpb24gaGVyZTogc2hvdWxkICJpZiAobWkt
PnBhcnQtPnBhcnRubykiIHBlcmhhcHMgYmUgY2hhbmdlZCBpbnRvDQo+ID4gImlmIChtaS0+cGFy
dC0+cGFydG5vID09IDApIj8NCj4gDQo+IEl0IHNob3VsZCBiZSBjb3JyZWN0IGFzLWlzLg0KDQpB
Z3JlZWQsIEkgZ290IG1pc2xlZCBieSB0aGUgY29tbWVudCBhYm92ZSB0aGUgY29kZS4NCg0KQmFy
dC4=
