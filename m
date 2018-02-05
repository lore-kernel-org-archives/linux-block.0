Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Feb 2018 13:06:01 -0800
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: Fix a race between resetting the timer and
 completion handling
Message-ID: <20180205210601.GP1121507@devbig577.frc2.facebook.com>
References: <20180201224930.17918-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180201224930.17918-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Bart.

Thanks a lot for testing and fixing the issues but I'm a bit confused
by the patch.  Maybe we can split patch a bit more?  There seem to be
three things going on,

1. Changing preemption protection to irq protection in issue path.

2. Merge of aborted_gstate_sync and gstate_seq.

3. Updates to blk_mq_rq_timed_out().

Are all three changes necessary for stability?

> @@ -831,13 +834,12 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
>  		__blk_mq_complete_request(req);
>  		break;
>  	case BLK_EH_RESET_TIMER:
> -		/*
> -		 * As nothing prevents from completion happening while
> -		 * ->aborted_gstate is set, this may lead to ignored
> -		 * completions and further spurious timeouts.
> -		 */
> -		blk_mq_rq_update_aborted_gstate(req, 0);
> +		local_irq_disable();
> +		write_seqcount_begin(&req->gstate_seq);
>  		blk_add_timer(req);
> +		req->aborted_gstate = 0;
> +		write_seqcount_end(&req->gstate_seq);
> +		local_irq_enable();
>  		break;

So, this is #3 and I'm not sure how adding gstate_seq protection gets
rid of the race condition mentioned in the comment.  It's still the
same that nothing is protecting against racing w/ completion.

Thanks.

-- 
tejun
