Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jerome Glisse <jglisse@redhat.com>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
	<christian.koenig@amd.com>
CC: Logan Gunthorpe <logang@deltatee.com>, Alex Williamson
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
Date: Thu, 10 May 2018 18:44:25 +0000
Message-ID: <0E894398-041D-4FA6-966F-BB37866A9AF2@raithlin.com>
References: <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
 <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
 <1775CC56-4651-422F-953A-18E024D3717C@raithlin.com>
 <20180509160722.GB4140@redhat.com>
 <366A8132-B88A-40F7-BDE3-DA542E45FC0C@raithlin.com>
 <20180509174952.GC4140@redhat.com>
 <405531AE-8315-4A4F-9B0C-8DBE49BFCAB4@raithlin.com>
 <73b6a454-bf84-1640-0b5e-137d03c0ad8c@amd.com>
 <20180510145946.GB3652@redhat.com>
In-Reply-To: <20180510145946.GB3652@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

SGkgSmVyb21lDQoNCj4gICAgSG9wZXMgdGhpcyBoZWxwcyB1bmRlcnN0YW5kaW5nIHRoZSBiaWcg
cGljdHVyZS4gSSBvdmVyIHNpbXBsaWZ5IHRoaW5nIGFuZA0KPiAgICBkZXZpbHMgaXMgaW4gdGhl
IGRldGFpbHMuDQogICAgDQpUaGlzIHdhcyBhIGdyZWF0IHByaW1lciB0aGFua3MgZm9yIHB1dHRp
bmcgaXQgdG9nZXRoZXIuIEFuIExXTi5uZXQgYXJ0aWNsZSBwZXJoYXBzIDstKT8/DQoNClN0ZXBo
ZW4NCiAgICANCg0K
