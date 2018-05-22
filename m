Return-Path: <prvs=673874c89=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "keith.busch@linux.intel.com" <keith.busch@linux.intel.com>
CC: "hch@lst.de" <hch@lst.de>, "keith.busch@intel.com"
	<keith.busch@intel.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Date: Tue, 22 May 2018 16:48:01 +0000
Message-ID: <9ddccf3d36f114b1e358f88bf360db87fd9d8246.camel@wdc.com>
References: <20180521231131.6685-1-keith.busch@intel.com>
	 <20180521231131.6685-4-keith.busch@intel.com>
	 <e7a287827b4c00151bb7714deca7ea6453177504.camel@wdc.com>
	 <20180522141507.GQ5528@localhost.localdomain>
	 <d73bd0b081dbf2156e7b20df4f85e1db38785b0b.camel@wdc.com>
	 <20180522163403.GA8388@localhost.localdomain>
In-Reply-To: <20180522163403.GA8388@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTA1LTIyIGF0IDEwOjM0IC0wNjAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
T24gVHVlLCBNYXkgMjIsIDIwMTggYXQgMDQ6Mjk6MDdQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hl
IHdyb3RlOg0KPiA+IFBsZWFzZSBoYXZlIGFub3RoZXIgbG9vayBhdCB0aGUgY3VycmVudCBjb2Rl
IHRoYXQgaGFuZGxlcyByZXF1ZXN0IHRpbWVvdXRzDQo+ID4gYW5kIGNvbXBsZXRpb25zLiBUaGUg
Y3VycmVudCBpbXBsZW1lbnRhdGlvbiBndWFyYW50ZWVzIHRoYXQgbm8gZG91YmxlDQo+ID4gY29t
cGxldGlvbnMgY2FuIG9jY3VyIGJ1dCB5b3VyIHBhdGNoIHJlbW92ZXMgZXNzZW50aWFsIGFzcGVj
dHMgb2YgdGhhdA0KPiA+IGltcGxlbWVudGF0aW9uLg0KPiANCj4gSG93IGRvZXMgdGhlIGN1cnJl
bnQgaW1wbGVtZW50YXRpb24gZ3VhcmFudGVlIGEgZG91YmxlIGNvbXBsZXRpb24gZG9lc24ndA0K
PiBoYXBwZW4gd2hlbiB0aGUgcmVxdWVzdCBpcyBhbGxvY2F0ZWQgZm9yIGEgbmV3IGNvbW1hbmQ/
DQoNCkhlbGxvIEtlaXRoLA0KDQpJZiBhIHJlcXVlc3QgaXMgY29tcGxldGVzIGFuZCBpcyByZXVz
ZWQgYWZ0ZXIgdGhlIHRpbWVvdXQgaGFuZGxlciBoYXMgc2V0DQphYm9ydGVkX2dzdGF0ZSBhbmQg
YmVmb3JlIGJsa19tcV90ZXJtaW5hdGVfZXhwaXJlZCgpIGlzIGNhbGxlZCB0aGVuIHRoZSBsYXR0
ZXINCmZ1bmN0aW9uIHdpbGwgc2tpcCB0aGUgcmVxdWVzdCBiZWNhdXNlIHJlc3RhcnRpbmcgYSBy
ZXF1ZXN0IGNhdXNlcyB0aGUNCmdlbmVyYXRpb24gbnVtYmVyIGluIHJxLT5nc3RhdGUgdG8gYmUg
aW5jcmVtZW50ZWQuIEZyb20gYmxrX21xX3JxX3VwZGF0ZV9zdGF0ZSgpOg0KDQoJaWYgKHN0YXRl
ID09IE1RX1JRX0lOX0ZMSUdIVCkgew0KCQlXQVJOX09OX09OQ0UoKG9sZF92YWwgJiBNUV9SUV9T
VEFURV9NQVNLKSAhPSBNUV9SUV9JRExFKTsNCgkJbmV3X3ZhbCArPSBNUV9SUV9HRU5fSU5DOw0K
CX0NCg0KQmFydC4NCg0KDQoNCg==
