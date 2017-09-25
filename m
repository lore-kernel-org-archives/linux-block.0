Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "hare@suse.com" <hare@suse.com>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "oleksandr@natalenko.name"
	<oleksandr@natalenko.name>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v3 5/6] block: Make SCSI device suspend and resume work
 reliably
Date: Mon, 25 Sep 2017 16:20:20 +0000
Message-ID: <1506356419.2641.11.camel@wdc.com>
References: <20170922221405.22091-1-bart.vanassche@wdc.com>
	 <20170922221405.22091-6-bart.vanassche@wdc.com>
	 <20170925022621.GB6434@ming.t460p>
In-Reply-To: <20170925022621.GB6434@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE3LTA5LTI1IGF0IDEwOjI2ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
RnJpLCBTZXAgMjIsIDIwMTcgYXQgMDM6MTQ6MDRQTSAtMDcwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+ICtpbnQgYmxrX3F1ZXVlX2VudGVyKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLCBi
b29sIG5vd2FpdCwgYm9vbCBwcmVlbXB0KQ0KPiA+ICB7DQo+ID4gIAl3aGlsZSAodHJ1ZSkgew0K
PiA+ICAJCWludCByZXQ7DQo+ID4gIA0KPiA+IC0JCWlmIChwZXJjcHVfcmVmX3RyeWdldF9saXZl
KCZxLT5xX3VzYWdlX2NvdW50ZXIpKQ0KPiA+IC0JCQlyZXR1cm4gMDsNCj4gPiArCQlpZiAocGVy
Y3B1X3JlZl90cnlnZXRfbGl2ZSgmcS0+cV91c2FnZV9jb3VudGVyKSkgew0KPiA+ICsJCQkvKg0K
PiA+ICsJCQkgKiBFbnN1cmUgcmVhZCBvcmRlciBvZiBxX3VzYWdlX2NvdW50ZXIgYW5kIHRoZQ0K
PiA+ICsJCQkgKiBQUkVFTVBUX09OTFkgcXVldWUgZmxhZy4NCj4gPiArCQkJICovDQo+ID4gKwkJ
CXNtcF9ybWIoKTsNCj4gPiArCQkJaWYgKHByZWVtcHQgfHwgIWJsa19xdWV1ZV9wcmVlbXB0X29u
bHkocSkpDQo+ID4gKwkJCQlyZXR1cm4gMDsNCj4gPiArCQkJZWxzZQ0KPiA+ICsJCQkJcGVyY3B1
X3JlZl9wdXQoJnEtPnFfdXNhZ2VfY291bnRlcik7DQo+ID4gKwkJfQ0KPiANCj4gTm93IHlvdSBp
bnRyb2R1Y2Ugb25lIHNtcF9ybWIoKSBhbmQgdGVzdCBvbiBwcmVlbXB0IGZsYWcgb24NCj4gYmxr
LW1xJ3MgZmFzdCBwYXRoLCB3aGljaCBzaG91bGQgaGF2ZSBiZWVuIGF2b2lkZWQsIHNvIEkNCj4g
dGhpbmsgdGhpcyB3YXkgaXMgd29yc2UgdGhhbiBteSBwYXRjaHNldC4NCg0KU28gdGhhdCBtZWFu
cyB0aGF0IHlvdSBoYXZlIG5vdCBub3RpY2VkIHRoYXQgaXQgaXMgc2FmZSB0byBsZWF2ZSBvdXQg
dGhhdA0Kc21wX3JtcCgpIGNhbGwgYmVjYXVzZSBibGstbXEgcXVldWUgZnJlZXppbmcgYW5kIHVu
ZnJlZXppbmcgd2FpdHMgZm9yIGEgZ3JhY2UNCnBlcmlvZCBhbmQgaGVuY2Ugd2FpdHMgdW50aWwg
YWxsIENQVXMgaGF2ZSBleGVjdXRlZCBhIGZ1bGwgbWVtb3J5IGJhcnJpZXI/DQoNCkJhcnQu
