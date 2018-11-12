Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 4/6] block: avoid ordered task state change for polled IO
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-5-axboe@kernel.dk>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <653c9f83-157c-dca9-aa3b-02903dc81f5b@oracle.com>
Date: Mon, 12 Nov 2018 17:35:07 +0800
MIME-Version: 1.0
In-Reply-To: <20181110151317.3813-5-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Jens

On 11/10/18 11:13 PM, Jens Axboe wrote:
> We only really need the barrier if we're going to be sleeping,
> if we're just polling we're fine with the __set_current_state()
> variant.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/block_dev.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index c039abfb2052..e7550b1f9670 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -237,12 +237,23 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>  
>  	qc = submit_bio(&bio);
>  	for (;;) {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> +		/*
> +		 * Using non-atomic task state for polling
> +		 */
> +		__set_current_state(TASK_UNINTERRUPTIBLE);
> +
>  		if (!READ_ONCE(bio.bi_private))
>  			break;

When we don't use polling, the blkdev_bio_end_io_simple may come on a different cpu before
submit_bio returns 
For example,
__blkdev_direct_IO_simple
  qc = submit_bio(&bio) 
                                          blkdev_bio_end_io_simple
                                            WRITE_ONCE(bio.bi_private, NULL)
                                            wake_up_process(waiter)
  __set_current_state(TASK_UNINTERRUPTIBLE)                              
  READ_ONCE(bio.bi_private)

At the moment, a smp_rmb at least maybe needed before READ_ONCE(bio.bi_private)
to ensure the WRITE_ONCE(bio.bi_private, NULL) is seen if we miss the wakeup.

> +
>  		if (!(iocb->ki_flags & IOCB_HIPRI) ||
> -		    !blk_poll(bdev_get_queue(bdev), qc))
> +		    !blk_poll(bdev_get_queue(bdev), qc)) {
> +			/*
> +			 * If we're scheduling, ensure that task state
> +			 * change is ordered and seen.
> +			 */
> +			smp_mb();
>  			io_schedule();
> +		}
>  	}
>  	__set_current_state(TASK_RUNNING);
>  
> @@ -403,13 +414,19 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>  		return -EIOCBQUEUED;
>  
>  	for (;;) {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> +		/*
> +		 * See __blkdev_direct_IO_simple() loop
> +		 */
> +		__set_current_state(TASK_UNINTERRUPTIBLE);
> +

Similar with above.

>  		if (!READ_ONCE(dio->waiter))
>  			break;
>  
>  		if (!(iocb->ki_flags & IOCB_HIPRI) ||
> -		    !blk_poll(bdev_get_queue(bdev), qc))
> +		    !blk_poll(bdev_get_queue(bdev), qc)) {
> +			smp_mb();
>  			io_schedule();
> +		}
>  	}
>  	__set_current_state(TASK_RUNNING);
>  
> 

Thanks
Jianchao
