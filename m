Return-Path: <joseph.qi@linux.alibaba.com>
Subject: Re: [block regression] kernel oops triggered by removing scsi device
 dring IO
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20180408042112.GB19128@ming.t460p>
 <678220c26fa1677ab162006620b345ea4f38c86b.camel@wdc.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <44abf88a-ded4-bbf5-8410-6692ee5ebabb@linux.alibaba.com>
Date: Mon, 9 Apr 2018 14:54:10 +0800
MIME-Version: 1.0
In-Reply-To: <678220c26fa1677ab162006620b345ea4f38c86b.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart,

On 18/4/9 12:47, Bart Van Assche wrote:
> On Sun, 2018-04-08 at 12:21 +0800, Ming Lei wrote:
>> The following kernel oops is triggered by 'removing scsi device' during
>> heavy IO.
> 
> Is the below patch sufficient to fix this?
> 
> Thanks,
> 
> Bart.
> 
> 
> Subject: blk-mq: Avoid that submitting a bio concurrently with device removal triggers a crash
> 
> Because blkcg_exit_queue() is now called from inside blk_cleanup_queue()
> it is no longer safe to access cgroup information during or after the
> blk_cleanup_queue() call. Hence check earlier in generic_make_request()
> whether the queue has been marked as "dying".

The oops happens during generic_make_request_checks(), in
blk_throtl_bio() exactly.
So if we want to bypass dying queue, we have to check this before
generic_make_request_checks(), I think.

Thanks,
Joseph

> ---
>  block/blk-core.c | 72 +++++++++++++++++++++++++++++---------------------------
>  1 file changed, 37 insertions(+), 35 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index aa8c99fae527..3ac9dd25e04e 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2385,10 +2385,21 @@ blk_qc_t generic_make_request(struct bio *bio)
>  	 * yet.
>  	 */
>  	struct bio_list bio_list_on_stack[2];
> +	blk_mq_req_flags_t flags = bio->bi_opf & REQ_NOWAIT ?
> +		BLK_MQ_REQ_NOWAIT : 0;
> +	struct request_queue *q = bio->bi_disk->queue;
>  	blk_qc_t ret = BLK_QC_T_NONE;
>  
>  	if (!generic_make_request_checks(bio))
> -		goto out;
> +		return ret;
> +
> +	if (blk_queue_enter(q, flags) < 0) {
> +		if (unlikely(!blk_queue_dying(q) && (bio->bi_opf & REQ_NOWAIT)))
> +			bio_wouldblock_error(bio);
> +		else
> +			bio_io_error(bio);
> +		return ret;
> +	}
>  
>  	/*
>  	 * We only want one ->make_request_fn to be active at a time, else
> @@ -2423,46 +2434,37 @@ blk_qc_t generic_make_request(struct bio *bio)
>  	bio_list_init(&bio_list_on_stack[0]);
>  	current->bio_list = bio_list_on_stack;
>  	do {
> -		struct request_queue *q = bio->bi_disk->queue;
> -		blk_mq_req_flags_t flags = bio->bi_opf & REQ_NOWAIT ?
> -			BLK_MQ_REQ_NOWAIT : 0;
> -
> -		if (likely(blk_queue_enter(q, flags) == 0)) {
> -			struct bio_list lower, same;
> -
> -			/* Create a fresh bio_list for all subordinate requests */
> -			bio_list_on_stack[1] = bio_list_on_stack[0];
> -			bio_list_init(&bio_list_on_stack[0]);
> -			ret = q->make_request_fn(q, bio);
> -
> -			blk_queue_exit(q);
> -
> -			/* sort new bios into those for a lower level
> -			 * and those for the same level
> -			 */
> -			bio_list_init(&lower);
> -			bio_list_init(&same);
> -			while ((bio = bio_list_pop(&bio_list_on_stack[0])) != NULL)
> -				if (q == bio->bi_disk->queue)
> -					bio_list_add(&same, bio);
> -				else
> -					bio_list_add(&lower, bio);
> -			/* now assemble so we handle the lowest level first */
> -			bio_list_merge(&bio_list_on_stack[0], &lower);
> -			bio_list_merge(&bio_list_on_stack[0], &same);
> -			bio_list_merge(&bio_list_on_stack[0], &bio_list_on_stack[1]);
> -		} else {
> -			if (unlikely(!blk_queue_dying(q) &&
> -					(bio->bi_opf & REQ_NOWAIT)))
> -				bio_wouldblock_error(bio);
> +		struct bio_list lower, same;
> +
> +		WARN_ON_ONCE(!(flags & BLK_MQ_REQ_NOWAIT) &&
> +			     (bio->bi_opf & REQ_NOWAIT));
> +		WARN_ON_ONCE(q != bio->bi_disk->queue);
> +		q = bio->bi_disk->queue;
> +		/* Create a fresh bio_list for all subordinate requests */
> +		bio_list_on_stack[1] = bio_list_on_stack[0];
> +		bio_list_init(&bio_list_on_stack[0]);
> +		ret = q->make_request_fn(q, bio);
> +
> +		/* sort new bios into those for a lower level
> +		 * and those for the same level
> +		 */
> +		bio_list_init(&lower);
> +		bio_list_init(&same);
> +		while ((bio = bio_list_pop(&bio_list_on_stack[0])) != NULL)
> +			if (q == bio->bi_disk->queue)
> +				bio_list_add(&same, bio);
>  			else
> -				bio_io_error(bio);
> -		}
> +				bio_list_add(&lower, bio);
> +		/* now assemble so we handle the lowest level first */
> +		bio_list_merge(&bio_list_on_stack[0], &lower);
> +		bio_list_merge(&bio_list_on_stack[0], &same);
> +		bio_list_merge(&bio_list_on_stack[0], &bio_list_on_stack[1]);
>  		bio = bio_list_pop(&bio_list_on_stack[0]);
>  	} while (bio);
>  	current->bio_list = NULL; /* deactivate */
>  
>  out:
> +	blk_queue_exit(q);
>  	return ret;
>  }
>  EXPORT_SYMBOL(generic_make_request);
> 
