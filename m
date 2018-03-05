Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jerome Glisse <jglisse@redhat.com>
CC: Logan Gunthorpe <logang@deltatee.com>, Benjamin Herrenschmidt
	<benh@au1.ibm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jens Axboe
	<axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>, Sagi Grimberg
	<sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe
	<jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>, Dan Williams
	<dan.j.williams@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
	Oliver OHalloran <oliveroh@au1.ibm.com>
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
Date: Mon, 5 Mar 2018 20:36:03 +0000
Message-ID: <F78D688D-BB93-4BFB-9F2B-9809278CC25C@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <8e808448-fc01-5da0-51e7-1a6657d5a23a@deltatee.com>
 <1519936195.4592.18.camel@au1.ibm.com> <20180301205548.GA6742@redhat.com>
 <a512edf9-2d96-9229-fe60-e0ea60b3922b@deltatee.com>
 <20180301211036.GB6742@redhat.com>
 <8D3B5C26-39E0-478D-B51F-A22B3F36C4D7@raithlin.com>
 <20180302220950.GA6148@redhat.com>
In-Reply-To: <20180302220950.GA6148@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

PiAgICBZZXMgaSBuZWVkIHRvIGRvY3VtZW50IHRoYXQgc29tZSBtb3JlIGluIGhtbS50eHQuLi4N
Cg0KSGkgSmVybW9uZSwgdGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24uIENhbiBJIHN1Z2dlc3Qg
eW91IHVwZGF0ZSBobW0udHh0IHdpdGggd2hhdCB5b3Ugc2VudCBvdXQ/DQoNCj4gIEkgYW0gYWJv
dXQgdG8gc2VuZCBSRkMgZm9yIG5vdXZlYXUsIGkgYW0gc3RpbGwgd29ya2luZyBvdXQgc29tZSBi
dWdzLg0KDQpHcmVhdC4gSSB3aWxsIGtlZXAgYW4gZXllIG91dCBmb3IgaXQuIEFuIGV4YW1wbGUg
dXNlciBvZiBobW0gd2lsbCBiZSB2ZXJ5IGhlbHBmdWwuDQoNCj4gaSB3aWxsIGZpeCB0aGUgTUFJ
TlRBSU5FUlMgYXMgcGFydCBvZiB0aG9zZS4NCiAgICANCkF3ZXNvbWUsIHRoYW5rcy4NCg0KU3Rl
cGhlbg0KICAgIA0KDQo=
