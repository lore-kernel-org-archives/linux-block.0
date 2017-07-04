Return-Path: <ming.lei@redhat.com>
Date: Tue, 4 Jul 2017 16:18:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 2/8] nvme-fc: quiesce/unquiesce admin_q instead of
 start/stop its hw queues
Message-ID: <20170704081833.GD29053@ming.t460p>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
 <1499154912-10420-3-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499154912-10420-3-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 04, 2017 at 10:55:06AM +0300, Sagi Grimberg wrote:
> unlike blk_mq_stop_hw_queues and blk_mq_start_stopped_hw_queues
> quiescing/unquiescing respects the submission path rcu grace.
> Also make sure to kick the requeue list when appropriate.
> 
> Reviewed-By: James Smart <james.smart@broadcom.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/fc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 50cc3b2b0e11..d63263f0b530 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2320,8 +2320,10 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>  	if (ret)
>  		goto out_delete_hw_queue;
>  
> -	if (ctrl->ctrl.state != NVME_CTRL_NEW)
> -		blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
> +	if (ctrl->ctrl.state != NVME_CTRL_NEW) {
> +		blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
> +		blk_mq_kick_requeue_list(ctrl->ctrl.admin_q);

Same question as that in patch 1 about blk_mq_kick_requeue_list().

-- 
Ming
