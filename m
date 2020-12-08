Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA85C433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 13:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BACCF23A79
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 13:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgLHNUr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 08:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLHNUq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 08:20:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7088BC061749
        for <linux-block@vger.kernel.org>; Tue,  8 Dec 2020 05:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=tCEu8T8VsYV1bSdsPcylpEvyRYt5rPxVBJk0qmCos2o=; b=q+PjFCN+vW3SF0x5t+ZWSEeOae
        PBuz1LSxl3m3C0yM8q7PK0qhRXU9gSZRnckKvEVIiWiNhcsYFTpDnhMxZRZyhXwn6ign3vwS3E307
        VB8cMJgBssxbW1BZFvAafiTNJmol0iIIYfZXn6+SckA2C5VMRg7SF1HoadAvxNSMztTqxj4i7TZNh
        RVi1UhfjADNUJmEj+8ePzLOG2PO980TLszhQecRgGzfiYIxZ+8Cc4yZEpSsL6O3GcbWnX+6TsHBlv
        FS91mmcigak6Vr9slMrezCmgGwUpMcbVfWqdeGMb7pOOu9XStrqjVLtY0aERQziqhvJGu6WYWhuZ4
        nrWdYsdA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmcuS-0006OH-7n; Tue, 08 Dec 2020 13:20:04 +0000
Date:   Tue, 8 Dec 2020 13:20:04 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20201208132004.GC22219@infradead.org>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201204191356.2516405-4-bigeasy@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 04, 2020 at 08:13:56PM +0100, Sebastian Andrzej Siewior wrote:
> With llist_head it is possible to avoid the locking (the irq-off region)
> when items are added. This makes it possible to add items on a remote
> CPU.
> llist_add() returns true if the list was previously empty. This can be
> used to invoke the SMP function call / raise sofirq only if the first
> item was added (otherwise it is already pending).
> This simplifies the code a little and reduces the IRQ-off regions. With
> this change it possible to reduce the SMP-function call a simple
> __raise_softirq_irqoff().
> blk_mq_complete_request_remote() needs a preempt-disable section if the
> request needs to complete on the local CPU. Some callers (USB-storage)
> invoke this preemptible context and the request needs to be enqueued on
> the same CPU as the softirq is raised.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  block/blk-mq.c         | 77 ++++++++++++++----------------------------
>  include/linux/blkdev.h |  2 +-
>  2 files changed, 27 insertions(+), 52 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3c0e94913d874..b5138327952a4 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -41,7 +41,7 @@
>  #include "blk-mq-sched.h"
>  #include "blk-rq-qos.h"
>  
> +static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
>  
>  static void blk_mq_poll_stats_start(struct request_queue *q);
>  static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
> @@ -567,68 +567,32 @@ void blk_mq_end_request(struct request *rq, blk_status_t error)
>  }
>  EXPORT_SYMBOL(blk_mq_end_request);
>  
> +static void blk_complete_reqs(struct llist_head *cpu_list)
>  {
> +	struct llist_node *entry;
> +	struct request *rq, *rq_next;
>  
> +	entry = llist_del_all(cpu_list);
> +	entry = llist_reverse_order(entry);

I find the variable naming and split of the assignments a little
strange.  What about:

static void blk_complete_reqs(struct llist_head *list)
{
	struct llist_node *first = llist_reverse_order(llist_del_all(list));
	struct request *rq, *next;

?

> +	llist_for_each_entry_safe(rq, rq_next, entry, ipi_list)
>  		rq->q->mq_ops->complete(rq);
>  }

Aren't some sanitizers going to be unhappy if we never delete the
request from the list?

>  bool blk_mq_complete_request_remote(struct request *rq)
>  {
> +	struct llist_head *cpu_list;
>  	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
>  
>  	/*
> @@ -669,12 +634,22 @@ bool blk_mq_complete_request_remote(struct request *rq)
>  		return false;
>  
>  	if (blk_mq_complete_need_ipi(rq)) {
> +		unsigned int cpu;
> +
> +		cpu = rq->mq_ctx->cpu;
> +		cpu_list = &per_cpu(blk_cpu_done, cpu);
> +		if (llist_add(&rq->ipi_list, cpu_list)) {
> +			INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
> +			smp_call_function_single_async(cpu, &rq->csd);
> +		}

I think the above code section inside the conditional should go into a
little helper instead of being open coded here in the fast path routine.
I laso don't really see the ¶oint of the cpu and cpulist locl variables.

>  	} else {
>  		if (rq->q->nr_hw_queues > 1)
>  			return false;
> +		preempt_disable();
> +		cpu_list = this_cpu_ptr(&blk_cpu_done);
> +		if (llist_add(&rq->ipi_list, cpu_list))
> +			raise_softirq(BLOCK_SOFTIRQ);
> +		preempt_enable();

I think the section after the return false here also would benefit from
a little helper with a descriptive name.

Otherwise this looks good to me.
