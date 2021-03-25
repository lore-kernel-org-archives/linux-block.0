Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0572C433E5
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D5C61A49
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhCYV1g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 17:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhCYV1W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 17:27:22 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE86C06175F
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 14:27:21 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id o9so4896554pgm.15
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 14:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TnnMN4vSnburpP0p5zfJZ0YTWAM3zr+1yO4sOYNeObw=;
        b=iDerRLqN0sWzjLVCp6K3+9wTVIJZe/I52K0B0MAzj+s2oWoQiLuRv/6tj2akbgx/DE
         tklxs/X/ZZ3dc77dCHHSJU0EhzfGBWXKsrPJR+CX/CaqLlfBwgJlDrgIyBGM2bUd+/GG
         JxxOGWi19FLW2tYu0DPKm4bOqga6AW3MAYdw0EMI/pmPt92phB2b41Jlasrp3xqgdEpV
         wRbg2n5FUk1uYjjyIx+IpmaKzwleep8ORV5Rl8LawAPTOxET33rR5zBA0q1kyUfwu1hL
         NkEAkNWCAFAIjFC9fMVr5vm5PmpFTPTyUKmOQVduOcSuk7EPQ2Cg9/x0LOl6mqz5bOgI
         wL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TnnMN4vSnburpP0p5zfJZ0YTWAM3zr+1yO4sOYNeObw=;
        b=sm5rDWrucl+3YnXmrNMbhVs194VgtS8xgCrzFjKshNRrUJqY22y8G1hVeeew+C8qjF
         V51YeDRVhz4FkHHn6Rj9US0s+cL2zqLeQfQYg1ayuU/LduznPRkbJWgtXSlwJvYr/LGT
         ht/7adqpueIkrsioCyowIXzCfUDU6EJWBkfZ8DXExrANU9vEuDlMxaM7kxtccNppHr5p
         oL2oGKcs32mEBW7QqPyGDYcMVAcZ/Nds+f8ubexEEdFJQqzuacsF74clu4f53dDf4Kst
         nsokb46Qk64AtkAJ+I15pRlgfpAqJTvtCFTv7V/6Iu2w2m0YWgOY1OXVoAthjN7hl09l
         mepA==
X-Gm-Message-State: AOAM531kKjNAisLZlzoIXe/465xN1wWdOD36rI0Ut8sjcmr0L11sczuN
        7pXfsBqYsvw0AohKRYozkmZTRqgIJipkRWNjoMninvYN1kWnERj3ttvFZNl1gwv9Ea/Zm2FSfoc
        DN5+g8PmiDKX/DVFkfo65vP9NOUvxuQ2uCNr4qX4FIFU8REU/EhlgqiiHjrokfaRtO37B
X-Google-Smtp-Source: ABdhPJy5Mf8TqiV+22r/mFlrkFLXc1kV2/znD6Fm/hdveG/IK+/VGL0qOev5BKQlzB1G/D8b93CG7TxG1XU=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a17:90a:8b97:: with SMTP id
 z23mr1664117pjn.1.1616707640440; Thu, 25 Mar 2021 14:27:20 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:26:08 +0000
In-Reply-To: <20210325212609.492188-1-satyat@google.com>
Message-Id: <20210325212609.492188-8-satyat@google.com>
Mime-Version: 1.0
References: <20210325212609.492188-1-satyat@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 7/8] blk-merge: Ensure bios aren't split in middle of a
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
index ffb4aa0ea68b..2903de62aaca 100644
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
2.31.0.291.g576ba9dcdaf-goog

