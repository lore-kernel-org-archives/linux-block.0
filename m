Return-Path: <ming.lei@redhat.com>
Date: Sat, 19 May 2018 06:32:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Laurence Oberman <loberman@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 1/6] nvme: Sync request queues on reset
Message-ID: <20180518223210.GB18334@ming.t460p>
References: <20180518163823.27820-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180518163823.27820-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 18, 2018 at 10:38:18AM -0600, Keith Busch wrote:
> This patch fixes races that occur with simultaneous controller
> resets by synchronizing request queues prior to initializing the
> controller. Withouth this, a thread may attempt disabling a controller
> at the same time as we're trying to enable it.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/nvme/host/core.c | 21 +++++++++++++++++++--
>  drivers/nvme/host/nvme.h |  1 +
>  drivers/nvme/host/pci.c  |  1 +
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 99b857e5a7a9..1de68b56b318 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3471,6 +3471,12 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(nvme_init_ctrl);
>  
> +static void nvme_start_queue(struct nvme_ns *ns)
> +{
> +	blk_mq_unquiesce_queue(ns->queue);
> +	blk_mq_kick_requeue_list(ns->queue);
> +}
> +
>  /**
>   * nvme_kill_queues(): Ends all namespace queues
>   * @ctrl: the dead controller that needs to end
> @@ -3499,7 +3505,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>  		blk_set_queue_dying(ns->queue);
>  
>  		/* Forcibly unquiesce queues to avoid blocking dispatch */
> -		blk_mq_unquiesce_queue(ns->queue);
> +		nvme_start_queue(ns);
>  	}
>  	up_read(&ctrl->namespaces_rwsem);
>  }
> @@ -3569,11 +3575,22 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
>  
>  	down_read(&ctrl->namespaces_rwsem);
>  	list_for_each_entry(ns, &ctrl->namespaces, list)
> -		blk_mq_unquiesce_queue(ns->queue);
> +		nvme_start_queue(ns);
>  	up_read(&ctrl->namespaces_rwsem);
>  }
>  EXPORT_SYMBOL_GPL(nvme_start_queues);
>  
> +void nvme_sync_queues(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_ns *ns;
> +
> +	down_read(&ctrl->namespaces_rwsem);
> +	list_for_each_entry(ns, &ctrl->namespaces, list)
> +		blk_sync_queue(ns->queue);
> +	up_read(&ctrl->namespaces_rwsem);
> +}
> +EXPORT_SYMBOL_GPL(nvme_sync_queues);

This way can't sync timeout reliably, since timeout events can
come from two NS at the same time, and one may be handled as
RESET_TIMER, and another one can be handled as EH_HANDLED.


Thanks,
Ming
