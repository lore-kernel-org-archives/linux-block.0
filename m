Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Logan Gunthorpe <logang@deltatee.com>,
	=?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Jerome
 Glisse" <jglisse@redhat.com>
CC: Alex Williamson <alex.williamson@redhat.com>, Bjorn Helgaas
	<helgaas@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jens Axboe
	<axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>, Sagi Grimberg
	<sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe
	<jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>, Dan Williams
	<dan.j.williams@intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Date: Thu, 10 May 2018 17:11:14 +0000
Message-ID: <868B49CE-4F0E-4A48-BE78-12149F85F1A4@raithlin.com>
References: <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
 <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
 <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
 <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
 <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
 <4e0d0b96-ab02-2662-adf3-fa956efd294c@deltatee.com>
 <2fc61d29-9eb4-d168-a3e5-955c36e5d821@amd.com>
 <94C8FE12-7FC3-48BD-9DCA-E6A427E71810@raithlin.com>
 <f0101988-cf82-7ffb-2aca-d3b8d2f4b504@deltatee.com>
In-Reply-To: <f0101988-cf82-7ffb-2aca-d3b8d2f4b504@deltatee.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

PiBOb3QgdG8gbWUuIEluIHRoZSBwMnBkbWEgY29kZSB3ZSBzcGVjaWZpY2FsbHkgcHJvZ3JhbSBE
TUEgZW5naW5lcyB3aXRoDQo+IHRoZSBQQ0kgYnVzIGFkZHJlc3MuIA0KDQpBaCB5ZXMgb2YgY291
cnNlLiBCcmFpbiBmYXJ0IG9uIG15IHBhcnQuIFdlIGFyZSBub3QgcHJvZ3JhbW1pbmcgdGhlIFAy
UERNQSBpbml0aWF0b3Igd2l0aCBhbiBJT1ZBIGJ1dCB3aXRoIHRoZSBQQ0kgYnVzIGFkZHJlc3Mu
Li4NCg0KPiBTbyByZWdhcmRsZXNzIG9mIHdoZXRoZXIgd2UgYXJlIHVzaW5nIHRoZSBJT01NVSBv
cg0KPiBub3QsIHRoZSBwYWNrZXRzIHdpbGwgYmUgZm9yd2FyZGVkIGRpcmVjdGx5IHRvIHRoZSBw
ZWVyLiBJZiB0aGUgQUNTDQo+ICBSZWRpciBiaXRzIGFyZSBvbiB0aGV5IHdpbGwgYmUgZm9yY2Vk
IGJhY2sgdG8gdGhlIFJDIGJ5IHRoZSBzd2l0Y2ggYW5kDQo+ICB0aGUgdHJhbnNhY3Rpb24gd2ls
bCBmYWlsLiBJZiB3ZSBjbGVhciB0aGUgQUNTIGJpdHMsIHRoZSBUTFBzIHdpbGwgZ28NCj4gIHdo
ZXJlIHdlIHdhbnQgYW5kIGV2ZXJ5dGhpbmcgd2lsbCB3b3JrIChidXQgd2UgbG9zZSB0aGUgaXNv
bGF0aW9uIG9mIEFDUykuDQoNCkFncmVlZC4NCiAgICANCj4gICAgRm9yIEVQcyB0aGF0IHN1cHBv
cnQgQVRTLCB3ZSBzaG91bGQgKGJ1dCBkb24ndCBuZWNlc3NhcmlseSBoYXZlIHRvKQ0KPiAgICBw
cm9ncmFtIHRoZW0gd2l0aCB0aGUgSU9WQSBhZGRyZXNzIHNvIHRoZXkgY2FuIGdvIHRocm91Z2gg
dGhlDQo+ICAgIHRyYW5zbGF0aW9uIHByb2Nlc3Mgd2hpY2ggd2lsbCBhbGxvdyBQMlAgd2l0aG91
dCBkaXNhYmxpbmcgdGhlIEFDUyBSZWRpcg0KPiAgICBiaXRzIC0tIHByb3ZpZGVkIHRoZSBBQ1Mg
ZGlyZWN0IHRyYW5zbGF0aW9uIGJpdCBpcyBzZXQuIChBbmQgYnR3LCBpZiBpdA0KPiAgICBpcywg
dGhlbiB3ZSBsb3NlIHRoZSBiZW5lZml0IG9mIEFDUyBwcm90ZWN0aW5nIGFnYWluc3QgbWFsaWNp
b3VzIEVQcykuDQo+ICAgIEJ1dCwgcGVyIGFib3ZlLCB0aGUgQVRTIHRyYW5zYWN0aW9uIHNob3Vs
ZCBpbnZvbHZlIG9ubHkgdGhlIElPVkEgYWRkcmVzcw0KPiAgICBzbyB0aGUgQUNTIGJpdHMgbm90
IGJlaW5nIHNldCBzaG91bGQgbm90IGJyZWFrIEFUUy4NCiAgICANCldlbGwgd2Ugd291bGQgc3Rp
bGwgaGF2ZSB0byBjbGVhciBzb21lIEFDUyBiaXRzIGJ1dCBub3cgd2UgY2FuIGNsZWFyIG9ubHkg
Zm9yIHRyYW5zbGF0ZWQgYWRkcmVzc2VzLg0KDQpTdGVwaGVuDQogICAgDQoNCg==
