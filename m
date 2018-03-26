Return-Path: <ming.lei@redhat.com>
Date: Mon, 26 Mar 2018 09:50:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux NVMe <linux-nvme@lists.infradead.org>,
	Linux Block <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/3] blk-mq: Allow PCI vector offset for mapping queues
Message-ID: <20180326015038.GD9828@ming.t460p>
References: <20180323221923.24545-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180323221923.24545-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Mar 23, 2018 at 04:19:21PM -0600, Keith Busch wrote:
> The PCI interrupt vectors intended to be associated with a queue may
> not start at 0. This patch adds an offset parameter so blk-mq may find
> the intended affinity mask. The default value is 0 so existing drivers
> that don't care about this parameter don't need to change.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  block/blk-mq-pci.c         | 12 ++++++++++--
>  include/linux/blk-mq-pci.h |  2 ++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
> index 76944e3271bf..1040a7705c13 100644
> --- a/block/blk-mq-pci.c
> +++ b/block/blk-mq-pci.c
> @@ -21,6 +21,7 @@
>   * blk_mq_pci_map_queues - provide a default queue mapping for PCI device
>   * @set:	tagset to provide the mapping for
>   * @pdev:	PCI device associated with @set.
> + * @offset:	PCI irq starting vector offset
>   *
>   * This function assumes the PCI device @pdev has at least as many available
>   * interrupt vectors as @set has queues.  It will then query the vector
> @@ -28,13 +29,14 @@
>   * that maps a queue to the CPUs that have irq affinity for the corresponding
>   * vector.
>   */
> -int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev)
> +int __blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev,
> +			    int offset)
>  {
>  	const struct cpumask *mask;
>  	unsigned int queue, cpu;
>  
>  	for (queue = 0; queue < set->nr_hw_queues; queue++) {
> -		mask = pci_irq_get_affinity(pdev, queue);
> +		mask = pci_irq_get_affinity(pdev, queue + offset);
>  		if (!mask)
>  			goto fallback;
>  
> @@ -50,4 +52,10 @@ int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev)
>  		set->mq_map[cpu] = 0;
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(__blk_mq_pci_map_queues);
> +
> +int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev)
> +{
> +	return __blk_mq_pci_map_queues(set, pdev, 0);
> +}
>  EXPORT_SYMBOL_GPL(blk_mq_pci_map_queues);
> diff --git a/include/linux/blk-mq-pci.h b/include/linux/blk-mq-pci.h
> index 6338551e0fb9..5a92ecdbd78e 100644
> --- a/include/linux/blk-mq-pci.h
> +++ b/include/linux/blk-mq-pci.h
> @@ -5,6 +5,8 @@
>  struct blk_mq_tag_set;
>  struct pci_dev;
>  
> +int __blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev,
> +			    int offset);
>  int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev);
>  
>  #endif /* _LINUX_BLK_MQ_PCI_H */
> -- 
> 2.14.3
> 

Given no many callers of blk_mq_pci_map_queues(), I suggest to add the
parameter of 'offset' to this API directly, then people may keep the 
'.pre_vectors' stuff in mind, and avoid to misuse it.

Thanks,
Ming
