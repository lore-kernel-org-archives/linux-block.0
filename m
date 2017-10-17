Return-Path: <prvs=456029237=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>, "hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>, "hare@suse.com"
	<hare@suse.com>
Subject: Re: [PATCH v9 09/10] block, scsi: Make SCSI quiesce and resume work
 reliably
Date: Tue, 17 Oct 2017 20:08:18 +0000
Message-ID: <1508270897.3457.7.camel@wdc.com>
References: <20171016232905.5047-1-bart.vanassche@wdc.com>
	 <20171016232905.5047-10-bart.vanassche@wdc.com>
	 <20171017004319.GB15996@ming.t460p>
In-Reply-To: <20171017004319.GB15996@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE3LTEwLTE3IGF0IDA4OjQzICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
TW9uLCBPY3QgMTYsIDIwMTcgYXQgMDQ6Mjk6MDRQTSAtMDcwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IFsgLi4uIF0NCj4gPiAgaW50DQo+ID4gIHNjc2lfZGV2aWNlX3F1aWVzY2Uoc3Ry
dWN0IHNjc2lfZGV2aWNlICpzZGV2KQ0KPiA+ICB7DQo+ID4gKwlzdHJ1Y3QgcmVxdWVzdF9xdWV1
ZSAqcSA9IHNkZXYtPnJlcXVlc3RfcXVldWU7DQo+ID4gIAlpbnQgZXJyOw0KPiA+ICANCj4gPiAr
CS8qDQo+ID4gKwkgKiBJdCBpcyBhbGxvd2VkIHRvIGNhbGwgc2NzaV9kZXZpY2VfcXVpZXNjZSgp
IG11bHRpcGxlIHRpbWVzIGZyb20NCj4gPiArCSAqIHRoZSBzYW1lIGNvbnRleHQgYnV0IGNvbmN1
cnJlbnQgc2NzaV9kZXZpY2VfcXVpZXNjZSgpIGNhbGxzIGFyZQ0KPiA+ICsJICogbm90IGFsbG93
ZWQuDQo+ID4gKwkgKi8NCj4gPiArCVdBUk5fT05fT05DRShzZGV2LT5xdWllc2NlZF9ieSAmJiBz
ZGV2LT5xdWllc2NlZF9ieSAhPSBjdXJyZW50KTsNCj4gDQo+IElmIHRoZSBhYm92ZSBsaW5lIGFu
ZCBjb21tZW50IGlzIHJlbW92ZWQsIGV2ZXJ5dGhpbmcgaXMgc3RpbGwgZmluZSwNCj4gZWl0aGVy
IG5lc3RlZCBjYWxsaW5nIG9yIGNvbmN1cnJlbnQgY2FsbGluZywgaXNuJ3QgaXQ/DQoNCklmIHNj
c2lfZGV2aWNlX3F1aWVzY2UoKSBpcyBjYWxsZWQgY29uY3VycmVudGx5IGZyb20gdHdvIGRpZmZl
cmVudCB0aHJlYWRzDQp0aGVuIHRoZSBmaXJzdCBzY3NpX2RldmljZV9yZXN1bWUoKSBjYWxsIHdp
bGwgcmVzdW1lIEkvTyBmb3IgKmJvdGgqIGNvbnRleHRzLg0KVGhhdCdzIG5vdCB3aGF0IHRoZSBj
YWxsZXJzIGV4cGVjdC4gSWYgc2NzaV9kZXZpY2VfcXVpZXNjZSgpIGFuZA0Kc2NzaV9kZXZpY2Vf
cmVzdW1lKCkgYXJlIGNhbGxlZCBjb25jdXJyZW50bHkgdGhhdCB3b3VsZCBiZSBldmVuIHdvcnNl
LiBJIHRoaW5rDQp3ZSAqcmVhbGx5KiBzaG91bGQga25vdyB3aGV0aGVyIGNhbGxlcnMgc2VyaWFs
aXplIHNjc2lfZGV2aWNlX3F1aWVzY2UoKSBhbmQNCnNjc2lfZGV2aWNlX3Jlc3VtZSgpIGNhbGxz
IHByb3Blcmx5LiBIZW5jZSB0aGUgV0FSTl9PTl9PTkNFKCkgc3RhdGVtZW50Lg0KDQpCYXJ0Lg==
