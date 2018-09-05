Return-Path: <ming.lei@redhat.com>
Date: Thu, 6 Sep 2018 06:09:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, bart.vanassche@wdc.com, sagi@grimberg.me,
	keith.busch@intel.com, jthumshirn@suse.de, jsmart2021@gmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme-pci: use queue close instead of queue freeze
Message-ID: <20180905220910.GC21352@ming.t460p>
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
 <1536120586-3378-4-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1536120586-3378-4-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 05, 2018 at 12:09:46PM +0800, Jianchao Wang wrote:
> nvme_dev_disable freezes queues to prevent new IO. nvme_reset_work
> will unfreeze and wait to drain the queues. However, if IO timeout
> at the moment, no body could do recovery as nvme_reset_work is
> waiting. We will encounter IO hang.
> 
> To avoid this scenario, use queue close to prevent new IO which
> doesn't need to drain the queues. And just use queue freeze to
> try to wait for in-flight IO for shutdown case.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  drivers/nvme/host/core.c | 22 ++++++++++++++++++++++
>  drivers/nvme/host/nvme.h |  3 +++
>  drivers/nvme/host/pci.c  | 27 ++++++++++++++-------------
>  3 files changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dd8ec1d..ce5b35b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3602,6 +3602,28 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>  }
>  EXPORT_SYMBOL_GPL(nvme_kill_queues);
>  
> +void nvme_close_queues(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_ns *ns;
> +
> +	down_read(&ctrl->namespaces_rwsem);
> +	list_for_each_entry(ns, &ctrl->namespaces, list)
> +		blk_set_queue_closed(ns->queue);
> +	up_read(&ctrl->namespaces_rwsem);
> +}
> +EXPORT_SYMBOL_GPL(nvme_close_queues);
> +
> +void nvme_open_queues(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_ns *ns;
> +
> +	down_read(&ctrl->namespaces_rwsem);
> +	list_for_each_entry(ns, &ctrl->namespaces, list)
> +		blk_clear_queue_closed(ns->queue);
> +	up_read(&ctrl->namespaces_rwsem);
> +}
> +EXPORT_SYMBOL_GPL(nvme_open_queues);
> +
>  void nvme_unfreeze(struct nvme_ctrl *ctrl)
>  {
>  	struct nvme_ns *ns;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bb4a200..fcd44cb 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -437,6 +437,9 @@ void nvme_wait_freeze(struct nvme_ctrl *ctrl);
>  void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
>  void nvme_start_freeze(struct nvme_ctrl *ctrl);
>  
> +void nvme_close_queues(struct nvme_ctrl *ctrl);
> +void nvme_open_queues(struct nvme_ctrl *ctrl);
> +
>  #define NVME_QID_ANY -1
>  struct request *nvme_alloc_request(struct request_queue *q,
>  		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d668682..c0ccd04 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2145,23 +2145,25 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  
>  	mutex_lock(&dev->shutdown_lock);
> +	nvme_close_queues(&dev->ctrl);
>  	if (pci_is_enabled(pdev)) {
>  		u32 csts = readl(dev->bar + NVME_REG_CSTS);
>  
> -		if (dev->ctrl.state == NVME_CTRL_LIVE ||
> -		    dev->ctrl.state == NVME_CTRL_RESETTING)
> -			nvme_start_freeze(&dev->ctrl);
>  		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
>  			pdev->error_state  != pci_channel_io_normal);
> -	}
>  
> -	/*
> -	 * Give the controller a chance to complete all entered requests if
> -	 * doing a safe shutdown.
> -	 */
> -	if (!dead) {
> -		if (shutdown)
> -			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
> +		if (dev->ctrl.state == NVME_CTRL_LIVE ||
> +		    dev->ctrl.state == NVME_CTRL_RESETTING) {
> +			/*
> +			 * Give the controller a chance to complete all entered
> +			 * requests if doing a safe shutdown.
> +			 */
> +			if (!dead && shutdown) {
> +				nvme_start_freeze(&dev->ctrl);
> +				nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
> +				nvme_unfreeze(&dev->ctrl);
> +			}
> +		}
>  	}
>  
>  	nvme_stop_queues(&dev->ctrl);
> @@ -2328,11 +2330,9 @@ static void nvme_reset_work(struct work_struct *work)
>  		new_state = NVME_CTRL_ADMIN_ONLY;
>  	} else {
>  		nvme_start_queues(&dev->ctrl);
> -		nvme_wait_freeze(&dev->ctrl);
>  		/* hit this only when allocate tagset fails */
>  		if (nvme_dev_add(dev))
>  			new_state = NVME_CTRL_ADMIN_ONLY;
> -		nvme_unfreeze(&dev->ctrl);

nvme_dev_add() still may call freeze & unfreeze queue, so your patch
can't avoid draining queue completely here.

Thanks,
Ming
