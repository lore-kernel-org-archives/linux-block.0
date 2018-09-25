Return-Path: <keith.busch@intel.com>
Date: Tue, 25 Sep 2018 09:47:45 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>,
	Linux Block <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Allow blocking queue tag iter callbacks
Message-ID: <20180925154744.GA11822@localhost.localdomain>
References: <20180924210919.9995-1-keith.busch@intel.com>
 <45fc0cf9-92b2-2380-d11b-428613a470c2@oracle.com>
 <fc9d3a15-b136-478c-c35f-74a9a3479fb7@acm.org>
 <4de9e32b-18a0-bc37-1454-def9486fe3e0@oracle.com>
 <20180925143916.GB11657@localhost.localdomain>
 <1537888485.11137.1.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1537888485.11137.1.camel@acm.org>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 25, 2018 at 08:14:45AM -0700, Bart Van Assche wrote:
> On Tue, 2018-09-25 at 08:39 -0600, Keith Busch wrote:
> > On Tue, Sep 25, 2018 at 10:39:46AM +0800, jianchao.wang wrote:
> > > But the issue is the left part of blk_mq_timeout_work is moved out of protection of q refcount.
> > 
> > I'm not sure what you mean by "left part". The only part that isn't
> > outside the reference with this patch is the part Bart pointed out.
> > 
> > This looks like it may be fixed by either moving the refcount back up a
> > level to all the callers of blk_mq_queue_tag_busy_iter, or add
> > cancel_work_sync(&q->timeout_work) to __blk_mq_update_nr_hw_queues after
> > the freeze.
> 
> Hi Keith,
> 
> How about applying the following (untested) patch on top of your patch?

Yep, this works. I can fold in a v2.
 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 019f9b169887..099e203b5213 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -851,6 +851,9 @@ static void blk_mq_timeout_work(struct work_struct *work)
>  	if (!blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next))
>  		return;
>  
> +	if (!percpu_ref_tryget(&q->q_usage_counter))
> +		return;
> +
>  	if (next != 0) {
>  		mod_timer(&q->timeout, next);
>  	} else {
> @@ -866,6 +869,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
>  				blk_mq_tag_idle(hctx);
>  		}
>  	}
> +	blk_queue_exit(q);
>  }
> 
> Thanks,
> 
> Bart.
