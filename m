Return-Path: <prvs=541b0d852=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH 3/4] block: convert REQ_ATOM_COMPLETE to stealing
 rq->__deadline bit
Date: Wed, 10 Jan 2018 18:29:36 +0000
Message-ID: <1515608975.2745.14.camel@wdc.com>
References: <1515544167-10751-1-git-send-email-axboe@kernel.dk>
	 <1515544167-10751-4-git-send-email-axboe@kernel.dk>
In-Reply-To: <1515544167-10751-4-git-send-email-axboe@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTAxLTA5IGF0IDE3OjI5IC0wNzAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBA
QCAtMzEzLDggKzMwNyw2IEBAIGludCBfX2Jsa19tcV9kZWJ1Z2ZzX3JxX3Nob3coc3RydWN0IHNl
cV9maWxlICptLCBzdHJ1Y3QgcmVxdWVzdCAqcnEpDQo+ICAJc2VxX3B1dHMobSwgIiwgLnJxX2Zs
YWdzPSIpOw0KPiAgCWJsa19mbGFnc19zaG93KG0sIChfX2ZvcmNlIHVuc2lnbmVkIGludClycS0+
cnFfZmxhZ3MsIHJxZl9uYW1lLA0KPiAgCQkgICAgICAgQVJSQVlfU0laRShycWZfbmFtZSkpOw0K
PiAtCXNlcV9wdXRzKG0sICIsIC5hdG9taWNfZmxhZ3M9Iik7DQo+IC0JYmxrX2ZsYWdzX3Nob3co
bSwgcnEtPmF0b21pY19mbGFncywgcnFhZl9uYW1lLCBBUlJBWV9TSVpFKHJxYWZfbmFtZSkpOw0K
PiAgCXNlcV9wcmludGYobSwgIiwgLnRhZz0lZCwgLmludGVybmFsX3RhZz0lZCIsIHJxLT50YWcs
DQo+ICAJCSAgIHJxLT5pbnRlcm5hbF90YWcpOw0KPiAgCWlmIChtcV9vcHMtPnNob3dfcnEpDQoN
CldoZXRoZXIgb3Igbm90IGEgcmVxdWVzdCBoYXMgYmVlbiBtYXJrZWQgY29tcGxldGUgaXMgdmVy
eSB1c2VmdWwgdG8ga25vdy4gSGF2ZSB5b3UNCmNvbnNpZGVyZWQgdG8gc2hvdyB0aGUgcmV0dXJu
IHZhbHVlIG9mIGJsa19ycV9pc19jb21wbGV0ZSgpIGluIHRoZSBkZWJ1Z2ZzIG91dHB1dD8NCg0K
VGhhbmtzLA0KDQpCYXJ0Lg==
