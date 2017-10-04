Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>
CC: "jthumshirn@suse.de" <jthumshirn@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "oleksandr@natalenko.name"
	<oleksandr@natalenko.name>, "hare@suse.com" <hare@suse.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 6/8] scsi: Reduce suspend latency
Date: Wed, 4 Oct 2017 15:41:30 +0000
Message-ID: <1507131688.3583.26.camel@wdc.com>
References: <20171002225218.18548-1-bart.vanassche@wdc.com>
	 <20171002225218.18548-7-bart.vanassche@wdc.com>
	 <20171004070444.GD20879@lst.de>
In-Reply-To: <20171004070444.GD20879@lst.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE3LTEwLTA0IGF0IDA5OjA0ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gPiArCS8qDQo+ID4gKwkgKiBEbyBub3QgYXR0ZW1wdCB0byBmcmVlemUgdGhlIHF1ZXVl
IG9mIGFuIGFscmVhZHkgcXVpZXNjZWQgZGV2aWNlDQo+ID4gKwkgKiBiZWNhdXNlIHRoYXQgY291
bGQgcmVzdWx0IGluIGEgZGVhZGxvY2suDQo+ID4gKwkgKi8NCj4gPiArCWZyZWV6ZSA9IHNkZXYt
PnNkZXZfc3RhdGUgPT0gU0RFVl9SVU5OSU5HOw0KPiA+ICsJaWYgKGZyZWV6ZSkNCj4gPiArCQli
bGtfbXFfZnJlZXplX3F1ZXVlKHEpOw0KPiA+ICAJZXJyID0gc2NzaV9kZXZpY2Vfc2V0X3N0YXRl
KHNkZXYsIFNERVZfUVVJRVNDRSk7DQo+IA0KPiBJIGRvbid0IHJlYWxseSBsaWtlIHRoaXMgbWFn
aWMgd2l0aCBhIGZyZWV6ZSBpbnNpZGUgdGhlIGxvY2sNCj4gYW5kIHRoZSBtYWdpYyBkZXBlbmRl
bmN5IG9uIHRoZSBwcmV2aW91cy4gIEJ1dCBJIGNhbid0IHJlYWxseSBjb21lIHVwDQo+IHdpdGgg
YSBiZXR0ZXIgaWRlYSBlaXRoZXIuDQoNClRoZSBkZWFkbG9jayBJIHJlZmVycmVkIHRvIGluIG15
IGNvbW1lbnQgY2FuIG9ubHkgb2NjdXIgaWYgYW55IGNvZGUgd291bGQgY2hhbmdlDQp0aGUgU0NT
SSBkZXZpY2Ugc3RhdGUgaW50byBTREVWX1FVSUVTQ0Ugd2l0aG91dCBmcmVlemluZyB0aGUgcmVx
dWVzdCBxdWV1ZSBmaXJzdC4NCkkgd2lsbCBsb29rIGludG8gZnJlZXppbmcgdGhlIHF1ZXVlIHdp
dGhvdXQgaG9sZGluZyB0aGUgc2RldiBzdGF0ZSBtdXRleC4NCg0KQmFydC4=
