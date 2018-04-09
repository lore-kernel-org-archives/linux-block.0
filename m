Return-Path: <hch@lst.de>
Date: Mon, 9 Apr 2018 12:04:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Keith Busch <keith.busch@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/8] blk-mq: don't keep offline CPUs mapped to hctx 0
Message-ID: <20180409100452.GB11144@lst.de>
References: <20180408094814.28953-1-ming.lei@redhat.com> <20180408094814.28953-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180408094814.28953-3-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Sun, Apr 08, 2018 at 05:48:08PM +0800, Ming Lei wrote:
> >From commit 4b855ad37194 ("blk-mq: Create hctx for each present CPU),
> blk-mq doesn't remap queue after CPU topo is changed, that said when
> some of these offline CPUs become online, they are still mapped to
> hctx 0, then hctx 0 may become the bottleneck of IO dispatch and
> completion.
> 
> This patch sets up the mapping from the beginning, and aligns to
> queue mapping for PCI device (blk_mq_pci_map_queues()).

Please kill the now pointless cpu_to_queue_index function.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
