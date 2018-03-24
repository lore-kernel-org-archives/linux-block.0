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
Date: Sat, 24 Mar 2018 15:28:43 +0000
Message-ID: <121026DC-40C7-4F4E-BE27-BDA652BDEB6A@raithlin.com>
References: <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org>
 <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
 <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org>
 <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
 <BB94077B-7EB3-49C4-862D-BF77D0A692CC@raithlin.com>
 <20180313230850.GA45763@bhelgaas-glaptop.roam.corp.google.com>
 <C90AA66C-FFC6-4CCA-B959-7BBECA65509C@raithlin.com>
 <20180323215046.GC210003@bhelgaas-glaptop.roam.corp.google.com>
 <dc414fa5-1af9-0ba7-e12e-4cd9df313119@deltatee.com>
 <20180324034947.GE210003@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180324034947.GE210003@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

PiBUaGF0IHdvdWxkIGJlIHZlcnkgbmljZSBidXQgbWFueSBkZXZpY2VzIGRvIG5vdCBzdXBwb3J0
IHRoZSBpbnRlcm5hbA0KPiByb3V0ZS4gDQoNCkJ1dCBMb2dhbiBpbiB0aGUgTlZNZSBjYXNlIHdl
IGFyZSBkaXNjdXNzaW5nIG1vdmVtZW50IHdpdGhpbiBhIHNpbmdsZSBmdW5jdGlvbiAoaS5lLiBm
cm9tIGEgTlZNZSBuYW1lc3BhY2UgdG8gYSBOVk1lIENNQiBvbiB0aGUgc2FtZSBmdW5jdGlvbiku
IEJqb3JuIGlzIGRpc2N1c3NpbmcgbW92ZW1lbnQgYmV0d2VlbiB0d28gZnVuY3Rpb25zIChQRnMg
b3IgVkZzKSBpbiB0aGUgc2FtZSBQQ0llIEVQLiBJbiB0aGUgY2FzZSBvZiBtdWx0aS1mdW5jdGlv
biBlbmRwb2ludHMgSSB0aGluayB0aGUgc3RhbmRhcmQgcmVxdWlyZXMgdGhvc2UgZGV2aWNlcyB0
byBzdXBwb3J0IGludGVybmFsIERNQXMgZm9yIHRyYW5zZmVycyBiZXR3ZWVuIHRob3NlIGZ1bmN0
aW9ucyAoYnV0IGRvZXMgbm90IHJlcXVpcmUgaXQgd2l0aGluIGEgZnVuY3Rpb24pLg0KDQpTbyBJ
IHRoaW5rIHRoZSBzdW1tYXJ5IGlzOg0KDQoxLiBUaGVyZSBpcyBubyByZXF1aXJlbWVudCBmb3Ig
YSBzaW5nbGUgZnVuY3Rpb24gdG8gc3VwcG9ydCBpbnRlcm5hbCBETUFzIGJ1dCBpbiB0aGUgY2Fz
ZSBvZiBOVk1lIHdlIGRvIGhhdmUgYSBwcm90b2NvbCBzcGVjaWZpYyB3YXkgZm9yIGEgTlZNZSBm
dW5jdGlvbiB0byBpbmRpY2F0ZSBpdCBzdXBwb3J0cyB2aWEgdGhlIENNQiBCQVIuIE90aGVyIHBy
b3RvY29scyBtYXkgYWxzbyBoYXZlIHN1Y2ggbWV0aG9kcyBidXQgSSBhbSBub3QgYXdhcmUgb2Yg
dGhlbSBhdCB0aGlzIHRpbWUuDQoNCjIuIEZvciBtdWx0aS1mdW5jdGlvbiBlbmQtcG9pbnRzIEkg
dGhpbmsgaXQgaXMgYSByZXF1aXJlbWVudCB0aGF0IERNQXMgKmJldHdlZW4qIGZ1bmN0aW9ucyBh
cmUgc3VwcG9ydGVkIHZpYSBhbiBpbnRlcm5hbCBwYXRoIGJ1dCB0aGlzIGNhbiBiZSBvdmVyLXJp
ZGRlbiBieSBBQ1Mgd2hlbiBzdXBwb3J0ZWQgaW4gdGhlIEVQLg0KDQozLiBGb3IgbXVsdGktZnVu
Y3Rpb24gZW5kLXBvaW50cyB0aGVyZSBpcyBubyByZXF1aXJlbWVudCB0byBzdXBwb3J0IGludGVy
bmFsIERNQSB3aXRoaW4gZWFjaCBpbmRpdmlkdWFsIGZ1bmN0aW9uIChpLmUuIGEgbGEgcG9pbnQg
MSBidXQgZXh0ZW5kZWQgdG8gZWFjaCBmdW5jdGlvbiBpbiBhIE1GIGRldmljZSkuIA0KDQpCYXNl
ZCBvbiBteSByZXZpZXcgb2YgdGhlIHNwZWNpZmljYXRpb24gSSBjb25jdXIgd2l0aCBCam9ybiB0
aGF0IHAycGRtYSBiZXR3ZWVuIGZ1bmN0aW9ucyBpbiBhIE1GIGVuZC1wb2ludCBzaG91bGQgYmUg
YXNzdXJlZCB0byBiZSBzdXBwb3J0ZWQgdmlhIHRoZSBzdGFuZGFyZC4gSG93ZXZlciBpZiB0aGUg
cDJwZG1hIGludm9sdmVzIG9ubHkgYSBzaW5nbGUgZnVuY3Rpb24gaW4gYSBNRiBkZXZpY2UgdGhl
biB3ZSBjYW4gb25seSBzdXBwb3J0IE5WTWUgQ01CcyBmb3Igbm93LiBMZXQncyByZXZpZXcgYW5k
IHNlZSB3aGF0IHRoZSBvcHRpb25zIGFyZSBmb3Igc3VwcG9ydGluZyB0aGlzIGluIHRoZSBuZXh0
IHJlc3Bpbi4NCg0KU3RlcGhlbg0KDQoNCg==
