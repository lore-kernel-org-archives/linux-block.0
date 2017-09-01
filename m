Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le Moal
	<Damien.LeMoal@wdc.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 4/8] scsi: sd_zbc: Reorganize and cleanup
Date: Fri, 1 Sep 2017 16:14:02 +0000
Message-ID: <1504282441.14386.32.camel@wdc.com>
References: <20170901113631.12323-1-damien.lemoal@wdc.com>
	 <20170901113631.12323-5-damien.lemoal@wdc.com>
In-Reply-To: <20170901113631.12323-5-damien.lemoal@wdc.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE3LTA5LTAxIGF0IDIwOjM2ICswOTAwLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToN
Cj4gSW50cm9kdWNlIHNkX3piYy5oIGZvciB6YmMgcmVsYXRlZCBkZWNsYXJhdGlvbnMgKGF2b2lk
IGNsdXR0ZXJpbmcgc2QuaCkuDQo+IA0KPiBGaXggY29tbWVudHMgc3R5bGUgaW4gc2RfemJjLmMg
KGRvIG5vdCB1c2UgZG9jdW1lbnRhdGlvbiBmb3JtYXQpIGFuZA0KPiBhZGQvZml4IGNvbW1lbnRz
IHRvIGVuaGFuY2UgZXhwbGFuYXRpb25zLiBBbHNvIHJlbW92ZSBhIHVzZWxlc3MgYmxhbmsNCj4g
bGluZSBpbiBzZF96YmNfcmVhZF96b25lcygpLg0KPiANCj4gUmVhcnJhbmdlIHNkX3piY19zZXR1
cCgpIHRvIGluY2x1ZGUgdXNlXzE2X2Zvcl9ydyBhbmQgdXNlXzEwX2Zvcl9ydw0KPiBhc3NpZ25t
ZW50IGFuZCBzaW1wbGlmeSBucl96b25lcyBjYWxjdWxhdGlvbi4NCj4gDQo+IEZpbmFsbHksIHVz
ZSB0aGUgbWluKCkgbWFjcm8gc2RfemJjX2NoZWNrX3pvbmVfc2l6ZSgpIHRvIGdldCBhIHJlcG9y
dA0KPiB6b25lIHJlcGx5IHNpemUgaW5zdGVhZCBvZiB0aGUgb3BlbiBjb2RlZCB2ZXJzaW9uLg0K
DQpIZWxsbyBEYW1pZW4sDQoNClNob3VsZCB0aGlzIHBhdGNoIHBlcmhhcHMgYmUgc3BsaXQgaW50
byBtdWx0aXBsZSBwYXRjaGVzIHRvIG1ha2UgcmV2aWV3DQplYXNpZXI/DQoNCj4gK3N0YXRpYyBp
bmxpbmUgdm9pZCBzZF96YmNfcmVtb3ZlKHN0cnVjdCBzY3NpX2Rpc2sgKnNka3ApIHt9DQoNClBs
ZWFzZSB1c2UgdGhlIHNhbWUgY29kaW5nIHN0eWxlIGFzIGluIG90aGVyIExpbnV4IGtlcm5lbCBo
ZWFkZXIgZmlsZXMsDQpuYW1lbHkgJ3snIGFuZCAnfScgYm90aCBhdCB0aGUgc3RhcnQgb2YgYSBs
aW5lLiBTZWUgZS5nLiBpbmNsdWRlL2xpbnV4L3N5c2ZzLmguDQoNClRoYW5rcywNCg0KQmFydC4=
