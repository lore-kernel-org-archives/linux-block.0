Return-Path: <ming.lei@redhat.com>
Date: Wed, 5 Jul 2017 15:22:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v2 5/8] nvme: kick requeue list when requeueing a request
 instead of when starting the queues
Message-ID: <20170705072221.GE11084@ming.t460p>
References: <1499237591-15861-1-git-send-email-sagi@grimberg.me>
 <1499237591-15861-6-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499237591-15861-6-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 05, 2017 at 09:53:08AM +0300, Sagi Grimberg wrote:
> When we requeue a request, we can always insert the request
> back to the scheduler instead of doing it when restarting
> the queues and kicking the requeue work, so get rid of
> the requeue kick in nvme (core and drivers).
> 
> Also, now there is no need start hw queues in nvme_kill_queues
> We don't stop the hw queues anymore, so no need to
> start them.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/core.c | 19 ++-----------------
>  drivers/nvme/host/fc.c   |  4 +---
>  drivers/nvme/host/pci.c  |  1 -
>  drivers/nvme/host/rdma.c |  1 -
>  4 files changed, 3 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d70df1d0072d..48cafaa6fbc5 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -131,7 +131,7 @@ void nvme_complete_rq(struct request *req)
>  {
>  	if (unlikely(nvme_req(req)->status && nvme_req_needs_retry(req))) {
>  		nvme_req(req)->retries++;
> -		blk_mq_requeue_request(req, !blk_mq_queue_stopped(req->q));
> +		blk_mq_requeue_request(req, true);
>  		return;
>  	}

This change is correct.

-- 
Ming
