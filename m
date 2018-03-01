Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Logan Gunthorpe <logang@deltatee.com>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Christoph
 Hellwig" <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<keith.busch@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy
	<maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
	=?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Alex Williamson <alex.williamson@redhat.com>,
	Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
Date: Thu, 1 Mar 2018 23:32:46 +0000
Message-ID: <2F4ADC7B-0A78-4FA3-9DE3-B20FB0C537E7@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
 <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
 <20180301184249.GI19007@ziepe.ca>
 <edaf476a-cfe9-0598-1aa5-14802a9a1477@deltatee.com>
 <20180301224540.GL19007@ziepe.ca>
 <77591162-4CCD-446E-A27C-1CDB4996ACB7@raithlin.com>
 <20180301232038.GO19007@ziepe.ca>
In-Reply-To: <20180301232038.GO19007@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

PiAgIE5vLCBsb2NhbGl0eSBtYXR0ZXJzLiBJZiB5b3UgaGF2ZSBhIGJ1bmNoIG9mIE5JQ3MgYW5k
IGJ1bmNoIG9mIGRyaXZlcw0KPiAgIGFuZCB0aGUgYWxsb2NhdG9yIGNob29zZXMgdG8gcHV0IGFs
bCBQMlAgbWVtb3J5IG9uIGEgc2luZ2xlIGRyaXZlIHlvdXINCj4gICBwZXJmb3JtYW5jZSB3aWxs
IHN1Y2sgaG9ycmlibHkgZXZlbiBpZiBhbGwgdGhlIHRyYWZmaWMgaXMgb2ZmbG9hZGVkLg0KICAg
IA0KU2FnaSBicm91Z2h0IHRoaXMgdXAgZWFybGllciBpbiBoaXMgY29tbWVudHMgYWJvdXQgdGhl
IF9maW5kXyBmdW5jdGlvbi4gV2UgYXJlIHBsYW5uaW5nIHRvIGRvIHNvbWV0aGluZyBhYm91dCB0
aGlzIGluIHRoZSBuZXh0IHZlcnNpb24uIFRoaXMgbWlnaHQgYmUgYSByYW5kb21pemF0aW9uIG9y
IGEgInVzZXItcGljayIgYW5kIGluY2x1ZGUgYSBydWxlIGFyb3VuZCB1c2luZyB0aGUgcDJwX2Rl
diBvbiB0aGUgRVAgaWYgdGhhdCBFUCBpcyBwYXJ0IG9mIHRoZSB0cmFuc2FjdGlvbi4NCg0KU3Rl
cGhlbg0KDQoNCiAgICANCg0K
