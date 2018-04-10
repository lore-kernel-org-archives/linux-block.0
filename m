Return-Path: <ming.lei@redhat.com>
Date: Tue, 10 Apr 2018 09:30:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [block regression] kernel oops triggered by removing scsi device
 dring IO
Message-ID: <20180410013051.GA9133@ming.t460p>
References: <20180408042112.GB19128@ming.t460p>
 <678220c26fa1677ab162006620b345ea4f38c86b.camel@wdc.com>
 <44abf88a-ded4-bbf5-8410-6692ee5ebabb@linux.alibaba.com>
 <f7dd2dceb3767a0f1fad571b57f5f8e09afb3c3e.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f7dd2dceb3767a0f1fad571b57f5f8e09afb3c3e.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 09, 2018 at 10:54:57PM +0000, Bart Van Assche wrote:
> On Mon, 2018-04-09 at 14:54 +0800, Joseph Qi wrote:
> > The oops happens during generic_make_request_checks(), in
> > blk_throtl_bio() exactly.
> > So if we want to bypass dying queue, we have to check this before
> > generic_make_request_checks(), I think.
> 
> How about something like the patch below?
> 
> Thanks,
> 
> Bart.
> 
> Subject: [PATCH] blk-mq: Avoid that submitting a bio concurrently with device
>  removal triggers a crash
> 
> Because blkcg_exit_queue() is now called from inside blk_cleanup_queue()
> it is no longer safe to access cgroup information during or after the
> blk_cleanup_queue() call. Hence protect the generic_make_request_checks()
> call with a blk_queue_enter() / blk_queue_exit() pair.
> 
> ---
>  block/blk-core.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d69888ff52f0..0c48bef8490f 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2388,9 +2388,24 @@ blk_qc_t generic_make_request(struct bio *bio)
>  	 * yet.
>  	 */
>  	struct bio_list bio_list_on_stack[2];
> +	blk_mq_req_flags_t flags = bio->bi_opf & REQ_NOWAIT ?
> +		BLK_MQ_REQ_NOWAIT : 0;
> +	struct request_queue *q = bio->bi_disk->queue;
> +	bool check_result;
>  	blk_qc_t ret = BLK_QC_T_NONE;
>  
> -	if (!generic_make_request_checks(bio))
> +	if (blk_queue_enter(q, flags) < 0) {

The queue pointer need to be checked before calling blk_queue_enter
since the check is done in generic_make_request_checks().

Also is it possible to see queue freed here?

-- 
Ming
