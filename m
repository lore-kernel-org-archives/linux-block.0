Return-Path: <ming.lei@redhat.com>
Date: Tue, 4 Jul 2017 16:23:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 3/8] nvme-loop: quiesce admin_q instead of stopping hw
 queues
Message-ID: <20170704082232.GE29053@ming.t460p>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
 <1499154912-10420-4-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499154912-10420-4-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 04, 2017 at 10:55:07AM +0300, Sagi Grimberg wrote:
> Before we iterate over the tags, we need to make sure that
> no inflight requests are being queued, so use quiesce
> helper for that.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/target/loop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index 3d51341e62ee..891002ee005f 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -434,7 +434,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
>  	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
>  		nvme_shutdown_ctrl(&ctrl->ctrl);
>  
> -	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
> +	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
>  	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
>  				nvme_cancel_request, &ctrl->ctrl);
>  	nvme_loop_destroy_admin_queue(ctrl);

Is the queue killed before calling nvme_loop_destroy_admin_queue()? If
not, simply quiescing and not unquiescing will hang in
blk_cleanup_queue().  So I suggest to put blk_mq_unquiesce_queue()
after blk_mq_tagset_busy_iter().

-- 
Ming
