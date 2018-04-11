Return-Path: <ming.lei@redhat.com>
Date: Wed, 11 Apr 2018 10:05:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH] blk-mq: Avoid that submitting a bio concurrently with
 device removal triggers a crash
Message-ID: <20180411020541.GB4494@ming.t460p>
References: <20180410203035.26167-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180410203035.26167-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 10, 2018 at 02:30:35PM -0600, Bart Van Assche wrote:
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
>  block/blk-core.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 34e2f2227fd9..a330cd2829e1 100644
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

As I mentioned last time, the queue pointer has to be checked before
calling blk_queue_enter(), since it isn't difficult to trigger the
failure log of 'generic_make_request: Trying to access nonexistent
block-device'.

-- 
Ming
