Return-Path: <keith.busch@intel.com>
Date: Fri, 5 Jan 2018 11:11:53 -0700
From: Keith Busch <keith.busch@intel.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
	Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Dan Williams <dan.j.williams@intel.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 09/12] nvme-pci: Use PCI p2pmem subsystem to manage the
 CMB
Message-ID: <20180105181152.GA10657@localhost.localdomain>
References: <20180104190137.7654-1-logang@deltatee.com>
 <20180104190137.7654-10-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180104190137.7654-10-logang@deltatee.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jan 04, 2018 at 12:01:34PM -0700, Logan Gunthorpe wrote:
> Register the CMB buffer as p2pmem and use the appropriate allocation
> functions to create and destroy the IO SQ.
> 
> If the CMB supports WDS and RDS, publish it for use as p2p memory
> by other devices.

<>

> +	if (qid && dev->cmb_use_sqes) {
> +		nvmeq->sq_cmds = pci_alloc_p2pmem(pdev, SQ_SIZE(depth));

> +		nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
> +							    nvmeq->sq_cmds);
> +		nvmeq->sq_cmds_is_io = true;
> +	}

This gets into some spec type trouble for creating an IO submission
queue. We use the sq_dma_addr as the PRP entry to the Create I/O
SQ command, which has some requirements:

  "the PRP Entry shall have an offset of 0h."

So this has to be 4k aligned, but pci_alloc_p2pmem doesn't guarantee
that. I doubt the spec's intention was to require such alignment for
CMB SQs, but there may be controllers enforcing the rule as written.
