Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1537900280.11137.30.camel@acm.org>
Subject: Re: [PATCH v7 02/13] PCI/P2PDMA: Add sysfs group to display p2pmem
 stats
From: Bart Van Assche <bvanassche@acm.org>
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
	linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>,  Jason Gunthorpe <jgg@mellanox.com>,
 Max Gurtovoy <maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
 =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>,  Alex Williamson
 <alex.williamson@redhat.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,  Jens Axboe <axboe@kernel.dk>
Date: Tue, 25 Sep 2018 11:31:20 -0700
In-Reply-To: <9241a6af-9826-d1ff-c13b-882cb3b6a34a@deltatee.com>
References: <20180925162231.4354-1-logang@deltatee.com>
	 <20180925162231.4354-3-logang@deltatee.com>
	 <1537896555.11137.22.camel@acm.org>
	 <9241a6af-9826-d1ff-c13b-882cb3b6a34a@deltatee.com>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-09-25 at 12:15 -0600, Logan Gunthorpe wrote:
+AD4 On 2018-09-25 11:29 a.m., Bart Van Assche wrote:
+AD4 +AD4 On Tue, 2018-09-25 at 10:22 -0600, Logan Gunthorpe wrote:
+AD4 +AD4 +AD4 +AEAAQA -83,9 +-132,14 +AEAAQA static int pci+AF8-p2pdma+AF8-setup(struct pci+AF8-dev +ACo-pdev)
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4  	pdev-+AD4-p2pdma +AD0 p2p+ADs
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4 +-	error +AD0 sysfs+AF8-create+AF8-group(+ACY-pdev-+AD4-dev.kobj, +ACY-p2pmem+AF8-group)+ADs
+AD4 +AD4 +AD4 +-	if (error)
+AD4 +AD4 +AD4 +-		goto out+AF8-pool+AF8-destroy+ADs
+AD4 +AD4 +AD4 +-
+AD4 +AD4 +AD4  	return 0+ADs
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4  out+AF8-pool+AF8-destroy:
+AD4 +AD4 +AD4 +-	pdev-+AD4-p2pdma +AD0 NULL+ADs
+AD4 +AD4 +AD4  	gen+AF8-pool+AF8-destroy(p2p-+AD4-pool)+ADs
+AD4 +AD4 +AD4  out:
+AD4 +AD4 +AD4  	devm+AF8-kfree(+ACY-pdev-+AD4-dev, p2p)+ADs
+AD4 +AD4 
+AD4 +AD4 This doesn't look right to me. Shouldn't devm+AF8-remove+AF8-action() be called instead
+AD4 +AD4 of devm+AF8-kfree() if sysfs+AF8-create+AF8-group() fails?
+AD4 
+AD4 That makes no sense to me. We are reversing a devm+AF8-kzalloc() not a
+AD4 custom action....

In case what I wrote was not clear: both devm+AF8-kzalloc() and
devm+AF8-add+AF8-action+AF8-or+AF8-reset() have to be reversed if sysfs+AF8-create+AF8-group() fails.
devm+AF8-add+AF8-action+AF8-or+AF8-reset() calls devres+AF8-add(). The latter function adds an
element to the dev-+AD4-devres+AF8-head list. So I think that only calling devm+AF8-kfree()
if sysfs+AF8-create+AF8-group() fails will lead to corruption of the dev-+AD4-devres+AF8-head
list.

Bart.
