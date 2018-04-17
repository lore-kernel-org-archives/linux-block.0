Return-Path: <prvs=63851e16a=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>
CC: "shaun@tancheff.com" <shaun@tancheff.com>, "hare@suse.com"
	<hare@suse.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] block: Avoid executing a report or reset zones while a
 queue is frozen
Date: Tue, 17 Apr 2018 17:35:07 +0000
Message-ID: <f966e56f3c2c9add48d0a93fb56321f7eb7ee33e.camel@wdc.com>
References: <20180417010034.28676-1-bart.vanassche@wdc.com>
	 <20180417151857.GA25646@lst.de>
In-Reply-To: <20180417151857.GA25646@lst.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTA0LTE3IGF0IDE3OjE4ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gTW9uLCBBcHIgMTYsIDIwMTggYXQgMDY6MDA6MzRQTSAtMDcwMCwgQmFydCBWYW4g
QXNzY2hlIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggb24gaXRzZWxmIGRvZXMgbm90IGNoYW5nZSB0
aGUgYmVoYXZpb3Igb2YgZWl0aGVyIGlvY3RsLg0KPiA+IEhvd2V2ZXIsIHRoaXMgcGF0Y2ggaXMg
bmVjZXNzYXJ5IHRvIGF2b2lkIHRoYXQgdGhlc2UgaW9jdGxzIGZhaWwNCj4gPiB3aXRoIC1FSU8g
aWYgc2RfcmV2YWxpZGF0ZV9kaXNrKCkgaXMgY2FsbGVkIHdoaWxlIHRoZXNlIGlvY3RscyBhcmUN
Cj4gPiBpbiBwcm9ncmVzcyBiZWNhdXNlIHRoZSBjdXJyZW50IHpvbmVkIGJsb2NrIGNvbW1hbmQg
Y29kZSB0ZW1wb3JhcmlseQ0KPiA+IGNsZWFycyBkYXRhIHRoYXQgaXMgbmVlZGVkIGJ5IHRoZXNl
IGlvY3Rscy4gU2VlIGFsc28gY29tbWl0DQo+ID4gM2VkMDVhOTg3ZTBmICgiYmxrLXpvbmVkOiBp
bXBsZW1lbnQgaW9jdGxzIikuDQo+IA0KPiBIbW0uICBJIHRoaW5rIHdlIG5lZWQgdG8gYXZvaWQg
Y2xlYXJpbmcgdGhhdCBkYXRhIGFuZCB1cGRhdGUgaXQgdXNpbmcNCj4gUkNVIGluc3RlYWQuICBD
YWxsaW5nIGJsa19xdWV1ZV9lbnRlciBiZWZvcmUgc3VibWl0dGluZyBiaW9zIGlzDQo+IHNvbWV0
aGluZyB0aGF0IHdvdWxkIG1ha2Ugem9uZSByZXBvcnRpbmcgdmVyeSBkaWZmZXJlbnQgZnJvbSBh
bnkNCj4gb3RoZXIgYmxvY2sgbGF5ZXIgdXNlci4NCg0KSGVsbG8gQ2hyaXN0b3BoLA0KDQpQbGVh
c2UgaGF2ZSBhIGxvb2sgYXQgZ2VuZXJpY19tYWtlX3JlcXVlc3QoKS4gSSB0aGluayB0aGF0IGZ1
bmN0aW9uIHNob3dzDQp0aGF0IGJsa19xdWV1ZV9lbnRlcigpIGlzIGNhbGxlZCBhbnl3YXkgYmVm
b3JlIC5tYWtlX3JlcXVlc3RfZm4oKSBpcyBjYWxsZWQuDQoNClRoYW5rcywNCg0KQmFydC4NCg0K
DQo=
