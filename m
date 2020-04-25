Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61A3C55185
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 08:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8423B20706
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 08:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgDYIcd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 04:32:33 -0400
Received: from verein.lst.de ([213.95.11.211]:39059 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgDYIcc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 04:32:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9D59168CFC; Sat, 25 Apr 2020 10:32:25 +0200 (CEST)
Date:   Sat, 25 Apr 2020 10:32:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        peterz@infradead.org, paulmck@kernel.org
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200425083224.GA5634@lst.de>
References: <20200424102351.475641-1-ming.lei@redhat.com> <20200424102351.475641-8-ming.lei@redhat.com> <20200424103851.GD28156@lst.de> <20200425031723.GC477579@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425031723.GC477579@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 25, 2020 at 11:17:23AM +0800, Ming Lei wrote:
> I am not sure if it helps by adding two helper, given only two
> parameters are needed, and the new parameter is just a constant.
> 
> > the point of barrier(), smp_mb__before_atomic and
> > smp_mb__after_atomic), as none seems to be addressed and I also didn't
> > see a reply.
> 
> I believe it has been documented:
> 
> +   /*
> +    * Add one memory barrier in case that direct issue IO process is
> +    * migrated to other CPU which may not belong to this hctx, so we can
> +    * order driver tag assignment and checking BLK_MQ_S_INACTIVE.
> +    * Otherwise, barrier() is enough given both setting BLK_MQ_S_INACTIVE
> +    * and driver tag assignment are run on the same CPU in case that
> +    * BLK_MQ_S_INACTIVE is set.
> +    */
> 
> OK, I can add more:
> 
> In case of not direct issue, __blk_mq_delay_run_hw_queue() guarantees
> that dispatch is done on CPUs of this hctx.
> 
> In case of direct issue, the direct issue IO process may be migrated to
> other CPU which doesn't belong to hctx->cpumask even though the chance
> is quite small, but still possible.
> 
> This patch sets hctx as inactive in the last CPU of hctx, so barrier()
> is enough for not direct issue. Otherwise, one smp_mb() is added for
> ordering tag assignment(include setting rq) and checking S_INACTIVE in
> blk_mq_get_driver_tag().

How do you prevent a cpu migration between the call to raw_smp_processor_id
and barrier? 

Also as far as I can tell Documentation/core-api/atomic_ops.rst ask
you to use smp_mb__before_atomic and smp_mb__after_atomic for any
ordering with non-updating bitops.  Quote:

--------------------------------- snip ---------------------------------
If explicit memory barriers are required around {set,clear}_bit() (which do
not return a value, and thus does not need to provide memory barrier
semantics), two interfaces are provided::

        void smp_mb__before_atomic(void);
	void smp_mb__after_atomic(void);
--------------------------------- snip ---------------------------------

I really want someone who knows the memory model to look over this scheme,
as it looks dangerous.
