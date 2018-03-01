Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Sagi Grimberg <sagi@grimberg.me>
CC: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jens Axboe
	<axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>, Dan Williams
	<dan.j.williams@intel.com>, =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?=
	<jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Alex Williamson" <alex.williamson@redhat.com>, Steve Wise
	<swise@opengridcomputing.com>
Subject: Re: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
Date: Thu, 1 Mar 2018 19:01:31 +0000
Message-ID: <88ACB0F6-DE78-400B-A42C-953B49026FA2@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
 <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
 <20180301184249.GI19007@ziepe.ca>
In-Reply-To: <20180301184249.GI19007@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

ICAgIA0KPiBJIGFncmVlLCBJIGRvbid0IHRoaW5rIHRoaXMgc2VyaWVzIHNob3VsZCB0YXJnZXQg
YW55dGhpbmcgb3RoZXIgdGhhbg0KPiB1c2luZyBwMnAgbWVtb3J5IGxvY2F0ZWQgaW4gb25lIG9m
IHRoZSBkZXZpY2VzIGV4cGVjdGVkIHRvIHBhcnRpY2lwYXRlDQo+IGluIHRoZSBwMnAgdHJhc25h
Y3Rpb24gZm9yIGEgZmlyc3QgcGFzcy4uDQoNCkkgZGlzYWdyZWUuIFRoZXJlIGlzIGRlZmluaXRl
bHkgaW50ZXJlc3QgaW4gdXNpbmcgYSBOVk1lIENNQiBhcyBhIGJvdW5jZSBidWZmZXIgYW5kIGlu
IGRlcGxveWluZyBzeXN0ZW1zIHdoZXJlIG9ubHkgc29tZSBvZiB0aGUgTlZNZSBTU0RzIGJlbG93
IGEgc3dpdGNoICBoYXZlIGEgQ01CIGJ1dCB1c2UgUDJQIHRvIGFjY2VzcyBhbGwgb2YgdGhlbS4g
QWxzbyB0aGVyZSBhcmUgc29tZSBkZXZpY2VzIHRoYXQgb25seSBleHBvc2UgbWVtb3J5IGFuZCB0
aGVpciBlbnRpcmUgcHVycG9zZSBpcyB0byBhY3QgYXMgYSBwMnAgZGV2aWNlLCBzdXBwb3J0aW5n
IHRoZXNlIGRldmljZXMgd291bGQgYmUgdmFsdWFibGUuDQogICAgDQo+IGxvY2FsaXR5IGlzIHN1
cGVyIGltcG9ydGFudCBmb3IgcDJwLCBzbyBJIGRvbid0IHRoaW5rIHRoaW5ncyBzaG91bGQNCj4g
IHN0YXJ0IG91dCBpbiBhIHdheSB0aGF0IG1ha2VzIHNwZWNpZnlpbmcgdGhlIGRlc2lyZWQgbG9j
YWxpdHkgaGFyZC4NCg0KRW5zdXJpbmcgdGhhdCB0aGUgRVBzIGVuZ2FnZWQgaW4gcDJwIGFyZSBh
bGwgZGlyZWN0bHkgY29ubmVjdGVkIHRvIHRoZSBzYW1lIFBDSWUgc3dpdGNoIGVuc3VyZXMgbG9j
YWxpdHkgYW5kIChmb3IgdGhlIHN3aXRjaGVzIHdlIGhhdmUgdGVzdGVkKSBwZXJmb3JtYW5jZS4g
SSBhZ3JlZSBzb2x2aW5nIHRoZSBjYXNlIHdoZXJlIHRoZSBuYW1lc3BhY2UgYXJlIENNQiBhcmUg
b24gdGhlIHNhbWUgUENJZSBFUCBpcyB2YWx1YWJsZSBidXQgSSBkb24ndCBzZWUgaXQgYXMgY3Jp
dGljYWwgdG8gaW5pdGlhbCBhY2NlcHRhbmNlIG9mIHRoZSBzZXJpZXMuDQogICAgDQpTdGVwaGVu
DQogICAgDQoNCg==
