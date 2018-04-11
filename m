Return-Path: <prvs=63297c413=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"maxg@mellanox.com" <maxg@mellanox.com>, "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH v5] blk-mq: Avoid that a completion can be ignored for
 BLK_EH_RESET_TIMER
Date: Wed, 11 Apr 2018 13:36:43 +0000
Message-ID: <56f31e573cdd0d17cce5108d7e722d63519c8a40.camel@wdc.com>
References: <20180410210157.30477-1-bart.vanassche@wdc.com>
	 <20180411021104.GC4494@ming.t460p>
In-Reply-To: <20180411021104.GC4494@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTA0LTExIGF0IDEwOjExICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
VHVlLCBBcHIgMTAsIDIwMTggYXQgMDM6MDE6NTdQTSAtMDYwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IFRoZSBibGstbXEgdGltZW91dCBoYW5kbGluZyBjb2RlIGlnbm9yZXMgY29tcGxl
dGlvbnMgdGhhdCBvY2N1ciBhZnRlcg0KPiA+IGJsa19tcV9jaGVja19leHBpcmVkKCkgaGFzIGJl
ZW4gY2FsbGVkIGFuZCBiZWZvcmUgYmxrX21xX3JxX3RpbWVkX291dCgpDQo+ID4gaGFzIHJlc2V0
IHJxLT5hYm9ydGVkX2dzdGF0ZS4gSWYgYSBibG9jayBkcml2ZXIgdGltZW91dCBoYW5kbGVyIGFs
d2F5cw0KPiA+IHJldHVybnMgQkxLX0VIX1JFU0VUX1RJTUVSIHRoZW4gdGhlIHJlc3VsdCB3aWxs
IGJlIHRoYXQgdGhlIHJlcXVlc3QNCj4gPiBuZXZlciB0ZXJtaW5hdGVzLg0KPiANCj4gVW5kZXIg
dGhpcyBzaXR1YXRpb246DQo+IA0KPiBJTU8sIGlmIHRoaXMgcmVxdWVzdCBoYXMgYmVlbiBoYW5k
bGVkIGJ5IGRyaXZlcidzIGlycSBoYW5kbGVyLCBhbmQgaWYNCj4gZHJpdmVyJ3MgLnRpbWVvdXQg
c3RpbGwgcmV0dXJucyBCTEtfRUhfUkVTRVRfVElNRVIsIGl0IGlzIGRyaXZlcidzIGJ1ZywNCj4g
YW5kIHRoZSBjb3JyZWN0IHJldHVybiB2YWx1ZSBzaG91bGQgYmUgQkxLX0VIX0hBTkRMRUQuDQoN
Ck1heWJlLiBJbiB0aGUgdmlydGlvLXNjc2kgZHJpdmVyIEkgZm91bmQgdGhlIGZvbGxvd2luZzoN
Cg0KLyoNCiAqIFRoZSBob3N0IGd1YXJhbnRlZXMgdG8gcmVzcG9uZCB0byBlYWNoIGNvbW1hbmQs
IGFsdGhvdWdoIEkvTw0KICogbGF0ZW5jaWVzIG1pZ2h0IGJlIGhpZ2hlciB0aGFuIG9uIGJhcmUg
bWV0YWwuICBSZXNldCB0aGUgdGltZXINCiAqIHVuY29uZGl0aW9uYWxseSB0byBnaXZlIHRoZSBo
b3N0IGEgY2hhbmNlIHRvIHBlcmZvcm0gRUguDQogKi8NCnN0YXRpYyBlbnVtIGJsa19laF90aW1l
cl9yZXR1cm4gdmlydHNjc2lfZWhfdGltZWRfb3V0KHN0cnVjdCBzY3NpX2NtbmQgKnNjbW5kKQ0K
ew0KCXJldHVybiBCTEtfRUhfUkVTRVRfVElNRVI7DQp9DQoNCkJhcnQuDQoNCg0KDQo=
