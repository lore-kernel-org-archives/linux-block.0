Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3347C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE90261052
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhJLQZS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhJLQZS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 12:25:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942F2C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Z4QYME4cfvFHNzZsqwkmUUe81/k5gSLrLEwG7YwAaxE=; b=fuoyBgXHArpmAMVvtOKtVXhRHV
        0nuXNjm8Oo3lGX8zRSSlHODBNp+Z3Nh335VlI60voLWy2YxnL8IdIoVEsqqfbxoHhlStk3O/Ru9ax
        HKntzAs6tu0sZI/FeJkS5YG9aVa13Ki6/xgptVo8tg2wynmeAfhjne4UkPLr8NorJ7DHjANeczyAO
        vqdiNaSfOO7pIoNAYTvyFnTFuKjz3M+lw/khaGXQ0H1ImkHEmvvfdFG7TStNhwbgbY0GXD0upWdrP
        dDEWRo3gufs/qvM0h4r6JhA+mFHDzWMuKl06P73dQX3XYEeDza4/Syatd3moiKUOi89ibyZ49ubhh
        zHHxxbag==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maKXU-006e7i-3U; Tue, 12 Oct 2021 16:22:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/8] block: move bio_mergeable out of bio.h
Date:   Tue, 12 Oct 2021 18:17:59 +0200
Message-Id: <20211012161804.991559-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012161804.991559-1-hch@lst.de>
References: <20211012161804.991559-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_mergeable is only needed by I/O schedulers, so move it to
blk-mq-sched.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-sched.h | 5 +++++
 include/linux/bio.h  | 8 --------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index e4d367e0b2a30..a38d593a5e7a9 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -31,6 +31,11 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
 void blk_mq_sched_free_rqs(struct request_queue *q);
 
+static inline bool bio_mergeable(struct bio *bio)
+{
+	return !(bio->bi_opf & REQ_NOMERGE_FLAGS);
+}
+
 static inline bool
 blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
diff --git a/include/linux/bio.h b/include/linux/bio.h
index ae94794d07c9d..ec255f2829948 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -69,14 +69,6 @@ static inline bool bio_no_advance_iter(const struct bio *bio)
 	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
 }
 
-static inline bool bio_mergeable(struct bio *bio)
-{
-	if (bio->bi_opf & REQ_NOMERGE_FLAGS)
-		return false;
-
-	return true;
-}
-
 static inline unsigned int bio_cur_bytes(struct bio *bio)
 {
 	if (bio_has_data(bio))
-- 
2.30.2

