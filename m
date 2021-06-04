Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE2DC4743D
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 19:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECCF4613FE
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 19:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhFDUB0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jun 2021 16:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhFDUB0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jun 2021 16:01:26 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D09AC061767
        for <linux-block@vger.kernel.org>; Fri,  4 Jun 2021 12:59:39 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id f8-20020a17090a9b08b0290153366612f7so5808654pjp.1
        for <linux-block@vger.kernel.org>; Fri, 04 Jun 2021 12:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RhhC1LCT8rPaij2tSlm0EtMdQdPIQzsHGIcTpwsWNJI=;
        b=O5mhaoiyKYAf2FfzdD/uW/qz8fTJnrej2bs/W7+lu74g5LgAj7VlgD7D4tFnxJb3he
         FQbQj+/C80HEGpU5SqGAk3NUW++OIXrCIruLKlmdOOq72YQ1ivruOsm625RttnnlH3jv
         dfOUu+3qLLNLfHZ40l4Mwrt9XygrfzDx6yNyNIlRu3H88Bmztyfi2DqV5KaZIsQww/Ni
         b47SNv6Pj/chBs7UKNLalXZDEhy8yL/fyVuuuVyjt6fW74CcqxSweP3GgM+1j977nB2z
         4HaEp6V3+5ZgX4f78Sb8QxR0LAfzDLfZ9I6sF0rVsIp2r2k0qtRiGOHtnKwH+Cqv0btx
         GV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RhhC1LCT8rPaij2tSlm0EtMdQdPIQzsHGIcTpwsWNJI=;
        b=HvFgkxZKQfM3qCptmfIO3Cu2pBk/4CkFt0z1rC0qjsdTabCq8/0Q/Nxt9x7Grqxbaw
         mELXPXa0UVmc1Di/kbmF4W3fCN5zyNkEzBcgRWzfUXtRLAaZ3mOSDK2mIA5Tx9XELwDf
         pkY52hfDyRPg/u56nkt7iMVm5rliEwtdvKJCKlsH3fmT+8LFnbkgVi3ZAdtbNL1Qk79p
         OfcQt/RIFI1olzRBBxlDC5Feu4eYz1wuXEqvEcHrTR2xRJVi5r1xEdlbR2o7A0XmJnyY
         mDGxZnxFaBGZAE6CpS3DTG8yfijvSryHf94k44Zsb3Z5Puj8nJ/szowxKUXr8LLIHtFi
         h2Fg==
X-Gm-Message-State: AOAM533HVQiWLtHp/tWX1pVkky0XpZJ6O8YsMsn1rA6+/LGU9KGCudh2
        wptDWzljq1vgyw6IffR+N/euUxVEu6vsD+GXKJxk3+YV//68/sofc6ii8/0tZJBY92lI8Qlkgaz
        toCKZbnYIvCZKsvXhC1h5jo+qhHg4+dfV9qtt2NGfB+h0fhyikSX5k7z4U0gFtUIoGJnZ
X-Google-Smtp-Source: ABdhPJx1/zbo9ivQFwgi7Hpi4EofsvvDKRafsmvEDyXZ3uBeDnv6H1UMIk6kN5bWlssKX/hbIujAVa0yiXM=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a17:902:a5c9:b029:f7:9f7e:aa2f with SMTP id
 t9-20020a170902a5c9b02900f79f7eaa2fmr5978686plq.54.1622836778802; Fri, 04 Jun
 2021 12:59:38 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:58:59 +0000
In-Reply-To: <20210604195900.2096121-1-satyat@google.com>
Message-Id: <20210604195900.2096121-10-satyat@google.com>
Mime-Version: 1.0
References: <20210604195900.2096121-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 09/10] blk-merge: Ensure bios aren't split in middle of a
 crypto data unit
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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
index 4d97fb6dd226..00266e4ab05f 100644
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
2.32.0.rc1.229.g3e70b5a671-goog

