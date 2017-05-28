Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>
CC: "osandov@fb.com" <osandov@fb.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hare@suse.com" <hare@suse.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
Subject: Re: [PATCH 12/19] blk-mq: Initialize a request before assigning a tag
Date: Sun, 28 May 2017 16:17:33 +0000
Message-ID: <1495988252.2849.9.camel@sandisk.com>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com>
	 <20170525184327.23570-13-bart.vanassche@sandisk.com>
	 <20170528084208.GG13083@lst.de>
In-Reply-To: <20170528084208.GG13083@lst.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gU3VuLCAyMDE3LTA1LTI4IGF0IDEwOjQyICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gVGh1LCBNYXkgMjUsIDIwMTcgYXQgMTE6NDM6MjBBTSAtMDcwMCwgQmFydCBWYW4g
QXNzY2hlIHdyb3RlOg0KPiA+IEluaXRpYWxpemF0aW9uIG9mIGJsay1tcSByZXF1ZXN0cyBpcyBh
IGJpdCB3ZWlyZDogYmxrX21xX3JxX2N0eF9pbml0KCkNCj4gPiBpcyBjYWxsZWQgYWZ0ZXIgYSB0
YWcgaGFzIGJlZW4gYXNzaWduZWQgYW5kIC5ycV9mbGFncyBpcyBpbml0aWFsaXplZA0KPiA+IGlu
IF9fYmxrX21xX2ZpbmlzaF9yZXF1ZXN0KCkuDQo+ID4gDQo+ID4gQ2FsbCBibGtfbXFfcnFfY3R4
X2luaXQoKSBiZWZvcmUNCj4gPiBtb2RpZnlpbmcgYW55IHN0cnVjdCByZXF1ZXN0IG1lbWJlcnMu
IEluaXRpYWxpemUgLnJxX2ZsYWdzIGluDQo+ID4gYmxrX21xX3JxX2N0eF9pbml0KCkgaW5zdGVh
ZCBvZiBpbiBfX2Jsa19tcV9maW5pc2hfcmVxdWVzdCgpLiBUaGlzDQo+ID4gcGF0Y2ggZG9lcyBu
b3QgY2hhbmdlIHRoZSBiZWhhdmlvciBvZiB0aGUgYmxvY2sgbGF5ZXIuDQo+IA0KPiBPbmUgdGhp
bmdzIHRoaXMgcGF0Y2ggZG9lcyBpcyB0byBpbml0aWFsaXplIHRoZSB0YWcgdmFsdWUgYWN0dWFs
bHkNCj4gc2V0IHR3aWNlLiAgSW4gZ2VuZXJhbCB0aGlzIGxvb2tzIG9rLCBidXQgSSBjYW4ndCBy
ZWFsbHkgc2VlIHRoZSByZWFsDQo+IHZhbHVlLg0KDQpIZWxsbyBDaHJpc3RvcGgsDQoNCklmIHlv
dSB3YW50IEkgY2FuIGxlYXZlIG91dCB0aGUgY2hhbmdlcyB0byB0aGUgLnRhZyAvIC5pbnRlcm5h
bF90YWcNCmFzc2lnbm1lbnRzIGZyb20gdGhpcyBwYXRjaC4NCg0KQmFydC4=
