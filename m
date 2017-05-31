Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751101AbdEaCi3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2017 22:38:29 -0400
Date: Wed, 31 May 2017 10:38:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v2 4/8] blk-mq: fix blk_mq_quiesce_queue
Message-ID: <20170531023816.GC12220@ming.t460p>
References: <20170527142126.26079-1-ming.lei@redhat.com>
 <20170527142126.26079-5-ming.lei@redhat.com>
 <1495921605.13651.2.camel@sandisk.com>
 <20170528104400.GB6488@ming.t460p>
 <1495987808.2849.5.camel@sandisk.com>
 <20170530002227.GA29253@ming.t460p>
 <1496163285.2627.9.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496163285.2627.9.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 30, 2017 at 04:54:47PM +0000, Bart Van Assche wrote:
> On Tue, 2017-05-30 at 08:22 +0800, Ming Lei wrote:
> > On Sun, May 28, 2017 at 04:10:09PM +0000, Bart Van Assche wrote:
> > > I really would like to see the blk_queue_quiesced() tests as close as possible to
> > > the blk_mq_hctx_stopped() tests. But I agree that we need a way to document and/or
> > 
> > Could you explain why we have to do that? And checking on stopped state
> > doesn't need to hold RCU/SRCU read lock, and that two states are really
> > different.
> 
> I'm really surprised that you ask me why ... It's because the purpose of the
> "stopped" and "quiesced" flags is similar, namely preventing that dispatching

Actually they are not, and you can find it in patch 7.

But I will move the check into the dispatch function, and add comment about
rcu/scru read lock requirement.

> requests happens. It doesn't matter that with your patches applied it is no
> longer needed to hold an RCU / SRCU lock when testing the stopped flag.
> 
> > > verify that these tests occur with an RCU read-side lock held. Have you considered
> > > to use rcu_read_lock_held() to document this?
> > 
> > Then we need to check if it is RCU or SRCU, and make code ugly as
> > current check on BLOCKING.
> 
> How about introducing a macro or inline function in the block layer that tests
> whether either the RCU read lock or an SRCU read lock is held depending on the
> value of the BLK_MQ_F_BLOCKING flag?

That might make code clean, but need to check the condition two times.

Thanks,
Ming
