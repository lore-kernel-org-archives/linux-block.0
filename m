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
Date: Wed, 9 May 2018 13:12:53 +0000
Message-ID: <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
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

SmVyb21lIGFuZCBDaHJpc3RpYW4NCiAgICANCj4gSSB0aGluayB0aGVyZSBpcyBjb25mdXNpb24g
aGVyZSwgQWxleCBwcm9wZXJseSBleHBsYWluZWQgdGhlIHNjaGVtZQ0KPiBQQ0lFLWRldmljZSBk
byBhIEFUUyByZXF1ZXN0IHRvIHRoZSBJT01NVSB3aGljaCByZXR1cm5zIGEgdmFsaWQNCj4gdHJh
bnNsYXRpb24gZm9yIGEgdmlydHVhbCBhZGRyZXNzLiBEZXZpY2UgY2FuIHRoZW4gdXNlIHRoYXQg
YWRkcmVzcw0KPiBkaXJlY3RseSB3aXRob3V0IGdvaW5nIHRocm91Z2ggSU9NTVUgZm9yIHRyYW5z
bGF0aW9uLg0KDQpTbyBJIHdlbnQgdGhyb3VnaCBBVFMgaW4gdmVyc2lvbiA0LjByMSBvZiB0aGUg
UENJIHNwZWMuIEl0IGxvb2tzIGxpa2UgZXZlbiBhIEFUUyB0cmFuc2xhdGVkIFRMUCBpcyBzdGls
bCBpbXBhY3RlZCBieSBBQ1MgdGhvdWdoIGl0IGhhcyBhIHNlcGFyYXRlIGNvbnRyb2wga25vYiBm
b3IgdHJhbnNsYXRlZCBhZGRyZXNzIFRMUHMgKHNlZSA3LjcuNy4yIG9mIDQuMHIxIG9mIHRoZSBz
cGVjKS4gU28gZXZlbiBpZiB5b3VyIGRldmljZSBzdXBwb3J0cyBBVFMgYSBQMlAgRE1BIHdpbGwg
c3RpbGwgYmUgcm91dGVkIHRvIHRoZSBhc3NvY2lhdGVkIFJQIG9mIHRoZSBkb21haW4gYW5kIGRv
d24gYWdhaW4gdW5sZXNzIHdlIGRpc2FibGUgQUNTIERUIFAyUCBvbiBhbGwgYnJpZGdlcyBiZXR3
ZWVuIHRoZSB0d28gZGV2aWNlcyBpbnZvbHZlZCBpbiB0aGUgUDJQIERNQS4gDQoNClNvIHdlIHN0
aWxsIGRvbid0IGdldCBmaW5lIGdyYWluZWQgY29udHJvbCB3aXRoIEFUUyBhbmQgSSBndWVzcyB3
ZSBzdGlsbCBoYXZlIHNlY3VyaXR5IGlzc3VlcyBiZWNhdXNlIGEgcm9ndWUgb3IgbWFsZnVuY3Rp
b25pbmcgRVAgY291bGQganVzdCBhcyBlYXNpbHkgaXNzdWUgVExQcyB3aXRoIFRBIHNldCB2cyBu
b3Qgc2V0Lg0KDQo+IEFsc28gQVRTIGlzIG1lYW5pbmdsZXNzIHdpdGhvdXQgc29tZXRoaW5nIGxp
a2UgUEFTSUQgYXMgZmFyIGFzIGkga25vdy4NCiAgICANCkFUUyBpcyBzdGlsbCBzb21ld2hhdCB2
YWx1YWJsZSB3aXRob3V0IFBTQUlEIGluIHRoZSBzZW5zZSB5b3UgY2FuIGNhY2hlIElPTU1VIGFk
ZHJlc3MgdHJhbnNsYXRpb25zIGF0IHRoZSBFUC4gVGhpcyBzYXZlcyBoYW1tZXJpbmcgb24gdGhl
IElPTU1VIGFzIG11Y2ggaW4gY2VydGFpbiB3b3JrbG9hZHMuDQoNCkludGVyZXN0aW5nbHkgU2Vj
dGlvbiA3LjcuNy4yIGFsbW9zdCBtZW50aW9ucyB0aGF0IFJvb3QgUG9ydHMgdGhhdCBzdXBwb3J0
IEFUUyBBTkQgY2FuIGltcGxlbWVudCBQMlAgYmV0d2VlbiByb290IHBvcnRzIHNob3VsZCBhZHZl
cnRpc2UgIkFDUyBEaXJlY3QgVHJhbnNsYXRlZCBQMlAgKFQpIiBjYXBhYmlsaXR5LiBUaGlzIHRp
ZXMgaW50byB0aGUgZGlzY3Vzc2lvbiBhcm91bmQgUDJQIGJldHdlZW4gcm91dGUgcG9ydHMgd2Ug
aGFkIGEgZmV3IHdlZWtzIGFnby4uLg0KDQpTdGVwaGVuICAgIA0KDQo=
