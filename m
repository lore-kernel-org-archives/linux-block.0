Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC98C76190
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 17:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D5E2190F
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 17:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfGVRMW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:12:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38123 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfGVRMW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 13:12:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id f5so9139300pgu.5
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 10:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XnQNiInuJz4OAMuGhdIh2/RIRlM2itKx62gUE+ixMeg=;
        b=aEr/Rd9x+2vMg5N8eV+N7t0I6K00vvsO30z+UPm4oajYP5PGYXu+xC8ru7ubmpiSNb
         ls0pvyMDRkIqKSawJpmioAMtzCQnP8pAOSNwtmZQGmVPHDln0mUQptvAYcx0LwOv2/H/
         8e5XnWDmKaqrMC06zdDfCsObCH2Mk1xCoCsPDLTExkqr7VrxGqgJGAicFB+OOqf2yKoV
         ydSLXa+n7Ekm/L8TS85btJTClu4v3wk+Pl6iB//CBkvNe2BS+Tj9E0OJh5r7dmG1/hH4
         l31DDu9GfQzyW1GVdFar2gXA+E8uKd9AM/a3W0wQxJ5Hh02pOm+ZOZhUfCJlN/zxcsWE
         xhxQ==
X-Gm-Message-State: APjAAAUl1Z8omlwMtMWGODhn8fk4s3xWHt5wXbj+a+JHvf2VfCprytsN
        4GKfBSIf9VjWiUpJYnnT4/A=
X-Google-Smtp-Source: APXvYqzWrOT7RsjibcA+AD5OKaA28k6eJ67Z2aY6EyoyfbL5KXz96bDGy6SDxWZdTN/xGgGq4ZpDrw==
X-Received: by 2002:a65:52ca:: with SMTP id z10mr21986107pgp.424.1563815541123;
        Mon, 22 Jul 2019 10:12:21 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t26sm31196528pgu.43.2019.07.22.10.12.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 10:12:19 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 1/5] block: Declare several function pointer arguments 'const'
Date:   Mon, 22 Jul 2019 10:12:06 -0700
Message-Id: <20190722171210.149443-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722171210.149443-1-bvanassche@acm.org>
References: <20190722171210.149443-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make it clear to the compiler and also to humans that the functions
that query request queue properties do not modify any member of the
request_queue data structure.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-merge.c      |  7 ++++---
 include/linux/blkdev.h | 32 ++++++++++++++++----------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 57f7990b342d..8344d94f13e0 100644
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
index d2724cc7ccff..8da92411c8a2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1243,42 +1243,42 @@ enum blk_default_limits {
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
 
@@ -1293,7 +1293,7 @@ static inline unsigned short bdev_logical_block_size(struct block_device *bdev)
 	return queue_logical_block_size(bdev_get_queue(bdev));
 }
 
-static inline unsigned int queue_physical_block_size(struct request_queue *q)
+static inline unsigned int queue_physical_block_size(const struct request_queue *q)
 {
 	return q->limits.physical_block_size;
 }
@@ -1303,7 +1303,7 @@ static inline unsigned int bdev_physical_block_size(struct block_device *bdev)
 	return queue_physical_block_size(bdev_get_queue(bdev));
 }
 
-static inline unsigned int queue_io_min(struct request_queue *q)
+static inline unsigned int queue_io_min(const struct request_queue *q)
 {
 	return q->limits.io_min;
 }
@@ -1313,7 +1313,7 @@ static inline int bdev_io_min(struct block_device *bdev)
 	return queue_io_min(bdev_get_queue(bdev));
 }
 
-static inline unsigned int queue_io_opt(struct request_queue *q)
+static inline unsigned int queue_io_opt(const struct request_queue *q)
 {
 	return q->limits.io_opt;
 }
@@ -1323,7 +1323,7 @@ static inline int bdev_io_opt(struct block_device *bdev)
 	return queue_io_opt(bdev_get_queue(bdev));
 }
 
-static inline int queue_alignment_offset(struct request_queue *q)
+static inline int queue_alignment_offset(const struct request_queue *q)
 {
 	if (q->limits.misaligned)
 		return -1;
@@ -1353,7 +1353,7 @@ static inline int bdev_alignment_offset(struct block_device *bdev)
 	return q->limits.alignment_offset;
 }
 
-static inline int queue_discard_alignment(struct request_queue *q)
+static inline int queue_discard_alignment(const struct request_queue *q)
 {
 	if (q->limits.discard_misaligned)
 		return -1;
@@ -1443,7 +1443,7 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 	return 0;
 }
 
-static inline int queue_dma_alignment(struct request_queue *q)
+static inline int queue_dma_alignment(const struct request_queue *q)
 {
 	return q ? q->dma_alignment : 511;
 }
@@ -1554,7 +1554,7 @@ static inline void blk_queue_max_integrity_segments(struct request_queue *q,
 }
 
 static inline unsigned short
-queue_max_integrity_segments(struct request_queue *q)
+queue_max_integrity_segments(const struct request_queue *q)
 {
 	return q->limits.max_integrity_segments;
 }
@@ -1637,7 +1637,7 @@ static inline void blk_queue_max_integrity_segments(struct request_queue *q,
 						    unsigned int segs)
 {
 }
-static inline unsigned short queue_max_integrity_segments(struct request_queue *q)
+static inline unsigned short queue_max_integrity_segments(const struct request_queue *q)
 {
 	return 0;
 }
-- 
2.22.0.657.g960e92d24f-goog

