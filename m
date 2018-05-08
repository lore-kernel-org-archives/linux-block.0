Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Alex Williamson <alex.williamson@redhat.com>, Logan Gunthorpe
	<logang@deltatee.com>
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
Date: Tue, 8 May 2018 21:42:27 +0000
Message-ID: <354F7407-0DC7-470C-B9AA-74FDF9C46B08@raithlin.com>
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
In-Reply-To: <20180508152631.50fd583c@w520.home>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

SGkgQWxleA0KDQo+ICAgIEJ1dCBpdCB3b3VsZCBiZSBhIG11Y2ggZWFzaWVyIHByb3Bvc2FsIHRv
IGRpc2FibGUgQUNTIHdoZW4gdGhlIElPTU1VIGlzDQo+ICAgIG5vdCBlbmFibGVkLCBBQ1MgaGFz
IG5vIHJlYWwgcHVycG9zZSBpbiB0aGF0IGNhc2UuDQoNCkkgZ3Vlc3Mgb25lIGlzc3VlIEkgaGF2
ZSB3aXRoIHRoaXMgaXMgdGhhdCBpdCBkaXNhYmxlcyBJT01NVSBncm91cHMgZm9yIGFsbCBSb290
IFBvcnRzIGFuZCBub3QganVzdCB0aGUgb25lKHMpIHdlIHdpc2ggdG8gZG8gcDJwZG1hIG9uLiAN
CiAgICANCj4gICAgVGhlIElPTU1VIGFuZCBQMlAgYXJlIGFscmVhZHkgbm90IGV4Y2x1c2l2ZSwg
d2UgY2FuIGJvdW5jZSBvZmYgdGhlDQo+ICAgIElPTU1VIG9yIG1ha2UgdXNlIG9mIEFUUyBhcyB3
ZSd2ZSBwcmV2aW91c2x5IGRpc2N1c3NlZC4gIFdlIHdlcmUNCj4gICAgcHJldmlvdXNseSB0YWxr
aW5nIGFib3V0IGEgYnVpbGQgdGltZSBjb25maWcgb3B0aW9uIHRoYXQgeW91IGRpZG4ndA0KPiAg
ICBleHBlY3QgZGlzdHJvcyB0byB1c2UsIHNvIEkgZG9uJ3QgdGhpbmsgaW50ZXJ2ZW50aW9uIGZv
ciB0aGUgdXNlciB0bw0KPiAgICBkaXNhYmxlIHRoZSBJT01NVSBpZiBpdCdzIGVuYWJsZWQgYnkg
ZGVmYXVsdCBpcyBhIHNlcmlvdXMgY29uY2Vybg0KPiAgICBlaXRoZXIuDQoNCkFUUyBkZWZpbml0
ZWx5IG1ha2VzIHRoaW5ncyBtb3JlIGludGVyZXN0aW5nIGZvciB0aGUgY2FzZXMgd2hlcmUgdGhl
IEVQcyBzdXBwb3J0IGl0LiBIb3dldmVyIEkgZG9uJ3QgcmVhbGx5IGhhdmUgYSBoYW5kbGUgb24g
aG93IGNvbW1vbiBBVFMgc3VwcG9ydCBpcyBnb2luZyB0byBiZSBpbiB0aGUga2luZHMgb2YgZGV2
aWNlcyB3ZSBoYXZlIGJlZW4gZm9jdXNlZCBvbiAoTlZNZSBTU0RzIGFuZCBSRE1BIE5JQ3MgbW9z
dGx5KS4gDQogICAgDQo+IFdoYXQgeW91J3JlIHRyeWluZyB0byBkbyBpcyBlbmFibGVkIGRpcmVj
dCBwZWVyLXRvLXBlZXIgZm9yIGVuZHBvaW50cw0KPiAgd2hpY2ggZG8gbm90IHN1cHBvcnQgQVRT
IHdoZW4gdGhlIElPTU1VIGlzIGVuYWJsZWQsIHdoaWNoIGlzIG5vdA0KPiAgc29tZXRoaW5nIHRo
YXQgbmVjZXNzYXJpbHkgbWFrZXMgc2Vuc2UgdG8gbWUuIA0KDQpBcyBhYm92ZSB0aGUgYWR2YW50
YWdlIG9mIGxlYXZpbmcgdGhlIElPTU1VIG9uIGlzIHRoYXQgaXQgYWxsb3dzIGZvciBib3RoIHAy
cGRtYSBQQ0kgZG9tYWlucyBhbmQgSU9NTVUgZ3JvdXBpbmdzIFBDSSBkb21haW5zIGluIHRoZSBz
YW1lIHN5c3RlbS4gSXQgaXMganVzdCB0aGF0IHRoZXNlIGRvbWFpbnMgd2lsbCBiZSBzZXBhcmF0
ZSB0byBlYWNoIG90aGVyLg0KDQo+ICBTbyB0aGF0IGxlYXZlcyBhdm9pZGluZyBib3VuY2UgYnVm
ZmVycyBhcyB0aGUgcmVtYWluaW5nIElPTU1VIGZlYXR1cmUNCg0KSSBhZ3JlZSB3aXRoIHlvdSBo
ZXJlIHRoYXQgdGhlIGRldmljZXMgd2Ugd2lsbCB3YW50IHRvIHVzZSBmb3IgcDJwIHdpbGwgcHJv
YmFibHkgbm90IHJlcXVpcmUgYSBib3VuY2UgYnVmZmVyIGFuZCB3aWxsIHN1cHBvcnQgNjQgYml0
IERNQSBhZGRyZXNzaW5nLg0KICAgIA0KPiBJJ20gc3RpbGwgbm90IHNlZWluZyB3aHkgaXQncyB0
ZXJyaWJseSB1bmRlc2lyYWJsZSB0byByZXF1aXJlIGRldmljZXMgdG8gc3VwcG9ydA0KPiBBVFMg
aWYgdGhleSB3YW50IHRvIGRvIGRpcmVjdCBQMlAgd2l0aCBhbiBJT01NVSBlbmFibGVkLg0KDQpJ
IHRoaW5rIHRoZSBvbmUgcmVhc29uIGlzIGZvciB0aGUgdXNlLWNhc2UgYWJvdmUuIEFsbG93aW5n
IElPTU1VIGdyb3VwaW5ncyBvbiBvbmUgZG9tYWluIGFuZCBwMnBkbWEgb24gYW5vdGhlciBkb21h
aW4uLi4uDQogICAgDQpTdGVwaGVuDQogICAgDQoNCg==
