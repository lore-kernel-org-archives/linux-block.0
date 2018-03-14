Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Logan Gunthorpe <logang@deltatee.com>
CC: Sinan Kaya <okaya@codeaurora.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jens Axboe
	<axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>, Sagi Grimberg
	<sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe
	<jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>, Dan Williams
	<dan.j.williams@intel.com>, =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?=
	<jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Alex Williamson" <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Date: Wed, 14 Mar 2018 14:05:06 +0000
Message-ID: <45A47A71-B435-4DFA-8925-8EB91CEAB230@raithlin.com>
References: <3e738f95-d73c-4182-2fa1-8664aafb1ab7@deltatee.com>
 <703aa92c-0c1c-4852-5887-6f6e6ccde0fb@codeaurora.org>
 <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org>
 <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
 <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org>
 <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
 <BB94077B-7EB3-49C4-862D-BF77D0A692CC@raithlin.com>
 <20180313230850.GA45763@bhelgaas-glaptop.roam.corp.google.com>
 <8de5d3dd-a78f-02d5-0eea-4365364143b6@deltatee.com>
 <20180314025639.GA50067@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180314025639.GA50067@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

PkkgYXNzdW1lIHlvdSB3YW50IHRvIGV4Y2x1ZGUgUm9vdCBQb3J0cyBiZWNhdXNlIG9mIG11bHRp
LWZ1bmN0aW9uDQo+ICBkZXZpY2VzIGFuZCB0aGUgInJvdXRlIHRvIHNlbGYiIGVycm9yLiAgSSB3
YXMgaG9waW5nIGZvciBhIHJlZmVyZW5jZQ0KPiAgdG8gdGhhdCBzbyBJIGNvdWxkIGxlYXJuIG1v
cmUgYWJvdXQgaXQuDQoNCkFwb2xvZ2llcyBCam9ybi4gVGhpcyBzbGlwcGVkIHRocm91Z2ggbXkg
bmV0LiBJIHdpbGwgdHJ5IGFuZCBnZXQgeW91IGEgcmVmZXJlbmNlIGZvciBSVFMgaW4gdGhlIG5l
eHQgY291cGxlIG9mIGRheXMuDQogICAgDQo+IFdoaWxlIEkgd2FzIGxvb2tpbmcgZm9yIGl0LCBJ
IGZvdW5kIHNlYyA2LjEyLjEuMiAoUENJZSByNC4wKSwgIkFDUw0KPiBGdW5jdGlvbnMgaW4gU1It
SU9WIENhcGFibGUgYW5kIE11bHRpLUZ1bmN0aW9uIERldmljZXMiLCB3aGljaCBzZWVtcw0KPiBy
ZWxldmFudC4gIEl0IHRhbGtzIGFib3V0ICJwZWVyLXRvLXBlZXIgUmVxdWVzdHMgKGJldHdlZW4g
RnVuY3Rpb25zIG9mDQo+IHRoZSBkZXZpY2UpIi4gIFRoYXkgc2F5cyB0byBtZSB0aGF0IG11bHRp
LWZ1bmN0aW9uIGRldmljZXMgY2FuIERNQQ0KPiBiZXR3ZWVuIHRoZW1zZWx2ZXMuDQogICAgDQpJ
IHdpbGwgZ28gdGFrZSBhIGxvb2suIEFwcHJlY2lhdGUgdGhlIGxpbmsuDQoNClN0ZXBoZW4gDQoN
Cg==
