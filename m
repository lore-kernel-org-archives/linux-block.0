Return-Path: <prvs=5056bd117=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "jthumshirn@suse.de" <jthumshirn@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"hare@suse.com" <hare@suse.com>, "jejb@linux.vnet.ibm.com"
	<jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH] blk-mq: Fix several SCSI request queue lockups
Date: Tue, 5 Dec 2017 01:13:43 +0000
Message-ID: <1512436422.2795.47.camel@wdc.com>
References: <20171204173032.16330-1-bart.vanassche@wdc.com>
	 <20171204224200.GA6888@ming.t460p> <1512427697.2795.14.camel@wdc.com>
	 <20171204230151.GD6888@ming.t460p> <1512430346.2795.34.camel@wdc.com>
	 <20171205002040.GA8365@ming.t460p> <1512433798.2795.45.camel@wdc.com>
	 <20171205010428.GB8365@ming.t460p>
In-Reply-To: <20171205010428.GB8365@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE3LTEyLTA1IGF0IDA5OjA0ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gVGhl
biBubyByZWFzb24gdG8gcmV2ZXJ0IGNvbW1pdCgwZGYyMWM4NmJkYmYgc2NzaTogaW1wbGVtZW50
IC5nZXRfYnVkZ2V0IGFuDQo+IC5wdXRfYnVkZ2V0IGZvciBibGstbXEpIGZvciBvbmUgaXNzdWUg
d2hpY2ggbWF5IG5ldmVyIGhhcHBlbiBpbiByZWFsaXR5IHNpbmNlDQo+IHRoaXMgcmVwcm9kdWNl
ciBuZWVkIG91dC1vZi10cmVlIHBhdGNoLg0KDQpTb3JyeSBidXQgSSBkaXNhZ3JlZSBjb21wbGV0
ZWx5LiBZb3Ugc2VlbSB0byBvdmVybG9vayB0aGF0IHRoZXJlIG1heSBiZSBvdGhlcg0KY2lyY3Vt
c3RhbmNlcyB0aGF0IHRyaWdnZXIgdGhlIHNhbWUgbG9ja3VwLCBlLmcuIGEgU0NTSSBxdWV1ZSBm
dWxsIGNvbmRpdGlvbi4NCg0KQmFydC4=
