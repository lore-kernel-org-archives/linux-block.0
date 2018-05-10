Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jerome Glisse <jglisse@redhat.com>
CC: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Logan
 Gunthorpe" <logang@deltatee.com>, Alex Williamson
	<alex.williamson@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Christoph
 Hellwig" <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas
	<bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy
	<maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Date: Thu, 10 May 2018 14:20:00 +0000
Message-ID: <405531AE-8315-4A4F-9B0C-8DBE49BFCAB4@raithlin.com>
References: <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
 <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
 <1775CC56-4651-422F-953A-18E024D3717C@raithlin.com>
 <20180509160722.GB4140@redhat.com>
 <366A8132-B88A-40F7-BDE3-DA542E45FC0C@raithlin.com>
 <20180509174952.GC4140@redhat.com>
In-Reply-To: <20180509174952.GC4140@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

SGkgSmVyb21lDQoNCj4gQXMgaXQgaXMgdGllIHRvIFBBU0lEIHRoaXMgaXMgZG9uZSB1c2luZyBJ
T01NVSBzbyBsb29rcyBmb3IgY2FsbGVyDQo+IG9mIGFtZF9pb21tdV9iaW5kX3Bhc2lkKCkgb3Ig
aW50ZWxfc3ZtX2JpbmRfbW0oKSBpbiBHUFUgdGhlIGV4aXN0aW5nDQo+ICB1c2VyIGlzIHRoZSBB
TUQgR1BVIGRyaXZlciBzZWU6DQogICAgDQpBaCB0aGFua3MuIFRoaXMgY2xlYXJlZCB0aGluZ3Mg
dXAgZm9yIG1lLiBBIHF1aWNrIHNlYXJjaCBzaG93cyB0aGVyZSBhcmUgc3RpbGwgbm8gdXNlcnMg
b2YgaW50ZWxfc3ZtX2JpbmRfbW0oKSBidXQgSSBzZWUgdGhlIEFNRCB2ZXJzaW9uIHVzZWQgaW4g
dGhhdCBHUFUgZHJpdmVyLg0KDQpPbmUgdGhpbmcgSSBjb3VsZCBub3QgZ3JvayBmcm9tIHRoZSBj
b2RlIGhvdyB0aGUgR1BVIGRyaXZlciBpbmRpY2F0ZXMgd2hpY2ggRE1BIGV2ZW50cyByZXF1aXJl
IEFUUyB0cmFuc2xhdGlvbnMgYW5kIHdoaWNoIGRvIG5vdC4gSSBhbSBhc3N1bWluZyB0aGUgZHJp
dmVyIGltcGxlbWVudHMgc29tZXdheSBvZiBpbmRpY2F0aW5nIHRoYXQgYW5kIGl0cyBub3QganVz
dCBhIGdsb2JhbCBPTiBvciBPRkYgZm9yIGFsbCBETUFzPyBUaGUgcmVhc29uIEkgYXNrIGlzIHRo
YXQgSSBsb29raW5nIGF0IGlmIE5WTWUgd2FzIHRvIHN1cHBvcnQgQVRTIHdoYXQgd291bGQgbmVl
ZCB0byBiZSBhZGRlZCBpbiB0aGUgTlZNZSBzcGVjIGFib3ZlIGFuZCBiZXlvbmQgd2hhdCB3ZSBo
YXZlIGluIFBDSSBBVFMgdG8gc3VwcG9ydCBlZmZpY2llbnQgdXNlIG9mIEFUUyAoZm9yIGV4YW1w
bGUgd291bGQgd2UgbmVlZCBhIGZsYWcgaW4gdGhlIHN1Ym1pc3Npb24gcXVldWUgZW50cmllcyB0
byBpbmRpY2F0ZSBhIHBhcnRpY3VsYXIgSU8ncyBTR0wvUFJQIHNob3VsZCB1bmRlcmdvIEFUUyku
DQoNCkNoZWVycw0KDQpTdGVwaGVuICAgIA0KDQo=
