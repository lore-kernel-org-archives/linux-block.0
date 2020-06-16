Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0ABC433DF
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 00:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B182074D
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 00:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCWd1M0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgFPA4w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgFPA4v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 20:56:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3FEC061A0E
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2020 17:56:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i4so741415pjd.0
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2020 17:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sdE7QDiyNCaWfAAZLc00Pnlw07T4St6eqFHodzUAZ+Q=;
        b=NCWd1M0KTbHhO4nPoVPPOEGQ//D6PQw7OjC29SZtezj7sA5jeChcEtTz97R84Z0eMA
         hQxIJbjltBxPCD26sEeJ05xQIB4wLaoMgUWrfnR0gIWwLhOpneShTtSXeD6fmbdVAMvJ
         GLUKZnc8bZ22500Lhe2qcTKZZybro637/Omr7pcCQBQnUGfjBl5GLpbdLw5qSaDBrBmz
         CAFz5hFbWDcbNz4+HmTkUBK6lf7bf1ZKQh3ukuvpbEbBJw17cG38MSLO57AgKbW8yVPJ
         sMkg90UADM8bo+m3mw/Q4lWSJzW4Yf7Hj/W0euRdOC6/5bAVWO9CpxjQZ2zlZk+kFOIx
         Y80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sdE7QDiyNCaWfAAZLc00Pnlw07T4St6eqFHodzUAZ+Q=;
        b=LyMpx7WUZkUnhkxtolWKhgLHynnhS9duE5omwVUcltmb+SMWf8+RyaZC36EiFRePa0
         zZz2sh9OQfypfobqeDYBvXF5g17ZC6BNa2PSW3zhBzDvpfITeUWtK+T+ExX3mFkJUO4D
         hy364QGhAagKAKIWzM/OU7FdTaBIZGq7wyHtnHnt6wB3394qL/L6PL3YI+Es2FOXGayf
         +3gVOeiGsKdVU7S3ryDFejROpQ8jPoQZaB5XRymPeURMi+5qnN2EYoj1eZYnU786QifK
         JXfNspjt8+c/B/OfXmKonQV2FZslTAGFJ2DCvz7WQaxbKroZLVymae+mpomObDwC6UNP
         kLfQ==
X-Gm-Message-State: AOAM531FRdV/b82Wy/k/+RwSDgeA0AhV5NJs7ktBimQ0Xw+/jfNeKG/X
        OctNYHrLQ/7QwSFIzSfHOLuLz6DL
X-Google-Smtp-Source: ABdhPJztGJ47ezxG56WAAsKhjyx7xJBsP8j5UtS9VzHALZ/+xjCda9R1ZWj4p+jCA9EckwpL2Rupfg==
X-Received: by 2002:a17:902:b10a:: with SMTP id q10mr472198plr.281.1592269009438;
        Mon, 15 Jun 2020 17:56:49 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id y4sm15135395pfr.182.2020.06.15.17.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 17:56:48 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH] block: add split_alignment for request queue
Date:   Mon, 15 Jun 2020 17:56:33 -0700
Message-Id: <20200616005633.172804-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This feature allows the user to control the alignment at which request
queue is allowed to split bios. Google CloudSQL's 16k user space
application expects that direct io writes aligned at 16k boundary in
the user-space are not split by kernel at non-16k boundaries. More
details about this feature can be found in CloudSQL's Cloud Next 2018
presentation[1]. The underlying block device is capable of performing
16k aligned writes atomically. Thus, this allows the user-space SQL
application to avoid double-writes (to protect against partial
failures) which are very costly provided that these writes are not
split at non-16k boundary by any underlying layers.

We make use of Ext4's bigalloc feature to ensure that writes issued by
Ext4 are 16k aligned. But, 16K aligned data writes may get merged with
contiguous non-16k aligned Ext4 metadata writes. Such a write request
would be broken by the kernel only guaranteeing that the individually
split requests are physical block size aligned.

We started observing a significant increase in 16k unaligned splits in
5.4. Bisect points to commit 07173c3ec276cbb18dc0e0687d37d310e98a1480
("block: enable multipage bvecs"). This patch enables multipage bvecs
resulting in multiple 16k aligned writes issued by the user-space to
be merged into one big IO at first. Later, __blk_queue_split() splits
these IOs while trying to align individual split IOs to be physical
block size.

Newly added split_alignment parameter is the alignment at which
requeust queue is allowed to split IO request. By default this
alignment is turned off and current behavior is unchanged.

[1] CloudNext'18 "Optimizaing performance for Cloud SQL for MySQL"
    https://www.youtube.com/watch?v=gIeuiGg-_iw

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 Documentation/block/queue-sysfs.rst |  8 ++++
 block/blk-merge.c                   | 64 ++++++++++++++++++++++-------
 block/blk-sysfs.c                   | 30 ++++++++++++++
 include/linux/blkdev.h              |  1 +
 4 files changed, 88 insertions(+), 15 deletions(-)

diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
index 6a8513af9201..c3eaba149415 100644
--- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -251,4 +251,12 @@ devices are described in the ZBC (Zoned Block Commands) and ZAC
 do not support zone commands, they will be treated as regular block devices
 and zoned will report "none".
 
+split_alignment (RW)
+----------------------
+This is the alignment in bytes at which the requeust queue is allowed
+to split IO requests. Once this value is set, the requeust queue
+splits IOs such that the individual IOs are aligned to
+split_alignment. The value of 0 indicates that an IO request can be
+split anywhere. This value must be a power of 2.
+
 Jens Axboe <jens.axboe@oracle.com>, February 2009
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1534ed736363..cdf337c74b83 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -105,15 +105,18 @@ static struct bio *blk_bio_discard_split(struct request_queue *q,
 static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
 		struct bio *bio, struct bio_set *bs, unsigned *nsegs)
 {
+	sector_t split;
+
 	*nsegs = 0;
 
-	if (!q->limits.max_write_zeroes_sectors)
-		return NULL;
+	split = q->limits.max_write_zeroes_sectors;
+	if (split && q->split_alignment >> 9)
+		split = round_down(split, q->split_alignment >> 9);
 
-	if (bio_sectors(bio) <= q->limits.max_write_zeroes_sectors)
+	if (!split || bio_sectors(bio) <= split)
 		return NULL;
 
-	return bio_split(bio, q->limits.max_write_zeroes_sectors, GFP_NOIO, bs);
+	return bio_split(bio, split, GFP_NOIO, bs);
 }
 
 static struct bio *blk_bio_write_same_split(struct request_queue *q,
@@ -121,15 +124,18 @@ static struct bio *blk_bio_write_same_split(struct request_queue *q,
 					    struct bio_set *bs,
 					    unsigned *nsegs)
 {
+	sector_t split;
+
 	*nsegs = 1;
 
-	if (!q->limits.max_write_same_sectors)
-		return NULL;
+	split = q->limits.max_write_same_sectors;
+	if (split && q->split_alignment >> 9)
+		split = round_down(split, q->split_alignment >> 9);
 
-	if (bio_sectors(bio) <= q->limits.max_write_same_sectors)
+	if (!split || bio_sectors(bio) <= split)
 		return NULL;
 
-	return bio_split(bio, q->limits.max_write_same_sectors, GFP_NOIO, bs);
+	return bio_split(bio, split, GFP_NOIO, bs);
 }
 
 /*
@@ -248,7 +254,10 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 {
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
 	struct bvec_iter iter;
-	unsigned nsegs = 0, sectors = 0;
+	unsigned int nsegs = 0, nsegs_aligned = 0;
+	unsigned int sectors = 0, sectors_aligned = 0, before = 0, after = 0;
+	unsigned int sector_alignment =
+		q->split_alignment ? (q->split_alignment >> 9) : 0;
 	const unsigned max_sectors = get_max_io_size(q, bio);
 	const unsigned max_segs = queue_max_segments(q);
 
@@ -264,12 +273,31 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 		    sectors + (bv.bv_len >> 9) <= max_sectors &&
 		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
 			nsegs++;
-			sectors += bv.bv_len >> 9;
-		} else if (bvec_split_segs(q, &bv, &nsegs, &sectors, max_segs,
-					 max_sectors)) {
-			goto split;
+			before = round_down(sectors, sector_alignment);
+			sectors += (bv.bv_len >> 9);
+			after = round_down(sectors, sector_alignment);
+			if (sector_alignment && before != after) {
+				/* This is a valid split point */
+				nsegs_aligned = nsegs;
+				sectors_aligned = after;
+			}
+			goto next;
 		}
-
+		if (sector_alignment) {
+			before = round_down(sectors, sector_alignment);
+			after = round_down(sectors + (bv.bv_len >> 9),
+					  sector_alignment);
+			if ((nsegs < max_segs) && before != after &&
+			    ((after - before) << 9) + bv.bv_offset <=  PAGE_SIZE
+			    && after <= max_sectors) {
+				sectors_aligned = after;
+				nsegs_aligned = nsegs + 1;
+			}
+		}
+		if (bvec_split_segs(q, &bv, &nsegs, &sectors, max_segs,
+				    max_sectors))
+			goto split;
+next:
 		bvprv = bv;
 		bvprvp = &bvprv;
 	}
@@ -278,7 +306,13 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	return NULL;
 split:
 	*segs = nsegs;
-	return bio_split(bio, sectors, GFP_NOIO, bs);
+	if (sector_alignment && sectors_aligned == 0)
+		return NULL;
+
+	*segs = sector_alignment ? nsegs_aligned : nsegs;
+
+	return bio_split(bio, sector_alignment ? sectors_aligned : sectors,
+			 GFP_NOIO, bs);
 }
 
 /**
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fca9b158f4a0..f045c7a79a74 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -529,6 +529,29 @@ static ssize_t queue_dax_show(struct request_queue *q, char *page)
 	return queue_var_show(blk_queue_dax(q), page);
 }
 
+static ssize_t queue_split_alignment_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(q->split_alignment, page);
+}
+
+static ssize_t queue_split_alignment_store(struct request_queue *q, const char *page,
+						size_t count)
+{
+	unsigned long split_alignment;
+	int ret;
+
+	ret = queue_var_store(&split_alignment, page, count);
+	if (ret < 0)
+		return ret;
+
+	/* split_alignment can only be a power of 2 */
+	if (split_alignment & (split_alignment - 1))
+		return -EINVAL;
+
+	q->split_alignment = split_alignment;
+	return count;
+}
+
 static struct queue_sysfs_entry queue_requests_entry = {
 	.attr = {.name = "nr_requests", .mode = 0644 },
 	.show = queue_requests_show,
@@ -727,6 +750,12 @@ static struct queue_sysfs_entry throtl_sample_time_entry = {
 };
 #endif
 
+static struct queue_sysfs_entry queue_split_alignment = {
+	.attr = {.name = "split_alignment", .mode = 0644 },
+	.show = queue_split_alignment_show,
+	.store = queue_split_alignment_store,
+};
+
 static struct attribute *queue_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
@@ -766,6 +795,7 @@ static struct attribute *queue_attrs[] = {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	&throtl_sample_time_entry.attr,
 #endif
+	&queue_split_alignment.attr,
 	NULL,
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32868fbedc9e..e8feb43f6fdd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -473,6 +473,7 @@ struct request_queue {
 	void			*dma_drain_buffer;
 	unsigned int		dma_pad_mask;
 	unsigned int		dma_alignment;
+	unsigned int		split_alignment;
 
 	unsigned int		rq_timeout;
 	int			poll_nsec;
-- 
2.27.0.290.gba653c62da-goog

