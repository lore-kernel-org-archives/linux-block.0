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
Date: Wed, 9 May 2018 16:30:32 +0000
Message-ID: <366A8132-B88A-40F7-BDE3-DA542E45FC0C@raithlin.com>
References: <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
 <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
 <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
 <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
 <1775CC56-4651-422F-953A-18E024D3717C@raithlin.com>
 <20180509160722.GB4140@redhat.com>
In-Reply-To: <20180509160722.GB4140@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

SGkgSmVyb21lDQoNCj4gTm93IGluc2lkZSB0aGF0IHBhZ2UgdGFibGUgeW91IGNhbiBwb2ludCBH
UFUgdmlydHVhbCBhZGRyZXNzDQo+IHRvIHVzZSBHUFUgbWVtb3J5IG9yIHVzZSBzeXN0ZW0gbWVt
b3J5LiBUaG9zZSBzeXN0ZW0gbWVtb3J5IGVudHJ5IGNhbg0KPiBhbHNvIGJlIG1hcmsgYXMgQVRT
IGFnYWluc3QgYSBnaXZlbiBQQVNJRC4NCiAgICANClRoYW5rcy4gVGhpcyBhbGwgbWFrZXMgc2Vu
c2UuIA0KDQpCdXQgZG8geW91IGhhdmUgZXhhbXBsZXMgb2YgdGhpcyBpbiBhIGtlcm5lbCBkcml2
ZXIgKGlmIHNvIGNhbiB5b3UgcG9pbnQgbWUgdG9vIGl0KSBvciBpcyB0aGlzIGFsbCBkb25lIHZp
YSB1c2VyLXNwYWNlPyBCYXNlZCBvbiBteSBncmVwcGluZyBvZiB0aGUga2VybmVsIGNvZGUgSSBz
ZWUgemVybyBFUCBkcml2ZXJzIHVzaW5nIGluLWtlcm5lbCBBVFMgZnVuY3Rpb25hbGl0eSByaWdo
dCBub3cuLi4NCg0KU3RlcGhlbg0KICAgIA0KDQo=
