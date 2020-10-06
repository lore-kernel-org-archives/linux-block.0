Return-Path: <SRS0=/MU2=DN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276AEC47095
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 07:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2854C2080A
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 07:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YgIIZGm2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgJFHH1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 03:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbgJFHH0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 03:07:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC21C0613D2
        for <linux-block@vger.kernel.org>; Tue,  6 Oct 2020 00:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=v3qm8jk/m29MYSu/R0mBBoqOjSNzON7a8VE8CzosqD0=; b=YgIIZGm2VzT81n7+BUEYpO8LIz
        Y0OL+V47GXmj32KxOeDFjF4JaQGGx6AdY+f1obIXqVmfWiTzapQgwdmWtvrz/w8NJCyl7yJpzDqQY
        swM+zaF9j8tqpUninwSPFInn2cB2eB2ZGfVA0+dTTpEko06YMjUc1TW4XltMM8kXaKwKPZpXvA6UT
        nt9SC4l6Smzwg8aTg58cgJXPDswTc2R6na9ac27zrAafxljer23e11xqc5ru1VDTglWRnBsxdQFpt
        lAs1C4Dh/NQL9qhU01A5pZOvUSITSrL3+ElC0ngkAO76JPchxIZgVohPbAob14e7O7Vdww2T+ZOQZ
        2r0GlGfg==;
Received: from [2001:4bb8:184:92a2:9ae2:c87f:2c64:2882] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPh4F-0002XM-TW; Tue, 06 Oct 2020 07:07:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: remove the unused blk_integrity_merge_bio export
Date:   Tue,  6 Oct 2020 09:07:18 +0200
Message-Id: <20201006070719.427627-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006070719.427627-1-hch@lst.de>
References: <20201006070719.427627-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Also move the definition from the public blkdev.h to the private
block/blk.h header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-integrity.c  | 1 -
 block/blk.h            | 7 +++++++
 include/linux/blkdev.h | 8 --------
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index a262e069eb3fe6..410da060d1f5ad 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -211,7 +211,6 @@ bool blk_integrity_merge_bio(struct request_queue *q, struct request *req,
 
 	return true;
 }
-EXPORT_SYMBOL(blk_integrity_merge_bio);
 
 struct integrity_sysfs_entry {
 	struct attribute attr;
diff --git a/block/blk.h b/block/blk.h
index ba4e8ac538cdc7..8fcb146d30034f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -122,6 +122,8 @@ static inline bool bio_integrity_endio(struct bio *bio)
 
 bool blk_integrity_merge_rq(struct request_queue *, struct request *,
 		struct request *);
+bool blk_integrity_merge_bio(struct request_queue *, struct request *,
+		struct bio *);
 
 static inline bool integrity_req_gap_back_merge(struct request *req,
 		struct bio *next)
@@ -151,6 +153,11 @@ static inline bool blk_integrity_merge_rq(struct request_queue *rq,
 {
 	return true;
 }
+static inline bool blk_integrity_merge_bio(struct request_queue *rq,
+		struct request *r, struct bio *b)
+{
+	return true;
+}
 static inline bool integrity_req_gap_back_merge(struct request *req,
 		struct bio *next)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1c01e724659273..a8b04af50191dc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1663,8 +1663,6 @@ extern int blk_integrity_compare(struct gendisk *, struct gendisk *);
 extern int blk_rq_map_integrity_sg(struct request_queue *, struct bio *,
 				   struct scatterlist *);
 extern int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
-extern bool blk_integrity_merge_bio(struct request_queue *, struct request *,
-				    struct bio *);
 
 static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
 {
@@ -1792,12 +1790,6 @@ static inline unsigned short queue_max_integrity_segments(const struct request_q
 {
 	return 0;
 }
-static inline bool blk_integrity_merge_bio(struct request_queue *rq,
-					   struct request *r,
-					   struct bio *b)
-{
-	return true;
-}
 
 static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
 						   unsigned int sectors)
-- 
2.28.0

