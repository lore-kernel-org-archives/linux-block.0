Return-Path: <ming.lei@redhat.com>
Date: Wed, 5 Jul 2017 15:20:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v2 4/8] nvme-pci: quiesce/unquiesce admin_q instead of
 start/stop its hw queues
Message-ID: <20170705071958.GD11084@ming.t460p>
References: <1499237591-15861-1-git-send-email-sagi@grimberg.me>
 <1499237591-15861-5-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499237591-15861-5-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 05, 2017 at 09:53:07AM +0300, Sagi Grimberg wrote:
> unlike blk_mq_stop_hw_queues and blk_mq_start_stopped_hw_queues
> quiescing/unquiescing respects the submission path rcu grace.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/pci.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index eb729ff70e7d..df7c8a355075 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1125,7 +1125,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
>  	spin_unlock_irq(&nvmeq->q_lock);
>  
>  	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
> -		blk_mq_stop_hw_queues(nvmeq->dev->ctrl.admin_q);
> +		blk_mq_quiesce_queue(nvmeq->dev->ctrl.admin_q);
>  
>  	pci_free_irq(to_pci_dev(nvmeq->dev->dev), vector, nvmeq);
>  
> @@ -1315,7 +1315,7 @@ static void nvme_dev_remove_admin(struct nvme_dev *dev)
>  		 * user requests may be waiting on a stopped queue. Start the
>  		 * queue to flush these to completion.
>  		 */
> -		blk_mq_start_stopped_hw_queues(dev->ctrl.admin_q, true);
> +		blk_mq_unquiesce_queue(dev->ctrl.admin_q);
>  		blk_cleanup_queue(dev->ctrl.admin_q);
>  		blk_mq_free_tag_set(&dev->admin_tagset);
>  	}
> @@ -1351,8 +1351,10 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
>  			dev->ctrl.admin_q = NULL;
>  			return -ENODEV;
>  		}
> -	} else
> -		blk_mq_start_stopped_hw_queues(dev->ctrl.admin_q, true);
> +	} else {
> +		blk_mq_unquiesce_queue(dev->ctrl.admin_q);
> +		blk_mq_kick_requeue_list(dev->ctrl.admin_q);
> +	}

Hammmm, the kick is still not needed. Actually kick requeue list
is only needed where we restart the queue. For quiesce and unquiesce,
we don't touch the STOPPED state, so needn't to kick requeue list.

-- 
Ming
