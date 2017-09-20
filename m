Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23383 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbdITCzp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Sep 2017 22:55:45 -0400
Date: Wed, 20 Sep 2017 10:55:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH V4 06/14] blk-mq-sched: don't dequeue request until all
 in ->dispatch are flushed
Message-ID: <20170920025523.GD23062@ming.t460p>
References: <20170902151729.6162-1-ming.lei@redhat.com>
 <20170902151729.6162-7-ming.lei@redhat.com>
 <20170919191105.GA31219@vader.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170919191105.GA31219@vader.DHCP.thefacebook.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 19, 2017 at 12:11:05PM -0700, Omar Sandoval wrote:
> On Sat, Sep 02, 2017 at 11:17:21PM +0800, Ming Lei wrote:
> > During dispatching, we moved all requests from hctx->dispatch to
> > one temporary list, then dispatch them one by one from this list.
> > Unfortunately during this period, run queue from other contexts
> > may think the queue is idle, then start to dequeue from sw/scheduler
> > queue and still try to dispatch because ->dispatch is empty. This way
> > hurts sequential I/O performance because requests are dequeued when
> > lld queue is busy.
> > 
> > This patch introduces the state of BLK_MQ_S_DISPATCH_BUSY to
> > make sure that request isn't dequeued until ->dispatch is
> > flushed.
> > 
> > Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Neat. I did something similar when I first started on I/O scheduling for
> blk-mq, but I completely serialized dispatch so only one CPU would be
> dispatching a given hctx at a time. I ended up ditching it because it
> was actually a performance regression on artificial null-blk tests with
> many CPUs and 1 hctx, and it was also really hard to get right without
> deadlocks. Yours still allows concurrent dispatch from multiple CPUs, so
> you probably wouldn't have those same issues, but I don't like how
> handwavy this is about races on the DISPATCH_BUSY bit, and how the
> handling of that bit is spread around everywhere. I'm not totally
> opposed to taking this as is, but what do you think about serializing
> the dispatch per hctx completely?

I think we might need that for SCSI because q->queue_depth is actually
a per-request_queue limit, and all hctxs share the depth.

It has been posted once in V2 as patch 6 ~ 14:

	https://marc.info/?t=150191627900003&r=1&w=2

but running all hctx is missed after queue busy is cleared.

I appreciate much you may take a look at it and see if
that approach is good, maybe we can figure out one better one.

I tested serializing all hctx can improve mq-deadline some on
IB/SRP, but Bart and Jens suggested to split this patchset, so
not include it in V3/V4. 

And sbitmap may be required to mark if one hctx need to run
again, otherwise it is observed performance loss with none on
IB/SRP if all hctxes is simply run after the busy bit is cleared.

-- 
Ming
