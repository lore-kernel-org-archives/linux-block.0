Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jerome Glisse <jglisse@redhat.com>, Logan Gunthorpe <logang@deltatee.com>
CC: Benjamin Herrenschmidt <benh@au1.ibm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jens Axboe
	<axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>, Sagi Grimberg
	<sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe
	<jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>, Dan Williams
	<dan.j.williams@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
	Oliver OHalloran <oliveroh@au1.ibm.com>
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
Date: Fri, 2 Mar 2018 21:38:43 +0000
Message-ID: <8D3B5C26-39E0-478D-B51F-A22B3F36C4D7@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <8e808448-fc01-5da0-51e7-1a6657d5a23a@deltatee.com>
 <1519936195.4592.18.camel@au1.ibm.com> <20180301205548.GA6742@redhat.com>
 <a512edf9-2d96-9229-fe60-e0ea60b3922b@deltatee.com>
 <20180301211036.GB6742@redhat.com>
In-Reply-To: <20180301211036.GB6742@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

PiBJdCBzZWVtcyBwZW9wbGUgbWlzcy11bmRlcnN0YW5kIEhNTSA6KCANCg0KSGkgSmVyb21lDQoN
CllvdXIgdW5oYXBweSBmYWNlIGVtb3RpY29uIG1hZGUgbWUgc2FkIHNvIEkgd2VudCBvZmYgdG8g
KHJlKXJlYWQgdXAgb24gSE1NLiBBbG9uZyB0aGUgd2F5IEkgY2FtZSB1cCB3aXRoIGEgY291cGxl
IG9mIHRoaW5ncy4NCg0KV2hpbGUgaG1tLnR4dCBpcyByZWFsbHkgbmljZSB0byByZWFkIGl0IG1h
a2VzIG5vIG1lbnRpb24gb2YgREVWSUNFX1BSSVZBVEUgYW5kIERFVklDRV9QVUJMSUMuIEl0IGFs
c28gZ2l2ZXMgbm8gaW5kaWNhdGlvbiB3aGVuIG9uZSBtaWdodCBjaG9vc2UgdG8gdXNlIG9uZSBv
dmVyIHRoZSBvdGhlci4gV291bGQgaXQgYmUgcG9zc2libGUgdG8gdXBkYXRlIGhtbS50eHQgdG8g
aW5jbHVkZSBzb21lIGRpc2N1c3Npb24gb24gdGhpcz8gSSB1bmRlcnN0YW5kIHRoYXQgREVWSUNF
X1BVQkxJQyBjcmVhdGVzIGEgbWFwcGluZyBpbiB0aGUga2VybmVsJ3MgbGluZWFyIGFkZHJlc3Mg
c3BhY2UgZm9yIHRoZSBkZXZpY2UgbWVtb3J5IGFuZCBERVZJQ0VfUFJJVkFURSBkb2VzIG5vdC4g
SG93ZXZlciwgbGlrZSBJIHNhaWQsIEkgYW0gbm90IHN1cmUgd2hlbiB5b3Ugd291bGQgdXNlIGVp
dGhlciBvbmUgYW5kIHRoZSBwcm9zIGFuZCBjb25zIG9mIGRvaW5nIHNvLiBJIGFjdHVhbGx5IGVu
ZGVkIHVwIGZpbmRpbmcgc29tZSB1c2VmdWwgaW5mb3JtYXRpb24gaW4gbWVtcmVtYXAuaCBidXQg
SSBkb24ndCB0aGluayBpdCBpcyBmYWlyIHRvIGV4cGVjdCBwZW9wbGUgdG8gZGlnICp0aGF0KiBk
ZWVwIHRvIGZpbmQgdGhpcyBpbmZvcm1hdGlvbiA7LSkuDQoNCkEgcXVpY2sgZ3JlcCBzaG93cyBu
byBkcml2ZXJzIHVzaW5nIHRoZSBITU0gQVBJIGluIHRoZSB1cHN0cmVhbSBjb2RlIHRvZGF5LiBJ
cyB0aGlzIGNvcnJlY3Q/IEFyZSB0aGVyZSBhbnkgZXhhbXBsZXMgb2Ygb3V0IG9mIHRyZWUgZHJp
dmVycyB0aGF0IHVzZSBITU0geW91IGNhbiBwb2ludCBtZSB0b28/IEFzIGEgZHJpdmVyIGRldmVs
b3BlciB3aGF0IHJlc291cmNlcyBleGlzdCB0byBoZWxwIG1lIHdyaXRlIGEgSE1NIGF3YXJlIGRy
aXZlcj8NCg0KVGhlICh2ZXJ5IG5pY2UpIGhtbS50eHQgZG9jdW1lbnQgaXMgbm90IHJlZmVyZW5j
ZXMgaW4gdGhlIE1BSU5UQUlORVJTIGZpbGU/IFlvdSBtaWdodCB3YW50IHRvIGZpeCB0aGF0IHdo
ZW4geW91IGhhdmUgYSBtb21lbnQuDQoNClN0ZXBoZW4NCg0KDQo=
