Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E6AC19759
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 22:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD532080C
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 22:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbfHAWu4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:50:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40983 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732058AbfHAWuy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 18:50:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so34907465pff.8
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2019 15:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VUEzYYkhp+BC4vL6yhQylrF9cJTyrVZWCRRlLtTmY5A=;
        b=h5p/LAPTV+gnSbwY0SA9Z5GN1J65J+oz0y/ALrt3c23VXhMMi6xbqgZsmyLqpAE8mX
         02jLo+Mv6PWpBS9Nan6GE7fA6o6u7JNVO+5k4JOW+EKKvjXvJQJcwN87Cx4zPjyvOXiy
         txmswLBvYXaqvEDdwDBnFE6TtpFZEeLj9yXCBEYXu+AZNQPw/p0YEAxStslulun7QnDx
         daPs26ABbjA2zFzwpCmoZ41RSm7I74MU+2B8ucUguTpl6SE9Ytw7ApoCxK9TqRerFXBs
         eKkqmwqoTqhfTBHUYd/mJfbg1jXocXBFEyXDLSEWu0bb/yv8TIvEBlNKJNZfB+M8wmgg
         5f3A==
X-Gm-Message-State: APjAAAVs+fqgzoGhN85+itztNIHWLqFUBN1NI8GLZpFltNfVm6jkKnSf
        n2KkaJVPkX0gUQq2fDMPXO4=
X-Google-Smtp-Source: APXvYqw51tX4aSKGR37uaxgzC+dCpw5NiuM1okQ4llUzhER/5BuSNJvzZOfPbOi1NuSsD+o/r/n1Sw==
X-Received: by 2002:a62:d45d:: with SMTP id u29mr55860120pfl.135.1564699854172;
        Thu, 01 Aug 2019 15:50:54 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id d12sm35472010pfn.11.2019.08.01.15.50.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 15:50:53 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH v2 1/5] block: Declare several function pointer arguments 'const'
Date:   Thu,  1 Aug 2019 15:50:40 -0700
Message-Id: <20190801225044.143478-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801225044.143478-1-bvanassche@acm.org>
References: <20190801225044.143478-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make it clear to the compiler and also to humans that the functions
that query request queue properties do not modify any member of the
request_queue data structure.

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
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
index 1ef375dafb1c..96a29a72fd4a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1232,42 +1232,42 @@ enum blk_default_limits {
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
 
@@ -1282,7 +1282,7 @@ static inline unsigned short bdev_logical_block_size(struct block_device *bdev)
 	return queue_logical_block_size(bdev_get_queue(bdev));
 }
 
-static inline unsigned int queue_physical_block_size(struct request_queue *q)
+static inline unsigned int queue_physical_block_size(const struct request_queue *q)
 {
 	return q->limits.physical_block_size;
 }
@@ -1292,7 +1292,7 @@ static inline unsigned int bdev_physical_block_size(struct block_device *bdev)
 	return queue_physical_block_size(bdev_get_queue(bdev));
 }
 
-static inline unsigned int queue_io_min(struct request_queue *q)
+static inline unsigned int queue_io_min(const struct request_queue *q)
 {
 	return q->limits.io_min;
 }
@@ -1302,7 +1302,7 @@ static inline int bdev_io_min(struct block_device *bdev)
 	return queue_io_min(bdev_get_queue(bdev));
 }
 
-static inline unsigned int queue_io_opt(struct request_queue *q)
+static inline unsigned int queue_io_opt(const struct request_queue *q)
 {
 	return q->limits.io_opt;
 }
@@ -1312,7 +1312,7 @@ static inline int bdev_io_opt(struct block_device *bdev)
 	return queue_io_opt(bdev_get_queue(bdev));
 }
 
-static inline int queue_alignment_offset(struct request_queue *q)
+static inline int queue_alignment_offset(const struct request_queue *q)
 {
 	if (q->limits.misaligned)
 		return -1;
@@ -1342,7 +1342,7 @@ static inline int bdev_alignment_offset(struct block_device *bdev)
 	return q->limits.alignment_offset;
 }
 
-static inline int queue_discard_alignment(struct request_queue *q)
+static inline int queue_discard_alignment(const struct request_queue *q)
 {
 	if (q->limits.discard_misaligned)
 		return -1;
@@ -1432,7 +1432,7 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 	return 0;
 }
 
-static inline int queue_dma_alignment(struct request_queue *q)
+static inline int queue_dma_alignment(const struct request_queue *q)
 {
 	return q ? q->dma_alignment : 511;
 }
@@ -1543,7 +1543,7 @@ static inline void blk_queue_max_integrity_segments(struct request_queue *q,
 }
 
 static inline unsigned short
-queue_max_integrity_segments(struct request_queue *q)
+queue_max_integrity_segments(const struct request_queue *q)
 {
 	return q->limits.max_integrity_segments;
 }
@@ -1626,7 +1626,7 @@ static inline void blk_queue_max_integrity_segments(struct request_queue *q,
 						    unsigned int segs)
 {
 }
-static inline unsigned short queue_max_integrity_segments(struct request_queue *q)
+static inline unsigned short queue_max_integrity_segments(const struct request_queue *q)
 {
 	return 0;
 }
-- 
2.22.0.770.g0f2c4a37fd-goog

