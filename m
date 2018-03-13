Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Logan Gunthorpe <logang@deltatee.com>, Sinan Kaya <okaya@codeaurora.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas
	<bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy
	<maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
	=?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Date: Tue, 13 Mar 2018 22:31:55 +0000
Message-ID: <BB94077B-7EB3-49C4-862D-BF77D0A692CC@raithlin.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
 <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <52cbbbc4-c488-f83f-8d02-14d455b4efd7@codeaurora.org>
 <3e738f95-d73c-4182-2fa1-8664aafb1ab7@deltatee.com>
 <703aa92c-0c1c-4852-5887-6f6e6ccde0fb@codeaurora.org>
 <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org>
 <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
 <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org>
 <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
In-Reply-To: <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Pj4gSXQgc291bmRzIGxpa2UgeW91IGhhdmUgdmVyeSB0aWdodCBoYXJkd2FyZSBleHBlY3RhdGlv
bnMgZm9yIHRoaXMgdG8gd29yaw0KPj4gYXQgdGhpcyBtb21lbnQuIFlvdSBhbHNvIGRvbid0IHdh
bnQgdG8gZ2VuZXJhbGl6ZSB0aGlzIGNvZGUgZm9yIG90aGVycyBhbmQNCj4+IGFkZHJlc3MgdGhl
IHNob3J0Y29taW5ncy4NCj4gIE5vLCB0aGF0J3MgdGhlIHdheSB0aGUgY29tbXVuaXR5IGhhcyBw
dXNoZWQgdGhpcyB3b3JrDQoNCkhpIFNpbmFuDQoNClRoYW5rcyBmb3IgYWxsIHRoZSBpbnB1dC4g
QXMgTG9nYW4gaGFzIHBvaW50ZWQgb3V0IHRoZSBzd2l0Y2ggcmVxdWlyZW1lbnQgaXMgc29tZXRo
aW5nIHRoYXQgaGFzIGV2b2x2ZWQgb3ZlciB0aW1lIGJhc2VkIG9uIGlucHV0IGZyb20gdGhlIGNv
bW11bml0eS4gWW91IGFyZSBtb3JlIHRoYW4gd2VsY29tZSB0byBoYXZlIGFuIG9waW5pb24gb24g
dGhpcyAoYW5kIHlvdSBoYXZlIG1hZGUgdGhhdCBvcGluaW9uIGNsZWFyIDstKSkuIE92ZXIgdGlt
ZSB0aGUgcGF0Y2hzZXQgbWF5IGV2b2x2ZSBmcm9tIGl0cyBjdXJyZW50IHJlcXVpcmVtZW50cyBi
dXQgcmlnaHQgbm93IHdlIGFyZSBhbGlnbmVkIHdpdGggdGhlIGZlZWRiYWNrIGZyb20gdGhlIGNv
bW11bml0eS4NCg0KQ2hlZXJzDQoNClN0ZXBoZW4NCiANCg0K
