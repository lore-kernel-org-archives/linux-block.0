Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A739AC433E0
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 09:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B0D9224DE
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 09:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbhAYJhm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jan 2021 04:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbhAYJfw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 04:35:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280DEC061353;
        Mon, 25 Jan 2021 00:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1YTL3xi9CVuV+0Md7FSHan4RIDZ4NeHG0snB2En/L1k=; b=IKK3nq9rkHme4slZau8I2LIOE/
        8aDher63l1E6jIGv4VbZ9GMYPJe8Z3F7SNHXKZ6mZQlZN/VcKAHx4Lz1WFAUAYzGSwDVH5w1N5yhW
        yUNvKvJPaf8oz3524BfMXCwlKhxBPiZI6/ixqVE5joxeb75fSZGt6KEHfFlj5WwhYCHfEA7T2dgQ6
        7YF+CT9FTFGNeKL55fNyQD8vmarHlIcOoFQh9kCxspGJOpXiK07+oO+2xnNV0hxaPSGp3G0eEDFIK
        YNZd2wfAUcOZBC3ZcSQ41oMIaq7xpuV6Oz61w8UKIyYXteN3Wc/Y8+VAeCNwhBMu/EEkfF29DH9zy
        ZIh8ikXg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l3xOp-003yLT-Hk; Mon, 25 Jan 2021 08:39:06 +0000
Date:   Mon, 25 Jan 2021 08:39:03 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20210125083903.GB945284@infradead.org>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
 <20210123201027.3262800-4-bigeasy@linutronix.de>
 <20210125083012.GD942655@infradead.org>
 <20210125083204.ahddujk5m6njwbju@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125083204.ahddujk5m6njwbju@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 25, 2021 at 09:32:04AM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-01-25 08:30:12 [+0000], Christoph Hellwig wrote:
> > > +static void blk_mq_complete_send_ipi(struct request *rq)
> > > +{
> > > +	struct llist_head *list;
> > > +	unsigned int cpu;
> > > +
> > > +	cpu = rq->mq_ctx->cpu;
> > > +	list = &per_cpu(blk_cpu_done, cpu);
> > > +	if (llist_add(&rq->ipi_list, list)) {
> > > +		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
> > > +		smp_call_function_single_async(cpu, &rq->csd);
> > > +	}
> > > +}
> > 
> > Nit: it would be nice to initialize cpu and list in the declaration
> > lines.
> 
> Why? They get initialized later.

Because:

	unsigned int cpu = rq->mq_ctx->cpu;
	struct llist_head *list = &per_cpu(blk_cpu_done, cpu);

is a lot easier to follow than:

	struct llist_head *list;
	unsigned int cpu;

	cpu = rq->mq_ctx->cpu;
	list = &per_cpu(blk_cpu_done, cpu);

