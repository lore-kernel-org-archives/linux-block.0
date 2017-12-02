Return-Path: <prvs=5028ec12e=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"hare@suse.de" <hare@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "osandov@fb.com" <osandov@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 4/7] blk-mq: Avoid that request processing stalls when
 sharing tags
Date: Sat, 2 Dec 2017 00:48:51 +0000
Message-ID: <1512175730.2520.29.camel@wdc.com>
References: <20171201000848.2656-1-bart.vanassche@wdc.com>
	 <20171201000848.2656-5-bart.vanassche@wdc.com>
	 <20171201025803.GA29741@ming.t460p> <1512157932.2520.27.camel@wdc.com>
	 <20171202003625.GA24521@ming.t460p>
In-Reply-To: <20171202003625.GA24521@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gU2F0LCAyMDE3LTEyLTAyIGF0IDA4OjM2ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
RnJpLCBEZWMgMDEsIDIwMTcgYXQgMDc6NTI6MTRQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IE9uIEZyaSwgMjAxNy0xMi0wMSBhdCAxMDo1OCArMDgwMCwgTWluZyBMZWkgd3Jv
dGU6DQo+ID4gPiBPbiBUaHUsIE5vdiAzMCwgMjAxNyBhdCAwNDowODo0NVBNIC0wODAwLCBCYXJ0
IFZhbiBBc3NjaGUgd3JvdGU6DQo+ID4gPiA+IGJsa19tcV9kaXNwYXRjaF9ycV9saXN0KCkgaXMg
Y2FsbGVkLiBNYWtlIHN1cmUgdGhhdA0KPiA+ID4gPiBCTEtfTVFfU19TQ0hFRF9SRVNUQVJUIGlz
IHNldCBiZWZvcmUgYW55IGJsa19tcV9kaXNwYXRjaF9ycV9saXN0KCkNCj4gPiA+ID4gY2FsbCBv
Y2N1cnMuDQo+ID4gPiA+IA0KPiA+ID4gPiBGaXhlczogY29tbWl0IGIzNDc2ODlmZmJjYSAoImJs
ay1tcS1zY2hlZDogaW1wcm92ZSBkaXNwYXRjaGluZyBmcm9tIHN3IHF1ZXVlIikNCj4gPiA+IA0K
PiA+ID4gV2UgYWx3YXlzIG1hcmsgUkVTVEFSVCBzdGF0ZSBiaXQganVzdCBiZWZvcmUgZGlzcGF0
Y2hpbmcgZnJvbSAtPmRpc3BhdGNoX2xpc3QsDQo+ID4gPiB0aGlzIHdheSBoYXMgYmVlbiB0aGVy
ZSBiZWZvcmUgYjM0NzY4OWZmYmNhLCB3aGljaCBkb2Vzbid0IGNoYW5nZSB0aGlzDQo+ID4gPiBS
RVNUQVJUIG1lY2hhbmlzbSwgc28gcGxlYXNlIGV4cGxhaW4gYSBiaXQgd2h5IGl0IGlzIGEgZml4
IG9uIGNvbW1pdA0KPiA+ID4gYjM0NzY4OWZmYmNhLg0KPiA+IA0KPiA+IEknbSBub3QgY29tcGxl
dGVseSBzdXJlIHdoaWNoIHBhdGNoIGludHJvZHVjZWQgdGhlIGxvY2t1cCBmaXhlZCBieSB0aGlz
IHBhdGNoDQo+ID4gYnV0IEkgd2lsbCBoYXZlIGFub3RoZXIgbG9vayB3aGV0aGVyIHRoaXMgd2Fz
IHJlYWxseSBpbnRyb2R1Y2VkIGJ5IGNvbW1pdA0KPiA+IGIzNDc2ODlmZmJjYS4NCj4gDQo+IFBs
ZWFzZSBtYWtlIHN1cmUgJ0ZpeGVzJyB0YWcgY29ycmVjdC4NCg0KRnVydGhlciB0ZXN0cyBoYXZl
IHNob3duIHRoYXQgdGhlIGxvY2t1cCBJIHJlZmVycmVkIHRvIGRvZXMgbm90IG9jY3VyIGJlZm9y
ZSBjb21taXQNCmIzNDc2ODlmZmJjYSBidXQgdGhhdCBpdCBvY2N1cnMgd2l0aCBiMzQ3Njg5ZmZi
Y2EuIEkgdGhpbmsgdGhhdCBzaG93cyBjbGVhcmx5IHRoYXQNCmNvbW1pdCBiMzQ3Njg5ZmZiY2Eg
aW50cm9kdWNlZCB0aGlzIGxvY2t1cC4NCg0KQmFydC4=
