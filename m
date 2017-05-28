Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750998AbdE1LLN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 May 2017 07:11:13 -0400
Date: Sun, 28 May 2017 19:11:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v2 0/8] blk-mq: fix & improve queue quiescing
Message-ID: <20170528111105.GD6488@ming.t460p>
References: <20170527142126.26079-1-ming.lei@redhat.com>
 <1495920721.13651.0.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495920721.13651.0.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, May 27, 2017 at 09:32:02PM +0000, Bart Van Assche wrote:
> On Sat, 2017-05-27 at 22:21 +0800, Ming Lei wrote:
> > There are some issues in current blk_mq_quiesce_queue():
> > 
> >     - in case of direct issue or BLK_MQ_S_START_ON_RUN, dispatch won't
> >     be prevented after blk_mq_quiesce_queue() is returned.
> >     - in theory, new RCU read-side critical sections may begin while
> >     synchronize_rcu() was waiting, and end after returning from 
> >     synchronize_rcu(), then dispatch still may be run after
> >     synchronize_rcu() returns
> 
> Hello Ming,

Hello Bart,

> 
> I disagree with the second part of your statement. blk_mq_quiesce_queue()

You can find the similar description from line 158 to line 180.
of Documentation/RCU/whatisRCU.txt.

For example, there may be schedule preempt or irq handling between
checking stopped flag(false) and the RCU read-side critical sections, and
synchronize_*rcu() may return before running this RCU read-side critical
sections. That is why we have to move the check into RCU read-side
critical sections.

> stops all hardware queues before calling synchronize_*rcu().
> blk_mq_sched_dispatch_requests() is called with an RCU lock held and checks
> whether a hctx has been stopped before calling .queue_rq(). That is
> sufficient to prevent blk_mq_try_issue_directly() to trigger a .queue_rq()
> call.

Our case should be very similar with example "6.  ANALOGY WITH READER-WRITER
LOCKING" in Documentation/RCU/whatisRCU.txt.

Thanks,
Ming
