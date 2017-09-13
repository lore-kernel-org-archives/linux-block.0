Return-Path: <ming.lei@redhat.com>
Date: Wed, 13 Sep 2017 11:50:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: put the driver tag of nxt rq before first one is
 requeued
Message-ID: <20170913035043.GD24642@ming.t460p>
References: <1505236475-9209-1-git-send-email-jianchao.w.wang@oracle.com>
 <20170912102302.GC15792@ming.t460p>
 <23b700aa-ed37-1081-d980-4073804f293b@oracle.com>
 <20170913012452.GA24642@ming.t460p>
 <4b7dcb10-9ec5-9a00-8d16-009e83ef7b5b@oracle.com>
 <ccda7d87-a0b9-8292-3cb7-8edcca9c7f69@kernel.dk>
 <96a21c69-cf79-58a2-2c71-2e440abf9b36@oracle.com>
 <6327de01-0bf4-7e79-59ad-f6489378bfd5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6327de01-0bf4-7e79-59ad-f6489378bfd5@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 12, 2017 at 08:45:19PM -0600, Jens Axboe wrote:
> On 09/12/2017 08:42 PM, jianchao.wang wrote:
> > 
> > 
> > On 09/13/2017 10:23 AM, Jens Axboe wrote:
> >> On 09/12/2017 07:39 PM, jianchao.wang wrote:
> >>>
> >>>
> >>> On 09/13/2017 09:24 AM, Ming Lei wrote:
> >>>> On Wed, Sep 13, 2017 at 09:01:25AM +0800, jianchao.wang wrote:
> >>>>> Hi ming
> >>>>>
> >>>>> On 09/12/2017 06:23 PM, Ming Lei wrote:
> >>>>>>> @@ -1029,14 +1029,20 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
> >>>>>>>  		if (list_empty(list))
> >>>>>>>  			bd.last = true;
> >>>>>>>  		else {
> >>>>>>> -			struct request *nxt;
> >>>>>>> -
> >>>>>>>  			nxt = list_first_entry(list, struct request, queuelist);
> >>>>>>>  			bd.last = !blk_mq_get_driver_tag(nxt, NULL, false);
> >>>>>>>  		}
> >>>>>>>  
> >>>>>>>  		ret = q->mq_ops->queue_rq(hctx, &bd);
> >>>>>>>  		if (ret == BLK_STS_RESOURCE) {
> >>>>>>> +			/*
> >>>>>>> +			 * If an I/O scheduler has been configured and we got a
> >>>>>>> +			 * driver tag for the next request already, free it again.
> >>>>>>> +			 */
> >>>>>>> +			if (!list_empty(list)) {
> >>>>>>> +				nxt = list_first_entry(list, struct request, queuelist);
> >>>>>>> +				blk_mq_put_driver_tag(nxt);
> >>>>>>> +			}
> >>>>>> The following way might be more simple and clean:
> >>>>>>
> >>>>>> 			if (nxt)
> >>>>>> 				blk_mq_put_driver_tag(nxt);
> >>>>>>
> >>>>>> meantime 'nxt' need to be cleared inside the 'if (list_empty(list))'
> >>>>>> before .queue_rq().
> >>>>>
> >>>>> I had ever thought about that, but to avoid add extra command in the 
> >>>>> fast path, I made the patch above.
> >>>>
> >>>> Got it, so how about changing to the following way simply:
> >>>>
> >>>>  			if (nxt && !list_empty(list))
> >>>>  				blk_mq_put_driver_tag(nxt);
> >>>>
> >>> It seems that we even could change it as following:
> >>>                         if (!list_empty(list))
> >>>   				blk_mq_put_driver_tag(nxt);
> >>
> >> This is starting to get too clever for its own good, I generally don't
> >> like to sacrifice readability for performance. In reality, the compiler
> >> probably figures it out anyway...
> >>
> >> So either make it explicit, or add a nice comment as to why it is the
> >> way that it is.
> >>
> > yes, it indeed leads to compiler warning of "may be used uninitialized"
> > maybe the original one could be taken back.
> > 			if (!list_empty(list)) {
> > 				nxt = list_first_entry(list, struct request, queuelist);
> > 				blk_mq_put_driver_tag(nxt);
> > 			}
> > It is more readable and could avoid the warning.
> 
> Exactly, and especially the readability is the key element here. It's
> just not worth it to try and be too clever, especially not for something
> like this. When you read the above, you immediately know what the code
> does without needing a comment. That's not true for the other construct.
> You both have to read other parts of the function to figure out what it
> does, AND read the entire function to ensure it always does the right
> thing. Fragile.

OK, fair enough wrt. readability.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

For the original post.

-- 
Ming
