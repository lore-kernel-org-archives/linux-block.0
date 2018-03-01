Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jerome Glisse <jglisse@redhat.com>, Logan Gunthorpe <logang@deltatee.com>
CC: Benjamin Herrenschmidt <benh@au1.ibm.com>, "linux-kernel@vger.kernel.org"
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
Date: Thu, 1 Mar 2018 21:37:00 +0000
Message-ID: <EA9224B2-3B12-4F31-9602-DEAF9869A242@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <8e808448-fc01-5da0-51e7-1a6657d5a23a@deltatee.com>
 <1519936195.4592.18.camel@au1.ibm.com> <20180301205548.GA6742@redhat.com>
 <a512edf9-2d96-9229-fe60-e0ea60b3922b@deltatee.com>
 <20180301211036.GB6742@redhat.com>
In-Reply-To: <20180301211036.GB6742@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

PiBUaGUgaW50ZW50aW9uIG9mIEhNTSBpcyB0byBiZSB1c2VmdWwgZm9yIGFsbCBkZXZpY2UgbWVt
b3J5IHRoYXQgd2lzaA0KPiB0byBoYXZlIHN0cnVjdCBwYWdlIGZvciB2YXJpb3VzIHJlYXNvbnMu
DQoNCkhpIEplcm1vbmUgYW5kIHRoYW5rcyBmb3IgeW91ciBpbnB1dCEgVW5kZXJzdG9vZC4gV2Ug
aGF2ZSBsb29rZWQgYXQgSE1NIGluIHRoZSBwYXN0IGFuZCBsb25nIHRlcm0gSSBkZWZpbml0ZWx5
IHdvdWxkIGxpa2UgdG8gY29uc2lkZXIgaG93IHdlIGNhbiBhZGQgUDJQIGZ1bmN0aW9uYWxpdHkg
dG8gSE1NIGZvciBib3RoIERFVklDRV9QUklWQVRFIGFuZCBERVZJQ0VfUFVCTElDIHNvIHdlIGNh
biBwYXNzIGFkZHJlc3NhYmxlIGFuZCBub24tYWRkcmVzc2FibGUgYmxvY2tzIG9mIGRhdGEgYmV0
d2VlbiBkZXZpY2VzLiBIb3dldmVyIHRoYXQgaXMgd2VsbCBiZXlvbmQgdGhlIGludGVudGlvbnMg
b2YgdGhpcyBzZXJpZXMgOy0pLg0KDQpTdGVwaGVuDQogICAgDQoNCg==
