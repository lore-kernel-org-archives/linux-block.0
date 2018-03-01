Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Keith Busch <keith.busch@intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>,
	Sagi Grimberg <sagi@grimberg.me>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jens Axboe
	<axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy
	<maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
	=?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Alex Williamson <alex.williamson@redhat.com>,
	Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
Date: Thu, 1 Mar 2018 23:57:43 +0000
Message-ID: <CE2A5D93-E735-4414-8DC1-B308B74A1C5B@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
 <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
 <20180301184249.GI19007@ziepe.ca>
 <edaf476a-cfe9-0598-1aa5-14802a9a1477@deltatee.com>
 <20180301224540.GL19007@ziepe.ca>
 <77591162-4CCD-446E-A27C-1CDB4996ACB7@raithlin.com>
 <20180301234930.GG14799@localhost.localdomain>
In-Reply-To: <20180301234930.GG14799@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

PiBXZSBkb24ndCB3YW50IHRvIGx1bXAgdGhlc2UgYWxsIHRvZ2V0aGVyIHdpdGhvdXQga25vd2lu
ZyB3aGljaCByZWdpb24geW91J3JlIGFsbG9jYXRpbmcgZnJvbSwgcmlnaHQ/DQoNCkluIGFsbCBz
ZXJpb3VzbmVzcyBJIGRvIGFncmVlIHdpdGggeW91IG9uIHRoZXNlIEtlaXRoIGluIHRoZSBsb25n
IHRlcm0uIFdlIHdvdWxkIGNvbnNpZGVyIGFkZGluZyBwcm9wZXJ0eSBmbGFncyBmb3IgdGhlIG1l
bW9yeSBhcyBpdCBpcyBhZGRlZCB0byB0aGUgcDJwIGNvcmUgYW5kIHRoZW4gdGhlIGFsbG9jYXRv
ciBjb3VsZCBldm9sdmUgdG8gaW50ZWxsaWdlbnRseSBkaXNoIGl0IG91dC4gQXR0cmlidXRlcyBs
aWtlIGVuZHVyYW5jZSwgbGF0ZW5jeSBhbmQgc3BlY2lhbCB3cml0ZSBjb21taXQgcmVxdWlyZW1l
bnRzIGNvdWxkIGFsbCBiZWNvbWUgYXR0cmlidXRlcyBpbiB0aW1lLiBQZXJoYXBzIG9uZSBtb3Jl
IHJlYXNvbiBmb3IgYSBjZW50cmFsIGVudGl0eSBmb3IgcDJwIG1lbW9yeSBhbGxvY2F0aW9uIHNv
IHRoaXMgY29kZSBkb2VzIG5vdCBlbmQgdXAgaGF2aW5nIHRvIGdvIGludG8gbWFueSBkaWZmZXJl
bnQgZHJpdmVycz8NCg0KU3RlcGhlbg0KICAgIA0KDQo=
