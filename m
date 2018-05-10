Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jerome Glisse <jglisse@redhat.com>
CC: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Logan
 Gunthorpe" <logang@deltatee.com>, Alex Williamson
	<alex.williamson@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Christoph
 Hellwig" <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas
	<bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy
	<maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Date: Thu, 10 May 2018 18:41:09 +0000
Message-ID: <B525870A-B25E-46BB-B501-DAA39F1741DC@raithlin.com>
References: <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
 <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
 <4e0d0b96-ab02-2662-adf3-fa956efd294c@deltatee.com>
 <2fc61d29-9eb4-d168-a3e5-955c36e5d821@amd.com>
 <94C8FE12-7FC3-48BD-9DCA-E6A427E71810@raithlin.com>
 <20180510144137.GA3652@redhat.com>
In-Reply-To: <20180510144137.GA3652@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

SGkgSmVyb21lDQoNCj4gICAgTm90ZSBvbiBHUFUgd2UgZG8gd291bGQgbm90IHJlbHkgb24gQVRT
IGZvciBwZWVyIHRvIHBlZXIuIFNvbWUgcGFydA0KPiAgICBvZiB0aGUgR1BVIChETUEgZW5naW5l
cykgZG8gbm90IG5lY2Vzc2FyaWx5IHN1cHBvcnQgQVRTLiBZZXQgdGhvc2UNCj4gICAgYXJlIHRo
ZSBwYXJ0IGxpa2VseSB0byBiZSB1c2UgaW4gcGVlciB0byBwZWVyLg0KDQpPSyB0aGlzIGlzIGdv
b2QgdG8ga25vdy4gSSBhZ3JlZSB0aGUgRE1BIGVuZ2luZSBpcyBwcm9iYWJseSBvbmUgb2YgdGhl
IEdQVSBjb21wb25lbnRzIG1vc3QgYXBwbGljYWJsZSB0byBwMnBkbWEuDQogICAgDQo+ICAgIFdl
IChha2UgR1BVIHBlb3BsZSBha2EgdGhlIGdvb2QgZ3V5cyA7KSkgZG8gbm8gd2FudCB0byBkbyBw
ZWVyIHRvIHBlZXINCj4gICAgZm9yIHBlcmZvcm1hbmNlIHJlYXNvbnMgaWUgd2UgZG8gbm90IGNh
cmUgaGF2aW5nIG91ciB0cmFuc2FjdGlvbiBnb2luZw0KPiAgICB0byB0aGUgcm9vdCBjb21wbGV4
IGFuZCBiYWNrIGRvd24gdGhlIGRlc3RpbmF0aW9uLiBBdCBsZWFzdCBpbiB1c2UgY2FzZQ0KPiAg
ICBpIGFtIHdvcmtpbmcgb24gdGhpcyBpcyBmaW5lLg0KDQpJZiB0aGUgR1BVIHBlb3BsZSBhcmUg
dGhlIGdvb2QgZ3V5cyBkb2VzIHRoYXQgbWFrZSB0aGUgTlZNZSBwZW9wbGUgdGhlIGJhZCBndXlz
IDstKS4gSWYgc28sIHdoYXQgYXJlIHRoZSBSRE1BIHBlb3BsZT8/PyBBZ2FpbiBnb29kIHRvIGtu
b3cuDQogICAgDQo+ICAgIFJlYXNvbnMgaXMgdGhhdCBHUFUgYXJlIGdpdmluZyB1cCBvbiBQQ0ll
IChzZWUgYWxsIHNwZWNpYWxpemUgbGluayBsaWtlDQo+ICAgIE5WbGluayB0aGF0IGFyZSBwb3Bw
aW5nIHVwIGluIEdQVSBzcGFjZSkuIFNvIGZvciBmYXN0IEdQVSBpbnRlci1jb25uZWN0DQo+ICAg
IHdlIGhhdmUgdGhpcyBuZXcgbGlua3MuIA0KDQpJIGxvb2sgZm9yd2FyZCB0byBOdmlkaWEgb3Bl
bi1saWNlbnNpbmcgTlZMaW5rIHRvIGFueW9uZSB3aG8gd2FudHMgdG8gdXNlIGl0IDstKS4gT3Ig
bWF5YmUgd2UnbGwgYWxsIGp1c3Qgc3dpdGNoIHRvIE9wZW5HZW5DQ0lYIHdoZW4gdGhlIHRpbWUg
Y29tZXMuDQogICAgDQo+ICAgIEFsc28gdGhlIElPTU1VIGlzb2xhdGlvbiBkbyBtYXR0ZXIgYSBs
b3QgdG8gdXMuIFRoaW5rIHNvbWVvbmUgdXNpbmcgdGhpcw0KPiAgICBwZWVyIHRvIHBlZXIgdG8g
Z2FpbiBjb250cm9sIG9mIGEgc2VydmVyIGluIHRoZSBjbG91ZC4NCiAgICANCkkgYWdyZWUgdGhh
dCBJT01NVSBpc29sYXRpb24gaXMgdmVyeSBkZXNpcmFibGUuIEhlbmNlIHRoZSBkZXNpcmUgdG8g
ZW5zdXJlIHdlIGNhbiBrZWVwIHRoZSBJT01NVSBvbiB3aGlsZSBkb2luZyBwMnBkbWEgaWYgYXQg
YWxsIHBvc3NpYmxlIHdoaWxzdCBzdGlsbCBkZWxpdmVyaW5nIHRoZSBkZXNpcmVkIHBlcmZvcm1h
bmNlIHRvIHRoZSB1c2VyLg0KDQpTdGVwaGVuICAgIA0KDQo=
