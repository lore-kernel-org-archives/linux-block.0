Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [GIT PULL] nvme update for Linux 4.14, take 2
Date: Wed, 30 Aug 2017 16:56:28 +0000
Message-ID: <1504112187.2526.47.camel@wdc.com>
References: <20170829150507.rjixn6uf3id6kltx@infradead.org>
	 <9a27048d-1252-985f-c905-b738d709b204@kernel.dk>
	 <38ddd70f-3fec-09c0-dafb-eba1e8f9cc18@grimberg.me>
	 <1504106914.2526.5.camel@wdc.com>
	 <a798247e-cc89-f189-4ad9-92095a86106e@grimberg.me>
	 <1504107991.2526.16.camel@wdc.com>
	 <30e386a2-aac7-e9b7-59e2-52c481247e4e@kernel.dk>
	 <0ca15e8f-fc04-7694-a471-379103c6428d@grimberg.me>
	 <1504109513.2526.28.camel@wdc.com>
	 <a2945cf7-93e5-11da-0780-3472b29f18bc@grimberg.me>
In-Reply-To: <a2945cf7-93e5-11da-0780-3472b29f18bc@grimberg.me>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE3LTA4LTMwIGF0IDE5OjQ3ICswMzAwLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0K
PiA+ID4gSWYgd2UgZ2V0IHRvIGNob29zZSwgbXkgcHJlZmVyZW5jZSB3b3VsZCBiZSB0byByZXN0
b3JlIHRoZSBvbGQgYmVoYXZpb3INCj4gPiA+IGJlY2F1c2UgY3VycmVudGx5IGV4aXN0aW5nIG52
bWUgdHJhbnNwb3J0cyBrZWVwIHRoZWlyIGludGVybmFsIGN0cmwNCj4gPiA+IHJlcHJlc2VudGF0
aW9uIGluIHRoZSB0YWdzZXQtPmRyaXZlcl9kYXRhIGFzIHRoZXkgaW1wbGVtZW50DQo+ID4gPiBp
bml0L2V4aXRfcmVxdWVzdC4gQm91bmNpbmcgaW4gbnZtZSBjb3JlIHdvdWxkIHJlcXVpcmUgdG8g
Y2hhbmdlIHRoYXQNCj4gPiA+IGFuZCBhbHdheXMga2VlcCBzdHJ1Y3QgbnZtZV9jdHJsIGFzIHRo
ZSB0YWdzZXQtPmRyaXZlcl9kYXRhIGFuZCBjb252ZXJ0DQo+ID4gPiBpdCBvbiBldmVyeSBoYW5k
bGVyLi4uDQo+ID4gPiANCj4gPiA+IEV2ZXJ5dGhpbmcgaXMgZG9hYmxlIGJ1dCBpdCBzZWVtcyBs
aWtlIGFuIHVubmVlZGVkIGhhc3NsZSB0byBtZS4uLg0KPiA+IA0KPiA+IFNvcnJ5IGJ1dCBJJ20g
bm90IGNvbnZpbmNlZCB0aGF0IGl0IHdvdWxkIGJlIG5lY2Vzc2FyeSB0byBjaGFuZ2Ugd2hhdA0K
PiA+IHRhZ3NldC0+ZHJpdmVyX2RhdGEgcG9pbnRzIGF0LiBIb3cgYWJvdXQgbW92aW5nIGJsa19t
cV9yZWluaXRfdGFnc2V0KCkgZnJvbQ0KPiA+IHRoZSBibG9jayBsYXllciBjb3JlIHRvIHRoZSBO
Vk1lIGNvcmUsIHRvIHJlbmFtZSBpdCBhbmQgdG8gcGFzcyBhIHBvaW50ZXINCj4gPiB0byB0aGUg
bnZtZV9jdHJsIGRhdGEgc3RydWN0dXJlIHRvIHRoYXQgZnVuY3Rpb24gaW5zdGVhZCBvZiBvbmx5
IGJsb2NrIGxheWVyDQo+ID4gaW5mb3JtYXRpb24/DQo+IA0KPiBUaGF0IHdvdWxkIG1lYW4gdGhh
dCBJIG5lZWQgdG8gb3Blbi1jb2RlIHRoZSB0YWdzZXQgaXRlcmF0aW9uIGluIG52bWUNCj4gd2hp
Y2ggZG9lcyBub3QgZmVlbCBsaWtlIHNvbWV0aGluZyBhIGRyaXZlciBzaG91bGQgZG8uDQoNCkhv
dyBhYm91dCByZW5hbWluZyBibGtfbXFfcmVpbml0X3RhZ3NldCgpIGludG8gYmxrX21xX3RhZ3Nl
dF9pdGVyKCkgYW5kDQp0byBtYWtlIHRoZSBhcmd1bWVudCBsaXN0IG9mIGJsa19tcV90YWdzZXRf
aXRlcigpIG1vcmUgc2ltaWxhciB0byB0aGF0IG9mDQpibGtfbXFfcXVldWVfdGFnX2J1c3lfaXRl
cigpIHN1Y2ggdGhhdCBjYWxsZXJzIG9mIGJsa19tcV90YWdzZXRfaXRlcigpDQpjYW4gcGFzcyBh
IHBvaW50ZXIgdG8gYW55IHN0cnVjdHVyZSB0aHJvdWdoIHRoZSBAcHJpdiBhcmd1bWVudD8gVGhh
dCB3b3VsZA0KbWFrZSB0aGlzIGZ1bmN0aW9uIG1vcmUgZ2VuZXJhbCBhbmQgbWF5YmUgYWxzbyBt
b3JlIHVzZWZ1bCB0byBvdGhlciBibG9jaw0KZHJpdmVycy4NCg0KQmFydC4=
