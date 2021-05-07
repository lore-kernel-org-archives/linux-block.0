Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04758C433ED
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 06:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9888613CD
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 06:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhEGG64 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 May 2021 02:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbhEGG64 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 May 2021 02:58:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673CAC061574
        for <linux-block@vger.kernel.org>; Thu,  6 May 2021 23:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gxT6tgJKFvxd0r/6lckoxhsFPmqIjvV1p/6lG6HqL+g=; b=XoZ3kBd8IKgDb5bkMlTtwoDwnz
        RCN1Qh93lAM+IrHSButpBletx9YZFWAW5r5UqxtADVbmtyv/5mcq2iYpVVbiczTRs+jmYtEgHglpw
        rcbQowELKzjKorfQ2WNXIEkGMPCXtJGJGbMc5DPOBPTUGMKtCPWHsF3kt7WciZ+JogClfZBankNaw
        70UVeCXfFzQU9nxpF+a1wBOWTRVd8TbPQxQ0u/w6hubY9KPgACWFAFrR+aNeOJYT/Lwx/gkS45xcK
        SwMj85+gT6OEdY2Fw0LK3Quh3OR/c49GzRcDh6EakfNKKuw/RqqgoQvxRWQklEGg5xWuSE4QwqMEd
        U5g9qhKA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leuQN-002ugM-8v; Fri, 07 May 2021 06:57:26 +0000
Date:   Fri, 7 May 2021 07:57:23 +0100
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
Message-ID: <YJTk02/xqiO4Oy3n@infradead.org>
References: <20210505145855.174127-1-ming.lei@redhat.com>
 <20210505145855.174127-4-ming.lei@redhat.com>
 <20210506071256.GD328487@infradead.org>
 <YJOb+a85Cpb56Mdz@T590>
 <20210506121849.GA400362@infradead.org>
 <YJPxYXCZ2j1r1my1@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJPxYXCZ2j1r1my1@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 06, 2021 at 09:38:41PM +0800, Ming Lei wrote:
> > So.  Even a different LUN shares the same tagset.  So I can see the
> > need for the cmpxchg (please document it!), but I don't see the need
> > for the complex iteration.  All the rqs are freed in one single loop,
> > so we can just iterate through them sequentially.
> 
> That is exactly what the patch is doing, requests are stored in page
> list, so check if one request(covered in page list) reference in
> drv_tags->rq[i] exists, if yes, we clear the request reference.
> 
> The code is actually sort of self-document: before we free requests,
> clear the reference in hostwide drv->rqs[].

What the patch does it to do a completely pointless nested loop.
Instead of just looping through all requests which is simple and fast
it loops through each page, and then does another loop inside that,
just increasing complexity and runtime.  We should at least do something
like the incremental patch below instead which is simpler, faster and
easier to understand:


diff --git a/block/blk-mq.c b/block/blk-mq.c
index c1b28e09a27e..598fe82cfbcf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2311,29 +2311,20 @@ static size_t order_to_size(unsigned int order)
 	return (size_t)PAGE_SIZE << order;
 }
 
-/* called before freeing request pool in @tags */
+/* ensure that blk_mq_find_and_get_req can't find the tags any more */
 static void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
 		struct blk_mq_tags *tags, unsigned int hctx_idx)
 {
 	struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
-	struct page *page;
 	unsigned long flags;
+	int i;
 
 	spin_lock_irqsave(&drv_tags->lock, flags);
-	list_for_each_entry(page, &tags->page_list, lru) {
-		unsigned long start = (unsigned long)page_address(page);
-		unsigned long end = start + order_to_size(page->private);
-		int i;
+	for (i = 0; i < set->queue_depth; i++) {
+		struct request *rq = drv_tags->rqs[i];
 
-		for (i = 0; i < set->queue_depth; i++) {
-			struct request *rq = drv_tags->rqs[i];
-			unsigned long rq_addr = (unsigned long)rq;
-
-			if (rq_addr >= start && rq_addr < end) {
-				WARN_ON_ONCE(refcount_read(&rq->ref) != 0);
-				cmpxchg(&drv_tags->rqs[i], rq, NULL);
-			}
-		}
+		WARN_ON_ONCE(refcount_read(&rq->ref) != 0);
+		cmpxchg(&drv_tags->rqs[i], rq, NULL);
 	}
 	spin_unlock_irqrestore(&drv_tags->lock, flags);
 }
