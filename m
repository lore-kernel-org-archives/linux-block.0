Return-Path: <prvs=5028ec12e=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "osandov@fb.com" <osandov@fb.com>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>, "hare@suse.de" <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 4/7] blk-mq: Avoid that request processing stalls when
 sharing tags
Date: Sat, 2 Dec 2017 01:05:05 +0000
Message-ID: <1512176705.2520.32.camel@wdc.com>
References: <20171201000848.2656-1-bart.vanassche@wdc.com>
	 <20171201000848.2656-5-bart.vanassche@wdc.com>
	 <20171201025803.GA29741@ming.t460p> <1512157932.2520.27.camel@wdc.com>
	 <20171202003625.GA24521@ming.t460p> <1512175730.2520.29.camel@wdc.com>
	 <20171202010026.GC24521@ming.t460p>
In-Reply-To: <20171202010026.GC24521@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gU2F0LCAyMDE3LTEyLTAyIGF0IDA5OjAwICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
U2F0LCBEZWMgMDIsIDIwMTcgYXQgMTI6NDg6NTFBTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IEZ1cnRoZXIgdGVzdHMgaGF2ZSBzaG93biB0aGF0IHRoZSBsb2NrdXAgSSByZWZl
cnJlZCB0byBkb2VzIG5vdCBvY2N1ciBiZWZvcmUgY29tbWl0DQo+ID4gYjM0NzY4OWZmYmNhIGJ1
dCB0aGF0IGl0IG9jY3VycyB3aXRoIGIzNDc2ODlmZmJjYS4NCj4gDQo+IFRoZW4geW91IG5lZWQg
dG8gcm9vdCBjYXVzZSBpdCwgb3INCg0KSXQncyBub3QgbXkgam9iIHRvIHJvb3QgY2F1c2UgYnVn
cyBpbnRyb2R1Y2VkIGJ5IHlvdXIgcGF0Y2hlcy4NCg0KPiBQcm92aWRlIGRlYnVnZnMgbG9nIGFu
ZCByZXByb2R1Y3Rpb24gc3RlcHMsIHBsZWFzZS4NCg0KSG93IEkgcmVwcm9kdWNlIHRoaXMgYnVn
IGlzIHNvbWV0aGluZyBJIGhhdmUgYWxyZWFkeSBtZW50aW9uZWQgbWFueSB0aW1lcyBpbg0KcHJl
dmlvdXMgZS1tYWlscy4NCg0KQmFydC4NCg==
