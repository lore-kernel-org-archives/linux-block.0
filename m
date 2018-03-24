Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 1/3] blk-mq: Allow PCI vector offset for mapping queues
To: Keith Busch <keith.busch@intel.com>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Linux Block <linux-block@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20180323221923.24545-1-keith.busch@intel.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <d818f023-01a5-0728-2cc9-7a0649b5df3c@oracle.com>
Date: Sat, 24 Mar 2018 21:55:49 +0800
MIME-Version: 1.0
In-Reply-To: <20180323221923.24545-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Keith

Thanks for your time and patch for this.

On 03/24/2018 06:19 AM, Keith Busch wrote:
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

Maybe we could provide a callback parameter for __blk_mq_pci_map_queues which
give the mapping from hctx queue num to device-relative interrupt vector index.

Thanks
Jianchao
