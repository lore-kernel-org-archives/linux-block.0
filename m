Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "hare@suse.com" <hare@suse.com>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "oleksandr@natalenko.name"
	<oleksandr@natalenko.name>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 5/7] scsi: Reduce suspend latency
Date: Wed, 27 Sep 2017 03:43:11 +0000
Message-ID: <1506481279.2822.5.camel@wdc.com>
References: <20170925202924.16603-1-bart.vanassche@wdc.com>
	 <20170925202924.16603-6-bart.vanassche@wdc.com>
	 <20170926222322.GA8050@ming.t460p>
In-Reply-To: <20170926222322.GA8050@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE3LTA5LTI3IGF0IDA2OjIzICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gICAg
ICAgICBtdXRleF9sb2NrKCZzZGV2LT5zdGF0ZV9tdXRleCk7DQo+ICAgICAgICAgZXJyID0gc2Nz
aV9kZXZpY2Vfc2V0X3N0YXRlKHNkZXYsIFNERVZfUVVJRVNDRSk7DQo+ICAgICAgICAgaWYgKGVy
ciA9PSAwKQ0KPiAgICAgICAgICAgICAgICAgYmxrX3NldF9wcmVlbXB0X29ubHkocSwgdHJ1ZSk7
DQo+ICAgICAgICAgbXV0ZXhfdW5sb2NrKCZzZGV2LT5zdGF0ZV9tdXRleCk7DQo+IA0KPiAgICAg
ICAgIGlmIChlcnIpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiANCj4gICAgICAg
ICBibGtfbXFfZnJlZXplX3F1ZXVlKHEpOw0KPiAgICAgICAgIGJsa19tcV91bmZyZWV6ZV9xdWV1
ZShxKTsNCj4gDQo+IEFueSByZXF1ZXN0cyBhbGxvY2F0ZWQgYmVmb3JlIHNjc2lfZGV2aWNlX3Nl
dF9zdGF0ZSgpIGFuZA0KPiBkaXNwYXRjaGVkIGFmdGVyIHNjc2lfZGV2aWNlX3NldF9zdGF0ZSgp
IGNhbid0IGJlIGRyYWluZWQgdXANCj4gYW55IG1vcmUsIHRoZW4gYmxrX21xX2ZyZWV6ZV9xdWV1
ZSgpIHdpbGwgd2FpdCBmb3JldmVyIGZvciB0aGUNCj4gZHJhaW4gdXAsIHNvIG5vdCBvbmx5IHRo
aXMgcGF0Y2hzZXQgY2FuJ3QgZml4IHRoZSBjdXJyZW50IHF1aWVzY2UNCj4gaXNzdWUsIGJ1dCBh
bHNvIGludHJvZHVjZXMgbmV3IEkvTyBoYW5nIGluIHNjc2lfZGV2aWNlX3F1aWVzY2UoKS4NCg0K
VGhhdCdzIGEgZ29vZCBjYXRjaCwgYnV0IGZvcnR1bmF0ZWx5IHRoaXMgaXMgdmVyeSBlYXN5IHRv
IGZpeDogbW92ZSB0aGUNCmJsa19tcV9mcmVlemVfcXVldWUoKSBjYWxsIGJlZm9yZSB0aGUgbXV0
ZXhfbG9jaygpIGFuZCBzY3NpX2RldmljZV9zZXRfc3RhdGUoKQ0KY2FsbHMuIFRoZSBlcnJvciBw
YXRoIHdpbGwgYWxzbyBuZWVkIHNvbWUgYWRqdXN0bWVudC4NCg0KQmFydC4=
