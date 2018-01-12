Return-Path: <prvs=54311c032=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hare@suse.com"
	<hare@suse.com>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq-debugfs: Also show requests that have not yet been
 started
Date: Fri, 12 Jan 2018 22:00:19 +0000
Message-ID: <1515794417.2396.72.camel@wdc.com>
References: <20180112215207.17852-1-bart.vanassche@wdc.com>
	 <78a60ddb-7e5f-3dac-2024-390e17da02f8@kernel.dk>
In-Reply-To: <78a60ddb-7e5f-3dac-2024-390e17da02f8@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE4LTAxLTEyIGF0IDE0OjU1IC0wNzAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBP
biAxLzEyLzE4IDI6NTIgUE0sIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gPiBXaGVuIGRlYnVn
Z2luZyBlLmcuIHRoZSBTQ1NJIHRpbWVvdXQgaGFuZGxlciBpdCBpcyBpbXBvcnRhbnQgdGhhdA0K
PiA+IHJlcXVlc3RzIHRoYXQgaGF2ZSBub3QgeWV0IGJlZW4gc3RhcnRlZCBvciB0aGF0IGFscmVh
ZHkgaGF2ZQ0KPiA+IGNvbXBsZXRlZCBhcmUgYWxzbyByZXBvcnRlZCB0aHJvdWdoIGRlYnVnZnMu
DQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBkZXBlbmRzIG9uIGEgcGF0Y2ggdGhhdCB3ZW50IHVwc3Ry
ZWFtIHJlY2VudGx5LCBuYW1lbHkNCj4gPiBjb21taXQgMTRlMzA2MmZiMTg1ICgic2NzaTogY29y
ZTogRml4IGEgc2NzaV9zaG93X3JxKCkgTlVMTCBwb2ludGVyDQo+ID4gZGVyZWZlcmVuY2UiKS4N
Cj4gDQo+IFdoeSBkb24ndCB3ZSBqdXN0IGtpbGwgdGhlIGNoZWNrLCBhbmQgZHVtcCBhbnkgcmVx
dWVzdCB0aGF0IGhhcyBhDQo+IG1hdGNoaW5nIGhjdHg/IFdlIGFscmVhZHkga25vdyB0aGUgYml0
IHdhcyBzZXQsIHNvIGp1c3QgcHJpbnQNCj4gYWxsIG9mIHRoZW0uDQoNCkl0IGlzIHZlcnkgaGVs
cGZ1bCBkdXJpbmcgZGVidWdnaW5nIHRoYXQgcmVxdWVzdHMgb3duZWQgYnkgYSBibG9jayBkcml2
ZXIgYW5kDQpyZXF1ZXN0cyBvd25lZCBieSB0aGUgYmxvY2sgbGF5ZXIgY29yZSBzaG93IHVwIGlu
IGRpZmZlcmVudCBkZWJ1Z2ZzIGZpbGVzLg0KUmVtb3ZpbmcgdGhlIGNoZWNrIGNvbXBsZXRlbHkg
d291bGQgY2F1c2UgYWxsIHJlcXVlc3RzIHRvIHNob3cgdXAgaW4gdGhlIHNhbWUNCmRlYnVnZnMg
ZmlsZSBhbmQgd291bGQgbWFrZSBpbnRlcnByZXRpbmcgdGhlIGNvbnRlbnRzIG9mIHRoZXNlIGRl
YnVnZnMgZmlsZXMNCm11Y2ggaGFyZGVyLg0KDQpUaGFua3MsDQoNCkJhcnQu
