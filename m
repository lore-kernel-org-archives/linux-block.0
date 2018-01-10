Return-Path: <prvs=541b0d852=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH 3/4] block: convert REQ_ATOM_COMPLETE to stealing
 rq->__deadline bit
Date: Wed, 10 Jan 2018 18:33:22 +0000
Message-ID: <1515609201.2745.15.camel@wdc.com>
References: <1515544167-10751-1-git-send-email-axboe@kernel.dk>
	 <1515544167-10751-4-git-send-email-axboe@kernel.dk>
	 <1515608975.2745.14.camel@wdc.com>
	 <1ce2cc85-1217-c0a8-2ca3-afe3e1c3845c@kernel.dk>
In-Reply-To: <1ce2cc85-1217-c0a8-2ca3-afe3e1c3845c@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTAxLTEwIGF0IDExOjMyIC0wNzAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBP
biAxLzEwLzE4IDExOjI5IEFNLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+ID4gT24gVHVlLCAy
MDE4LTAxLTA5IGF0IDE3OjI5IC0wNzAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiA+ID4gQEAgLTMx
Myw4ICszMDcsNiBAQCBpbnQgX19ibGtfbXFfZGVidWdmc19ycV9zaG93KHN0cnVjdCBzZXFfZmls
ZSAqbSwgc3RydWN0IHJlcXVlc3QgKnJxKQ0KPiA+ID4gIAlzZXFfcHV0cyhtLCAiLCAucnFfZmxh
Z3M9Iik7DQo+ID4gPiAgCWJsa19mbGFnc19zaG93KG0sIChfX2ZvcmNlIHVuc2lnbmVkIGludCly
cS0+cnFfZmxhZ3MsIHJxZl9uYW1lLA0KPiA+ID4gIAkJICAgICAgIEFSUkFZX1NJWkUocnFmX25h
bWUpKTsNCj4gPiA+IC0Jc2VxX3B1dHMobSwgIiwgLmF0b21pY19mbGFncz0iKTsNCj4gPiA+IC0J
YmxrX2ZsYWdzX3Nob3cobSwgcnEtPmF0b21pY19mbGFncywgcnFhZl9uYW1lLCBBUlJBWV9TSVpF
KHJxYWZfbmFtZSkpOw0KPiA+ID4gIAlzZXFfcHJpbnRmKG0sICIsIC50YWc9JWQsIC5pbnRlcm5h
bF90YWc9JWQiLCBycS0+dGFnLA0KPiA+ID4gIAkJICAgcnEtPmludGVybmFsX3RhZyk7DQo+ID4g
PiAgCWlmIChtcV9vcHMtPnNob3dfcnEpDQo+ID4gDQo+ID4gV2hldGhlciBvciBub3QgYSByZXF1
ZXN0IGhhcyBiZWVuIG1hcmtlZCBjb21wbGV0ZSBpcyB2ZXJ5IHVzZWZ1bCB0byBrbm93LiBIYXZl
IHlvdQ0KPiA+IGNvbnNpZGVyZWQgdG8gc2hvdyB0aGUgcmV0dXJuIHZhbHVlIG9mIGJsa19ycV9p
c19jb21wbGV0ZSgpIGluIHRoZSBkZWJ1Z2ZzIG91dHB1dD8NCj4gDQo+IFllYWgsIHRoYXQncyBh
IGdvb2QgcG9pbnQuIExldCBtZSBhZGQgdGhhdCBpbiBsaWV1IG9mIHRoZSBhdG9taWMgZmxhZ3Mg
dGhhdA0KPiBhcmUgYmVpbmcga2lsbGVkLiBBcmUgeW91IGZpbmUgd2l0aCB0aGUgcGF0Y2ggdGhl
bj8NCg0KVGhlIHJlc3Qgb2YgdGhlIHBhdGNoIGxvb2tzIGZpbmUgdG8gbWUuIFRoaXMgaXMgdGhl
IG9ubHkgY29tbWVudCBJIGhhZCBhYm91dCB0aGlzIHBhdGNoLg0KDQpCYXJ0Lg==
