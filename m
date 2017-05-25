Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757537AbdEYJJh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2017 05:09:37 -0400
Date: Thu, 25 May 2017 17:09:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH 0/7] blk-mq: fix queue quiescing
Message-ID: <20170525090917.GB15737@ming.t460p>
References: <20170525042131.13172-1-ming.lei@redhat.com>
 <1495689892.3045.2.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495689892.3045.2.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, May 25, 2017 at 05:24:54AM +0000, Bart Van Assche wrote:
> On Thu, 2017-05-25 at 12:21 +0800, Ming Lei wrote:
> > One big problem of blk_mq_quiesce_queue() is that it
> > can't prevent .queue_rq() in direct issue path from
> > being run even though hw queues are stopped by
> > blk_mq_quiesce_queue().
> 
> That's wrong. All what's needed to prevent that
> __blk_mq_try_issue_directly() calls .queue_rq() for a stopped
> queue is to check in __blk_mq_try_issue_directly() whether the

That should work, and I just didn't want to introduce a check
on global variable in fast path, but just figured out that
it is inevitable for percpu_ref too.

> relevant hardware queue has been stopped. That approach has the

I don't think it is a good idea to abuse stopped state for checking
queue quiesce, actually stopping queue has made lots of trouble,
we should avoid it in blk_mq_quiesce_queue() in the future, even
most of them in driver side.

So I will introduce a queue quiesce flag like in patch 2 for this
purpose.

> following two advantages over the approach of your patch series:
> - Lower code complexity and hence easier to review and to maintain.
> - Faster for queues for which BLK_MQ_F_BLOCKING has not been set.
>   For non-preemptible kernels rcu_read_lock() and rcu_read_lock()
>   are optimized out. That is not possible for
>   percpu_ref_tryget_live() / percpu_ref_put().

That won't be issue for perpcu access at all.

Another big issue is that 'srcu_struct' is very big, which shouldn't
be embedded into hctx, since we only have one real user of
BLK_MQ_F_BLOCKING.

So I will fix that too.

Thanks,
Ming
