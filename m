Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Logan Gunthorpe <logang@deltatee.com>, Alex Williamson
	<alex.williamson@redhat.com>
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
	<jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>, Dan Williams
	<dan.j.williams@intel.com>, =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?=
	<jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Date: Tue, 8 May 2018 22:25:06 +0000
Message-ID: <C3CEE4DB-A001-4E4C-B9B9-4B160E4C5367@raithlin.com>
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
In-Reply-To: <20905682-9440-7d4b-0260-99d3dc794c3d@deltatee.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

PiAgICBZZWFoLCBzbyBiYXNlZCBvbiB0aGUgZGlzY3Vzc2lvbiBJJ20gbGVhbmluZyB0b3dhcmQg
anVzdCBoYXZpbmcgYQ0KPiAgICBjb21tYW5kIGxpbmUgb3B0aW9uIHRoYXQgdGFrZXMgYSBsaXN0
IG9mIEJERnMgYW5kIGRpc2FibGVzIEFDUyBmb3IgdGhlbS4NCj4gICAgKEVzc2VudGlhbGx5IGFz
IERhbiBoYXMgc3VnZ2VzdGVkLikgVGhpcyBhdm9pZHMgdGhlIHNob3RndW4uDQoNCkkgY29uY3Vy
IHRoYXQgdGhpcyBzZWVtcyB0byBiZSB3aGVyZSB0aGUgY29udmVyc2F0aW9uIGlzIHRha2luZyB1
cy4NCg0KQEFsZXggLSBCZWZvcmUgd2UgZ28gZG8gdGhpcyBjYW4geW91IHByb3ZpZGUgaW5wdXQg
b24gdGhlIGFwcHJvYWNoPyBJIGRvbid0IHdhbnQgdG8gcmUtc3BpbiBvbmx5IHRvIGZpbmQgd2Ug
YXJlIHN0aWxsIG5vdCBjb252ZXJnaW5nIG9uIHRoZSBBQ1MgaXNzdWUuLi4uDQoNClRoYW5rcw0K
DQpTdGVwaGVuDQogICAgDQoNCg==
