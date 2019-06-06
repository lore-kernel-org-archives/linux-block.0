Return-Path: <SRS0=ECsc=UF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690FAC28EB4
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 10:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4180D20657
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 10:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OJZx8amT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfFFK31 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jun 2019 06:29:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60434 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFFK31 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jun 2019 06:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=k9U4LVCcXoPz3Isb57jgcS3Psto7+BH4TDr9+rpWxng=; b=OJZx8amTvylqEMIDCgb7FGKnFN
        WT5KfFUxxA6SGZW3tOE5+FvSc+VHTslxY4HjywG3XjpPVZULH7ij9mOssqvsWXRYTAEEaTspJUBO7
        X41fVtXoYYMB2DxpWbDljy053Ti549TG/OZFa9iIT4XniHpsnr3BLsYBExsakVqUlBT4lHCgTCp3y
        ammnWECJDTyn2AhGb72NWjAC9dWJ6j2plHVMdekXKMr0sq9/qOw/3Vg5uOt+CPV4hTJ/s12pV2A8/
        bxFa/XQm/YXQTc7aPIZ0AO+spYEACr/UzjHLV5Vhi6IQu7ZrPqYhjHZBD2nUCs02rXnAo1UGgEN09
        imZUbZgw==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYpeA-0000I2-99; Thu, 06 Jun 2019 10:29:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 6/6] block: mark blk_rq_bio_prep as inline
Date:   Thu,  6 Jun 2019 12:29:04 +0200
Message-Id: <20190606102904.4024-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606102904.4024-1-hch@lst.de>
References: <20190606102904.4024-1-hch@lst.de>
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
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-core.c | 11 -----------
 block/blk.h      | 13 ++++++++++++-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2287b8c2979c..42f8f09dacf0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1415,17 +1415,6 @@ bool blk_update_request(struct request *req, blk_status_t error,
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
index befdab456209..2097b1905dc7 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -50,7 +50,6 @@ struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
 		int node, int cmd_size, gfp_t flags);
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
-void blk_rq_bio_prep(struct request *rq, struct bio *bio, unsigned int nr_segs);
 void blk_freeze_queue(struct request_queue *q);
 
 static inline void blk_queue_enter_live(struct request_queue *q)
@@ -99,6 +98,18 @@ static inline bool bvec_gap_to_prev(struct request_queue *q,
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

