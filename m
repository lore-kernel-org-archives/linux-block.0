Return-Path: <keith.busch@intel.com>
Date: Mon, 24 Sep 2018 14:00:41 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bart Van Assche <bart.vanassche@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"jianchao.wang" <jianchao.w.wang@oracle.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: Regression caused by f5bbbbe4d635
Message-ID: <20180924200040.GA9777@localhost.localdomain>
References: <bae37c56-3f12-448d-cdb5-6ed2c2d069a4@kernel.dk>
 <20180924191348.GB9223@localhost.localdomain>
 <1537818667.195115.22.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1537818667.195115.22.camel@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 24, 2018 at 12:51:07PM -0700, Bart Van Assche wrote:
> On Mon, 2018-09-24 at 13:13 -0600, Keith Busch wrote:
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 85a1c1a59c72..28d128450621 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -848,22 +848,6 @@ static void blk_mq_timeout_work(struct work_struct *work)
> > 	struct blk_mq_hw_ctx *hctx;
> > 	int i;
> >  
> > -	/* A deadlock might occur if a request is stuck requiring a
> > -	 * timeout at the same time a queue freeze is waiting
> > -	 * completion, since the timeout code would not be able to
> > -	 * acquire the queue reference here.
> > -	 *
> > -	 * That's why we don't use blk_queue_enter here; instead, we use
> > -	 * percpu_ref_tryget directly, because we need to be able to
> > -	 * obtain a reference even in the short window between the queue
> > -	 * starting to freeze, by dropping the first reference in
> > -	 * blk_freeze_queue_start, and the moment the last request is
> > -	 * consumed, marked by the instant q_usage_counter reaches
> > -	 * zero.
> > -	 */
> > -	if (!percpu_ref_tryget(&q->q_usage_counter))
> > -		return;
> > -
> > 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
> >  
> > 	if (next != 0) {
> > @@ -881,7 +865,6 @@ static void blk_mq_timeout_work(struct work_struct *work)
> > 				blk_mq_tag_idle(hctx);
> > 		}
> > 	}
> > -	blk_queue_exit(q);
> >  }
> 
> Hi Keith,
> 
> The above introduces a behavior change: if the percpu_ref_tryget() call inside
> blk_mq_queue_tag_busy_iter() fails then blk_mq_timeout_work() will now call
> blk_mq_tag_idle(). I think that's wrong if the percpu_ref_tryget() call fails
> due to the queue having been frozen. Please make blk_mq_queue_tag_busy_iter()
> return a bool that indicates whether or not it has iterated over the request
> queue.

Good point, thanks for the feedback.
