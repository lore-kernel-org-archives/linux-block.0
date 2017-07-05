Return-Path: <ming.lei@redhat.com>
Date: Wed, 5 Jul 2017 15:14:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v2 3/8] nvme-loop: quiesce/unquiesce admin_q instead of
 start/stop its hw queues
Message-ID: <20170705071432.GB11084@ming.t460p>
References: <1499237591-15861-1-git-send-email-sagi@grimberg.me>
 <1499237591-15861-4-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499237591-15861-4-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 05, 2017 at 09:53:06AM +0300, Sagi Grimberg wrote:
> unlike blk_mq_stop_hw_queues and blk_mq_start_stopped_hw_queues
> quiescing/unquiescing respects the submission path rcu grace.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/target/loop.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index 3d51341e62ee..6a0b70685e77 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -434,9 +434,10 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
>  	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
>  		nvme_shutdown_ctrl(&ctrl->ctrl);
>  
> -	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
> +	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
>  	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
>  				nvme_cancel_request, &ctrl->ctrl);
> +	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
>  	nvme_loop_destroy_admin_queue(ctrl);
>  }
>  
> -- 
> 2.7.4
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
