Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 17 Aug 2017 13:37:42 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq-pci: add a fallback when pci_irq_get_affinity
 returns NULL
Message-ID: <20170817203742.GC2459@vader>
References: <20170817102447.28819-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170817102447.28819-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 17, 2017 at 12:24:47PM +0200, Christoph Hellwig wrote:
> While pci_irq_get_affinity should never fail for SMP kernel that
> implement the affinity mapping, it will always return NULL in the
> UP case, so provide a fallback mapping of all queues to CPU 0 in
> that case.

Reviewed-by: Omar Sandoval <osandov@fb.com>

Has nvme been fixed to not crash if blk_mq_alloc_tag_set() fails?

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Cc: stable@vger.kernel.org
> ---
>  block/blk-mq-pci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
> index 0c3354cf3552..76944e3271bf 100644
> --- a/block/blk-mq-pci.c
> +++ b/block/blk-mq-pci.c
> @@ -36,12 +36,18 @@ int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev)
>  	for (queue = 0; queue < set->nr_hw_queues; queue++) {
>  		mask = pci_irq_get_affinity(pdev, queue);
>  		if (!mask)
> -			return -EINVAL;
> +			goto fallback;
>  
>  		for_each_cpu(cpu, mask)
>  			set->mq_map[cpu] = queue;
>  	}
>  
>  	return 0;
> +
> +fallback:
> +	WARN_ON_ONCE(set->nr_hw_queues > 1);
> +	for_each_possible_cpu(cpu)
> +		set->mq_map[cpu] = 0;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_pci_map_queues);
> -- 
> 2.11.0
> 
