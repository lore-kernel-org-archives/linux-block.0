Return-Path: <ming.lei@redhat.com>
Date: Wed, 5 Jul 2017 15:16:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 2/8] nvme-fc: quiesce/unquiesce admin_q instead of
 start/stop its hw queues
Message-ID: <20170705071632.GC11084@ming.t460p>
References: <1499237591-15861-1-git-send-email-sagi@grimberg.me>
 <1499237591-15861-3-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499237591-15861-3-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 05, 2017 at 09:53:05AM +0300, Sagi Grimberg wrote:
> unlike blk_mq_stop_hw_queues and blk_mq_start_stopped_hw_queues
> quiescing/unquiescing respects the submission path rcu grace.
> 
> Also, make sure to unquiesce before cleanup the admin queue.
> 
> Reviewed-By: James Smart <james.smart@broadcom.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/fc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 50cc3b2b0e11..3e35fc622680 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1703,6 +1703,7 @@ nvme_fc_ctrl_free(struct kref *ref)
>  	list_del(&ctrl->ctrl_list);
>  	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
>  
> +	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
>  	blk_cleanup_queue(ctrl->ctrl.admin_q);
>  	blk_mq_free_tag_set(&ctrl->admin_tag_set);
>  
> @@ -2320,8 +2321,10 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>  	if (ret)
>  		goto out_delete_hw_queue;
>  
> -	if (ctrl->ctrl.state != NVME_CTRL_NEW)
> -		blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
> +	if (ctrl->ctrl.state != NVME_CTRL_NEW) {
> +		blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
> +		blk_mq_kick_requeue_list(ctrl->ctrl.admin_q);

Same comment with patch 1

-- 
Ming
