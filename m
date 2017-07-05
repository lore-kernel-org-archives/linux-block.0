Return-Path: <ming.lei@redhat.com>
Date: Thu, 6 Jul 2017 06:44:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v3 1/8] nvme-rdma: quiesce/unquiesce admin_q instead of
 start/stop its hw queues
Message-ID: <20170705224400.GA2332@ming.t460p>
References: <1499274037-17438-1-git-send-email-sagi@grimberg.me>
 <1499274037-17438-2-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499274037-17438-2-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 05, 2017 at 08:00:30PM +0300, Sagi Grimberg wrote:
> unlike blk_mq_stop_hw_queues and blk_mq_start_stopped_hw_queues
> quiescing/unquiescing respects the submission path rcu grace.
> Also make sure to kick the requeue list when appropriate.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/rdma.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index cfb22531fc16..f2cf9638b4d2 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -778,7 +778,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
>  
>  	if (ctrl->ctrl.queue_count > 1)
>  		nvme_stop_queues(&ctrl->ctrl);
> -	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
> +	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
>  
>  	/* We must take care of fastfail/requeue all our inflight requests */
>  	if (ctrl->ctrl.queue_count > 1)
> @@ -791,7 +791,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
>  	 * queues are not a live anymore, so restart the queues to fail fast
>  	 * new IO
>  	 */
> -	blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
> +	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
>  	nvme_start_queues(&ctrl->ctrl);
>  
>  	nvme_rdma_reconnect_or_remove(ctrl);
> @@ -1636,9 +1636,10 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl)
>  	if (test_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags))
>  		nvme_shutdown_ctrl(&ctrl->ctrl);
>  
> -	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
> +	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
>  	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
>  				nvme_cancel_request, &ctrl->ctrl);
> +	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
>  	nvme_rdma_destroy_admin_queue(ctrl);
>  }
>  
> -- 
> 2.7.4
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
