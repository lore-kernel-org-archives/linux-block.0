Return-Path: <hch@lst.de>
Date: Wed, 28 Mar 2018 09:32:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux NVMe <linux-nvme@lists.infradead.org>,
	Linux Block <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] nvme-pci: Separate IO and admin queue IRQ vectors
Message-ID: <20180328073214.GA18726@lst.de>
References: <20180327153908.3732-1-keith.busch@intel.com> <20180327153908.3732-3-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180327153908.3732-3-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 27, 2018 at 09:39:08AM -0600, Keith Busch wrote:
> -	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev), 0);
> +	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev),
> +				     dev->num_vecs > 1);

Can you turn this into:

-	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev), 0);
			     dev->num_vecs > 1 ? 1 /* admin queue */ : 0);

no functional change, but much easier to understand.

Except for that the whole series looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
