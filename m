Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>
CC: "hare@suse.com" <hare@suse.com>, "jthumshirn@suse.de"
	<jthumshirn@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "oleksandr@natalenko.name"
	<oleksandr@natalenko.name>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v4 4/7] block: Add the QUEUE_FLAG_PREEMPT_ONLY request
 queue flag
Date: Mon, 2 Oct 2017 15:56:08 +0000
Message-ID: <1506959767.3368.18.camel@wdc.com>
References: <20170925202924.16603-1-bart.vanassche@wdc.com>
	 <20170925202924.16603-5-bart.vanassche@wdc.com>
	 <20171002134755.GA7571@lst.de>
In-Reply-To: <20171002134755.GA7571@lst.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE3LTEwLTAyIGF0IDE1OjQ3ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gPiArdm9pZCBibGtfc2V0X3ByZWVtcHRfb25seShzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAq
cSwgYm9vbCBwcmVlbXB0X29ubHkpDQo+ID4gK3sNCj4gPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7
DQo+ID4gKw0KPiA+ICsJc3Bpbl9sb2NrX2lycXNhdmUocS0+cXVldWVfbG9jaywgZmxhZ3MpOw0K
PiA+ICsJaWYgKHByZWVtcHRfb25seSkNCj4gPiArCQlxdWV1ZV9mbGFnX3NldChRVUVVRV9GTEFH
X1BSRUVNUFRfT05MWSwgcSk7DQo+ID4gKwllbHNlDQo+ID4gKwkJcXVldWVfZmxhZ19jbGVhcihR
VUVVRV9GTEFHX1BSRUVNUFRfT05MWSwgcSk7DQo+ID4gKwlzcGluX3VubG9ja19pcnFyZXN0b3Jl
KHEtPnF1ZXVlX2xvY2ssIGZsYWdzKTsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MKGJsa19z
ZXRfcHJlZW1wdF9vbmx5KTsNCj4gDQo+IFdoeSBkbyB3ZSBldmVuIG5lZWQgdGhpcyBoZWxwZXI/
ICBUaGUgbG9jayBkb2Vzbid0IG1ha2Ugc2Vuc2UgdG8gbWUsDQo+IGFuZCBpdCB3b3VsZCBqdXN0
IG11Y2ggZWFzaWVyIHRvIHNldC9jbGVhciB0aGUgZmxhZyBmcm9tIHRoZSBkcml2ZXIuDQoNCkhl
bGxvIENocmlzdG9waCwNCg0KU2luY2UgcXVldWVfZmxhZ19zZXQoKSBhbmQgcXVldWVfZmxhZ19j
bGVhcigpIHVzZSBub24tYXRvbWljIHByaW1pdGl2ZXMgdG8NCnNldCBhbmQgY2xlYXIgZmxhZ3Mg
aXQgaXMgZXNzZW50aWFsIHRvIHByb3RlY3QgY2FsbHMgb2YgdGhlc2UgZnVuY3Rpb25zIHdpdGgN
CnRoZSBxdWV1ZSBsb2NrLiBPdGhlcndpc2UgZmxhZyB1cGRhdGVzIGNvdWxkIGdldCBsb3N0IGR1
ZSB0byBjb25jdXJyZW50DQpxdWV1ZV9mbGFnX3NldCgpIG9yIHF1ZXVlX2ZsYWdfY2xlYXIoKSBj
YWxscy4NCg0KT25lIG9mIHRoZSByZWFzb25zIHdoeSBJIGludHJvZHVjZWQgdGhpcyBoZWxwZXIg
ZnVuY3Rpb24gaXMgdG8ga2VlcCB0aGUNCndha2VfdXBfYWxsKCZxLT5tcV9mcmVlemVfd3EpIGNh
bGwgdGhhdCBpcyBhZGRlZCB0byB0aGlzIGZ1bmN0aW9uIGJ5IGEgbGF0ZXINCnBhdGNoIGluIHRo
ZSBibG9jayBsYXllci4NCg0KQmFydC4=
