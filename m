Return-Path: <prvs=673874c89=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>, "sebott@linux.ibm.com"
	<sebott@linux.ibm.com>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"maxg@mellanox.com" <maxg@mellanox.com>, "tj@kernel.org" <tj@kernel.org>,
	"keith.busch@intel.com" <keith.busch@intel.com>
Subject: Re: [PATCH v13] blk-mq: Rework blk-mq timeout handling again
Date: Tue, 22 May 2018 20:44:36 +0000
Message-ID: <2c0c013717470bb9d5f97ec0559e7081c1e152de.camel@wdc.com>
References: <20180522162515.20650-1-bart.vanassche@wdc.com>
	 <bc1946d4-7627-3885-68c9-5db6c13b585c@kernel.dk>
	 <fee466b8-8e39-adc6-efa4-e50ffa60a663@kernel.dk>
	 <448d63e9-cfcd-0bc8-abf3-30296590f1d6@kernel.dk>
	 <cd0693cc-a56d-665c-bc14-7e2653b91cb0@kernel.dk>
	 <e414a6f8-79a9-0faa-e186-beb3b528acd5@kernel.dk>
	 <256db3889953289d75b989dd589802ce8a756553.camel@wdc.com>
	 <460909df-cff0-f56b-882e-eb1a96f7510a@kernel.dk>
In-Reply-To: <460909df-cff0-f56b-882e-eb1a96f7510a@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTA1LTIyIGF0IDE0OjM4IC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBP
biA1LzIyLzE4IDI6MzMgUE0sIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gPiBUaGFua3MgZm9y
IGhhdmluZyByZXBvcnRlZCB0aGlzLiBIb3cgYWJvdXQgdXNpbmcgdGhlIGZvbGxvd2luZyBjaGFu
Z2UgdG8gc3VwcHJlc3MNCj4gPiB0aGF0IHdhcm5pbmc6DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBh
L2Jsb2NrL2Jsay1tcS5jIGIvYmxvY2svYmxrLW1xLmMNCj4gPiBpbmRleCBiYjk5YzAzZTdhMzQu
Ljg0ZTU1ZWE1NWJhZiAxMDA2NDQNCj4gPiAtLS0gYS9ibG9jay9ibGstbXEuYw0KPiA+ICsrKyBi
L2Jsb2NrL2Jsay1tcS5jDQo+ID4gQEAgLTg0NCw2ICs4NDQsNyBAQCBzdGF0aWMgdm9pZCBibGtf
bXFfcnFfdGltZWRfb3V0KHN0cnVjdCByZXF1ZXN0ICpyZXEsIGJvb2wgcmVzZXJ2ZWQpDQo+ID4g
IA0KPiA+ICAJc3dpdGNoIChyZXQpIHsNCj4gPiAgCWNhc2UgQkxLX0VIX0hBTkRMRUQ6DQo+ID4g
KwkJYmxrX21xX2NoYW5nZV9ycV9zdGF0ZShyZXEsIE1RX1JRX1RJTUVEX09VVCwgTVFfUlFfQ09N
UExFVEUpOw0KPiA+ICAJCV9fYmxrX21xX2NvbXBsZXRlX3JlcXVlc3QocmVxKTsNCj4gPiAgCQli
cmVhazsNCj4gPiAgCWNhc2UgQkxLX0VIX1JFU0VUX1RJTUVSOg0KPiA+IA0KPiA+IEkgdGhpbmsg
dGhpcyB3aWxsIHdvcmsgYmV0dGVyIHRoYW4gd2hhdCB3YXMgcHJvcG9zZWQgaW4geW91ciBsYXN0
IGUtbWFpbC4gSSdtIGFmcmFpZA0KPiA+IHRoYXQgd2l0aCB0aGF0IGNoYW5nZSB0aGF0IGEgY29t
cGxldGlvbiB0aGF0IG9jY3VycyB3aGlsZSB0aGUgdGltZW91dCBoYW5kbGVyIGlzDQo+ID4gcnVu
bmluZyBjYW4gYmUgaWdub3JlZC4NCj4gDQo+IFdoYXQgaWYgdGhhdCByYWNlcyB3aXRoIGVnIHJl
cXVldWU/IFdlIGdldCB0aGUgY29tcGxldGlvbiBmcm9tIElSUSwgZGVjaWRlIHdlDQo+IG5lZWQg
dG8gcmVxdWV1ZS9yZXN0YXJ0IHRoZSByZXF1ZXN0IHJhdGhlciB0aGFuIGNvbXBsZXRlIGl0Lg0K
DQpTaG91bGRuJ3QgYmxvY2sgZHJpdmVycyB0aGF0IHJlcXVldWUgYSByZXF1ZXN0IGZyb20gaW5z
aWRlIHRoZWlyIHRpbWVvdXQgaGFuZGxlcg0KcmV0dXJuIEJMS19FSF9OT1RfSEFORExFRCBpbnN0
ZWFkIG9mIEJMS19FSF9IQU5ETEVEPw0KDQpUaGFua3MsDQoNCkJhcnQuDQoNCg0K
