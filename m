Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/3] nvme/pci: Start request after doorbell ring
To: Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-2-keith.busch@intel.com>
Message-ID: <45a16b4c-fbc0-106d-df37-439374c7b5dc@kernel.dk>
Date: Thu, 21 Dec 2017 13:49:44 -0700
MIME-Version: 1.0
In-Reply-To: <20171221204636.2924-2-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/21/17 1:46 PM, Keith Busch wrote:
> This is a performance optimization that allows the hardware to work on
> a command in parallel with the kernel's stats and timeout tracking.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/nvme/host/pci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index f5800c3c9082..df5550ce0531 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -886,8 +886,6 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  			goto out_cleanup_iod;
>  	}
>  
> -	blk_mq_start_request(req);
> -
>  	spin_lock_irq(&nvmeq->q_lock);
>  	if (unlikely(nvmeq->cq_vector < 0)) {
>  		ret = BLK_STS_IOERR;
> @@ -895,6 +893,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		goto out_cleanup_iod;
>  	}
>  	__nvme_submit_cmd(nvmeq, &cmnd);
> +	blk_mq_start_request(req);
>  	nvme_process_cq(nvmeq);
>  	spin_unlock_irq(&nvmeq->q_lock);
>  	return BLK_STS_OK;

I guess this will work since we hold the q_lock, but you should probably
include a comment to that effect since it's important that we can't find
the completion before we've called started.

Actually, you'd need to reorder this after #2 (I'm assuming, it hasn't
shown up yet, but I'm guessing it's kill the cq check after submission)
since if we have multiple CPUs on the same hardware queue, one of
the other CPUs could find a completion event between your
__nvme_submit_cmd() and blk_mq_start_request() call. Very short window,
but it does exist.

-- 
Jens Axboe
