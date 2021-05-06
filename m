Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF78C433B4
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 12:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E01561177
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 12:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhEFMWe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 08:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhEFMWd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 08:22:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A261C061574
        for <linux-block@vger.kernel.org>; Thu,  6 May 2021 05:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0/F+By2/0rOY+/GbuQnN9Li3vHhcIf1Z++Inx131o78=; b=L2ORPbXOZEcmQNyXyAkePiQ/B1
        u+Yt/CMAO1hXrmDpPBMas2IwqG4VkLPquYMlVaVGpbJIuQdGWnrXaA2cgEhMZg+RbwlpBcebyazXp
        CrlzBXnW4Q4Ep5/BdraHLGodmaPavXH/q9hh36IXvGOhzuGDpSggQiKtFzQh/dyapbUKcp2QknFoG
        r27ORwGmekgry0Q/vgo2I3qjjn7gwOMvep/DV9LVhnp0VhyQYPa18SSUPj8k6b0tNOSUT2+oN3uD+
        MnfDg8p2oPicczpqzwi9pFjOlLfCP7CtOKAiNlxgtRuMo4hRImDJ5gLqy6MlwEpiWB7Q9OEbz3XIh
        kK4X2lDA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lecxt-001goW-MN; Thu, 06 May 2021 12:19:10 +0000
Date:   Thu, 6 May 2021 13:18:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V5 3/4] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
Message-ID: <20210506121849.GA400362@infradead.org>
References: <20210505145855.174127-1-ming.lei@redhat.com>
 <20210505145855.174127-4-ming.lei@redhat.com>
 <20210506071256.GD328487@infradead.org>
 <YJOb+a85Cpb56Mdz@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJOb+a85Cpb56Mdz@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 06, 2021 at 03:34:17PM +0800, Ming Lei wrote:
> > {
> > 	struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
> > 	unsigned int i = 0;
> > 	unsigned long flags;
> > 
> > 	spin_lock_irqsave(&drv_tags->lock, flags);
> > 	for (i = 0; i < set->queue_depth; i++)
> > 		WARN_ON_ONCE(refcount_read(&drv_tags->rqs[i]->ref) != 0);
> > 		drv_tags->rqs[i] = NULL;
> 
> drv_tags->rqs[] may be assigned from another LUN at the same time, then
> the simple clearing will overwrite the active assignment. We just need
> to clear mapping iff the stored rq will be freed.

So.  Even a different LUN shares the same tagset.  So I can see the
need for the cmpxchg (please document it!), but I don't see the need
for the complex iteration.  All the rqs are freed in one single loop,
so we can just iterate through them sequentially.

Btw, I think ->lock might better be named ->clear_lock to document its
purpose better.
