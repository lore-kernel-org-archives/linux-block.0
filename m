Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hare@suse.com" <hare@suse.com>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>, "oleksandr@natalenko.name"
	<oleksandr@natalenko.name>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 4/4] scsi-mq: Reduce suspend latency
Date: Thu, 21 Sep 2017 23:56:33 +0000
Message-ID: <1506038192.2521.33.camel@wdc.com>
References: <20170921212255.12788-1-bart.vanassche@wdc.com>
	 <20170921212255.12788-5-bart.vanassche@wdc.com>
	 <20170921220652.GD6854@ming.t460p> <1506033805.2521.27.camel@wdc.com>
	 <20170921232543.GG6854@ming.t460p> <1506036752.2521.32.camel@wdc.com>
	 <20170921235327.GH6854@ming.t460p>
In-Reply-To: <20170921235327.GH6854@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE3LTA5LTIyIGF0IDA3OjUzICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gVGhl
biB0aGF0IGlzIHNpbXBseSBub3QgZW5vdWdoIHNpbmNlIHRoZSBpc3N1ZSBpcyB0aGF0IHJlcXVl
c3QgcG9vbCBjYW4NCj4gYmUgdXNlZCB1cCBlYXNpbHkgd2hlbiBTQ1NJIGRldmljZSBpcyBxdWll
c2NlZCwgdGhlbiBubyByZXF1ZXN0IGlzIGxlZnQNCj4gZm9yIFJRRl9QUkVFTVBUKFBNKSwgYW5k
IEkvTyBoYW5nIGlzIHRyaWdnZXJlZC4NCj4gDQo+IEl0IGhhcyBiZWVuIGRpc2N1c3NlZCBmb3Ig
bG9uZyB0aW1lLCBJIGFtIHNvcnJ5IHlvdSBzdGlsbCBkb24ndA0KPiB1bmRlcnN0YW5kIGl0Lg0K
DQpJJ20gcmVhbGx5IHNvcnJ5IHRoYXQgeW91IGRvbid0IHVuZGVyc3RhbmQgdGhlIGludGVudGlv
biBvZiB0aGlzIHBhdGNoIHNlcmllcy4NCkFueXdheSwgbGV0J3MgY2xvc2UgdGhlIGRpc2N1c3Np
b24gaGVyZSBhbmQgY29udGludWUgb25jZSB0aGUgbmV4dCB2ZXJzaW9uIG9mDQp0aGlzIHBhdGNo
IHNlcmllcyBoYXMgYmVlbiBwb3N0ZWQuDQoNCkJhcnQu
