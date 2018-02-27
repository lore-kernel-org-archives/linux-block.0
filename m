Return-Path: <prvs=58911c18c=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 0/6] Fix races between blkcg code and request queue
 initialization and cleanup
Date: Tue, 27 Feb 2018 23:37:20 +0000
Message-ID: <1519774640.23791.22.camel@wdc.com>
References: <20180223010808.25765-1-bart.vanassche@wdc.com>
	 <20180224124427.GA26192@ming.t460p>
In-Reply-To: <20180224124427.GA26192@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gU2F0LCAyMDE4LTAyLTI0IGF0IDIwOjQ0ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
VGh1LCBGZWIgMjIsIDIwMTggYXQgMDU6MDg6MDJQTSAtMDgwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IEhlbGxvIEplbnMsDQo+ID4gDQo+ID4gUmVjZW50bHkgSm9zZXBoIFFpIGlkZW50
aWZpZWQgcmFjZXMgYmV0d2VlbiB0aGUgYmxvY2sgY2dyb3VwIGNvZGUgYW5kIHJlcXVlc3QNCj4g
PiBxdWV1ZSBpbml0aWFsaXphdGlvbiBhbmQgY2xlYW51cC4gVGhpcyBwYXRjaCBzZXJpZXMgYWRk
cmVzcyB0aGVzZSByYWNlcy4gUGxlYXNlDQo+ID4gY29uc2lkZXIgdGhlc2UgcGF0Y2hlcyBmb3Ig
a2VybmVsIHY0LjE3Lg0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiANCj4gPiBCYXJ0Lg0KPiA+IA0K
PiA+IENoYW5nZXMgYmV0d2VlbiB2MyBhbmQgdjQ6DQo+ID4gLSBBZGRlZCB0aHJlZSBwYXRjaGVz
IHRoYXQgZml4IHRoZSBjYWxsaW5nIG9yZGVyIG9mIGRlbF9nZW5kaXNrKCkgYW5kDQo+ID4gICBi
bGtfY2xlYW51cF9xdWV1ZSgpIGluIG11bHRpcGxlIGJsb2NrIGRyaXZlcnMuDQo+IA0KPiBTdWdn
ZXN0IHRvIGFkZCBkZXNjcmlwdGlvbiBhYm91dCB0aGUgcmVhc29uIHdoeSB3ZSBoYXZlIHRvIGRl
bGV0ZQ0KPiBnZW5kaXNrIGJlZm9yZSBibGtfY2xlYW51cF9xdWV1ZSgpIGluIGNvbW1pdCBsb2cu
DQo+IA0KPiBGb3IgcGF0Y2hlcyAxIH4gMzoNCj4gDQo+IFJldmlld2VkLWJ5OiBNaW5nIExlaSA8
bWluZy5sZWlAcmVkaGF0LmNvbT4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LiBJIHdpbGwgYWRk
IGEgY29tbWVudCBhYm91dCB3aHkgcGF0Y2hlcyAxIC0gMyBhcmUNCm5lY2Vzc2FyeSBpZiBJIGhh
dmUgdG8gcmVwb3N0IHRoaXMgcGF0Y2ggc2VyaWVzLg0KDQpCYXJ0Lg0KDQoNCg==
