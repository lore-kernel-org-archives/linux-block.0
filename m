Return-Path: <prvs=4710b8301=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hongxu.jia@windriver.com"
	<hongxu.jia@windriver.com>
Subject: Re: [PATCH] ide: Make ide_cdrom_prep_fs() initialize the sense buffer
 pointer
Date: Wed, 1 Nov 2017 22:33:27 +0000
Message-ID: <1509575605.2668.0.camel@wdc.com>
References: <20171101223149.27593-1-bart.vanassche@wdc.com>
In-Reply-To: <20171101223149.27593-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE3LTExLTAxIGF0IDE1OjMxIC0wNzAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
DQo+IFRoZSBjaGFuZ2VzIGludHJvZHVjZWQgdGhyb3VnaCBjb21taXQgODJlZDRkYjQ5OWI4IGFz
c3VtZSB0aGF0IHRoZQ0KPiBzZW5zZSBidWZmZXIgcG9pbnRlciBpbiBzdHJ1Y3Qgc2NzaV9yZXF1
ZXN0IGlzIGluaXRpYWxpemVkIGZvciBhbGwNCj4gcmVxdWVzdHMgLSBwYXNzdGhyb3VnaCBhbmQg
ZmlsZXN5c3RlbSByZXF1ZXN0cy4gSGVuY2UgbWFrZSBzdXJlDQo+IHRoYXQgdGhhdCBwb2ludGVy
IGlzIGluaXRpYWxpemVkIGZvciBmaWxlc3lzdGVtIHJlcXVlc3RzLiBSZW1vdmUNCj4gdGhlIG1l
bXNldCgpIGNhbGwgdGhhdCBjbGVhcnMgLmNtZCBiZWNhdXNlIHRoZSBzY3NpX3JlcV9pbml0KCkN
Cj4gY2FsbCBpbiBpZGVfaW5pdGlhbGl6ZV9ycSgpIGFscmVhZHkgaW5pdGlhbGl6ZXMgdGhlIC5j
bWQuDQoNCkhlbGxvIEplbnMsDQoNClBsZWFzZSBub3RlIHRoYXQgdGhpcyBwYXRjaCBhcHBsaWVz
IG9uIHRvcCBvZiB5b3VyIGZvci1saW51cyBicmFuY2gNCmJ1dCBpcyBpbnRlbmRlZCBmb3Iga2Vy
bmVsIHY0LjE1Lg0KDQpUaGFua3MsDQoNCkJhcnQu
