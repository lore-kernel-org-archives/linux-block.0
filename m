Return-Path: <prvs=541b0d852=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "jgg@mellanox.com" <jgg@mellanox.com>,
	"hch@lst.de" <hch@lst.de>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH 2/4] block: Introduce blk_wait_if_quiesced() and
 blk_finish_wait_if_quiesced()
Date: Wed, 10 Jan 2018 00:23:33 +0000
Message-ID: <1515543812.2721.35.camel@wdc.com>
References: <20180108185011.30018-1-bart.vanassche@wdc.com>
	 <20180108185011.30018-3-bart.vanassche@wdc.com>
	 <8dbe62ad-be38-a35d-df3e-b6f5486292ab@suse.de>
In-Reply-To: <8dbe62ad-be38-a35d-df3e-b6f5486292ab@suse.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTAxLTA5IGF0IDA3OjQxICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6
DQo+IEknbSBhbHdheXMgYSBiaXQgY2F1dGlvdXMgd2hlbiBoYXZpbmcgcmN1X3JlYWRfbG9jaygp
IGFuZA0KPiByY3VfcmVhZF91bmxvY2soKSBpbiB0d28gc2VwYXJhdGUgZnVuY3Rpb25zLg0KPiBD
YW4gd2UgbWFrZSB0aGlzIGRlcGVuZGVuY3kgbW9yZSBleHBsaWNpdCBieSByZW5hbWluZyB0aGUg
Zmlyc3QgZnVuY3Rpb24NCj4gdG8gYmxrX3N0YXJ0X3dhaXRfaWZfcXVpZXNjZWQoKSBhbmQgdXBk
YXRpbmcgdGhlIGNvbW1lbnQgdG8gdGhlIGVmZmVjdA0KPiB0aGF0IGJvdGggZnVuY3Rpb25zIG11
c3QgYmUgdXNlZCBpbiB0YW5kZW0/DQoNCkhlbGxvIEhhbm5lcywNCg0KVGhhdCBzb3VuZHMgbGlr
ZSBhIGdvb2QgaWRlYSB0byBtZS4gSSB3aWxsIG1ha2UgdGhlc2UgY2hhbmdlcyBhbmQgcmVwb3N0
IHRoaXMNCnBhdGNoIHNlcmllcy4NCg0KQmFydC4=
