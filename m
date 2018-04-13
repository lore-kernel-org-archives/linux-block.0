Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Logan Gunthorpe
	<logang@deltatee.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@codeaurora.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Christoph
 Hellwig" <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas
	<bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy
	<maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
	=?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Alex Williamson <alex.williamson@redhat.com>,
	Eric Wehage <Eric.Wehage@huawei.com>
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Date: Fri, 13 Apr 2018 21:56:06 +0000
Message-ID: <178FD8FA-53BA-49DA-807F-F8736157F179@raithlin.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
 <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <20180326121138.00005e30@huawei.com>
 <20180326140118.GA221690@bhelgaas-glaptop.roam.corp.google.com>
 <c717eb06-1e83-f0f3-4d6c-15531aa808e0@deltatee.com>
 <20180327094701.0000300d@huawei.com>
In-Reply-To: <20180327094701.0000300d@huawei.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

IA0KPiAgSSdsbCBzZWUgaWYgSSBjYW4gZ2V0IG91ciBQQ0kgU0lHIHBlb3BsZSB0byBmb2xsb3cg
dGhpcyB0aHJvdWdoIA0KDQpIaSBKb25hdGhhbg0KDQpDYW4geW91IGxldCBtZSBrbm93IGlmIHRo
aXMgbW92ZXMgZm9yd2FyZCB3aXRoaW4gUENJLVNJRz8gSSB3b3VsZCBsaWtlIHRvIHRyYWNrIGl0
LiBJIGNhbiBzZWUgdGhpcyBiZWluZyBkb2FibGUgYmV0d2VlbiBSb290IFBvcnRzIHRoYXQgcmVz
aWRlIGluIHRoZSBzYW1lIFJvb3QgQ29tcGxleCBidXQgbWlnaHQgYmVjb21lIG1vcmUgY2hhbGxl
bmdpbmcgdG8gc3RhbmRhcmRpemUgZm9yIFJQcyB0aGF0IHJlc2lkZSBpbiBkaWZmZXJlbnQgUkNz
IGluIHRoZSBzYW1lIChwb3RlbnRpYWxseSBtdWx0aS1zb2NrZXQpIHN5c3RlbS4gSSBrbm93IGlu
IHRoZSBwYXN0IHdlIGhhdmUgc2VlbSBNZW1XciBUTFBTIGNyb3NzIHRoZSBRUEkgYnVzIGluIElu
dGVsIHN5c3RlbXMgYnV0IEkgYW0gc3VyZSB0aGF0IGlzIG5vdCBzb21ldGhpbmcgdGhhdCB3b3Vs
ZCB3b3JrIGluIGFsbCBzeXN0ZW1zIGFuZCBtdXN0IGZhbGwgb3V0c2lkZSB0aGUgcmVtaXQgb2Yg
UENJLVNJRyA7LSkuDQoNCkkgYWdyZWUgc3VjaCBhIGNhcGFiaWxpdHkgYml0IHdvdWxkIGJlIHZl
cnkgdXNlZnVsIGJ1dCBpdCdzIGdvaW5nIHRvIGJlIHF1aXRlIHNvbWUgdGltZSBiZWZvcmUgd2Ug
Y2FuIHJlbHkgb24gaGFyZHdhcmUgYmVpbmcgYXZhaWxhYmxlIHRoYXQgc3VwcG9ydHMgaXQuDQoN
ClN0ZXBoZW4NCiAgICANCg0K
