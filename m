Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:33517 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752594AbeDMCnl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Apr 2018 22:43:41 -0400
Subject: Re: [PATCH v3] blk-mq: Avoid that submitting a bio concurrently with
 device removal triggers a crash
To: Bart Van Assche <bart.vanassche@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
References: <20180410230240.27709-1-bart.vanassche@wdc.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <032ce4f6-f6a4-5b9e-ded8-51070c0d57ff@linux.alibaba.com>
Date: Fri, 13 Apr 2018 10:43:27 +0800
MIME-Version: 1.0
In-Reply-To: <20180410230240.27709-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 18/4/11 07:02, Bart Van Assche wrote:
> Because blkcg_exit_queue() is now called from inside blk_cleanup_queue()
> it is no longer safe to access cgroup information during or after the
> blk_cleanup_queue() call. Hence protect the generic_make_request_checks()
> call with blk_queue_enter() / blk_queue_exit().
> 
> Reported-by: Ming Lei <ming.lei@redhat.com>
> Fixes: a063057d7c73 ("block: Fix a race between request queue removal and the block cgroup controller")
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>

I've tested using the following steps:
1) start a fio job with buffered write;
2) then remove the scsi device that fio write to:
echo "scsi remove-single-device ${dev}" > /proc/scsi/scsi

After applying this patch, the reported oops has gone.

Tested-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
> 
> Changes compared to v2: converted two ternary expressions into if-statements.
> 
> Changes compared to v1: guarded the blk_queue_exit() inside the loop with "if (q)".
> 
>  block/blk-core.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 34e2f2227fd9..39308e874ffa 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2386,8 +2386,20 @@ blk_qc_t generic_make_request(struct bio *bio)
>  	 * yet.
>  	 */
>  	struct bio_list bio_list_on_stack[2];
> +	blk_mq_req_flags_t flags = 0;
> +	struct request_queue *q = bio->bi_disk->queue;
>  	blk_qc_t ret = BLK_QC_T_NONE;
>  
> +	if (bio->bi_opf & REQ_NOWAIT)
> +		flags = BLK_MQ_REQ_NOWAIT;
> +	if (blk_queue_enter(q, flags) < 0) {
> +		if (!blk_queue_dying(q) && (bio->bi_opf & REQ_NOWAIT))
> +			bio_wouldblock_error(bio);
> +		else
> +			bio_io_error(bio);
> +		return ret;
> +	}
> +
>  	if (!generic_make_request_checks(bio))
>  		goto out;
>  
> @@ -2424,11 +2436,22 @@ blk_qc_t generic_make_request(struct bio *bio)
>  	bio_list_init(&bio_list_on_stack[0]);
>  	current->bio_list = bio_list_on_stack;
>  	do {
> -		struct request_queue *q = bio->bi_disk->queue;
> -		blk_mq_req_flags_t flags = bio->bi_opf & REQ_NOWAIT ?
> -			BLK_MQ_REQ_NOWAIT : 0;
> +		bool enter_succeeded = true;
> +
> +		if (unlikely(q != bio->bi_disk->queue)) {
> +			if (q)
> +				blk_queue_exit(q);
> +			q = bio->bi_disk->queue;
> +			flags = 0;
> +			if (bio->bi_opf & REQ_NOWAIT)
> +				flags = BLK_MQ_REQ_NOWAIT;
> +			if (blk_queue_enter(q, flags) < 0) {
> +				enter_succeeded = false;
> +				q = NULL;
> +			}
> +		}
>  
> -		if (likely(blk_queue_enter(q, flags) == 0)) {
> +		if (enter_succeeded) {
>  			struct bio_list lower, same;
>  
>  			/* Create a fresh bio_list for all subordinate requests */
> @@ -2436,8 +2459,6 @@ blk_qc_t generic_make_request(struct bio *bio)
>  			bio_list_init(&bio_list_on_stack[0]);
>  			ret = q->make_request_fn(q, bio);
>  
> -			blk_queue_exit(q);
> -
>  			/* sort new bios into those for a lower level
>  			 * and those for the same level
>  			 */
> @@ -2464,6 +2485,8 @@ blk_qc_t generic_make_request(struct bio *bio)
>  	current->bio_list = NULL; /* deactivate */
>  
>  out:
> +	if (q)
> +		blk_queue_exit(q);
>  	return ret;
>  }
>  EXPORT_SYMBOL(generic_make_request);
> 
