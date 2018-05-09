Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Don Dutile <ddutile@redhat.com>, Alex Williamson
	<alex.williamson@redhat.com>
CC: Logan Gunthorpe <logang@deltatee.com>,
	=?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Bjorn
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
Date: Wed, 9 May 2018 12:44:21 +0000
Message-ID: <C6D0BD3A-FA82-425A-899C-C2DBDCBC7EEC@raithlin.com>
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
 <11819753-af26-4632-8580-d4a47127a3b2@redhat.com>
In-Reply-To: <11819753-af26-4632-8580-d4a47127a3b2@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

SGkgRG9uDQoNCj4gICAgUkRNQSBWRnMgbGVuZCB0aGVtc2VsdmVzIHRvIE5WTUVvRiB3L2Rldmlj
ZS1hc3NpZ25tZW50Li4uLiBuZWVkIGEgd2F5IHRvDQo+ICAgIHB1dCBOVk1FICdyZXNvdXJjZXMn
IGludG8gYW4gYXNzaWduYWJsZS9tYW5hZ2VhYmxlIG9iamVjdCBmb3IgJ0lPTU1VLWdyb3VwaW5n
JywNCj4gICAgd2hpY2ggaXMgcmVhbGx5IGEgJ0RNQSBzZWN1cml0eSBkb21haW4nIGFuZCBsZXNz
IGFuICdJT01NVSBncm91cGluZyBkb21haW4nLg0KICAgIA0KSGEsIEkgbGlrZSB5b3VyIHRlcm0g
IkRNQSBTZWN1cml0eSBEb21haW4iIHdoaWNoIHNvdW5kcyBhYm91dCByaWdodCBmb3Igd2hhdCB3
ZSBhcmUgZGlzY3Vzc2luZyB3aXRoIHAycGRtYSBhbmQgQUNTIGRpc2FibGVtZW50IDstKS4gVGhl
IHByb2JsZW0gaXMgdGhhdCBBQ1MgaXMsIGluIHNvbWUgd2F5cywgdG9vIGJpZyBvZiBoYW1tZXIg
Zm9yIHdoYXQgd2Ugd2FudCBoZXJlIGluIHRoZSBzZW5zZSB0aGF0IGl0IGlzIGVpdGhlciBvbiBv
ciBvZmYgZm9yIHRoZSBicmlkZ2Ugb3IgTUYgRVAgd2UgZW5hYmxlL2Rpc2FibGUgaXQgZm9yLiBB
Q1MgY2FuJ3QgZmlsdGVyIHRoZSBUTFBzIGJ5IGFkZHJlc3Mgb3IgSUQgdGhvdWdoIFBDSS1TSUcg
YXJlIGhhdmluZyBzb21lIGRpc2N1c3Npb25zIG9uIGV4dGVuZGluZyBBQ1MuIFRoYXQncyBhIGxv
bmcgdGVybSBzb2x1dGlvbiBhbmQgd29uJ3QgYmUgYXBwbGljYWJsZSB0byB1cyBmb3Igc29tZSB0
aW1lLg0KDQpOVk1lIFNTRHMgdGhhdCBzdXBwb3J0IFNSLUlPViBhcmUgY29taW5nIHRvIG1hcmtl
dCBidXQgd2UgY2FuJ3QgYXNzdW1lIGFsbCBOVk1lIFNTRHMgd2l0aCBzdXBwb3J0IFNSLUlPVi4g
VGhhdCB3aWxsIHByb2JhYmx5IGJlIGEgcHJldHR5IGhpZ2ggZW5kLWZlYXR1cmUuLi4NCg0KU3Rl
cGhlbg0KICAgIA0KICAgIA0KDQo=
