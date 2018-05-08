Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jerome Glisse <jglisse@redhat.com>, Logan Gunthorpe <logang@deltatee.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
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
	<dan.j.williams@intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Date: Tue, 8 May 2018 21:35:08 +0000
Message-ID: <F2F18B0F-8083-4A2C-AD21-58E460F5FD1B@raithlin.com>
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
In-Reply-To: <20180508205005.GC15608@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

SGkgSmVyb21lDQoNCj4gICAgSSB0aGluayB0aGVyZSBpcyBjb25mdXNpb24gaGVyZSwgQWxleCBw
cm9wZXJseSBleHBsYWluZWQgdGhlIHNjaGVtZQ0KPiAgIFBDSUUtZGV2aWNlIGRvIGEgQVRTIHJl
cXVlc3QgdG8gdGhlIElPTU1VIHdoaWNoIHJldHVybnMgYSB2YWxpZA0KPiAgICB0cmFuc2xhdGlv
biBmb3IgYSB2aXJ0dWFsIGFkZHJlc3MuIERldmljZSBjYW4gdGhlbiB1c2UgdGhhdCBhZGRyZXNz
DQo+ICAgIGRpcmVjdGx5IHdpdGhvdXQgZ29pbmcgdGhyb3VnaCBJT01NVSBmb3IgdHJhbnNsYXRp
b24uDQoNClRoaXMgbWFrZXMgc2Vuc2UgYW5kIHRvIGJlIGhvbmVzdCBJIG5vdyB1bmRlcnN0YW5k
IEFUUyBhbmQgaXRzIGludGVyYWN0aW9uIHdpdGggQUNTIGEgbG90IGJldHRlciB0aGFuIEkgZGlk
IDI0IGhvdXJzIGFnbyA7LSkuDQoNCj4gICAgQVRTIGlzIGltcGxlbWVudGVkIGJ5IHRoZSBJT01N
VSBub3QgYnkgdGhlIGRldmljZSAod2VsbCBkZXZpY2UgaW1wbGVtZW50DQo+ICAgIHRoZSBjbGll
bnQgc2lkZSBvZiBpdCkuIEFsc28gQVRTIGlzIG1lYW5pbmdsZXNzIHdpdGhvdXQgc29tZXRoaW5n
IGxpa2UNCj4gICAgUEFTSUQgYXMgZmFyIGFzIGkga25vdy4NCiAgICANCkkgdGhpbmsgaXQncyB0
aGUgY2xpZW50IHNpZGUgdGhhdCBpcyB3aGF0IGlzIGltcG9ydGFudCB0byB1cy4gTm90IG1hbnkg
RVBzIHN1cHBvcnQgQVRTIHRvZGF5IGFuZCBpdCdzIG5vdCBjbGVhciBpZiBtYW55IHdpbGwgaW4g
dGhlIGZ1dHVyZS4gIFNvIGFzc3VtaW5nIHdlIHdhbnQgdG8gZG8gcDJwZG1hIGJldHdlZW4gZGV2
aWNlcyAoc29tZSBvZikgd2hpY2ggZG8gTk9UIHN1cHBvcnQgQVRTIGhvdyBiZXN0IGRvIHdlIGhh
bmRsZSB0aGUgQUNTIGlzc3VlPyBEaXNhYmxpbmcgdGhlIElPTU1VIHNlZW1zIGEgYml0IHN0cm9u
ZyB0byBtZSBnaXZlbiB0aGlzIGltcGFjdHMgYWxsIHRoZSBQQ0kgZG9tYWlucyBpbiB0aGUgc3lz
dGVtIGFuZCBub3QganVzdCB0aGUgZG9tYWluIHdlIHdpc2ggdG8gZG8gUDJQIG9uLg0KDQpTdGVw
aGVuDQoNCg==
