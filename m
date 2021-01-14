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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8525C433E6
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 15:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22F423B44
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 15:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbhANPsb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbhANPs3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jan 2021 10:48:29 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597DEC06179F
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 07:47:44 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id l3so4890188qvr.10
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 07:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=yjd7j/oRyi/09Ir0jClwnKrYAzTy2DPmihjhcr8kWmc=;
        b=YiREpvemIUhEmqaqL7UIAOp0t9TKxvhpsMRPaJXjYRycY9YcQHN79MViB3j2yosid1
         fcVc9F58S5arQiivAzziZ5HC+Cw9J2lSVwpVjgLz0U/HuGkcpjR2Q8xHBL6P4sUyfU7p
         ohOraXB1O/Vqraj0V9oqga+jIrZ8eOqgGLULv3XH8JOrzKgkkKhDH09Ye2Ej4eguMvo7
         WEV1iHYJ5dj4UHQM6yDWk5B8j5QIEgv9iMnXPrtNJWmUa3UtFNETfeWwWlLWzmpWG861
         2I9T6Dgm1gSTJwhBrAA0IRLAfK+HeF6On2w/ZhzDTaLsGGIARr7/CmmP/CKTDKX3cK7x
         KgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yjd7j/oRyi/09Ir0jClwnKrYAzTy2DPmihjhcr8kWmc=;
        b=GlGJ5K1sqei8UY3xc2F+j44gPYwrRdiMUt9FfpHrpp+H6p+D1aPZiNvCAkHrELhvMk
         yjK6/CWDkIydQE2YeiSDY/Y7MpdkjczSX751/T8Qa8NambAnoqMzHEyjinWF+rfj28hw
         aaSifEmtKBW4KRyqC77QebAP1dYvOtsVGnHenTZfY6iLY3Hzc+32g9zDNkDl2eQ0k3z6
         3L4KWPvr5m2D9CZIln0r5t3nl8KSOGlM94aUfFxR8cJGO3DCSahdBhZqSNPTZPsnfmgg
         WHv8vNKx6/1lkb02lFLyGA7aHzgSuUoVRWbY/FVMY9CC5XKcd7hZa/VymFA8q0snJWvG
         TMCw==
X-Gm-Message-State: AOAM530E3wo6ntsx3LD5OuAv9cXuqYfSpQfp0Af++HJt5OTHAbZ6VXBC
        CwyrKx8rpe+619x3lGbX9E9wm2dQCDPCoqspYvKQIpFfWweDmOoi6uBBcrg9Vry27QjLAzxLgYI
        QGZ8UXGGHiBxtaQ1UN022+7u1NHpylYbDMsyxMt/pVZvUepZM2ayJ3shii+eJGM1E8I21
X-Google-Smtp-Source: ABdhPJyi8OkvC7JM5jNlxAohk9r69dEQp7fliC/97rsmmY8YySVm9GtYm8d8/SHRxKz74I3GTEmSmucDh/8=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:6b52:: with SMTP id o18mr12072716ybm.143.1610639263413;
 Thu, 14 Jan 2021 07:47:43 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:47:23 +0000
In-Reply-To: <20210114154723.2495814-1-satyat@google.com>
Message-Id: <20210114154723.2495814-8-satyat@google.com>
Mime-Version: 1.0
References: <20210114154723.2495814-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 7/7] block: compute nsegs more accurately in blk_bio_segment_split()
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Previously, we rounded down the number of sectors just before calling
bio_split() in blk_bio_segment_split(). While this ensures that bios
are not split in the middle of a data unit, it makes it possible
for nsegs to be overestimated. This patch calculates nsegs accurately (it
calculates the smallest number of segments required for the aligned number
of sectors in the split bio).

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-merge.c | 97 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 80 insertions(+), 17 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 45cda45c1066..58428d348661 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -145,17 +145,17 @@ static inline unsigned get_max_io_size(struct request_queue *q,
 				       struct bio *bio)
 {
 	unsigned sectors = blk_max_size_offset(q, bio->bi_iter.bi_sector, 0);
-	unsigned max_sectors = sectors;
 	unsigned pbs = queue_physical_block_size(q) >> SECTOR_SHIFT;
 	unsigned lbs = queue_logical_block_size(q) >> SECTOR_SHIFT;
-	unsigned start_offset = bio->bi_iter.bi_sector & (pbs - 1);
+	unsigned pbs_aligned_sector =
+		round_down(sectors + bio->bi_iter.bi_sector, pbs);
 
-	max_sectors += start_offset;
-	max_sectors &= ~(pbs - 1);
-	if (max_sectors > start_offset)
-		return max_sectors - start_offset;
+	lbs = max(lbs, blk_crypto_bio_sectors_alignment(bio));
 
-	return sectors & ~(lbs - 1);
+	if (pbs_aligned_sector >= bio->bi_iter.bi_sector + lbs)
+		sectors = pbs_aligned_sector;
+
+	return round_down(sectors, lbs);
 }
 
 static inline unsigned get_max_segment_size(const struct request_queue *q,
@@ -174,6 +174,41 @@ static inline unsigned get_max_segment_size(const struct request_queue *q,
 			(unsigned long)queue_max_segment_size(q));
 }
 
+/**
+ * update_aligned_sectors_and_segs() - Ensures that *@aligned_sectors is aligned
+ *				       to @bio_sectors_alignment, and that
+ *				       *@aligned_segs is the value of nsegs
+ *				       when sectors reached/first exceeded that
+ *				       value of *@aligned_sectors.
+ *
+ * @nsegs: [in] The current number of segs
+ * @sectors: [in] The current number of sectors
+ * @aligned_segs: [in,out] The number of segments that make up @aligned_sectors
+ * @aligned_sectors: [in,out] The largest number of sectors <= @sectors that is
+ *		     aligned to @sectors
+ * @bio_sectors_alignment: [in] The alignment requirement for the number of
+ *			  sectors
+ *
+ * Updates *@aligned_sectors to the largest number <= @sectors that is also a
+ * multiple of @bio_sectors_alignment. This is done by updating *@aligned_sectors
+ * whenever @sectors is at least @bio_sectors_alignment more than
+ * *@aligned_sectors, since that means we can increment *@aligned_sectors while
+ * still keeping it aligned to @bio_sectors_alignment and also keeping it <=
+ * @sectors. *@aligned_segs is updated to the value of nsegs when @sectors first
+ * reaches/exceeds any value that causes *@aligned_sectors to be updated.
+ */
+static inline void update_aligned_sectors_and_segs(const unsigned int nsegs,
+						   const unsigned int sectors,
+						   unsigned int *aligned_segs,
+				unsigned int *aligned_sectors,
+				const unsigned int bio_sectors_alignment)
+{
+	if (sectors - *aligned_sectors < bio_sectors_alignment)
+		return;
+	*aligned_sectors = round_down(sectors, bio_sectors_alignment);
+	*aligned_segs = nsegs;
+}
+
 /**
  * bvec_split_segs - verify whether or not a bvec should be split in the middle
  * @q:        [in] request queue associated with the bio associated with @bv
@@ -195,9 +230,12 @@ static inline unsigned get_max_segment_size(const struct request_queue *q,
  * the block driver.
  */
 static bool bvec_split_segs(const struct request_queue *q,
-			    const struct bio_vec *bv, unsigned *nsegs,
-			    unsigned *sectors, unsigned max_segs,
-			    unsigned max_sectors)
+			    const struct bio_vec *bv, unsigned int *nsegs,
+			    unsigned int *sectors, unsigned int *aligned_segs,
+			    unsigned int *aligned_sectors,
+			    unsigned int bio_sectors_alignment,
+			    unsigned int max_segs,
+			    unsigned int max_sectors)
 {
 	unsigned max_len = (min(max_sectors, UINT_MAX >> 9) - *sectors) << 9;
 	unsigned len = min(bv->bv_len, max_len);
@@ -211,6 +249,11 @@ static bool bvec_split_segs(const struct request_queue *q,
 
 		(*nsegs)++;
 		total_len += seg_size;
+		update_aligned_sectors_and_segs(*nsegs,
+						*sectors + (total_len >> 9),
+						aligned_segs,
+						aligned_sectors,
+						bio_sectors_alignment);
 		len -= seg_size;
 
 		if ((bv->bv_offset + total_len) & queue_virt_boundary(q))
@@ -258,6 +301,9 @@ static int blk_bio_segment_split(struct request_queue *q,
 	unsigned nsegs = 0, sectors = 0;
 	const unsigned max_sectors = get_max_io_size(q, bio);
 	const unsigned max_segs = queue_max_segments(q);
+	const unsigned int bio_sectors_alignment =
+					blk_crypto_bio_sectors_alignment(bio);
+	unsigned int aligned_segs = 0, aligned_sectors = 0;
 
 	bio_for_each_bvec(bv, bio, iter) {
 		/*
@@ -272,8 +318,14 @@ static int blk_bio_segment_split(struct request_queue *q,
 		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
 			nsegs++;
 			sectors += bv.bv_len >> 9;
-		} else if (bvec_split_segs(q, &bv, &nsegs, &sectors, max_segs,
-					 max_sectors)) {
+			update_aligned_sectors_and_segs(nsegs, sectors,
+							&aligned_segs,
+							&aligned_sectors,
+							bio_sectors_alignment);
+		} else if (bvec_split_segs(q, &bv, &nsegs, &sectors,
+					   &aligned_segs, &aligned_sectors,
+					   bio_sectors_alignment, max_segs,
+					   max_sectors)) {
 			goto split;
 		}
 
@@ -281,11 +333,18 @@ static int blk_bio_segment_split(struct request_queue *q,
 		bvprvp = &bvprv;
 	}
 
+	/*
+	 * The input bio's number of sectors is assumed to be aligned to
+	 * bio_sectors_alignment. If that's the case, then this function should
+	 * ensure that aligned_segs == nsegs and aligned_sectors == sectors if
+	 * the bio is not going to be split.
+	 */
+	WARN_ON(aligned_segs != nsegs || aligned_sectors != sectors);
 	*segs = nsegs;
 	*split = NULL;
 	return 0;
 split:
-	*segs = nsegs;
+	*segs = aligned_segs;
 
 	/*
 	 * Bio splitting may cause subtle trouble such as hang when doing sync
@@ -294,10 +353,9 @@ static int blk_bio_segment_split(struct request_queue *q,
 	 */
 	bio->bi_opf &= ~REQ_HIPRI;
 
-	sectors = round_down(sectors, blk_crypto_bio_sectors_alignment(bio));
-	if (WARN_ON(sectors == 0))
+	if (WARN_ON(aligned_sectors == 0))
 		return -EIO;
-	*split = bio_split(bio, sectors, GFP_NOIO, bs);
+	*split = bio_split(bio, aligned_sectors, GFP_NOIO, bs);
 	return 0;
 }
 
@@ -395,6 +453,9 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
 {
 	unsigned int nr_phys_segs = 0;
 	unsigned int nr_sectors = 0;
+	unsigned int nr_aligned_phys_segs = 0;
+	unsigned int nr_aligned_sectors = 0;
+	unsigned int bio_sectors_alignment;
 	struct req_iterator iter;
 	struct bio_vec bv;
 
@@ -410,9 +471,11 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
 		return 1;
 	}
 
+	bio_sectors_alignment = blk_crypto_bio_sectors_alignment(rq->bio);
 	rq_for_each_bvec(bv, rq, iter)
 		bvec_split_segs(rq->q, &bv, &nr_phys_segs, &nr_sectors,
-				UINT_MAX, UINT_MAX);
+				&nr_aligned_phys_segs, &nr_aligned_sectors,
+				bio_sectors_alignment, UINT_MAX, UINT_MAX);
 	return nr_phys_segs;
 }
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

