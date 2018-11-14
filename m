Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FF0C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED8822419
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WJpcw9T/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED8822419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbeKOCGa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:06:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeKOCGa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 21:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pItYFqWxQT24iMx8w2j7tkzD9bGXU65H2gw/jMb0ybo=; b=WJpcw9T/n9HoUkjgcREitqPKtW
        sNk7PSKU6ugIsLxudsl6pcMTvc/iD16HHIx/mn9dzqBWOAKkQv4vvTCk5dM+/+cxeNwpoWsH799Nv
        loTJ1srbA2VUt2VnS30xgXA0OLZqqJC07KDgr4XddExwqggwfM+NqRYp84CmXhJrzkDB+17GLqxQ5
        bzHcbtrUnOIE+m0mFza3zZdTAKNm89dEFAT9OY7zhjGQvK4SegOr3vPy4fy/2wWOY7sXTQkSjwWI3
        A9fc9cuQBroqtpRee9OuTxxYZDQd9eUzJXPPPaaeRclCbFeMYlSJxSoOi/rVwUF4O2eeqOdezmLOt
        mf2+Zv7A==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMxcm-0006BF-MR; Wed, 14 Nov 2018 16:02:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: [PATCH 07/16] block: update a few comments for the legacy request removal
Date:   Wed, 14 Nov 2018 17:02:10 +0100
Message-Id: <20181114160219.28328-8-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only the mq locking is left in the flush state machine.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index c53197dcdd70..fcd18b158fd6 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -148,7 +148,7 @@ static void blk_flush_queue_rq(struct request *rq, bool add_front)
  * completion and trigger the next step.
  *
  * CONTEXT:
- * spin_lock_irq(q->queue_lock or fq->mq_flush_lock)
+ * spin_lock_irq(fq->mq_flush_lock)
  *
  * RETURNS:
  * %true if requests were added to the dispatch queue, %false otherwise.
@@ -252,7 +252,7 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
  * Please read the comment at the top of this file for more info.
  *
  * CONTEXT:
- * spin_lock_irq(q->queue_lock or fq->mq_flush_lock)
+ * spin_lock_irq(fq->mq_flush_lock)
  *
  */
 static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
-- 
2.19.1

