Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750896AbdE3AeZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 May 2017 20:34:25 -0400
Date: Tue, 30 May 2017 08:34:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v2 0/8] blk-mq: fix & improve queue quiescing
Message-ID: <20170530003411.GC29253@ming.t460p>
References: <20170527142126.26079-1-ming.lei@redhat.com>
 <1495920721.13651.0.camel@sandisk.com>
 <20170528111105.GD6488@ming.t460p>
 <1495987272.2849.1.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495987272.2849.1.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, May 28, 2017 at 04:01:13PM +0000, Bart Van Assche wrote:
> On Sun, 2017-05-28 at 19:11 +0800, Ming Lei wrote:
> > On Sat, May 27, 2017 at 09:32:02PM +0000, Bart Van Assche wrote:
> > > On Sat, 2017-05-27 at 22:21 +0800, Ming Lei wrote:
> > > > There are some issues in current blk_mq_quiesce_queue():
> > > > 
> > > >     - in case of direct issue or BLK_MQ_S_START_ON_RUN, dispatch won't
> > > >     be prevented after blk_mq_quiesce_queue() is returned.
> > > >     - in theory, new RCU read-side critical sections may begin while
> > > >     synchronize_rcu() was waiting, and end after returning from 
> > > >     synchronize_rcu(), then dispatch still may be run after
> > > >     synchronize_rcu() returns
> > > 
> > > I disagree with the second part of your statement. blk_mq_quiesce_queue()
> > 
> > You can find the similar description from line 158 to line 180.
> > of Documentation/RCU/whatisRCU.txt.
> > 
> > For example, there may be schedule preempt or irq handling between
> > checking stopped flag(false) and the RCU read-side critical sections, and
> > synchronize_*rcu() may return before running this RCU read-side critical
> > sections. That is why we have to move the check into RCU read-side
> > critical sections.
> 
> Hello Ming,
> 
> Have you noticed that in the current blk-mq code the test of the hctx
> stopped flag already occurs *inside* an RCU read-side critical section?
> __blk_mq_run_hw_queue() grabs an RCU read lock before
> blk_mq_sched_dispatch_requests() calls blk_mq_hctx_stopped().

OK, that is what I missed, will update the commit log in next post.

Thanks,
Ming
