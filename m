Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Logan
 Gunthorpe" <logang@deltatee.com>, Jerome Glisse <jglisse@redhat.com>
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
Date: Thu, 10 May 2018 14:16:25 +0000
Message-ID: <94C8FE12-7FC3-48BD-9DCA-E6A427E71810@raithlin.com>
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
In-Reply-To: <2fc61d29-9eb4-d168-a3e5-955c36e5d821@amd.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

SGkgQ2hyaXN0aWFuDQoNCj4gV2h5IHdvdWxkIGEgc3dpdGNoIG5vdCBpZGVudGlmeSB0aGF0IGFz
IGEgcGVlciBhZGRyZXNzPyBXZSB1c2UgdGhlIFBBU0lEIA0KPiAgICB0b2dldGhlciB3aXRoIEFU
UyB0byBpZGVudGlmeSB0aGUgYWRkcmVzcyBzcGFjZSB3aGljaCBhIHRyYW5zYWN0aW9uIA0KPiAg
ICBzaG91bGQgdXNlLg0KDQpJIHRoaW5rIHlvdSBhcmUgY29uZmxhdGluZyB0d28gdHlwZXMgb2Yg
VExQcyBoZXJlLiBJZiB0aGUgZGV2aWNlIHN1cHBvcnRzIEFUUyB0aGVuIGl0IHdpbGwgaXNzdWUg
YSBUUiBUTFAgdG8gb2J0YWluIGEgdHJhbnNsYXRlZCBhZGRyZXNzIGZyb20gdGhlIElPTU1VLiBU
aGlzIFRSIFRMUCB3aWxsIGJlIGFkZHJlc3NlZCB0byB0aGUgUlAgYW5kIHNvIHJlZ2FyZGxlc3Mg
b2YgQUNTIGl0IGlzIGdvaW5nIHVwIHRvIHRoZSBSb290IFBvcnQuIFdoZW4gaXQgZ2V0cyB0aGUg
cmVzcG9uc2UgaXQgZ2V0cyB0aGUgcGh5c2ljYWwgYWRkcmVzcyBhbmQgY2FuIHVzZSB0aGF0IHdp
dGggdGhlIFRBIGJpdCBzZXQgZm9yIHRoZSBwMnBkbWEuIEluIHRoZSBjYXNlIG9mIEFUUyBzdXBw
b3J0IHdlIGFsc28gaGF2ZSBtb3JlIGNvbnRyb2wgb3ZlciBBQ1MgYXMgd2UgY2FuIGRpc2FibGUg
aXQganVzdCBmb3IgVEEgYWRkcmVzc2VzIChhcyBwZXIgNy43LjcuNy4yIG9mIHRoZSBzcGVjKS4N
CiAgICANCiA+ICAgSWYgSSdtIG5vdCBjb21wbGV0ZWx5IG1pc3Rha2VuIHdoZW4geW91IGRpc2Fi
bGUgQUNTIGl0IGlzIHBlcmZlY3RseSANCiA+ICAgcG9zc2libGUgdGhhdCBhIGJyaWRnZSBpZGVu
dGlmaWVzIGEgdHJhbnNhY3Rpb24gYXMgYmVsb25naW5nIHRvIGEgcGVlciANCiA+ICAgYWRkcmVz
cywgd2hpY2ggaXNuJ3Qgd2hhdCB3ZSB3YW50IGhlcmUuDQogICANCllvdSBhcmUgcmlnaHQgaGVy
ZSBhbmQgSSB0aGluayB0aGlzIGlsbHVzdHJhdGVzIGEgcHJvYmxlbSBmb3IgdXNpbmcgdGhlIElP
TU1VIGF0IGFsbCB3aGVuIFAyUERNQSBkZXZpY2VzIGRvIG5vdCBzdXBwb3J0IEFUUy4gTGV0IG1l
IGV4cGxhaW46DQoNCklmIHdlIHdhbnQgdG8gZG8gYSBQMlBETUEgYW5kIHRoZSBETUEgZGV2aWNl
IGRvZXMgbm90IHN1cHBvcnQgQVRTIHRoZW4gSSB0aGluayB3ZSBoYXZlIHRvIGRpc2FibGUgdGhl
IElPTU1VIChzb21ldGhpbmcgTWlrZSBzdWdnZXN0ZWQgZWFybGllcikuIFRoZSByZWFzb24gaXMg
dGhhdCBzaW5jZSBBVFMgaXMgbm90IGFuIG9wdGlvbiB0aGUgRVAgbXVzdCBpbml0aWF0ZSB0aGUg
RE1BIHVzaW5nIHRoZSBhZGRyZXNzZXMgcGFzc2VkIGRvd24gdG8gaXQuIElmIHRoZSBJT01NVSBp
cyBvbiB0aGVuIHRoaXMgaXMgYW4gSU9WQSB0aGF0IGNvdWxkICh3aXRoIHNvbWUgbm9uLXplcm8g
cHJvYmFiaWxpdHkpIHBvaW50IHRvIGFuIElPIE1lbW9yeSBhZGRyZXNzIGluIHRoZSBzYW1lIFBD
SSBkb21haW4uIFNvIGlmIHdlIGRpc2FibGUgQUNTIHdlIGFyZSBpbiB0cm91YmxlIGFzIHdlIG1p
Z2h0IE1lbVdyIHRvIHRoZSB3cm9uZyBwbGFjZSBidXQgaWYgd2UgZW5hYmxlIEFDUyB3ZSBsb3Nl
IG11Y2ggb2YgdGhlIGJlbmVmaXQgb2YgUDJQRE1BLiBEaXNhYmxpbmcgdGhlIElPTU1VIHJlbW92
ZXMgdGhlIElPVkEgcmlzayBhbmQgaXJvbmljYWxseSBhbHNvIHJlc29sdmVzIHRoZSBJT01NVSBn
cm91cGluZyBpc3N1ZXMuDQoNClNvIEkgdGhpbmsgaWYgd2Ugd2FudCB0byBzdXBwb3J0IHBlcmZv
cm1hbnQgUDJQRE1BIGZvciBkZXZpY2VzIHRoYXQgZG9uJ3QgaGF2ZSBBVFMgKGFuZCBubyBOVk1l
IFNTRHMgdG9kYXkgc3VwcG9ydCBBVFMpIHRoZW4gd2UgaGF2ZSB0byBkaXNhYmxlIHRoZSBJT01N
VS4gSSBrbm93IHRoaXMgaXMgcHJvYmxlbWF0aWMgZm9yIEFNRHMgdXNlIGNhc2Ugc28gcGVyaGFw
cyB3ZSBhbHNvIG5lZWQgdG8gY29uc2lkZXIgYSBtb2RlIGZvciBQMlBETUEgZm9yIGRldmljZXMg
dGhhdCBETyBzdXBwb3J0IEFUUyB3aGVyZSB3ZSBjYW4gZW5hYmxlIHRoZSBJT01NVSAoYnV0IGlu
IHRoaXMgY2FzZSBFUHMgd2l0aG91dCBBVFMgY2Fubm90IHBhcnRpY2lwYXRlIGFzIFAyUERNQSBE
TUEgaW5pYXRvcnMpLg0KDQpNYWtlIHNlbnNlPw0KDQpTdGVwaGVuDQogDQogICAgDQogICAgDQoN
Cg==
