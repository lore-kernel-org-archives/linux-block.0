Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1537896805.11137.25.camel@acm.org>
Subject: Re: [PATCH v7 03/13] PCI/P2PDMA: Add PCI p2pmem DMA mappings to
 adjust the bus offset
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
Date: Tue, 25 Sep 2018 10:33:25 -0700
In-Reply-To: <20180925162231.4354-4-logang@deltatee.com>
References: <20180925162231.4354-1-logang@deltatee.com>
	 <20180925162231.4354-4-logang@deltatee.com>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-09-25 at 10:22 -0600, Logan Gunthorpe wrote:
+AD4 +-int pci+AF8-p2pdma+AF8-map+AF8-sg(struct device +ACo-dev, struct scatterlist +ACo-sg, int nents,
+AD4 +-		      enum dma+AF8-data+AF8-direction dir)
+AD4 +-+AHs
+AD4 +-	struct dev+AF8-pagemap +ACo-pgmap+ADs
+AD4 +-	struct scatterlist +ACo-s+ADs
+AD4 +-	phys+AF8-addr+AF8-t paddr+ADs
+AD4 +-	int i+ADs
+AD4 +-
+AD4 +-	/+ACo
+AD4 +-	 +ACo p2pdma mappings are not compatible with devices that use
+AD4 +-	 +ACo dma+AF8-virt+AF8-ops. If the upper layers do the right thing
+AD4 +-	 +ACo this should never happen because it will be prevented
+AD4 +-	 +ACo by the check in pci+AF8-p2pdma+AF8-add+AF8-client()
+AD4 +-	 +ACo-/
+AD4 +-	if (WARN+AF8-ON+AF8-ONCE(IS+AF8-ENABLED(CONFIG+AF8-DMA+AF8-VIRT+AF8-OPS) +ACYAJg
+AD4 +-			 dev-+AD4-dma+AF8-ops +AD0APQ +ACY-dma+AF8-virt+AF8-ops))
+AD4 +-		return 0+ADs

Are you assuming that the compiler will optimize out the dev-+AD4-dma+AF8-ops
+AD0APQ +ACY-dma+AF8-virt+AF8-ops test if CONFIG+AF8-DMA+AF8-VIRT+AF8-OPS+AD0-n such that no reference to the
dma+AF8-virt+AF8-ops symbol appears in the object file? Are you sure all compilers
and compiler versions that are used to build the Linux kernel will do that?

Thanks,

Bart.
