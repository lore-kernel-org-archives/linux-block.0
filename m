Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA6DC11F6B
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 05:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A271F61CF4
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 05:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhGGFcs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jul 2021 01:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhGGFck (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jul 2021 01:32:40 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591A7C061760;
        Tue,  6 Jul 2021 22:30:00 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t3so2082685oic.5;
        Tue, 06 Jul 2021 22:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m4lqZbjB3cGT822e5RliK4G6yObopCjhH4y/z9EF+yE=;
        b=uarWOHfmD7XP60mVc87ksvRwc4pY1WtrYJYBCiKDVw0ui4tcLwca1vvmSbKHYsCE8B
         1yFlTXTNgKcO8CmUyNWS6NM0wriSDqg2n/2Y6czDOWNrCsdmfLyuIaUBAPfj+df6HsYj
         NzgPL5N9RE7TRn7nsaRk5QG6+K8zpeJB3YsKzUZ90yD3gfMm5y5tgHeHuqBzC1ZSN1RM
         3oGu4GBv5DBXFef1P49ctr2YU+Uq3wlQQy4mjDSbqOj/QQqwwPe8OqUD6Jm2sBjOrr7x
         dzvLrfT95pKhbEYSj7O2tDK/blZSFQYXPvrxMjmObbirSA4Fp+EXKp1LfVyr0fqodvPI
         3qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m4lqZbjB3cGT822e5RliK4G6yObopCjhH4y/z9EF+yE=;
        b=OFPKxbo/OpkgPbs2edYPFDyvKqGtBjB9lrTd0PoChPMqArGVty2SbD3cRFTQT+cR2m
         /di2Qcyqt4mr085aYluwVY8EXuL5EyT/le01v2xdosI5bMmuRLy4YKBHX/zNijzmAQsW
         nrM1eWKvJ51E90cSOw4E0EOilyQEAnvSvZc1NvKdKlSYR+wQsl5x9ENov3QTqY9t3qJi
         dNtW4CvDFe7z8VveWogUXOs9pgnb/eX/FWJx8Drf0a3LPNrlGFkRxf5XEOum7EULE/Q5
         T6Xn1vWSPEpAGDNH+GaWYbf0CVYwUPJEnkKwo4KBlbdWvD3/91UumpCzyB8aq0+cCS+t
         AkQQ==
X-Gm-Message-State: AOAM532U1C3Mmzfv/5hFSe7lO3jqDO9hACmGGIMEG2+QaM9wbxfsdAXq
        mOQ9rc/IHB4yPKZTfyLovLSebD9GmXo=
X-Google-Smtp-Source: ABdhPJwvfNJLz/5wXrIprlLivN5giytnzDOg/H2mMcHim/HT0QkrRytdi2HM2uHe5HzfMbP1dg+8bg==
X-Received: by 2002:aca:fd81:: with SMTP id b123mr6684226oii.39.1625635799466;
        Tue, 06 Jul 2021 22:29:59 -0700 (PDT)
Received: from fractal.attlocal.net ([2600:1700:1151:2380:3ec5:124:b596:7a55])
        by smtp.googlemail.com with ESMTPSA id l11sm3284843oou.0.2021.07.06.22.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 22:29:59 -0700 (PDT)
From:   Satya Tangirala <satyaprateek2357@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Satya Tangirala <satyat@google.com>
Subject: [PATCH v4 8/9] blk-merge: Ensure bios aren't split in middle of a crypto data unit
Date:   Tue,  6 Jul 2021 22:29:42 -0700
Message-Id: <20210707052943.3960-9-satyaprateek2357@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210707052943.3960-1-satyaprateek2357@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Satya Tangirala <satyat@google.com>

Update get_max_io_size() to return a value aligned to
bio_required_sector_alignment(). With this change, and the changes
to blk_ksm_register() that restrict the supported data unit sizes
based on the queue's limits, blk_bio_segment_split() won't split bios in
the middle of a data unit anymore

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-merge.c | 49 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index a11b3b53717e..68c96dec5680 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -135,27 +135,39 @@ static struct bio *blk_bio_write_same_split(struct request_queue *q,
 
 /*
  * Return the maximum number of sectors from the start of a bio that may be
- * submitted as a single request to a block device. If enough sectors remain,
- * align the end to the physical block size. Otherwise align the end to the
- * logical block size. This approach minimizes the number of non-aligned
- * requests that are submitted to a block device if the start of a bio is not
- * aligned to a physical block boundary.
+ * submitted as a single request to a block device. Tries to align the end to
+ * the physical block size, while also aligning the returned number of sectors
+ * to bio_required_sector_alignment(). This approach minimizes the number of
+ * non-aligned requests that are submitted to a block device if the start of a
+ * bio is not aligned to a physical block boundary.
+ *
+ * More clearly, there are two conditions we're interested in satisfying.
+ *
+ * Condition 1) We absolutely must have @return divisible by the
+ * bio_required_sector_alignment(bio).
+ *
+ * Condition 2) *If possible*, while still satisfying Condition 1, we would like
+ * to have start_offset + @return divisible by physical block size in sectors
+ * (pbs).
  */
 static inline unsigned get_max_io_size(struct request_queue *q,
 				       struct bio *bio)
 {
-	unsigned sectors = blk_max_size_offset(q, bio->bi_iter.bi_sector, 0);
-	unsigned max_sectors = sectors;
-	unsigned pbs = queue_physical_block_size(q) >> SECTOR_SHIFT;
-	unsigned lbs = queue_logical_block_size(q) >> SECTOR_SHIFT;
-	unsigned start_offset = bio->bi_iter.bi_sector & (pbs - 1);
-
-	max_sectors += start_offset;
-	max_sectors &= ~(pbs - 1);
-	if (max_sectors > start_offset)
-		return max_sectors - start_offset;
-
-	return sectors & ~(lbs - 1);
+	unsigned int start_offset = bio->bi_iter.bi_sector;
+	unsigned int sectors = blk_max_size_offset(q, start_offset, 0);
+	unsigned int pbs = queue_physical_block_size(q) >> SECTOR_SHIFT;
+	unsigned int req_sector_align = bio_required_sector_alignment(bio);
+	unsigned int pbs_aligned_sector = round_down(start_offset + sectors, pbs);
+
+	/*
+	 * If we can return a pbs aligned endpoint while satisfying Condition 1,
+	 * then do so.
+	 */
+	if (pbs_aligned_sector > start_offset &&
+	    IS_ALIGNED(pbs_aligned_sector - start_offset, req_sector_align))
+		return pbs_aligned_sector - start_offset;
+
+	return round_down(sectors, req_sector_align);
 }
 
 static inline unsigned get_max_segment_size(const struct request_queue *q,
@@ -235,6 +247,7 @@ static bool bvec_split_segs(const struct request_queue *q,
  * following is guaranteed for the cloned bio:
  * - That it has at most get_max_io_size(@q, @bio) sectors.
  * - That it has at most queue_max_segments(@q) segments.
+ * - That the number of sectors is aligned to bio_required_sector_alignment(@bio).
  *
  * Except for discard requests the cloned bio will point at the bi_io_vec of
  * the original bio. It is the responsibility of the caller to ensure that the
@@ -286,7 +299,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	 * big IO can be trival, disable iopoll when split needed.
 	 */
 	bio->bi_opf &= ~REQ_HIPRI;
-
+	sectors = round_down(sectors, bio_required_sector_alignment(bio));
 	return bio_split(bio, sectors, GFP_NOIO, bs);
 }
 
-- 
2.25.1

