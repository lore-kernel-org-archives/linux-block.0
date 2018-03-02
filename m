Return-Path: <toshi.kani@hpe.com>
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "hch@lst.de" <hch@lst.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, "jglisse@redhat.com" <jglisse@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"maxg@mellanox.com" <maxg@mellanox.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "keith.busch@intel.com" <keith.busch@intel.com>,
	"benh@kernel.crashing.org" <benh@kernel.crashing.org>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "oliveroh@au1.ibm.com" <oliveroh@au1.ibm.com>
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
Date: Fri, 2 Mar 2018 17:38:58 +0000
Message-ID: <1520015040.2693.38.camel@hpe.com>
References: <20180228234006.21093-1-logang@deltatee.com>
	 <1519876489.4592.3.camel@kernel.crashing.org>
	 <1519876569.4592.4.camel@au1.ibm.com>
	 <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
	 <1519936477.4592.23.camel@au1.ibm.com>
	 <1519936815.4592.25.camel@au1.ibm.com> <20180301205315.GJ19007@ziepe.ca>
	 <1519942012.4592.31.camel@au1.ibm.com>
	 <CA+55aFy-oAiFJ3WDx4giR1enj65y-YJnZZhY6geFw0ygFyKXfQ@mail.gmail.com>
	 <1519943658.4592.34.camel@kernel.crashing.org>
	 <1520010446.2693.19.camel@hpe.com>
	 <CA+55aFztf2D4NwEkRxnJkD6kK62CWKxmERbALMGoMgFEGLEJZA@mail.gmail.com>
In-Reply-To: <CA+55aFztf2D4NwEkRxnJkD6kK62CWKxmERbALMGoMgFEGLEJZA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE4LTAzLTAyIGF0IDA4OjU3IC0wODAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToN
Cj4gT24gRnJpLCBNYXIgMiwgMjAxOCBhdCA4OjIyIEFNLCBLYW5pLCBUb3NoaSA8dG9zaGkua2Fu
aUBocGUuY29tPiB3cm90ZToNCj4gPiANCj4gPiBGV0lXLCB0aGlzIHRoaW5nIGlzIGNhbGxlZCBN
VFJScyBvbiB4ODYsIHdoaWNoIGFyZSBpbml0aWFsaXplZCBieSBCSU9TLg0KPiANCj4gTm8uDQo+
IA0KPiBPciByYXRoZXIsIHRoYXQncyBzaW1wbHkganVzdCBhbm90aGVyIChzbWFsbCkgcGFydCBv
ZiBpdCBhbGwgLSBhbmQgYW4NCj4gYXJjaGl0ZWN0ZWQgYW5kIGRvY3VtZW50ZWQgb25lIGF0IHRo
YXQuDQo+IA0KPiBMaWtlIHRoZSBwYWdlIHRhYmxlIGNhY2hpbmcgZW50cmllcywgdGhlIG1lbW9y
eSB0eXBlIHJhbmdlIHJlZ2lzdGVycw0KPiBhcmUgcmVhbGx5IGp1c3QgInNlY29uZGFyeSBpbmZv
cm1hdGlvbiIuIFRoZXkgZG9uJ3QgYWN0dWFsbHkgc2VsZWN0DQo+IGJldHdlZW4gUENJZSBhbmQg
UkFNLCB0aGV5IGp1c3QgYWZmZWN0IHRoZSBiZWhhdmlvciBvbiB0b3Agb2YgdGhhdC4NCj4gDQo+
IFRoZSByZWFsbHkgbml0dHktZ3JpdHR5IHN0dWZmIGlzIG5vdCBhcmNoaXRlY3RlZCwgYW5kIGdl
bmVyYWxseSBub3QNCj4gZG9jdW1lbnRlZCBvdXRzaWRlIChwb3NzaWJseSkgdGhlIEJJT1Mgd3Jp
dGVyJ3MgZ3VpZGUgdGhhdCBpcyBub3QgbWFkZQ0KPiBwdWJsaWMuDQo+IA0KPiBUaG9zZSBtYWdp
Y2FsIHJlZ2lzdGVycyBjb250YWluIGRldGFpbHMgbGlrZSBob3cgdGhlIERSQU0gaXMNCj4gaW50
ZXJsZWF2ZWQgKGlmIGl0IGlzKSwgd2hhdCB0aGUgdGltaW5ncyBhcmUsIHdoZXJlIHdoaWNoIG1l
bW9yeQ0KPiBjb250cm9sbGVyIGhhbmRsZXMgd2hpY2ggbWVtb3J5IHJhbmdlLCBhbmQgd2hhdCBh
cmUgZ29lcyB0byBQQ0llIGV0Yy4NCj4gDQo+IEJhc2ljYWxseSBhbGwgdGhlIGFjdHVhbCAqc3Rl
ZXJpbmcqIGluZm9ybWF0aW9uIGlzIHZlcnkgbXVjaCBoaWRkZW4NCj4gYXdheSBmcm9tIHRoZSBr
ZXJuZWwgKGFuZCBvZnRlbiBmcm9tIHRoZSBCSU9TIHRvbykuIFRoZSBwYXJ0cyB3ZSBzZWUNCj4g
YXQgYSBoaWdoZXIgbGV2ZWwgYXJlIGp1c3QgdHVuaW5nIGFuZCB0d2Vha3MuDQo+IA0KPiBOb3Rl
OiB0aGUgZGV0YWlscyBkaWZmZXIgX2Vub3Jtb3VzbHlfIGJldHdlZW4gZGlmZmVyZW50IGNoaXBz
LiBUaGUNCj4gc2V0dXAgY2FuIGJlIHZlcnkgZGlmZmVyZW50LCB3aXRoIHRoaW5ncyBsaWtlIEtu
aWdodHMgTGFuZGluZyBoYXZpbmcNCj4gdGhlIGV4dGVybmFsIGNhY2hlIHRoYXQgY2FuIGFsc28g
YWN0IGFzIGxvY2FsIG1lbW9yeSB0aGF0IGlzbid0IGENCj4gY2FjaGUgYnV0IG1hcHMgYXQgYSBk
aWZmZXJlbnQgcGh5c2ljYWwgYWRkcmVzcyBpbnN0ZWFkIGV0Yy4gVGhhdCdzIHRoZQ0KPiBraW5k
IG9mIHN0ZWVyaW5nIEknbSB0YWxraW5nIGFib3V0IC0gYXQgYSBsb3cgbGV2ZWwgaG93IHBoeXNp
Y2FsDQo+IGFkZHJlc3NlcyBnZXQgbWFwcGVkIHRvIGRpZmZlcmVudCBjYWNoZSBwYXJ0aXRpb25z
LCBtZW1vcnkNCj4gY29udHJvbGxlcnMsIG9yIHRvIHRoZSBJTyBzeXN0ZW0gZXRjLg0KDQpSaWdo
dCwgTVJDIGNvZGUgaXMgbm90IGRvY3VtZW50ZWQgcHVibGljbHksIGFuZCBpdCBpcyB2ZXJ5IG11
Y2ggQ1BVDQpkZXBlbmRlbnQuICBJdCBwcm9ncmFtcyBhZGRyZXNzIGRlY29kZXJzIGFuZCBtYXBz
IERSQU1zIHRvIHBoeXNpY2FsDQphZGRyZXNzIGFzIHlvdSBkZXNjcmliZWQuICBNVFJScyBoYXZl
IG5vdGhpbmcgdG8gZG8gd2l0aCB0aGlzIG1lbW9yeQ0KY29udHJvbGxlciBzZXR0aW5nLiAgVGhh
dCBzYWlkLCBNVFJScyBzcGVjaWZ5IENQVSdzIG1lbW9yeSBhY2Nlc3MgdHlwZSwNCnN1Y2ggYXMg
VUMgYW5kIFdCLg0KDQpUaGFua3MsDQotVG9zaGkNCg==
