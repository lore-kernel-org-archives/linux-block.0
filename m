Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6E8C04AB1
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 06:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F1420879
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 06:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="juiuYSTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfEMGjF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 May 2019 02:39:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfEMGjE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 02:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=s2kx0Pwv+YVLjI/MK8lN/4670dthhnWmC1mj+5QFMpI=; b=juiuYSTYzaodImoFl0E72V53fL
        fo9G7cyJLnDmT0fIPYCZfYbdFC0egYVV3WHp5wAeA1N49Xv3s6jYcGd42pkr9Swh8Hb+StTykCrOz
        Qiju0+d+u8SalxkW9Qnwy2Bt3k3PKqsnryThWTUCk6qJtBY/Kzjzw3CpoJ0Z/usawmseZCHjAbnKt
        qBEc69OfqxdNS6nCeTCykYQp2ZZD02oGHrKNs8MpGGgwLHNSGjIo1pBFqoXf+X0unC7vKf03GwJQN
        /XCHcRRnvolbFpVUkw34FIWoDv1UY/xsQdjmHodwhgX9CNf2yHdOIqeFh6J8EJin6cORTB7Dm9aP1
        WVwRQSPw==;
Received: from 089144210233.atnat0019.highway.a1.net ([89.144.210.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ4c3-0007Rj-3v; Mon, 13 May 2019 06:39:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     ming.lei@redhat.com, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Subject: [PATCH 10/10] block: mark blk_rq_bio_prep as inline
Date:   Mon, 13 May 2019 08:37:54 +0200
Message-Id: <20190513063754.1520-11-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513063754.1520-1-hch@lst.de>
References: <20190513063754.1520-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This function just has a few trivial assignments, has two callers with
one of them being in the fastpath.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 11 -----------
 block/blk.h      | 13 ++++++++++++-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c894c9887dca..9405388ac658 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1473,17 +1473,6 @@ bool blk_update_request(struct request *req, blk_status_t error,
 }
 EXPORT_SYMBOL_GPL(blk_update_request);
 
-void blk_rq_bio_prep(struct request *rq, struct bio *bio, unsigned int nr_segs)
-{
-	rq->nr_phys_segments = nr_segs;
-	rq->__data_len = bio->bi_iter.bi_size;
-	rq->bio = rq->biotail = bio;
-	rq->ioprio = bio_prio(bio);
-
-	if (bio->bi_disk)
-		rq->rq_disk = bio->bi_disk;
-}
-
 #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
 /**
  * rq_flush_dcache_pages - Helper function to flush all pages in a request
diff --git a/block/blk.h b/block/blk.h
index 5352cdb876a6..cbb0995ed17e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -51,7 +51,6 @@ struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
 void blk_exit_queue(struct request_queue *q);
-void blk_rq_bio_prep(struct request *rq, struct bio *bio, unsigned int nr_segs);
 void blk_freeze_queue(struct request_queue *q);
 
 static inline void blk_queue_enter_live(struct request_queue *q)
@@ -100,6 +99,18 @@ static inline bool bvec_gap_to_prev(struct request_queue *q,
 	return __bvec_gap_to_prev(q, bprv, offset);
 }
 
+static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
+		unsigned int nr_segs)
+{
+	rq->nr_phys_segments = nr_segs;
+	rq->__data_len = bio->bi_iter.bi_size;
+	rq->bio = rq->biotail = bio;
+	rq->ioprio = bio_prio(bio);
+
+	if (bio->bi_disk)
+		rq->rq_disk = bio->bi_disk;
+}
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 void blk_flush_integrity(void);
 bool __bio_integrity_endio(struct bio *);
-- 
2.20.1

