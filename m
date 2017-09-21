Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "hare@suse.com" <hare@suse.com>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "oleksandr@natalenko.name"
	<oleksandr@natalenko.name>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2 3/4] block, scsi: Make SCSI device suspend and resume
 work reliably
Date: Thu, 21 Sep 2017 22:44:23 +0000
Message-ID: <1506033862.2521.28.camel@wdc.com>
References: <20170921212255.12788-1-bart.vanassche@wdc.com>
	 <20170921212255.12788-4-bart.vanassche@wdc.com>
	 <20170921220401.GC6854@ming.t460p>
In-Reply-To: <20170921220401.GC6854@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE3LTA5LTIyIGF0IDA2OjA0ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
VGh1LCBTZXAgMjEsIDIwMTcgYXQgMDI6MjI6NTRQTSAtMDcwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IC0tLSBhL2Jsb2NrL2Jsay1jb3JlLmMNCj4gPiArKysgYi9ibG9jay9ibGstY29y
ZS5jDQo+ID4gQEAgLTE0MjksMTEgKzE0MjksMTggQEAgc3RydWN0IHJlcXVlc3QgKmJsa19nZXRf
cmVxdWVzdChzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSwgdW5zaWduZWQgaW50IG9wLA0KPiA+ICAJ
CQkJZ2ZwX3QgZ2ZwX21hc2spDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCByZXF1ZXN0ICpyZXE7DQo+
ID4gKwljb25zdCBib29sIG1heV9zbGVlcCA9IGdmcF9tYXNrICYgX19HRlBfRElSRUNUX1JFQ0xB
SU07DQo+ID4gKw0KPiA+ICsJaWYgKHVubGlrZWx5KGJsa19xdWV1ZV9wcmVlbXB0X29ubHkocSkg
JiYgIShvcCAmIFJFUV9QUkVFTVBUKSkpIHsNCj4gDQo+IFRoZSBmbGFnIGlzIHNldCB3aXRoIHF1
ZXVlX2xvY2ssIGJ1dCBjaGVja2VkIHdpdGhvdXQgYW55IGxvY2ssIGRvIHlvdQ0KPiB0aGluayBp
dCBpcyBzYWZlIGluIHRoaXMgd2F5Pw0KPiANCj4gQWxzbyB0aGlzIGZsYWcgaXNuJ3QgY2hlY2tl
ZCBpbiBub3JtYWwgSS9PIHBhdGgsIGJ1dCB5b3UgdW5mcmVlemUNCj4gcXVldWUgZHVyaW5nIHNj
c2lfZGV2aWNlX3F1aWVzY2UoKSwgdGhlbiBhbnkgbm9ybWFsIEkvTyBjYW4gY29tZQ0KPiBmcm9t
IHRoYXQgdGltZS4NCg0KSSB3aWxsIGFkZHJlc3MgYm90aCBjb21tZW50cyBpbiB0aGUgbmV4dCB2
ZXJzaW9uIG9mIHRoaXMgcGF0Y2ggc2VyaWVzLg0KDQpCYXJ0Lg==
