Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: "benh@au1.ibm.com" <benh@au1.ibm.com>, Logan Gunthorpe
	<logang@deltatee.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas
	<bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy
	<maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
	=?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Alex Williamson
	<alex.williamson@redhat.com>, Oliver OHalloran <oliveroh@au1.ibm.com>
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
Date: Thu, 1 Mar 2018 18:09:58 +0000
Message-ID: <B4151146-0490-40D4-BB0A-4FC9DE5841A4@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
In-Reply-To: <1519876569.4592.4.camel@au1.ibm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Pj4gU28gT2xpdmVyIChDQykgd2FzIGhhdmluZyBpc3N1ZXMgZ2V0dGluZyBhbnkgb2YgdGhhdCB0
byB3b3JrIGZvciB1cy4NCj4+IA0KPj4gVGhlIHByb2JsZW0gaXMgdGhhdCBhY2Njb3JkaW5nIHRv
IGhpbSAoSSBkaWRuJ3QgZG91YmxlIGNoZWNrIHRoZSBsYXRlc3QNCj4+IHBhdGNoZXMpIHlvdSBl
ZmZlY3RpdmVseSBob3RwbHVnIHRoZSBQQ0llIG1lbW9yeSBpbnRvIHRoZSBzeXN0ZW0gd2hlbg0K
Pj4gY3JlYXRpbmcgc3RydWN0IHBhZ2VzLg0KPj4gDQo+PiBUaGlzIGNhbm5vdCBwb3NzaWJseSB3
b3JrIGZvciB1cy4gRmlyc3Qgd2UgY2Fubm90IG1hcCBQQ0llIG1lbW9yeSBhcw0KPj4gY2FjaGFi
bGUuIChOb3RlIHRoYXQgZG9pbmcgc28gaXMgYSBiYWQgaWRlYSBpZiB5b3UgYXJlIGJlaGluZCBh
IFBMWA0KPj4gc3dpdGNoIGFueXdheSBzaW5jZSB5b3UnZCBhaHZlIHRvIG1hbmFnZSBjYWNoZSBj
b2hlcmVuY3kgaW4gU1cpLg0KPiAgIA0KPiAgIE5vdGU6IEkgdGhpbmsgdGhlIGFib3ZlIG1lYW5z
IGl0IHdvbid0IHdvcmsgYmVoaW5kIGEgc3dpdGNoIG9uIHg4Ng0KPiAgIGVpdGhlciwgd2lsbCBp
dCA/DQogDQpCZW4gDQoNCldlIGhhdmUgZG9uZSBleHRlbnNpdmUgdGVzdGluZyBvZiB0aGlzIHNl
cmllcyBhbmQgaXRzIHByZWRlY2Vzc29ycyB1c2luZyBQQ0llIHN3aXRjaGVzIGZyb20gYm90aCBC
cm9hZGNvbSAoUExYKSBhbmQgTWljcm9zZW1pLiBXZSBoYXZlIGFsc28gZG9uZSB0ZXN0aW5nIG9u
IHg4Nl82NCwgQVJNNjQgYW5kIHBwYzY0ZWwgYmFzZWQgQVJDSCB3aXRoIHZhcnlpbmcgZGVncmVl
cyBvZiBzdWNjZXNzLiBUaGUgc2VyaWVzIGFzIGl0IGN1cnJlbnRseSBzdGFuZHMgb25seSB3b3Jr
cyBvbiB4ODZfNjQgYnV0IG1vZGlmaWVkIChoYWNreSkgdmVyc2lvbnMgaGF2ZSBiZWVuIG1hZGUg
dG8gd29yayBvbiBBUk02NC4gVGhlIHg4Nl82NCB0ZXN0aW5nIGhhcyBiZWVuIGRvbmUgb24gYSBy
YW5nZSBvZiAoSW50ZWwpIENQVXMsIHNlcnZlcnMsIFBDSSBFUHMgKGluY2x1ZGluZyBSRE1BIE5J
Q3MgZnJvbSBhdCBsZWFzdCB0aHJlZSB2ZW5kb3JzLCBOVk1lIFNTRHMgZnJvbSBhdCBsZWFzdCBm
b3VyIHZlbmRvcnMgYW5kIFAyUCBkZXZpY2VzIGZyb20gZm91ciB2ZW5kb3JzKSBhbmQgUENJIHN3
aXRjaGVzLg0KDQpJIGRvIGZpbmQgaXQgc2xpZ2h0bHkgb2ZmZW5zaXZlIHRoYXQgeW91IHdvdWxk
IHF1ZXN0aW9uIHRoZSBzZXJpZXMgZXZlbiB3b3JraW5nLiBJIGhvcGUgeW91IGFyZSBub3Qgc3Vn
Z2VzdGluZyB3ZSB3b3VsZCBzdWJtaXQgdGhpcyBmcmFtZXdvcmsgbXVsdGlwbGUgdGltZXMgd2l0
aG91dCBoYXZpbmcgZG9uZSB0ZXN0aW5nIG9uIGl0Li4uLg0KDQpTdGVwaGVuDQoNCg==
