Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbdHXGSq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 02:18:46 -0400
Date: Thu, 24 Aug 2017 14:18:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 06/20] blk-mq-sched: don't dequeue request until all
 in ->dispatch are flushed
Message-ID: <20170824061833.GG12966@ming.t460p>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-7-ming.lei@redhat.com>
 <1503432571.2508.15.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503432571.2508.15.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Aug 22, 2017 at 08:09:32PM +0000, Bart Van Assche wrote:
> On Sat, 2017-08-05 at 14:56 +0800, Ming Lei wrote:
> > +	/*
> > +	 * Wherever DISPATCH_BUSY is set, blk_mq_run_hw_queue()
> > +	 * will be run to try to make progress, so it is always
> > +	 * safe to check the state here.
> > +	 */
> > +	if (test_bit(BLK_MQ_S_DISPATCH_BUSY, &hctx->state))
> > +		return;
> 
> The comment above test_bit() is useful but does not explain the purpose of
> the early return. Is the purpose of the early return perhaps to serialize
> blk_mq_sched_dispatch_requests() calls? If so, please mention this.

If the bit is set, that means there are requests in hctx->dispatch, so
return early for avoiding to dequeue requests from sw/scheduler queue
unnecessarily.

I thought the code is self-comment, so not explain it, will add the
comment.

-- 
Ming
