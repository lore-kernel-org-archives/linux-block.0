Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Jerome
 Glisse" <jglisse@redhat.com>, Logan Gunthorpe <logang@deltatee.com>
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
Date: Wed, 9 May 2018 15:41:44 +0000
Message-ID: <1775CC56-4651-422F-953A-18E024D3717C@raithlin.com>
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
In-Reply-To: <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Q2hyaXN0aWFuDQoNCj4gICAgSW50ZXJlc3RpbmcgcG9pbnQsIGdpdmUgbWUgYSBtb21lbnQgdG8g
Y2hlY2sgdGhhdC4gVGhhdCBmaW5hbGx5IG1ha2VzIA0KPiAgICBhbGwgdGhlIGhhcmR3YXJlIEkg
aGF2ZSBzdGFuZGluZyBhcm91bmQgaGVyZSB2YWx1YWJsZSA6KQ0KICAgIA0KWWVzLiBBdCB0aGUg
dmVyeSBsZWFzdCBpdCBwcm92aWRlcyBhbiBpbml0aWFsIHN0YW5kYXJkcyBiYXNlZCBwYXRoIGZv
ciBQMlAgRE1BcyBhY3Jvc3MgUlBzIHdoaWNoIGlzIHNvbWV0aGluZyB3ZSBoYXZlIGRpc2N1c3Nl
ZCBvbiB0aGlzIGxpc3QgaW4gdGhlIHBhc3QgYXMgYmVpbmcgZGVzaXJhYmxlLg0KDQpCVFcgSSBh
bSB0cnlpbmcgdG8gdW5kZXJzdGFuZCBob3cgYW4gQVRTIGNhcGFibGUgRVAgZnVuY3Rpb24gZGV0
ZXJtaW5lcyB3aGVuIHRvIHBlcmZvcm0gYW4gQVRTIFRyYW5zbGF0aW9uIFJlcXVlc3QgKEFUUyBU
UikuIElzIHRoZXJlIGFuIHVwc3RyZWFtIGV4YW1wbGUgb2YgdGhlIGRyaXZlciBmb3IgeW91ciBB
UFUgdGhhdCB1c2VzIEFUUz8gSWYgc28sIGNhbiB5b3UgcHJvdmlkZSBhIHBvaW50ZXIgdG8gaXQu
IERvIHlvdSBwcm92aWRlIHNvbWUgdHlwZSBvZiBlbnRyeSBpbiB0aGUgc3VibWlzc2lvbiBxdWV1
ZXMgZm9yIGNvbW1hbmRzIGdvaW5nIHRvIHRoZSBBUFUgdG8gaW5kaWNhdGUgaWYgdGhlIGFkZHJl
c3MgYXNzb2NpYXRlZCB3aXRoIGEgc3BlY2lmaWMgY29tbWFuZCBzaG91bGQgYmUgdHJhbnNsYXRl
ZCB1c2luZyBBVFMgb3Igbm90PyBPciBkbyB5b3Ugc2ltcGx5IGVuYWJsZSBBVFMgYW5kIHRoZW4g
YWxsIGFkZHJlc3NlcyBwYXNzZWQgdG8geW91ciBBUFUgdGhhdCBtaXNzIHRoZSBsb2NhbCBjYWNo
ZSByZXN1bHQgaW4gYSBBVFMgVFI/DQoNCllvdXIgZmVlZGJhY2sgd291bGQgYmUgdXNlZnVsIGFu
ZCBJIGluaXRpYXRlIGRpc2N1c3Npb25zIHdpdGhpbiB0aGUgTlZNZSBjb21tdW5pdHkgb24gd2hl
cmUgd2UgbWlnaHQgZ28gd2l0aCBBVFMuLi4NCg0KVGhhbmtzDQoNClN0ZXBoZW4NCg0K
