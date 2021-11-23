Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DE8C433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhKWQm6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbhKWQmx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 11:42:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76144C061748
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hL3559VS027qDMhjPdfKNK+RjMkhpHyILDqAX/T3jZ8=; b=w7LglHvvE0YtpEpOr1FZmgeesl
        7dmdLZsossqyxzJDDA4qjUDqb9zMj0q4dNlKGRhFukI9/VJeEV8u/qE4N6XA0CxjTMCO3HX66gBJO
        X8l5Zp+QaDIGxf6tLO8P8yZM6bD80KWG4sxCmIl3v8cqilEgEdfP5fpb80BOtRZvCfuH+lcLq3+50
        C7aQq7hKudffHuczrzL4bepEMJaLRuTPnSg7ye8ze4CDh3Bg1lOPepdQURwr7RzaWnnGE7fBsvnhw
        pOdxOVgYkKGRTStgCqcHWwBoezoi75XIknKpvCTBPT6BiUFmpGpAVl//r9uoaGyIUIKPjYc8qg/1v
        Wo2TLyjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpYpc-002wLM-Vq; Tue, 23 Nov 2021 16:39:44 +0000
Date:   Tue, 23 Nov 2021 08:39:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] block: move io_context creation into where it's
 needed
Message-ID: <YZ0ZUJGilOzhF2k5@infradead.org>
References: <20211123161813.326307-1-axboe@kernel.dk>
 <20211123161813.326307-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123161813.326307-2-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	/* create task io_context, if we don't have one already */
> +	if (unlikely(!current->io_context))
> +		create_task_io_context(current, GFP_ATOMIC, rq->q->node);

Wouldn't it be nicer to have an interface that hides the check
and the somewhat pointless current argument?  And name that with a
blk_ prefix?

> +
> +	blk_mq_sched_assign_ioc(rq);

But thinking about this a little more:

struct io_context has two uses, one is the unsigned short ioprio,
and the other is the whole bfq mess.

Can't we just split the ioprio out (we'll find a hole somewhere
in task_struct) and then just allocate the io_context in
blk_mq_sched_assign_ioc, which would also avoid the pointless
ioc_lookup_icq on a newly allocated io_context.  I'd also really
expect blk_mq_sched_assign_ioc to be implemented in blk-ioc.c.

While we're at it: bfq_bic_lookup is a really weird helper which
gets passed an unused bfqd argument.
