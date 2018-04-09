Return-Path: <axboe@kernel.dk>
Subject: Re: [block regression] kernel oops triggered by removing scsi device
 dring IO
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20180408042112.GB19128@ming.t460p>
 <678220c26fa1677ab162006620b345ea4f38c86b.camel@wdc.com>
 <44abf88a-ded4-bbf5-8410-6692ee5ebabb@linux.alibaba.com>
 <f7dd2dceb3767a0f1fad571b57f5f8e09afb3c3e.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d31f4b4f-5f8f-a247-7c4b-a88d9895681d@kernel.dk>
Date: Mon, 9 Apr 2018 16:58:18 -0600
MIME-Version: 1.0
In-Reply-To: <f7dd2dceb3767a0f1fad571b57f5f8e09afb3c3e.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/9/18 4:54 PM, Bart Van Assche wrote:
> On Mon, 2018-04-09 at 14:54 +0800, Joseph Qi wrote:
>> The oops happens during generic_make_request_checks(), in
>> blk_throtl_bio() exactly.
>> So if we want to bypass dying queue, we have to check this before
>> generic_make_request_checks(), I think.
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
> +		if (!blk_queue_dying(q) && (bio->bi_opf & REQ_NOWAIT))
> +			bio_wouldblock_error(bio);
> +		else
> +			bio_io_error(bio);
> +		return ret;
> +	}
> +
> +	check_result = generic_make_request_checks(bio);
> +	blk_queue_exit(q);

This ends up being nutty in the generic_make_request() case, where we
do the exact same enter/exit logic right after. That needs to get unified.
Maybe move the queue enter into generic_make_request_checks(), and exit
in the caller?

-- 
Jens Axboe
