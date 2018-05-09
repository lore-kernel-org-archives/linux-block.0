Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Logan Gunthorpe <logang@deltatee.com>, Dan Williams
	<dan.j.williams@intel.com>, Alex Williamson <alex.williamson@redhat.com>
CC: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jens Axboe
	<axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>, Sagi Grimberg
	<sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe
	<jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
	=?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Date: Wed, 9 May 2018 12:38:53 +0000
Message-ID: <BFD17865-3125-469C-B736-9A60D9B35B63@raithlin.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
 <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
 <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
 <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508144341.0441b676@w520.home>
 <a524127a-3557-3dff-971c-dfe94ba5a01c@deltatee.com>
 <20180508152631.50fd583c@w520.home>
 <354F7407-0DC7-470C-B9AA-74FDF9C46B08@raithlin.com>
 <20180508160336.0935ddde@w520.home>
 <20905682-9440-7d4b-0260-99d3dc794c3d@deltatee.com>
 <20180508163206.7d3bf383@w520.home>
 <CAPcyv4i1ksiu1pExF=EE21P2Wz1a9LaDaG247oG_WSbYgcR93g@mail.gmail.com>
 <2ce7908d-1422-55f8-aeba-94ccce2cb484@deltatee.com>
In-Reply-To: <2ce7908d-1422-55f8-aeba-94ccce2cb484@deltatee.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

SGkgTG9nYW4NCg0KPiAgICBZZWFoLCBJJ20gaGF2aW5nIGEgaGFyZCB0aW1lIGNvbWluZyB1cCB3
aXRoIGFuIGVhc3kgZW5vdWdoIHNvbHV0aW9uIGZvcg0KPiAgICB0aGUgdXNlci4gSSBhZ3JlZSB3
aXRoIERhbiB0aG91Z2gsIHRoZSBidXMgcmVudW1iZXJpbmcgcmlzayB3b3VsZCBiZQ0KPiAgICBm
YWlybHkgbG93IGluIHRoZSBjdXN0b20gaGFyZHdhcmUgc2VlaW5nIHRoZSBzd2l0Y2hlcyBhcmUg
bGlrZWx5IGdvaW5nDQo+ICAgIHRvIGJlIGRpcmVjdGx5IHNvbGRlcmVkIHRvIHRoZSBzYW1lIGJv
YXJkIHdpdGggdGhlIENQVS4NCiAgICANCkkgYW0gYWZyYWlkIHRoYXQgc29sZGVyZWQgZG93biBh
c3N1bXB0aW9uIG1heSBub3QgYmUgdmFsaWQuIE1vcmUgYW5kIG1vcmUgUENJZSBjYXJkcyB3aXRo
IFBDSWUgc3dpdGNoZXMgb24gdGhlbSBhcmUgYmVjb21pbmcgYXZhaWxhYmxlIGFuZCBwZW9wbGUg
YXJlIHVzaW5nIHRoZXNlIHRvIGNvbm5lY3Qgc2VydmVycyB0byBhcnJheXMgb2YgTlZNZSBTU0Rz
IHdoaWNoIG1heSBtYWtlIHRoZSB0b3BvbG9neSBtb3JlIGR5bmFtaWMuDQoNClN0ZXBoZW4NCg0K
