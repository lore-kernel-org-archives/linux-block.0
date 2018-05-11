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
Date: Fri, 11 May 2018 21:50:03 +0000
Message-ID: <A50EA568-81E7-4AD7-8C1B-1029FEA92F49@raithlin.com>
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
 <868B49CE-4F0E-4A48-BE78-12149F85F1A4@raithlin.com>
 <8113cba8-62b9-1801-7a77-f82be223b183@deltatee.com>
 <cf2b92c9-7c5b-f19c-b5b1-2f2d435296d1@amd.com>
 <53fa38ce-40dd-6bc1-9b83-c6ccf228b755@deltatee.com>
In-Reply-To: <53fa38ce-40dd-6bc1-9b83-c6ccf228b755@deltatee.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

PiAgICBJIGZpbmQgdGhpcyBoYXJkIHRvIGJlbGlldmUuIFRoZXJlJ3MgYWx3YXlzIHRoZSBwb3Nz
aWJpbGl0eSB0aGF0IHNvbWUgDQo+ICAgIHBhcnQgb2YgdGhlIHN5c3RlbSBkb2Vzbid0IHN1cHBv
cnQgQUNTIHNvIGlmIHRoZSBQQ0kgYnVzIGFkZHJlc3NlcyBhbmQgDQo+ICAgIElPVkEgb3Zlcmxh
cCB0aGVyZSdzIGEgZ29vZCBjaGFuY2UgdGhhdCBQMlAgYW5kIEFUUyB3b24ndCB3b3JrIGF0IGFs
bCBvbiANCj4gICAgc29tZSBoYXJkd2FyZS4NCg0KSSB0ZW5kIHRvIGFncmVlIGJ1dCB0aGlzIGNv
bWVzIGRvd24gdG8gaG93IElPVkEgYWRkcmVzc2VzIGFyZSBnZW5lcmF0ZWQgaW4gdGhlIGtlcm5l
bC4gQWxleCAob3IgYW55b25lIGVsc2UpIGNhbiB5b3UgcG9pbnQgdG8gd2hlcmUgSU9WQSBhZGRy
ZXNzZXMgYXJlIGdlbmVyYXRlZD8gQXMgTG9nYW4gc3RhdGVkIGVhcmxpZXIsIHAycGRtYSBieXBh
c3NlcyB0aGlzIGFuZCBwcm9ncmFtcyB0aGUgUENJIGJ1cyBhZGRyZXNzIGRpcmVjdGx5IGJ1dCBv
dGhlciBJTyBnb2luZyB0byB0aGUgc2FtZSBQQ0kgRVAgbWF5IGZsb3cgdGhyb3VnaCB0aGUgSU9N
TVUgYW5kIGJlIHByb2dyYW1tZWQgd2l0aCBJT1ZBIHJhdGhlciB0aGFuIFBDSSBidXMgYWRkcmVz
c2VzLg0KICAgIA0KPiBJIHByZWZlciANCj4gICAgdGhlIG9wdGlvbiB0byBkaXNhYmxlIHRoZSBB
Q1MgYml0IG9uIGJvb3QgYW5kIGxldCB0aGUgZXhpc3RpbmcgY29kZSBwdXQgDQo+ICAgIHRoZSBk
ZXZpY2VzIGludG8gdGhlaXIgb3duIElPTU1VIGdyb3VwIChhcyBpdCBzaG91bGQgYWxyZWFkeSBk
byB0byANCj4gICAgc3VwcG9ydCBoYXJkd2FyZSB0aGF0IGRvZXNuJ3QgaGF2ZSBBQ1Mgc3VwcG9y
dCkuDQogICAgDQorMQ0KDQpTdGVwaGVuDQogICAgDQoNCg==
