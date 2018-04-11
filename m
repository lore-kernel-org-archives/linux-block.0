Return-Path: <ming.lei@redhat.com>
Date: Wed, 11 Apr 2018 10:12:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2] blk-mq: Avoid that submitting a bio concurrently with
 device removal triggers a crash
Message-ID: <20180411021222.GD4494@ming.t460p>
References: <20180410204554.28914-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180410204554.28914-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 10, 2018 at 02:45:54PM -0600, Bart Van Assche wrote:
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
> ---
> 
> Changes compared to v1: changed the blk_queue_exit() inside the loop with "if (q)".
> 
>  block/blk-core.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 34e2f2227fd9..181b1a688a5b 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2386,8 +2386,19 @@ blk_qc_t generic_make_request(struct bio *bio)
>  	 * yet.
>  	 */
>  	struct bio_list bio_list_on_stack[2];
> +	blk_mq_req_flags_t flags = bio->bi_opf & REQ_NOWAIT ?
> +		BLK_MQ_REQ_NOWAIT : 0;
> +	struct request_queue *q = bio->bi_disk->queue;
>  	blk_qc_t ret = BLK_QC_T_NONE;
>  
> +	if (blk_queue_enter(q, flags) < 0) {

Same issue with V1, the queue pointer has to be checked before calling
blk_queue_enter().

-- 
Ming
