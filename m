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
	"Alex Williamson" <alex.williamson@redhat.com>, Steve Wise
	<swise@opengridcomputing.com>
Subject: Re: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
Date: Thu, 1 Mar 2018 16:15:04 +0000
Message-ID: <A95AE6BF-1CAC-48F5-B676-DA7BD6D5BF24@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
In-Reply-To: <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

PiA+IElkZWFsbHksIHdlJ2Qgd2FudCB0byB1c2UgYW4gTlZNRSBDTUIgYnVmZmVyIGFzIHAycCBt
ZW1vcnkuIFRoaXMgd291bGQNCj4gPiBzYXZlIGFuIGV4dHJhIFBDSSB0cmFuc2ZlciBhcyB0aGUg
TlZNRSBjYXJkIGNvdWxkIGp1c3QgdGFrZSB0aGUgZGF0YQ0KPiA+IG91dCBvZiBpdCdzIG93biBt
ZW1vcnkuIEhvd2V2ZXIsIGF0IHRoaXMgdGltZSwgY2FyZHMgd2l0aCBDTUIgYnVmZmVycw0KPiA+
IGRvbid0IHNlZW0gdG8gYmUgYXZhaWxhYmxlLg0KDQo+IENhbiB5b3UgZGVzY3JpYmUgd2hhdCB3
b3VsZCBiZSB0aGUgcGxhbiB0byBoYXZlIGl0IHdoZW4gdGhlc2UgZGV2aWNlcw0KPiBkbyBjb21l
IGFsb25nPyBJJ2Qgc2F5IHRoYXQgcDJwX2RldiBuZWVkcyB0byBiZWNvbWUgYSBudm1ldF9ucyBy
ZWZlcmVuY2UNCj4gYW5kIG5vdCBmcm9tIG52bWV0X2N0cmwuIFRoZW4sIHdoZW4gY21iIGNhcGFi
bGUgZGV2aWNlcyBjb21lIGFsb25nLCB0aGUNCj4gbnMgY2FuIHByZWZlciB0byB1c2UgaXRzIG93
biBjbWIgaW5zdGVhZCBvZiBsb2NhdGluZyBhIHAycF9kZXYgZGV2aWNlPw0KDQpIaSBTYWdpDQoN
ClRoYW5rcyBmb3IgdGhlIHJldmlldyEgVGhhdCBjb21taXQgbWVzc2FnZSBpcyBzb21ld2hhdCBk
YXRlZCBhcyBOVk1lIGNvbnRyb2xsZXJzIHdpdGggQ01CcyB0aGF0IHN1cHBvcnQgUkRTIGFuZCBX
RFMgYXJlIG5vdyBjb21tZXJjaWFsbHkgYXZhaWxhYmxlIFsxXS4gSG93ZXZlciB3ZSBoYXZlIG5v
dCB5ZXQgdHJpZWQgdG8gZG8gYW55IGtpbmQgb2Ygb3B0aW1pemF0aW9uIGFyb3VuZCB0aGlzIHll
dCBpbiB0ZXJtcyBvZiBkZXRlcm1pbmluZyB3aGljaCBwMnBfZGV2IHRvIHVzZS4gWW91ciBzdWdn
ZXN0IGFib3ZlIGxvb2tzIGdvb2QgYW5kIHdlIGNhbiBsb29rIGludG8gdGhpcyBraW5kIG9mIG9w
dGltaXphdGlvbiBpbiBkdWUgY291cnNlLg0KDQpbMV0gaHR0cDovL3d3dy5laWRldGljb20uY29t
L3VwbG9hZHMvaW1hZ2VzL05vTG9hZF9Qcm9kdWN0X1NwZWMucGRmDQogICAgDQo+PiArCWN0cmwt
PnAycF9kZXYgPSBwY2lfcDJwbWVtX2ZpbmQoJmN0cmwtPnAycF9jbGllbnRzKTsNCg0KPiBUaGlz
IGlzIHRoZSBmaXJzdCBwMnBfZGV2IGZvdW5kIHJpZ2h0PyBXaGF0IGhhcHBlbnMgaWYgSSBoYXZl
IG1vcmUgdGhhbg0KPiBhIHNpbmdsZSBwMnAgZGV2aWNlPyBJbiB0aGVvcnkgSSdkIGhhdmUgbW9y
ZSBwMnAgbWVtb3J5IEkgY2FuIHVzZS4gSGF2ZQ0KPiB5b3UgY29uc2lkZXJlZCBtYWtpbmcgcGNp
X3AycG1lbV9maW5kIHJldHVybiB0aGUgbGVhc3QgdXNlZCBzdWl0YWJsZQ0KPiBkZXZpY2U/DQog
ICAgDQpZZXMgcGNpX3AycG1lbV9maW5kIHdpbGwgYWx3YXlzIHJldHVybiB0aGUgZmlyc3QgdmFs
aWQgcDJwX2RldiBmb3VuZC4gQXQgdGhlIHZlcnkgbGVhc3Qgd2Ugc2hvdWxkIHVwZGF0ZSB0aGlz
IGFsbG9jYXRlIG92ZXIgYWxsIHRoZSB2YWxpZCBwMnBfZGV2LiBTaW5jZSB0aGUgbG9hZCBvbiBh
bnkgZ2l2ZW4gcDJwX2RldiB3aWxsIHZhcnkgb3ZlciB0aW1lIEkgdGhpbmsgYSByYW5kb20gYWxs
b2NhdGlvbiBvZiB0aGUgZGV2aWNlcyBtYWtlcyBzZW5zZSAoYXQgbGVhc3QgZm9yIG5vdykuIA0K
DQpTdGVwaGVuDQoNCg==
