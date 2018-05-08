Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Dan Williams <dan.j.williams@intel.com>, Logan Gunthorpe
	<logang@deltatee.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, linux-rdma
	<linux-rdma@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Christoph
 Hellwig" <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas
	<bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy
	<maxg@mellanox.com>, =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alex Williamson
	<alex.williamson@redhat.com>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
	<christian.koenig@amd.com>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Date: Tue, 8 May 2018 14:44:43 +0000
Message-ID: <64C231F5-DE36-415F-B308-3A423B0BBACB@raithlin.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <CAPcyv4g+5N_n03J-VhmJfrr60Sqk95ZapLKBkwSsGvV4nQ+ZRw@mail.gmail.com>
In-Reply-To: <CAPcyv4g+5N_n03J-VhmJfrr60Sqk95ZapLKBkwSsGvV4nQ+ZRw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

SGkgRGFuDQoNCj4gICAgSXQgc2VlbXMgdW53aWVsZHkgdGhhdCB0aGlzIGlzIGEgY29tcGlsZSB0
aW1lIG9wdGlvbiBhbmQgbm90IGEgcnVudGltZQ0KPiAgICBvcHRpb24uIENhbid0IHdlIGhhdmUg
YSBrZXJuZWwgY29tbWFuZCBsaW5lIG9wdGlvbiB0byBvcHQtaW4gdG8gdGhpcw0KPiAgICBiZWhh
dmlvciByYXRoZXIgdGhhbiByZXF1aXJlIGEgd2hvbGx5IHNlcGFyYXRlIGtlcm5lbCBpbWFnZT8N
CiAgDQpJIHRoaW5rIGJlY2F1c2Ugb2YgdGhlIHNlY3VyaXR5IGltcGxpY2F0aW9ucyBhc3NvY2lh
dGVkIHdpdGggcDJwZG1hIGFuZCBBQ1Mgd2Ugd2FudGVkIHRvIG1ha2UgaXQgdmVyeSBjbGVhciBw
ZW9wbGUgd2VyZSBjaG9vc2luZyBvbmUgKHAycGRtYSkgb3IgdGhlIG90aGVyIChJT01NVSBncm91
cGluZ3MgYW5kIGlzb2xhdGlvbikuIEhvd2V2ZXIgcGVyc29uYWxseSBJIHdvdWxkIHByZWZlciBp
bmNsdWRpbmcgdGhlIG9wdGlvbiBvZiBhIHJ1bi10aW1lIGtlcm5lbCBwYXJhbWV0ZXIgdG9vLiBJ
biBmYWN0IGEgZmV3IG1vbnRocyBhZ28gSSBwcm9wb3NlZCBhIHNtYWxsIHBhdGNoIHRoYXQgZGlk
IGp1c3QgdGhhdCBbMV0uIEl0IG5ldmVyIHJlYWxseSB3ZW50IGFueXdoZXJlIGJ1dCBpZiBwZW9w
bGUgd2VyZSBvcGVuIHRvIHRoZSBpZGVhIHdlIGNvdWxkIGxvb2sgYXQgYWRkaW5nIGl0IHRvIHRo
ZSBzZXJpZXMuDQogIA0KPiBXaHkgaXMgdGhpcyB0ZXh0IGFkZGVkIGluIGEgZm9sbG93IG9uIHBh
dGNoIGFuZCBub3QgdGhlIHBhdGNoIHRoYXQNCj4gIGludHJvZHVjZWQgdGhlIGNvbmZpZyBvcHRp
b24/DQoNCkJlY2F1c2UgdGhlIEFDUyBzZWN0aW9uIHdhcyBhZGRlZCBsYXRlciBpbiB0aGUgc2Vy
aWVzIGFuZCB0aGlzIGluZm9ybWF0aW9uIGlzIGFzc29jaWF0ZWQgd2l0aCB0aGF0IGFkZGl0aW9u
YWwgZnVuY3Rpb25hbGl0eS4NCiAgICANCj4gSSdtIGFsc28gd29uZGVyaW5nIGlmIHRoYXQgY29t
bWFuZCBsaW5lIG9wdGlvbiBjYW4gdGFrZSBhICdidXMgZGV2aWNlDQo+IGZ1bmN0aW9uJyBhZGRy
ZXNzIG9mIGEgc3dpdGNoIHRvIGxpbWl0IHRoZSBzY29wZSBvZiB3aGVyZSBBQ1MgaXMNCj4gZGlz
YWJsZWQuDQoNCkJ5IHRoaXMgeW91IG1lYW4gdGhlIGFkZHJlc3MgZm9yIGVpdGhlciBhIFJQLCBE
U1AsIFVTUCBvciBNRiBFUCBiZWxvdyB3aGljaCB3ZSBkaXNhYmxlIEFDUz8gV2UgY291bGQgZG8g
dGhhdCBidXQgSSBkb24ndCB0aGluayBpdCBhdm9pZHMgdGhlIGlzc3VlIG9mIGNoYW5nZXMgaW4g
SU9NTVUgZ3JvdXBpbmdzIGFzIGRldmljZXMgYXJlIGFkZGVkL3JlbW92ZWQuIEl0IHNpbXBseSBj
aGFuZ2VzIHRoZSBwcm9ibGVtIGZyb20gYWZmZWN0aW5nIGFuZCBlbnRpcmUgUENJIGRvbWFpbiB0
byBhIHN1Yi1zZXQgb2YgdGhlIGRvbWFpbi4gV2UgY2FuIGFscmVhZHkgaGFuZGxlIHRoaXMgYnkg
ZG9pbmcgcDJwZG1hIG9uIG9uZSBSUCBhbmQgbm9ybWFsIElPTU1VIGlzb2xhdGlvbiBvbiB0aGUg
b3RoZXIgUlBzIGluIHRoZSBzeXN0ZW0uDQoNClN0ZXBoZW4NCg0KWzFdIGh0dHBzOi8vbWFyYy5p
bmZvLz9sPWxpbnV4LWRvYyZtPTE1MDkwNzE4ODMxMDgzOCZ3PTINCiAgICANCg0K
