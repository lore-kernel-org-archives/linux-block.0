Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751243AbdIADCx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 23:02:53 -0400
Date: Fri, 1 Sep 2017 11:02:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "axboe@fb.com" <axboe@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>
Subject: Re: [PATCH V3 06/14] blk-mq-sched: don't dequeue request until all
 in ->dispatch are flushed
Message-ID: <20170901030236.GC16525@ming.t460p>
References: <20170826163332.28971-1-ming.lei@redhat.com>
 <20170826163332.28971-7-ming.lei@redhat.com>
 <1504113058.2526.54.camel@wdc.com>
 <20170831040123.GE12246@ming.t460p>
 <1504213218.31872.55.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504213218.31872.55.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 31, 2017 at 09:00:19PM +0000, Bart Van Assche wrote:
> On Thu, 2017-08-31 at 12:01 +0800, Ming Lei wrote:
> > On Wed, Aug 30, 2017 at 05:11:00PM +0000, Bart Van Assche wrote:
> > > On Sun, 2017-08-27 at 00:33 +0800, Ming Lei wrote:
> > > [ ... ]
> > > Shouldn't blk_mq_sched_dispatch_requests() set BLK_MQ_S_DISPATCH_BUSY just after
> > > the following statement because this statement makes the dispatch list empty?
> > 
> > Actually that is what I did in V1.
> > 
> > I changed to this way because setting the BUSY flag here will increase
> > the race window a bit, for example, if one request is added to ->dispatch
> > just after it is flushed(), the check on the BUSY bit won't catch this
> > case. Then we can avoid to check both the bit and list_empty_careful(&hctx->dispatch)
> > in blk_mq_sched_dispatch_requests(), so code becomes simpler and more
> > readable if we set the flag simply from the beginning.
> 
> Hello Ming,
> 
> My understanding is that blk_mq_sched_dispatch_requests() will only work
> correctly if the code that sets the DISPATCH_BUSY flag does that after having
> inserted one or more elements in the dispatch list. Although x86 CPUs do not
> reorder store operations I think that the functions that set the DISPATCH_BUSY
> flag need a memory barrier these two store operations. I'm referring to the
> blk_mq_sched_bypass_insert(), blk_mq_dispatch_wait_add() and
> blk_mq_hctx_notify_dead() functions.

That is a good question, but it has been answered by the comment
before checking the DISPATCH_BUSY state in blk_mq_sched_dispatch_requests():

	/*
	 * If DISPATCH_BUSY is set, that means hw queue is busy
	 * and requests in the list of hctx->dispatch need to
	 * be flushed first, so return early.
	 *
	 * Wherever DISPATCH_BUSY is set, blk_mq_run_hw_queue()
	 * will be run to try to make progress, so it is always
	 * safe to check the state here.
	 */

Suppose the two writes are reordered, sooner or latter, the
list_empty_careful(&hctx->dispatch) will be observed, and
will dispatch request from this hw queue after '->dispatch'
is flushed.

Since now the setting of DISPATCH_BUSY requires to hold
hctx->lock, we should avoid to add barrier there.

> 
> > > > +		 * too small, no need to worry about performance
> > > 
> > >                    ^^^
> > > The word "too" seems extraneous to me in this sentence.
> > 
> > Maybe 'extremely' is better, or just remove it?
> 
> If the word "too" would be removed I think the comment is still clear.

OK.

-- 
Ming
