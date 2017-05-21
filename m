Return-Path: <hch@lst.de>
Date: Sun, 21 May 2017 08:20:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Zhang Yi <yizhan@redhat.com>,
	linux-block@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] nvme: use blk_mq_start_hw_queues() in
	nvme_kill_queues()
Message-ID: <20170521062002.GB12287@lst.de>
References: <20170520035605.21785-1-ming.lei@redhat.com> <20170520035605.21785-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170520035605.21785-2-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

> index d5e0906262ea..ce0d96913ee6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2437,7 +2437,13 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>  		revalidate_disk(ns->disk);
>  		blk_set_queue_dying(ns->queue);
>  		blk_mq_abort_requeue_list(ns->queue);
> -		blk_mq_start_stopped_hw_queues(ns->queue, true);
> +
> +		/*
> +		 * We have to force to start queues for avoiding hang
> +		 * forever, and we have to make sure that queues won't
> +		 * be stopped forever from now on.
> +		 */

		/*
		 * Forcibly start all queues to avoid having stuck requests.
		 * Note: We must make sure to not stop the queues from
		 * now until the final removal.
		 */

Otherwise this looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
