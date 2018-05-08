Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Don Dutile <ddutile@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
	Logan Gunthorpe <logang@deltatee.com>
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
Date: Tue, 8 May 2018 21:27:45 +0000
Message-ID: <3C9FB262-A93C-4C8F-B1E0-85C6D6F78BC2@raithlin.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <CAPcyv4g+5N_n03J-VhmJfrr60Sqk95ZapLKBkwSsGvV4nQ+ZRw@mail.gmail.com>
 <64C231F5-DE36-415F-B308-3A423B0BBACB@raithlin.com>
 <15433946-f7f5-f610-4e80-380fb59920e5@redhat.com>
In-Reply-To: <15433946-f7f5-f610-4e80-380fb59920e5@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

SGkgRG9uDQoNCj5XZWxsLCBwMnAgRE1BIGlzIGEgZnVuY3Rpb24gb2YgYSBjb29wZXJhdGluZyAn
YWdlbnQnIHNvbWV3aGVyZSBhYm92ZSB0aGUgdHdvIGRldmljZXMuDQo+ICAgIFRoYXQgYWdlbnQg
c2hvdWxkICdyZXF1ZXN0JyB0byB0aGUga2VybmVsIHRoYXQgQUNTIGJlIHJlbW92ZWQvY2lyY3Vt
dmVudGVkIChwMnAgZW5hYmxlZCkgYnR3biB0d28gZW5kcG9pbnRzLg0KPiAgICBJIHJlY29tbWVu
ZCBkb2luZyBzbyB2aWEgYSBzeXNmcyBtZXRob2QuDQoNClllcyB3ZSBsb29rZWQgYXQgc29tZXRo
aW5nIGxpa2UgdGhpcyBpbiB0aGUgcGFzdCBidXQgaXQgZG9lcyBoaXQgdGhlIElPTU1VIGdyb3Vw
aW5nIGlzc3VlIEkgZGlzY3Vzc2VkIGVhcmxpZXIgdG9kYXkgd2hpY2ggaXMgbm90IGFjY2VwdGFi
bGUgcmlnaHQgbm93LiBJbiB0aGUgbG9uZyB0ZXJtLCBvbmNlIHdlIGdldCBJT01NVSBncm91cGlu
ZyBjYWxsYmFja3MgdG8gVk1zIHdlIGNhbiBsb29rIGF0IGV4dGVuZGluZyBwMnBkbWEgaW4gdGhp
cyB3YXkuIEJ1dCBJIGRvbid0IHRoaW5rIHRoaXMgaXMgdmlhYmxlIGZvciB0aGUgaW5pdGlhbCBz
ZXJpZXMuIA0KDQogICAgDQo+ICAgICAgICAgICAgU28gSSBkb24ndCB1bmRlcnN0YW5kIHRoZSBj
b21tZW50cyB3aHkgVk1zIHNob3VsZCBuZWVkIHRvIGtub3cuDQoNCkFzIEkgdW5kZXJzdGFuZCBp
dCBWTXMgbmVlZCB0byBrbm93IGJlY2F1c2UgVkZJTyBwYXNzZXMgSU9NTVUgZ3JvdXBpbmcgdXAg
aW50byB0aGUgVk1zLiBTbyBpZiBhIElPTU1VIGdyb3VwaW5nIGNoYW5nZXMgdGhlIFZNJ3Mgdmll
dyBvZiBpdHMgUENJZSB0b3BvbG9neSBjaGFuZ2VzLiBJIHRoaW5rIHdlIGV2ZW4gaGF2ZSB0byBi
ZSBjb2duaXphbnQgb2YgdGhlIGZhY3QgdGhlIE9TIHJ1bm5pbmcgb24gdGhlIFZNIG1heSBub3Qg
ZXZlbiBzdXBwb3J0IGhvdC1wbHVnIG9mIFBDSSBkZXZpY2VzLg0KICAgIA0KPiBJcyB0aGVyZSBh
IHRocmVhZCBJIG5lZWQgdG8gcmVhZCB1cCB0byBleHBsYWluIC9jbGVhci11cCB0aGUgdGhvdWdo
dHMgYWJvdmU/DQoNCklmIHlvdSBzZWFyY2ggZm9yIHAycGRtYSB5b3Ugc2hvdWxkIGZpbmQgdGhl
IHByZXZpb3VzIGRpc2N1c3Npb25zLiBUaGFua3MgZm9yIHRoZSBpbnB1dCENCg0KU3RlcGhlbg0K
ICAgIA0KICAgIA0KDQo=
