Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87300C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C19610A0
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhJMRZf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhJMRZf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 13:25:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EACC061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dQ1G3yUTFz5g7SpXLVnVv/JoERJ9yqrT4EeBD8PaadQ=; b=FbM+uxp4QUWNId+zKmU/9koGVT
        ePswFulvemq5pYRGmG9RpP15/yqFKWYW+3fMbs5ebtu811UMXzDs2YsmKdnRFJ48aTgRkAoMddrmL
        J2RZxjWzbKyxc58b5lr0rYDFrpeqqpyzyZfd42eN8ErNCoXK4cQpE+muejVvUHJecdtTwhguUBUWi
        CbN2cabMvDFl0VnEjjpotXhhu7MhIapQKrPli7rz3/yJNrgeThC2qhzTvWMefLyk/+RrA5Ui1JCDd
        sIOkigoyFtKv3STvAOgdjsoVQNwY9SFKTne+3zVecakolLL1ln1iDQnpGGmW42dvx1YfW6/035b58
        dZ47BVtQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mahxn-007esP-SB; Wed, 13 Oct 2021 17:23:04 +0000
Date:   Wed, 13 Oct 2021 18:22:47 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] block: inline fast path of driver tag allocation
Message-ID: <YWcV52525ZR6ilwx@infradead.org>
References: <20211013164937.985367-1-axboe@kernel.dk>
 <20211013164937.985367-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013164937.985367-3-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 10:49:35AM -0600, Jens Axboe wrote:
> If we don't use an IO scheduler or have shared tags, then we don't need
> to call into this external function at all. This saves ~2% for such
> a setup.

Hmm.  What happens if you just throw an inline tag onto
blk_mq_get_driver_tag?  All the high performance callers should be
in blk-mq.c anyway.  If that isn't enough maybe something like the
version below?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 38e6651d8b94c..ba9af26d5209d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1126,18 +1126,23 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
 	return true;
 }
 
-bool blk_mq_get_driver_tag(struct request *rq)
+static void blk_mq_inc_active_requests(struct request *rq)
+{
+	if (!(rq->rq_flags & RQF_MQ_INFLIGHT)) {
+		rq->rq_flags |= RQF_MQ_INFLIGHT;
+		__blk_mq_inc_active_requests(rq->mq_hctx);
+	}
+}
+
+inline bool blk_mq_get_driver_tag(struct request *rq)
 {
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	if (rq->tag == BLK_MQ_NO_TAG && !__blk_mq_get_driver_tag(rq))
 		return false;
 
-	if ((hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED) &&
-			!(rq->rq_flags & RQF_MQ_INFLIGHT)) {
-		rq->rq_flags |= RQF_MQ_INFLIGHT;
-		__blk_mq_inc_active_requests(hctx);
-	}
+	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+		blk_mq_inc_active_requests(rq);
 	hctx->tags->rqs[rq->tag] = rq;
 	return true;
 }
