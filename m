Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B214C433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 18:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbhKWS40 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhKWS4Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 13:56:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C04BC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 10:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KK/J1hOHVMQgo8rhCaxLK1DTC6fObZ3oZeMEhXL07zg=; b=ALswjEJotZz5PGTvV1TomiU6yF
        Wm4KPB2fppDEeJa6vHpxy/oCZXN217io1MwSMivU7qLqJEx+gO1e0El01d7n7FDVyr4bU6VJNW/YA
        bxAoxGDExpwmjqZpBtw7VtUxrrM0wj/nTIGoewBjnh5u69oUKASu400sfCygz+v4d55qNPjxTopS1
        PrsAQRjG0dUQhz9PKqRZiNL5/w2RP/DsCYKRHY8eX/oj/KiTbDfMTaZOQomZLpSm8gH4iwe6T2ReF
        +ey0WwPjyaJ3l+M7VqboE84R8GEKtFd2L+/giGGKMAH3rFWs/xqBl0IBi9vA40iD568kFT3KPdhrF
        S+kIrWHg==;
Received: from [2001:4bb8:191:f9ce:a710:1fc3:2b4:5435] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpauo-00FzRB-Oi; Tue, 23 Nov 2021 18:53:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/8] block: move blk_get_flush_queue to blk-flush.c
Date:   Tue, 23 Nov 2021 19:53:05 +0100
Message-Id: <20211123185312.1432157-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123185312.1432157-1-hch@lst.de>
References: <20211123185312.1432157-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_get_flush_queue is only used in blk-flush.c, so move it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c | 6 ++++++
 block/blk.h       | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 1fce6d16e6d3a..86ee50455e414 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -95,6 +95,12 @@ enum {
 static void blk_kick_flush(struct request_queue *q,
 			   struct blk_flush_queue *fq, unsigned int flags);
 
+static inline struct blk_flush_queue *
+blk_get_flush_queue(struct request_queue *q, struct blk_mq_ctx *ctx)
+{
+	return blk_mq_map_queue(q, REQ_OP_FLUSH, ctx)->fq;
+}
+
 static unsigned int blk_flush_policy(unsigned long fflags, struct request *rq)
 {
 	unsigned int policy = 0;
diff --git a/block/blk.h b/block/blk.h
index 5d4d08df772b9..1346085d89cee 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -35,12 +35,6 @@ extern struct kmem_cache *blk_requestq_cachep;
 extern struct kobj_type blk_queue_ktype;
 extern struct ida blk_queue_ida;
 
-static inline struct blk_flush_queue *
-blk_get_flush_queue(struct request_queue *q, struct blk_mq_ctx *ctx)
-{
-	return blk_mq_map_queue(q, REQ_OP_FLUSH, ctx)->fq;
-}
-
 static inline void __blk_get_queue(struct request_queue *q)
 {
 	kobject_get(&q->kobj);
-- 
2.30.2

