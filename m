Return-Path: <ming.lei@redhat.com>
Date: Wed, 13 Sep 2017 09:52:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: put the driver tag of nxt rq before first one is
 requeued
Message-ID: <20170913015221.GB24642@ming.t460p>
References: <1505236475-9209-1-git-send-email-jianchao.w.wang@oracle.com>
 <20170912102302.GC15792@ming.t460p>
 <23b700aa-ed37-1081-d980-4073804f293b@oracle.com>
 <20170913012452.GA24642@ming.t460p>
 <4b7dcb10-9ec5-9a00-8d16-009e83ef7b5b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4b7dcb10-9ec5-9a00-8d16-009e83ef7b5b@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 13, 2017 at 09:39:44AM +0800, jianchao.wang wrote:
> 
> 
> On 09/13/2017 09:24 AM, Ming Lei wrote:
> > On Wed, Sep 13, 2017 at 09:01:25AM +0800, jianchao.wang wrote:
> >> Hi ming
> >>
> >> On 09/12/2017 06:23 PM, Ming Lei wrote:
> >>>> @@ -1029,14 +1029,20 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
> >>>>  		if (list_empty(list))
> >>>>  			bd.last = true;
> >>>>  		else {
> >>>> -			struct request *nxt;
> >>>> -
> >>>>  			nxt = list_first_entry(list, struct request, queuelist);
> >>>>  			bd.last = !blk_mq_get_driver_tag(nxt, NULL, false);
> >>>>  		}
> >>>>  
> >>>>  		ret = q->mq_ops->queue_rq(hctx, &bd);
> >>>>  		if (ret == BLK_STS_RESOURCE) {
> >>>> +			/*
> >>>> +			 * If an I/O scheduler has been configured and we got a
> >>>> +			 * driver tag for the next request already, free it again.
> >>>> +			 */
> >>>> +			if (!list_empty(list)) {
> >>>> +				nxt = list_first_entry(list, struct request, queuelist);
> >>>> +				blk_mq_put_driver_tag(nxt);
> >>>> +			}
> >>> The following way might be more simple and clean:
> >>>
> >>> 			if (nxt)
> >>> 				blk_mq_put_driver_tag(nxt);
> >>>
> >>> meantime 'nxt' need to be cleared inside the 'if (list_empty(list))'
> >>> before .queue_rq().
> >>
> >> I had ever thought about that, but to avoid add extra command in the 
> >> fast path, I made the patch above.
> > 
> > Got it, so how about changing to the following way simply:
> > 
> >  			if (nxt && !list_empty(list))
> >  				blk_mq_put_driver_tag(nxt);
> > 
> It seems that we even could change it as following:
>                         if (!list_empty(list))
>   				blk_mq_put_driver_tag(nxt);

Yeah, that is definitely more clean, :-)

Feel free to add "Reviewed-by: Ming Lei <ming.lei@redhat.com>"
in your next post.

-- 
Ming
