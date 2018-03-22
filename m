Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Logan Gunthorpe <logang@deltatee.com>, Sinan Kaya <okaya@codeaurora.org>,
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
	<benh@kernel.crashing.org>, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Date: Thu, 22 Mar 2018 22:57:32 +0000
Message-ID: <C90AA66C-FFC6-4CCA-B959-7BBECA65509C@raithlin.com>
References: <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <52cbbbc4-c488-f83f-8d02-14d455b4efd7@codeaurora.org>
 <3e738f95-d73c-4182-2fa1-8664aafb1ab7@deltatee.com>
 <703aa92c-0c1c-4852-5887-6f6e6ccde0fb@codeaurora.org>
 <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org>
 <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
 <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org>
 <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
 <BB94077B-7EB3-49C4-862D-BF77D0A692CC@raithlin.com>
 <20180313230850.GA45763@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180313230850.GA45763@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

PiAgSSd2ZSBzZWVuIHRoZSByZXNwb25zZSB0aGF0IHBlZXJzIGRpcmVjdGx5IGJlbG93IGEgUm9v
dCBQb3J0IGNvdWxkIG5vdA0KPiBETUEgdG8gZWFjaCBvdGhlciB0aHJvdWdoIHRoZSBSb290IFBv
cnQgYmVjYXVzZSBvZiB0aGUgInJvdXRlIHRvIHNlbGYiDQo+IGlzc3VlLCBhbmQgSSdtIG5vdCBk
aXNwdXRpbmcgdGhhdC4gIA0KDQpCam9ybiANCg0KWW91IGFza2VkIG1lIGZvciBhIHJlZmVyZW5j
ZSB0byBSVFMgaW4gdGhlIFBDSWUgc3BlY2lmaWNhdGlvbi4gQXMgbHVjayB3b3VsZCBoYXZlIGl0
IEkgZW5kZWQgdXAgaW4gYW4gSXJpc2ggYmFyIHdpdGggUGV0ZXIgT251ZnJ5ayB0aGlzIHdlZWsg
YXQgT0NQIFN1bW1pdC4gV2UgZGlzY3Vzc2VkIHRoZSB0b3BpYy4gSXQgaXMgbm90IGV4cGxpY2l0
bHkgcmVmZXJyZWQgdG8gYXMgIlJvdXRlIHRvIFNlbGYiIGFuZCBpdCdzIGNlcnRhaW5seSBub3Qg
ZXhwbGljaXQgKG9yIG9idmlvdXMpIGJ1dCByNi4yLjguMSBvZiB0aGUgUENJZSA0LjAgc3BlY2lm
aWNhdGlvbiBkaXNjdXNzZXMgZXJyb3IgY29uZGl0aW9ucyBmb3IgdmlydHVhbCBQQ0kgYnJpZGdl
cy4gT25lIG9mIHRoZXNlIGNvbmRpdGlvbnMgKGdpdmVuIGluIHRoZSB2ZXJ5IGZpcnN0IGJ1bGxl
dCBpbiB0aGF0IHNlY3Rpb24pIGFwcGxpZXMgdG8gYSByZXF1ZXN0IHRoYXQgaXMgZGVzdGluZWQg
Zm9yIHRoZSBzYW1lIHBvcnQgaXQgY2FtZSBpbiBvbi4gV2hlbiB0aGlzIG9jY3VycyB0aGUgcmVx
dWVzdCBtdXN0IGJlIHRlcm1pbmF0ZWQgYXMgYSBVUi4NCg0KU3RlcGhlbg0KDQoNCg==
