Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Sagi Grimberg <sagi@grimberg.me>, Logan Gunthorpe <logang@deltatee.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<keith.busch@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe
	<jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>, Dan Williams
	<dan.j.williams@intel.com>, =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?=
	<jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Alex Williamson" <alex.williamson@redhat.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>
Subject: Re: [PATCH v2 08/10] nvme-pci: Add support for P2P memory in requests
Date: Thu, 1 Mar 2018 15:58:40 +0000
Message-ID: <1CE68E79-E5FD-4EE2-BD88-B3EE57E43ACE@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-9-logang@deltatee.com>
 <c6639530-48ba-4655-c772-7d88a030e37e@grimberg.me>
In-Reply-To: <c6639530-48ba-4655-c772-7d88a030e37e@grimberg.me>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

PiBBbnkgcGxhbnMgYWRkaW5nIHRoZSBjYXBhYmlsaXR5IHRvIG52bWUtcmRtYT8gU2hvdWxkIGJl
DQo+IHN0cmFpZ2h0LWZvcndhcmQuLi4gSW4gdGhlb3J5LCB0aGUgdXNlLWNhc2Ugd291bGQgYmUg
cmRtYSBiYWNrZW5kDQo+IGZhYnJpYyBiZWhpbmQuIFNob3VsZG4ndCBiZSBoYXJkIHRvIHRlc3Qg
ZWl0aGVyLi4uDQoNCk5pY2UgaWRlYSBTYWdpLiBZZXMgd2UgaGF2ZSBiZWVuIHN0YXJ0aW5nIHRv
IGxvb2sgYXQgdGhhdC4gVGhvdWdoIGFnYWluIHdlIHdvdWxkIHByb2JhYmx5IHdhbnQgdG8gaW1w
b3NlIHRoZSAiYXR0YWNoZWQgdG8gdGhlIHNhbWUgUENJZSBzd2l0Y2giIHJ1bGUgd2hpY2ggbWln
aHQgYmUgbGVzcyBjb21tb24gdG8gc2F0aXNmeSBpbiBpbml0aWF0b3Igc3lzdGVtcy4gDQoNCkRv
d24gdGhlIHJvYWQgSSB3b3VsZCBhbHNvIGxpa2UgdG8gZGlzY3VzcyB0aGUgYmVzdCB3YXkgdG8g
dXNlIHRoaXMgUDJQIGZyYW1ld29yayB0byBmYWNpbGl0YXRlIGNvcGllcyBiZXR3ZWVuIE5WTWUg
bmFtZXNwYWNlcyAob24gYm90aCBQQ0llIGFuZCBmYWJyaWMgYXR0YWNoZWQgbmFtZXNwYWNlcykg
d2l0aG91dCBoYXZpbmcgdG8gZXhwb3NlIHRoZSBDTUIgdXAgdG8gdXNlciBzcGFjZS4gV2Fzbid0
IHNvbWV0aGluZyBsaWtlIHRoYXQgZG9uZSBpbiB0aGUgU0NTSSB3b3JsZCBhdCBzb21lIHBvaW50
IE1hcnRpbj8NCg0KU3RlcGhlbg0KICAgIA0KDQo=
