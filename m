Return-Path: <prvs=6335d9f7e=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "alan.christopher.jenkins@gmail.com" <alan.christopher.jenkins@gmail.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] block: do not use interruptible wait anywhere
Date: Thu, 12 Apr 2018 17:51:56 +0000
Message-ID: <13e67e1243ebd96f3f56a150d47444ada47ebde0.camel@wdc.com>
References: <20180412162321.3671-1-alan.christopher.jenkins@gmail.com>
In-Reply-To: <20180412162321.3671-1-alan.christopher.jenkins@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVGh1LCAyMDE4LTA0LTEyIGF0IDE3OjIzICswMTAwLCBBbGFuIEplbmtpbnMgd3JvdGU6DQo+
IEBAIC05NDcsMTQgKzk0NiwxMiBAQCBpbnQgYmxrX3F1ZXVlX2VudGVyKHN0cnVjdCByZXF1ZXN0
X3F1ZXVlICpxLCBibGtfbXFfcmVxX2ZsYWdzX3QgZmxhZ3MpDQo+ICAJCSAqLw0KPiAgCQlzbXBf
cm1iKCk7DQo+ICANCj4gLQkJcmV0ID0gd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlKHEtPm1xX2Zy
ZWV6ZV93cSwNCj4gKwkJd2FpdF9ldmVudChxLT5tcV9mcmVlemVfd3EsDQo+ICAJCQkJKGF0b21p
Y19yZWFkKCZxLT5tcV9mcmVlemVfZGVwdGgpID09IDAgJiYNCj4gIAkJCQkgKHByZWVtcHQgfHwg
IWJsa19xdWV1ZV9wcmVlbXB0X29ubHkocSkpKSB8fA0KPiAgCQkJCWJsa19xdWV1ZV9keWluZyhx
KSk7DQo+ICAJCWlmIChibGtfcXVldWVfZHlpbmcocSkpDQo+ICAJCQlyZXR1cm4gLUVOT0RFVjsN
Cj4gLQkJaWYgKHJldCkNCj4gLQkJCXJldHVybiByZXQ7DQo+ICAJfQ0KPiAgfQ0KDQpIZWxsbyBB
bGFuLA0KDQpQbGVhc2UgcmVpbmRlbnQgdGhlIHdhaXRfZXZlbnQoKSBhcmd1bWVudHMgc3VjaCB0
aGF0IHRoZXNlIHJlbWFpbiBhbGlnbmVkLg0KDQpBbnl3YXk6DQoNClJldmlld2VkLWJ5OiBCYXJ0
IFZhbiBBc3NjaGUgPGJhcnQudmFuYXNzY2hlQHdkYy5jb20+DQoNCg0K
