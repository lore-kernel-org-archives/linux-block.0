Return-Path: <decui@microsoft.com>
From: Dexuan Cui <decui@microsoft.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>, "hare@suse.com"
	<hare@suse.com>, "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "jth@kernel.org" <jth@kernel.org>
Subject: RE: [PATCH] genhd: Do not hold event lock when scheduling workqueue
 elements
Date: Tue, 7 Feb 2017 06:29:33 +0000
Message-ID: <MWHPR03MB2669125A47D3CB7EB530D084BF430@MWHPR03MB2669.namprd03.prod.outlook.com>
References: <1484732896-22941-1-git-send-email-hare@suse.de>
         <1485822639.2669.16.camel@sandisk.com>
         <532c55c4-15da-d2f9-401c-36bc4343756b@suse.com>
         <MWHPR03MB2669B8A45A07846AF0A06E46BF4F0@MWHPR03MB2669.namprd03.prod.outlook.com>
         <MWHPR03MB26699D4657FB67A535972208BF430@MWHPR03MB2669.namprd03.prod.outlook.com>
 <1486436195.2791.1.camel@sandisk.com>
 <MWHPR03MB26695ACBEBDB30E3E2E108FBBF430@MWHPR03MB2669.namprd03.prod.outlook.com>
In-Reply-To: <MWHPR03MB26695ACBEBDB30E3E2E108FBBF430@MWHPR03MB2669.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

PiBGcm9tOiBsaW51eC1ibG9jay1vd25lckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpsaW51eC1i
bG9jay0NCj4gb3duZXJAdmdlci5rZXJuZWwub3JnXSBPbiBCZWhhbGYgT2YgRGV4dWFuIEN1aQ0K
PiB3aXRoIHRoZSBsaW51eC1uZXh0IGtlcm5lbC4NCj4gDQo+IEkgY2FuIGJvb3QgdGhlIGd1ZXN0
IHdpdGggbGludXgtbmV4dCdzIG5leHQtMjAxNzAxMzAgd2l0aG91dCBhbnkgaXNzdWUsDQo+IGJ1
dCBzaW5jZSBuZXh0LTIwMTcwMTMxIEkgaGF2ZW4ndCBzdWNjZWVkZWQgaW4gYm9vdGluZyB0aGUg
Z3Vlc3QuDQo+IA0KPiBXaXRoIG5leHQtMjAxNzAyMDMgKG1lbnRpb25lZCBpbiBteSBtYWlsIGxh
c3QgRnJpZGF5KSwgSSBnb3QgdGhlIHNhbWUNCj4gY2FsbHRyYWNlIGFzIEhhbm5lcy4NCj4gDQo+
IFdpdGggdG9kYXkncyBsaW51eC1uZXh0IChuZXh0LTIwMTcwMjA2KSwgYWN0dWFsbHkgdGhlIGNh
bGx0cmFjZSBjaGFuZ2VkIHRvDQo+IHRoZSBiZWxvdy4NCj4gWyAgMTIyLjAyMzAzNl0gID8gcmVt
b3ZlX3dhaXRfcXVldWUrMHg3MC8weDcwDQo+IFsgIDEyMi4wNTEzODNdICBhc3luY19zeW5jaHJv
bml6ZV9mdWxsKzB4MTcvMHgyMA0KPiBbICAxMjIuMDc2OTI1XSAgZG9faW5pdF9tb2R1bGUrMHhj
MS8weDFmOQ0KPiBbICAxMjIuMDk3NTMwXSAgbG9hZF9tb2R1bGUrMHgyNGJjLzB4Mjk4MA0KIA0K
SSBkb24ndCBrbm93IHdoeSBpdCBoYW5ncyBoZXJlLCBidXQgdGhpcyBpcyB0aGUgc2FtZSBjYWxs
dHJhY2UgaW4gbXkNCmxhc3QtRnJpZGF5IG1haWwsIHdoaWNoIGNvbnRhaW5zIDIgY2FsbHRyYWNl
cy4gSXQgbG9va3MgdGhlIG90aGVyIGNhbGx0cmFjZSBoYXMNCmJlZW4gcmVzb2x2ZWQgYnkgc29t
ZSBjaGFuZ2VzIGJldHdlZW4gbmV4dC0yMDE3MDIwMyBhbmQgdG9kYXkuDQoNCkhlcmUgdGhlIGtl
cm5lbCBpcyB0cnlpbmcgdG8gbG9hZCB0aGUgSHlwZXItViBzdG9yYWdlIGRyaXZlciAoaHZfc3Rv
cnZzYyksIGFuZA0KdGhlIGRyaXZlcidzIF9faW5pdCBhbmQgLnByb2JlIGhhdmUgZmluaXNoZWQg
c3VjY2Vzc2Z1bGx5IGFuZCB0aGVuIHRoZSBrZXJuZWwNCmhhbmdzIGhlcmUuDQoNCkkgYmVsaWV2
ZSBzb21ldGhpbmcgaXMgYnJva2VuIHJlY2VudGx5LCBiZWNhdXNlIEkgZG9uJ3QgaGF2ZSBhbnkg
aXNzdWUgYmVmb3JlDQpKYW4gMzEuIA0KDQpUaGFua3MsDQotLSBEZXh1YW4NCg==
