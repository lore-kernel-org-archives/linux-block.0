Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Christoph
 Hellwig" <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas
	<bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy
	<maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
	=?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: Re: [PATCH v2 04/10] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Date: Thu, 1 Mar 2018 21:32:20 +0000
Message-ID: <EE1B4EB7-D3C0-4916-81CE-E647222D03E4@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-5-logang@deltatee.com>
 <20180301180257.GH13722@bhelgaas-glaptop.roam.corp.google.com>
 <0D05579B-789C-4A19-B3A2-C1A630BE31C0@raithlin.com>
 <20180301142155.5966c4c0@w520.home>
In-Reply-To: <20180301142155.5966c4c0@w520.home>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

PiB5b3VyIGtlcm5lbCBwcm92aWRlciBuZWVkcyB0byBkZWNpZGUgd2hldGhlciB0aGV5IGZhdm9y
IGRldmljZSBhc3NpZ25tZW50IG9yIHAycA0KDQpUaGFua3MgQWxleCEgVGhlIGhhcmR3YXJlIHJl
cXVpcmVtZW50cyBmb3IgUDJQIChzd2l0Y2gsIGhpZ2ggcGVyZm9ybWFuY2UgRVBzKSBhcmUgc3Vj
aCB0aGF0IHdlIHJlYWxseSBvbmx5IGV4cGVjdCBDT05GSUdfUDJQX0RNQSB0byBiZSBlbmFibGVk
IGluIHNwZWNpZmljIGluc3RhbmNlcyBhbmQgaW4gdGhvc2UgaW5zdGFuY2VzIHRoZSB1c2VycyBo
YXZlIG1hZGUgYSBkZWNpc2lvbiB0byBmYXZvciBQMlAgb3ZlciBJT01NVSBpc29sYXRpb24uIE9y
IHRoZXkgaGF2ZSBzZXR1cCB0aGVpciBQQ0llIHRvcG9sb2d5IGluIGEgd2F5IHRoYXQgZ2l2ZXMg
dGhlbSBJT01NVSBpc29sYXRpb24gd2hlcmUgdGhleSB3YW50IGl0IGFuZCBQMlAgd2hlcmUgdGhl
eSB3YW50IGl0Lg0KDQpTdGVwaGVuDQogDQoNCg==
