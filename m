Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35570 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753117AbdCOMTC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2017 08:19:02 -0400
Date: Wed, 15 Mar 2017 20:18:55 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "yizhan@redhat.com" <yizhan@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] blk-mq: don't complete un-started request in timeout
 handler
Message-ID: <20170315121851.GA15807@ming.t460p>
References: <1489064578-17305-1-git-send-email-tom.leiming@gmail.com>
 <1489064578-17305-3-git-send-email-tom.leiming@gmail.com>
 <1489536441.2676.21.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489536441.2676.21.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Mar 15, 2017 at 12:07:37AM +0000, Bart Van Assche wrote:
> On Thu, 2017-03-09 at 21:02 +0800, Ming Lei wrote:
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 159187a28d66..0aff380099d5 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -697,17 +697,8 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
> >  {
> >  	struct blk_mq_timeout_data *data = priv;
> >  
> > -	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags)) {
> > -		/*
> > -		 * If a request wasn't started before the queue was
> > -		 * marked dying, kill it here or it'll go unnoticed.
> > -		 */
> > -		if (unlikely(blk_queue_dying(rq->q))) {
> > -			rq->errors = -EIO;
> > -			blk_mq_end_request(rq, rq->errors);
> > -		}
> > +	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
> >  		return;
> > -	}
> >  
> >  	if (time_after_eq(jiffies, rq->deadline)) {
> >  		if (!blk_mark_rq_complete(rq))
> 
> Both the old and the new check look racy to me. The REQ_ATOM_STARTED bit can
> be changed concurrently by blk_mq_start_request(), __blk_mq_finish_request()

blk_mq_start_request() and __blk_mq_finish_request() won't be run concurrently.

>From view of __blk_mq_finish_request():

	- if it is run from merge queue io path(blk_mq_merge_queue_io()),
	blk_mq_start_request() can't be run at all, and the COMPLETE flag
	is kept as previous value(zero)

	- if it is run from normal complete path, COMPLETE flag is cleared
	before the req/tag is released to tag set.

so there isn't race in blk_mq_start_request() vs. __blk_mq_finish_request()
wrt. timeout.

> or __blk_mq_requeue_request(). Another issue with this function is that the

__blk_mq_requeue_request() can be run from two pathes:

	- dispatch failure, in which case the req/tag isn't released to tag set
	
	- IO completion path, in which COMPLETE flag is cleared before requeue.
	
so I can't see races with timeout in case of start rq vs. requeue rq. 

> request passed to this function can be reinitialized concurrently. Sorry but

Yes, that is possible, but rq->atomic_flags is kept, and in that case
when we handle timeout, COMPLETE is cleared before releasing the rq/tag to
tag set via blk_mark_rq_complete(), so we won't complete that req twice.



Thanks,
Ming
