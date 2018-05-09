Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Alex Williamson <alex.williamson@redhat.com>, Don Dutile
	<ddutile@redhat.com>
CC: Dan Williams <dan.j.williams@intel.com>, Logan Gunthorpe
	<logang@deltatee.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, linux-rdma <linux-rdma@vger.kernel.org>,
	linux-nvdimm <linux-nvdimm@lists.01.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jens Axboe
	<axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>, Sagi Grimberg
	<sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe
	<jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
	=?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
	<christian.koenig@amd.com>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Date: Wed, 9 May 2018 12:35:56 +0000
Message-ID: <B5BFCF39-6BB4-4E45-B805-C8FCC8B79EF3@raithlin.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <CAPcyv4g+5N_n03J-VhmJfrr60Sqk95ZapLKBkwSsGvV4nQ+ZRw@mail.gmail.com>
 <64C231F5-DE36-415F-B308-3A423B0BBACB@raithlin.com>
 <15433946-f7f5-f610-4e80-380fb59920e5@redhat.com>
 <3C9FB262-A93C-4C8F-B1E0-85C6D6F78BC2@raithlin.com>
 <c5f30ced-7bbf-9420-db1a-72519fc78b3a@redhat.com>
 <20180508180157.7c7b393f@w520.home>
In-Reply-To: <20180508180157.7c7b393f@w520.home>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

SGkgQWxleCBhbmQgRG9uDQoNCj4gICAgQ29ycmVjdCwgdGhlIFZNIGhhcyBubyBjb25jZXB0IG9m
IHRoZSBob3N0J3MgSU9NTVUgZ3JvdXBzLCBvbmx5IHRoZQ0KPiAgIGh5cGVydmlzb3Iga25vd3Mg
YWJvdXQgdGhlIGdyb3VwcywgDQoNCkJ1dCBhcyBJIHVuZGVyc3RhbmQgaXQgdGhlc2UgZ3JvdXBz
IGFyZSB1c3VhbGx5IHBhc3NlZCB0aHJvdWdoIHRvIFZNcyBvbiBhIHByZS1ncm91cCBiYXNpcyBi
eSB0aGUgaHlwZXJ2aXNvcj8gU28gSU9NTVUgZ3JvdXAgMSBtaWdodCBiZSBwYXNzZWQgdG8gVk0g
QSBhbmQgSU9NTVUgZ3JvdXAgMiBwYXNzZWQgdG8gVk0gQi4gU28gSSBhZ3JlZSB0aGUgVk0gaXMg
bm90IGF3YXJlIG9mIElPTU1VIGdyb3VwaW5ncyBidXQgaXQgaXMgaW1wYWN0ZWQgYnkgdGhlbSBp
biB0aGUgc2Vuc2UgdGhhdCBpZiB0aGUgZ3JvdXBpbmdzIGNoYW5nZSB0aGUgUENJIHRvcG9sb2d5
IHByZXNlbnRlZCB0byB0aGUgVk0gbmVlZHMgdG8gY2hhbmdlIHRvby4NCg0KU3RlcGhlbg0KDQo=
