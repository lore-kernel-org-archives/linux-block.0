Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-kernel@vger.kernel.org"
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
Date: Thu, 1 Mar 2018 23:00:51 +0000
Message-ID: <77591162-4CCD-446E-A27C-1CDB4996ACB7@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
 <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
 <20180301184249.GI19007@ziepe.ca>
 <edaf476a-cfe9-0598-1aa5-14802a9a1477@deltatee.com>
 <20180301224540.GL19007@ziepe.ca>
In-Reply-To: <20180301224540.GL19007@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Pj4gV2UnZCBwcmVmZXIgdG8gaGF2ZSBhIGdlbmVyaWMgd2F5IHRvIGdldCBwMnBtZW0gaW5zdGVh
ZCBvZiByZXN0cmljdGluZw0KPj4gb3Vyc2VsdmVzIHRvIG9ubHkgdXNpbmcgQ01Ccy4gV2UgZGlk
IHdvcmsgaW4gdGhlIHBhc3Qgd2hlcmUgdGhlIFAyUCBtZW1vcnkNCiA+PiB3YXMgcGFydCBvZiBh
biBJQiBhZGFwdGVyIGFuZCBub3QgdGhlIE5WTWUgY2FyZC4gU28gdGhpcyB3b24ndCB3b3JrIGlm
IGl0J3MNCiAgPj4gYW4gTlZNZSBvbmx5IGludGVyZmFjZS4NCiAgICANCiA+IEl0IGp1c3Qgc2Vl
bXMgbGlrZSBpdCBpdCBtYWtpbmcgaXQgdG9vIGNvbXBsaWNhdGVkLg0KDQpJIGRpc2FncmVlLiBI
YXZpbmcgYSBjb21tb24gYWxsb2NhdG9yIChpbnN0ZWFkIG9mIHNvbWUgc2VwYXJhdGUgYWxsb2Nh
dG9yIHBlciBkcml2ZXIpIG1ha2VzIHRoaW5ncyBzaW1wbGVyLg0KDQo+IFNlZW1zIGxpa2UgYSB2
ZXJ5IHN1YnRsZSBhbmQgaGFyZCB0byBkZWJ1ZyBwZXJmb3JtYW5jZSB0cmFwIHRvIGxlYXZlDQo+
IGZvciB0aGUgdXNlcnMsIGFuZCBwcmV0dHkgbXVjaCB0aGUgb25seSByZWFzb24gdG8gdXNlIFAy
UCBpcw0KPiBwZXJmb3JtYW5jZS4uLiBTbyB3aHkgaGF2ZSBzdWNoIGEgZGFuZ2Vyb3VzIGludGVy
ZmFjZT8NCg0KUDJQIGlzIGFib3V0IG9mZmxvYWRpbmcgdGhlIG1lbW9yeSBhbmQgUENJIHN1YnN5
c3RlbSBvZiB0aGUgaG9zdCBDUFUgYW5kIHRoaXMgaXMgYWNoaWV2ZWQgbm8gbWF0dGVyIHdoaWNo
IHAycF9kZXYgaXMgdXNlZC4NCg0KU3RlcGhlbg0KICAgIA0KDQo=
