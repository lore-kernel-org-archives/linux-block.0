Return-Path: <ming.lei@redhat.com>
Date: Wed, 28 Mar 2018 09:26:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux NVMe <linux-nvme@lists.infradead.org>,
	Linux Block <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, Don Brace <don.brace@microsemi.com>,
	qla2xxx-upstream@qlogic.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/3] blk-mq: Allow PCI vector offset for mapping queues
Message-ID: <20180328012648.GA17641@ming.t460p>
References: <20180327153908.3732-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180327153908.3732-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 27, 2018 at 09:39:06AM -0600, Keith Busch wrote:
> The PCI interrupt vectors intended to be associated with a queue may
> not start at 0; a driver may allocate pre_vectors for special use. This
> patch adds an offset parameter so blk-mq may find the intended affinity
> mask and updates all drivers using this API accordingly.
> 
> Cc: Don Brace <don.brace@microsemi.com>
> Cc: <qla2xxx-upstream@qlogic.com>
> Cc: <linux-scsi@vger.kernel.org>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
> v1 -> v2:
> 
>   Update blk-mq API directly instead of chaining a default parameter to
>   a new API, and update all drivers accordingly.
> 
>  block/blk-mq-pci.c                    | 6 ++++--
>  drivers/nvme/host/pci.c               | 2 +-
>  drivers/scsi/qla2xxx/qla_os.c         | 2 +-
>  drivers/scsi/smartpqi/smartpqi_init.c | 2 +-
>  include/linux/blk-mq-pci.h            | 3 ++-
>  5 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
> index 76944e3271bf..e233996bb76f 100644
> --- a/block/blk-mq-pci.c
> +++ b/block/blk-mq-pci.c
> @@ -21,6 +21,7 @@
>   * blk_mq_pci_map_queues - provide a default queue mapping for PCI device
>   * @set:	tagset to provide the mapping for
>   * @pdev:	PCI device associated with @set.
> + * @offset:	Offset to use for the pci irq vector
>   *
>   * This function assumes the PCI device @pdev has at least as many available
>   * interrupt vectors as @set has queues.  It will then query the vector
> @@ -28,13 +29,14 @@
>   * that maps a queue to the CPUs that have irq affinity for the corresponding
>   * vector.
>   */
> -int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev)
> +int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev,
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
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index cef5ce851a92..e3b9efca0571 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -414,7 +414,7 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
>  {
>  	struct nvme_dev *dev = set->driver_data;
>  
> -	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev));
> +	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev), 0);
>  }
>  
>  /**
> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> index 12ee6e02d146..2c705f3dd265 100644
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -6805,7 +6805,7 @@ static int qla2xxx_map_queues(struct Scsi_Host *shost)
>  	if (USER_CTRL_IRQ(vha->hw))
>  		rc = blk_mq_map_queues(&shost->tag_set);
>  	else
> -		rc = blk_mq_pci_map_queues(&shost->tag_set, vha->hw->pdev);
> +		rc = blk_mq_pci_map_queues(&shost->tag_set, vha->hw->pdev, 0);
>  	return rc;
>  }
>  
> diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
> index b2880c7709e6..10c94011c8a8 100644
> --- a/drivers/scsi/smartpqi/smartpqi_init.c
> +++ b/drivers/scsi/smartpqi/smartpqi_init.c
> @@ -5348,7 +5348,7 @@ static int pqi_map_queues(struct Scsi_Host *shost)
>  {
>  	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
>  
> -	return blk_mq_pci_map_queues(&shost->tag_set, ctrl_info->pci_dev);
> +	return blk_mq_pci_map_queues(&shost->tag_set, ctrl_info->pci_dev, 0);
>  }
>  
>  static int pqi_getpciinfo_ioctl(struct pqi_ctrl_info *ctrl_info,
> diff --git a/include/linux/blk-mq-pci.h b/include/linux/blk-mq-pci.h
> index 6338551e0fb9..9f4c17f0d2d8 100644
> --- a/include/linux/blk-mq-pci.h
> +++ b/include/linux/blk-mq-pci.h
> @@ -5,6 +5,7 @@
>  struct blk_mq_tag_set;
>  struct pci_dev;
>  
> -int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev);
> +int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev,
> +			  int offset);
>  
>  #endif /* _LINUX_BLK_MQ_PCI_H */
> -- 
> 2.14.3
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
