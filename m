Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBA4C433E9
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 19:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FADB22D58
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 19:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbhAZFb0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbhAYJZY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 04:25:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEC2C0617A7;
        Mon, 25 Jan 2021 00:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7yVqflIwxbWPrQTBGwlaVvHWryILP/M7IQGatiOKOy4=; b=kEmWH7L36XURkGDwt5Bt4DQM8I
        +9QyGaxW2J9XGxizkK+PvLs0QG7ahjXAFh0bwCgNmRAVBQ7ScYMfQNO/ommNz3H/jl/lLKL72E76/
        rDhHENXpLDibqGYW1UqFAriVyjmX86/6vZdsadEQdm3pzXQw2vPZCajmDm/XLFZQVyDzVLRc+O9eY
        S2LgH75ijbVtHRhlz8JuDXeAViPygINHFmhgwChWO0We8H3uCAZ6TpLjICdwrnS2cSdAQxVWKaXwa
        3z2bsV24k+gY4LdqYFlEdkIJiLstYfL+WxlZnxhlig3YQAdt1v9wDUlUsP3jvcO5x+WGjPOYvWsMl
        VcQbf25Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l3xGG-003xry-LL; Mon, 25 Jan 2021 08:30:14 +0000
Date:   Mon, 25 Jan 2021 08:30:12 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20210125083012.GD942655@infradead.org>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
 <20210123201027.3262800-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123201027.3262800-4-bigeasy@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static void blk_mq_complete_send_ipi(struct request *rq)
> +{
> +	struct llist_head *list;
> +	unsigned int cpu;
> +
> +	cpu = rq->mq_ctx->cpu;
> +	list = &per_cpu(blk_cpu_done, cpu);
> +	if (llist_add(&rq->ipi_list, list)) {
> +		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
> +		smp_call_function_single_async(cpu, &rq->csd);
> +	}
> +}

Nit: it would be nice to initialize cpu and list in the declaration
lines.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
