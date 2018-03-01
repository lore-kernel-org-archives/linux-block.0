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
Date: Thu, 1 Mar 2018 23:53:16 +0000
Message-ID: <6B6A0FD9-14F5-4AF2-A74A-DAA562C34AB9@raithlin.com>
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

PiBUaGVyZSdzIGEgbWVhbmluZ2Z1bCBkaWZmZXJlbmNlIGJldHdlZW4gd3JpdGluZyB0byBhbiBO
Vk1lIENNQiB2cyBQTVINCg0KV2hlbiB0aGUgUE1SIHNwZWMgYmVjb21lcyBwdWJsaWMgd2UgY2Fu
IGRpc2N1c3MgaG93IGJlc3QgdG8gaW50ZWdyYXRlIGl0IGludG8gdGhlIFAyUCBmcmFtZXdvcmsg
KGlmIGF0IGFsbCkgOy0pLg0KDQpTdGVwaGVuDQoNCiAgICANCg0K
