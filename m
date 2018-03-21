Return-Path: <hch@lst.de>
Date: Wed, 21 Mar 2018 10:27:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
	Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Dan Williams <dan.j.williams@intel.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH v3 11/11] nvmet: Optionally use PCI P2P memory
Message-ID: <20180321092702.GC7098@lst.de>
References: <20180312193525.2855-1-logang@deltatee.com> <20180312193525.2855-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180312193525.2855-12-logang@deltatee.com>
List-ID: <linux-block@vger.kernel.org>

> +				  const char *page, size_t count)
> +{
> +	struct nvmet_port *port = to_nvmet_port(item);
> +	struct device *dev;
> +	struct pci_dev *p2p_dev = NULL;
> +	bool use_p2pmem;
> +
> +	switch (page[0]) {
> +	case 'y':
> +	case 'Y':
> +	case 'a':
> +	case 'A':
> +		use_p2pmem = true;
> +		break;
> +	case 'n':
> +	case 'N':
> +		use_p2pmem = false;
> +		break;
> +	default:
> +		dev = bus_find_device_by_name(&pci_bus_type, NULL, page);
> +		if (!dev) {
> +			pr_err("No such PCI device: %s\n", page);
> +			return -ENODEV;
> +		}
> +
> +		use_p2pmem = true;
> +		p2p_dev = to_pci_dev(dev);
> +
> +		if (!pci_has_p2pmem(p2p_dev)) {
> +			pr_err("PCI device has no peer-to-peer memory: %s\n",
> +			       page);
> +			pci_dev_put(p2p_dev);
> +			return -ENODEV;
> +		}
> +	}

Yikes.  Shouldn't auto just be the normal yes case instead of this
string parsing mess?

> +	if (rsp->req.sg != &rsp->cmd->inline_sg) {
> +		if (rsp->req.p2p_dev)
> +			pci_p2pmem_free_sgl(rsp->req.p2p_dev, rsp->req.sg,
> +					    rsp->req.sg_cnt);
> +		else
> +			sgl_free(rsp->req.sg);
> +	}

Can we factor this into a helper, as the other target drivers (fc for now,
tcp soon) using sgl allocatins should share the code?

(same for the alloc side)
