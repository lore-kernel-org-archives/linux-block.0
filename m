Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB17C77B76
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 20:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjDPUJ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 16:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjDPUJ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 16:09:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8171FDD
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7E3POvlcC9iRKEOqthHTFYY0hV8UtacU7w+zg+Jy8JM=; b=YErtAdQycTCGEtvBf1qjJXNwqp
        rSEyLEeJB77/0SC6y0q3dxXQh2yZrcZEKC8hd0SQkTsZ1vHPpsCH4KcSWjjsb2k5kswTwBvyOUhhP
        KHtQN97jwvODt4CxE0d+A/43nlo9me99MZAsAcqyWuiNJfZcGfj93iEE1pRAgAlyImBcIGzz9Lrpe
        B3cnvxDohjbFq2NHIk+WVP2pFLzj67T9wOlldtRMoxcyqITqLqYMs9cyX2BBQ9Mwusf4LbLPkpY3+
        Azz1mCPM5TbI/UOpCpOvgUnDuwPKDkJCM4nGtYJrGC6eivX7D9fzOISVARjJ1EX0H6JAmJXSJ6a1R
        PXkEfBbQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1po8h7-00EOIs-12;
        Sun, 16 Apr 2023 20:09:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 5/7] blk-mq: defer to the normal submission path for post-flush requests
Date:   Sun, 16 Apr 2023 22:09:28 +0200
Message-Id: <20230416200930.29542-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230416200930.29542-1-hch@lst.de>
References: <20230416200930.29542-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Requests with the FUA bit on hardware without FUA support need a post
flush before returning the caller, but they can still be sent using
the normal I/O path after initializing the flush-related fields and
end I/O handler.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index f62e74d9d56bc8..9eda6d46438dba 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -435,6 +435,17 @@ bool blk_insert_flush(struct request *rq)
 		 * Queue for normal execution.
 		 */
 		return false;
+	case REQ_FSEQ_DATA | REQ_FSEQ_POSTFLUSH:
+		/*
+		 * Initialize the flush fields and completion handler to trigger
+		 * the post flush, and then just pass the command on.
+		 */
+		blk_rq_init_flush(rq);
+		rq->flush.seq |= REQ_FSEQ_PREFLUSH;
+		spin_lock_irq(&fq->mq_flush_lock);
+		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
+		spin_unlock_irq(&fq->mq_flush_lock);
+		return false;
 	default:
 		/*
 		 * Mark the request as part of a flush sequence and submit it
-- 
2.39.2

