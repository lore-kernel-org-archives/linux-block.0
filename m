Return-Path: <prvs=588021d7b=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jiufei.xue@linux.alibaba.com" <jiufei.xue@linux.alibaba.com>,
	"hch@lst.de" <hch@lst.de>, "shli@kernel.org" <shli@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "caspar@linux.alibaba.com" <caspar@linux.alibaba.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH 1/4] block: fix the count of PGPGOUT for WRITE_SAME
Date: Mon, 26 Feb 2018 23:43:20 +0000
Message-ID: <1519688599.2789.12.camel@wdc.com>
References: <fc363a8d-957c-be3a-e60a-a8b40727d727@linux.alibaba.com>
	 <ccd2433b-c197-bce3-fec7-14467f864d19@linux.alibaba.com>
In-Reply-To: <ccd2433b-c197-bce3-fec7-14467f864d19@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE4LTAyLTI2IGF0IDIwOjA0ICswODAwLCBKaXVmZWkgWHVlIHdyb3RlOg0KPiBU
aGUgdm0gY291bnRlcnMgaXMgY291bnRlZCBpbiBzZWN0b3JzLCBzbyB3ZSBzaG91bGQgZG8gdGhl
IGNvbnZlcnNhdGlvbg0KPiBpbiBzdWJtaXRfYmlvLg0KPiANCj4gRml4ZXM6IDc0ZDQ2OTkyZTBk
OSAoImJsb2NrOiByZXBsYWNlIGJpX2JkZXYgd2l0aCBhIGdlbmRpc2sgcG9pbnRlciBhbmQNCj4g
cGFydGl0aW9ucyBpbmRleCIpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaXVmZWkgWHVlIDxqaXVm
ZWkueHVlQGxpbnV4LmFsaWJhYmEuY29tPg0KPiAtLS0NCj4gIGJsb2NrL2Jsay1jb3JlLmMgfCAy
ICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9ibG9jay9ibGstY29yZS5jIGIvYmxvY2svYmxrLWNvcmUuYw0KPiBp
bmRleCAyZDFhN2JiLi42ZDgyYzRmIDEwMDY0NA0KPiAtLS0gYS9ibG9jay9ibGstY29yZS5jDQo+
ICsrKyBiL2Jsb2NrL2Jsay1jb3JlLmMNCj4gQEAgLTI0MzQsNyArMjQzNCw3IEBAIGJsa19xY190
IHN1Ym1pdF9iaW8oc3RydWN0IGJpbyAqYmlvKQ0KPiAgCQl1bnNpZ25lZCBpbnQgY291bnQ7DQo+
ICANCj4gIAkJaWYgKHVubGlrZWx5KGJpb19vcChiaW8pID09IFJFUV9PUF9XUklURV9TQU1FKSkN
Cj4gLQkJCWNvdW50ID0gcXVldWVfbG9naWNhbF9ibG9ja19zaXplKGJpby0+YmlfZGlzay0+cXVl
dWUpOw0KPiArCQkJY291bnQgPSBxdWV1ZV9sb2dpY2FsX2Jsb2NrX3NpemUoYmlvLT5iaV9kaXNr
LT5xdWV1ZSkgPj4gOTsNCj4gIAkJZWxzZQ0KPiAgCQkJY291bnQgPSBiaW9fc2VjdG9ycyhiaW8p
Ow0KDQpTaW5jZSB0aGlzIGlzIGEgZml4IGZvciBhIGtlcm5lbCB2NC4xNCBjaGFuZ2UsIHBsZWFz
ZSBhZGQgYQ0KIkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnIiB0YWcuDQoNClRoYW5rcywNCg0K
QmFydC4NCg0KDQo=
