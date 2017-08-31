Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbdHaDns (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Aug 2017 23:43:48 -0400
Date: Thu, 31 Aug 2017 11:43:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V3 05/14] blk-mq-sched: improve dispatching from sw queue
Message-ID: <20170831034333.GD12246@ming.t460p>
References: <20170826163332.28971-1-ming.lei@redhat.com>
 <20170826163332.28971-6-ming.lei@redhat.com>
 <1504110886.2526.36.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504110886.2526.36.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 30, 2017 at 04:34:47PM +0000, Bart Van Assche wrote:
> On Sun, 2017-08-27 at 00:33 +0800, Ming Lei wrote:
> > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > index 50c6485cb04f..7b7a366a97f3 100644
> > --- a/include/linux/blk-mq.h
> > +++ b/include/linux/blk-mq.h
> > @@ -30,6 +30,8 @@ struct blk_mq_hw_ctx {
> >  
> >  	struct sbitmap		ctx_map;
> >  
> > +	struct blk_mq_ctx	*dispatch_from;
> > +
> >  	struct blk_mq_ctx	**ctxs;
> >  	unsigned int		nr_ctx;
> 
> Hello Ming,
> 
> Are you relying here on the fact that the per-CPU queues are never
> reallocated, even if CPU hot-plugging occurs? Sorry but that seems fragile
> to me. I would like to see 'dispatch_from' be converted into an integer. It
> is easy to check whether an integer software queue index is out of range
> but it's not that easy to check whether a pointer became invalid.

If CPU hotplug happens, the instance of 'struct blk_mq_ctx' for that
CPU is still there and its index won't change from being setup because
its lifetime is same with 'struct request_queue', blk_mq_hctx_notify_dead()
just flushes the sw queue when the CPU is going away.

So we don't need to pay special attention to CPU hotplug here, please let
me know if you are fine now.


-- 
Ming
