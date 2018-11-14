Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442AFC07E85
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A02208E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pRblJo29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A02208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387526AbeKOCGY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:06:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeKOCGY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 21:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Y8h2zcNg2vPBvo+gLHyJ5B8EIuceZ4wP3yVBAiVq2bk=; b=pRblJo29Hz0FvwKIoP1wpLDvsJ
        1NplDR+tMIXmTx0rqbQ0FFvVusqpIWhlUSYFWLXvvA+19aqq4ThJCSLNVvng5y0cjI4Y/fTlBS/7/
        ejZpdS1Pw96aylHTHgpdw7AlFv0L5LtZvA44Zq6Zr2L5jJ3N/TuZ3ztIgL7j1GsfAXJ/JB22r+oVr
        lPeHngGDtQdMgfOOB+2pcSnF7FhC8KZNq7P5tnelQwDH/qms4WHALRcIcMRGcewYRpMjYUZeSsZFA
        gpPkWdzkAE3fX18vQiTXwEHz565rgSxkzn1+94CLiHKKH1vrEzNVlVs9ETF9VKJVOY/vorQQW0GBA
        +OuyhXrA==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMxch-0006AZ-0m; Wed, 14 Nov 2018 16:02:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: [PATCH 05/16] block: remove queue_lockdep_assert_held
Date:   Wed, 14 Nov 2018 17:02:08 +0100
Message-Id: <20181114160219.28328-6-hch@lst.de>
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

The only remaining user unconditionally drops and reacquires the lock,
which means we really don't need any additional (conditional) annotation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-throttle.c |  1 -
 block/blk.h          | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 8e6f3c9821c2..a665b0950369 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2353,7 +2353,6 @@ void blk_throtl_drain(struct request_queue *q)
 	struct bio *bio;
 	int rw;
 
-	queue_lockdep_assert_held(q);
 	rcu_read_lock();
 
 	/*
diff --git a/block/blk.h b/block/blk.h
index f2ddc71e93da..027a0ccc175e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -35,19 +35,6 @@ extern struct kmem_cache *blk_requestq_cachep;
 extern struct kobj_type blk_queue_ktype;
 extern struct ida blk_queue_ida;
 
-/*
- * @q->queue_lock is set while a queue is being initialized. Since we know
- * that no other threads access the queue object before @q->queue_lock has
- * been set, it is safe to manipulate queue flags without holding the
- * queue_lock if @q->queue_lock == NULL. See also blk_alloc_queue_node() and
- * blk_init_allocated_queue().
- */
-static inline void queue_lockdep_assert_held(struct request_queue *q)
-{
-	if (q->queue_lock)
-		lockdep_assert_held(q->queue_lock);
-}
-
 static inline struct blk_flush_queue *
 blk_get_flush_queue(struct request_queue *q, struct blk_mq_ctx *ctx)
 {
-- 
2.19.1

