Return-Path: <ming.lei@redhat.com>
Date: Sat, 19 May 2018 07:03:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Laurence Oberman <loberman@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 3/6] nvme: Move all IO out of controller reset
Message-ID: <20180518230357.GC18334@ming.t460p>
References: <20180518163823.27820-1-keith.busch@intel.com>
 <20180518163823.27820-3-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180518163823.27820-3-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 18, 2018 at 10:38:20AM -0600, Keith Busch wrote:
> IO may be retryable, so don't wait for them in the reset path. These
> commands may trigger a reset if that IO expires without a completion,
> placing it on the requeue list. Waiting for these would then deadlock
> the reset handler.
> 
> To fix the theoretical deadlock, this patch unblocks IO submission from
> the reset_work as before, but moves the waiting to the IO safe scan_work
> so that the reset_work may proceed to completion. Since the unfreezing
> happens in the controller LIVE state, the nvme device has to track if
> the queues were frozen now to prevent incorrect freeze depths.
> 
> This patch is also renaming the function 'nvme_dev_add' to a
> more appropriate name that describes what it's actually doing:
> nvme_alloc_io_tags.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/nvme/host/core.c |  3 +++
>  drivers/nvme/host/nvme.h |  1 +
>  drivers/nvme/host/pci.c  | 46 +++++++++++++++++++++++++++++++++-------------
>  3 files changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1de68b56b318..34d7731f1419 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -214,6 +214,7 @@ static inline bool nvme_req_needs_retry(struct request *req)
>  	if (blk_noretry_request(req))
>  		return false;
>  	if (nvme_req(req)->status & NVME_SC_DNR)
> +
>  		return false;
>  	if (nvme_req(req)->retries >= nvme_max_retries)
>  		return false;
> @@ -3177,6 +3178,8 @@ static void nvme_scan_work(struct work_struct *work)
>  	struct nvme_id_ctrl *id;
>  	unsigned nn;
>  
> +	if (ctrl->ops->update_hw_ctx)
> +		ctrl->ops->update_hw_ctx(ctrl);
>  	if (ctrl->state != NVME_CTRL_LIVE)
>  		return;
>  
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index c15c2ee7f61a..230c5424b197 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -320,6 +320,7 @@ struct nvme_ctrl_ops {
>  	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
>  	int (*reinit_request)(void *data, struct request *rq);
>  	void (*stop_ctrl)(struct nvme_ctrl *ctrl);
> +	void (*update_hw_ctx)(struct nvme_ctrl *ctrl);
>  };
>  
>  #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 2bd9d84f58d0..6a7cbc631d92 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -99,6 +99,7 @@ struct nvme_dev {
>  	u32 cmbloc;
>  	struct nvme_ctrl ctrl;
>  	struct completion ioq_wait;
> +	bool queues_froze;
>  
>  	/* shadow doorbell buffer support: */
>  	u32 *dbbuf_dbs;
> @@ -2065,10 +2066,33 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
>  	}
>  }
>  
> +static void nvme_pci_update_hw_ctx(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_dev *dev = to_nvme_dev(ctrl);
> +	bool unfreeze;
> +
> +	mutex_lock(&dev->shutdown_lock);
> +	unfreeze = dev->queues_froze;
> +	mutex_unlock(&dev->shutdown_lock);

What if nvme_dev_disable() just sets the .queues_froze flag and
userspace sends a RESCAN command at the same time?

> +
> +	if (unfreeze)
> +		nvme_wait_freeze(&dev->ctrl);
> +

timeout may comes just before&during blk_mq_update_nr_hw_queues() or
the above nvme_wait_freeze(), then both two may hang forever.

> +	blk_mq_update_nr_hw_queues(ctrl->tagset, dev->online_queues - 1);
> +	nvme_free_queues(dev, dev->online_queues);
> +
> +	if (unfreeze)
> +		nvme_unfreeze(&dev->ctrl);
> +
> +	mutex_lock(&dev->shutdown_lock);
> +	dev->queues_froze = false;
> +	mutex_unlock(&dev->shutdown_lock);

If the running scan work is triggered via user-space, the above code
may clear the .queues_froze flag wrong.

Thanks,
Ming
