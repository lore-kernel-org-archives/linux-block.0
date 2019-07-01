Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5E7C0650E
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 15:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B876520B7C
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 15:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfGAPso (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:48:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38970 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGAPso (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 11:48:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id 196so6244233pgc.6
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2019 08:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ONLgpekFE3x6JJxuHc8OoYkWc32xTBkXycJH35m+eIk=;
        b=I5j4N8oMaJmJMoEZGrvCYTp08kesu6lbasQRPCqxjoisvYAHkHq7WMes/Jjaherdbr
         fjrTGMaj6TMhvdP2ng9I3ZhcJ/Xk8lda3Xssrc6QdLwZU7WHrvgOIucTl72mG/PKhu6o
         f6juviMutOxA+lLrK8LSxgMazCyh+g7cE+Iuv5sX8b8iADkJ48vFPXOg7SY+CPldcxOp
         1zOnbZRW3hr+yNL+Ng99dogpOjaKvQ8nveq8XQZKEqZLWE4k5KJ9uULtLqXz15Ff7pSK
         +KZDXfGTjlIfToEAS67TUGz+BTS7HV4ao/xQAwxmO6CTyG/GUSf8iW1BrOAmR7YiFmzY
         V0KA==
X-Gm-Message-State: APjAAAVzkrgWLNlVV/Ao0hnd3lZKkr8g7WBxYRO0dpfxk+itRNpEYGJn
        m5qPTS10pwQ6c1i+LtCtE+4=
X-Google-Smtp-Source: APXvYqyl00adVevNaGIW3RPuHnDxD2JRkAZKWgCYoDc67xujoyoWPNGfuGleK/GcJFfsuzi/vZYNtg==
X-Received: by 2002:a63:b1d:: with SMTP id 29mr25485864pgl.103.1561996123040;
        Mon, 01 Jul 2019 08:48:43 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id q198sm16911171pfq.155.2019.07.01.08.48.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 08:48:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] block: Declare several function pointer arguments 'const'
Date:   Mon,  1 Jul 2019 08:48:36 -0700
Message-Id: <20190701154836.203998-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make it clear to the compiler and also to humans that the functions
that query request queue properties do not modify any member of the
request_queue data structure.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-merge.c      |  7 ++++---
 include/linux/blkdev.h | 32 ++++++++++++++++----------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index ca45eb51c669..4e2d94a50884 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -144,7 +144,7 @@ static inline unsigned get_max_io_size(struct request_queue *q,
 	return sectors;
 }
 
-static unsigned get_max_segment_size(struct request_queue *q,
+static unsigned get_max_segment_size(const struct request_queue *q,
 				     unsigned offset)
 {
 	unsigned long mask = queue_segment_boundary(q);
@@ -161,8 +161,9 @@ static unsigned get_max_segment_size(struct request_queue *q,
  * Split the bvec @bv into segments, and update all kinds of
  * variables.
  */
-static bool bvec_split_segs(struct request_queue *q, struct bio_vec *bv,
-		unsigned *nsegs, unsigned *sectors, unsigned max_segs)
+static bool bvec_split_segs(const struct request_queue *q,
+			    const struct bio_vec *bv, unsigned *nsegs,
+			    unsigned *sectors, unsigned max_segs)
 {
 	unsigned len = bv->bv_len;
 	unsigned total_len = 0;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index de32c10a6ea4..1e9253aa39b1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1238,42 +1238,42 @@ enum blk_default_limits {
 	BLK_SEG_BOUNDARY_MASK	= 0xFFFFFFFFUL,
 };
 
-static inline unsigned long queue_segment_boundary(struct request_queue *q)
+static inline unsigned long queue_segment_boundary(const struct request_queue *q)
 {
 	return q->limits.seg_boundary_mask;
 }
 
-static inline unsigned long queue_virt_boundary(struct request_queue *q)
+static inline unsigned long queue_virt_boundary(const struct request_queue *q)
 {
 	return q->limits.virt_boundary_mask;
 }
 
-static inline unsigned int queue_max_sectors(struct request_queue *q)
+static inline unsigned int queue_max_sectors(const struct request_queue *q)
 {
 	return q->limits.max_sectors;
 }
 
-static inline unsigned int queue_max_hw_sectors(struct request_queue *q)
+static inline unsigned int queue_max_hw_sectors(const struct request_queue *q)
 {
 	return q->limits.max_hw_sectors;
 }
 
-static inline unsigned short queue_max_segments(struct request_queue *q)
+static inline unsigned short queue_max_segments(const struct request_queue *q)
 {
 	return q->limits.max_segments;
 }
 
-static inline unsigned short queue_max_discard_segments(struct request_queue *q)
+static inline unsigned short queue_max_discard_segments(const struct request_queue *q)
 {
 	return q->limits.max_discard_segments;
 }
 
-static inline unsigned int queue_max_segment_size(struct request_queue *q)
+static inline unsigned int queue_max_segment_size(const struct request_queue *q)
 {
 	return q->limits.max_segment_size;
 }
 
-static inline unsigned short queue_logical_block_size(struct request_queue *q)
+static inline unsigned short queue_logical_block_size(const struct request_queue *q)
 {
 	int retval = 512;
 
@@ -1288,7 +1288,7 @@ static inline unsigned short bdev_logical_block_size(struct block_device *bdev)
 	return queue_logical_block_size(bdev_get_queue(bdev));
 }
 
-static inline unsigned int queue_physical_block_size(struct request_queue *q)
+static inline unsigned int queue_physical_block_size(const struct request_queue *q)
 {
 	return q->limits.physical_block_size;
 }
@@ -1298,7 +1298,7 @@ static inline unsigned int bdev_physical_block_size(struct block_device *bdev)
 	return queue_physical_block_size(bdev_get_queue(bdev));
 }
 
-static inline unsigned int queue_io_min(struct request_queue *q)
+static inline unsigned int queue_io_min(const struct request_queue *q)
 {
 	return q->limits.io_min;
 }
@@ -1308,7 +1308,7 @@ static inline int bdev_io_min(struct block_device *bdev)
 	return queue_io_min(bdev_get_queue(bdev));
 }
 
-static inline unsigned int queue_io_opt(struct request_queue *q)
+static inline unsigned int queue_io_opt(const struct request_queue *q)
 {
 	return q->limits.io_opt;
 }
@@ -1318,7 +1318,7 @@ static inline int bdev_io_opt(struct block_device *bdev)
 	return queue_io_opt(bdev_get_queue(bdev));
 }
 
-static inline int queue_alignment_offset(struct request_queue *q)
+static inline int queue_alignment_offset(const struct request_queue *q)
 {
 	if (q->limits.misaligned)
 		return -1;
@@ -1348,7 +1348,7 @@ static inline int bdev_alignment_offset(struct block_device *bdev)
 	return q->limits.alignment_offset;
 }
 
-static inline int queue_discard_alignment(struct request_queue *q)
+static inline int queue_discard_alignment(const struct request_queue *q)
 {
 	if (q->limits.discard_misaligned)
 		return -1;
@@ -1438,7 +1438,7 @@ static inline unsigned int bdev_zone_sectors(struct block_device *bdev)
 	return 0;
 }
 
-static inline int queue_dma_alignment(struct request_queue *q)
+static inline int queue_dma_alignment(const struct request_queue *q)
 {
 	return q ? q->dma_alignment : 511;
 }
@@ -1549,7 +1549,7 @@ static inline void blk_queue_max_integrity_segments(struct request_queue *q,
 }
 
 static inline unsigned short
-queue_max_integrity_segments(struct request_queue *q)
+queue_max_integrity_segments(const struct request_queue *q)
 {
 	return q->limits.max_integrity_segments;
 }
@@ -1632,7 +1632,7 @@ static inline void blk_queue_max_integrity_segments(struct request_queue *q,
 						    unsigned int segs)
 {
 }
-static inline unsigned short queue_max_integrity_segments(struct request_queue *q)
+static inline unsigned short queue_max_integrity_segments(const struct request_queue *q)
 {
 	return 0;
 }
-- 
2.22.0.410.gd8fdbe21b5-goog

