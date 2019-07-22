Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B88C76190
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 17:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B412190F
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 17:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfGVRM0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:12:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46484 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfGVRM0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 13:12:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id c73so17671337pfb.13
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 10:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lpbzzr3ZSzw/j2x3jxMSTnzwpwcRoRgPv+EISeqNwpc=;
        b=m6hmz17ihKDYmuMDitTt8GXhbSQYszZe4gicI9CREza9jrhPQNj/yjt/prvEs5TlBn
         Cs2+5MuGw6/7B+2+X20SWY0rqL86F4/uUEVW9gyi3dlBtWj2td4hMv3i7piKxj4eOl5U
         zsqhTkmB8NDaQLN0mAe3hZC8+liDoxsNM9onEcXj7bUW5fzufoMjUGWDCIYLaxNSaYf+
         pHNd1EG2XAjjE9wXc1VRBkMqyIa26CoLj7PujSJajoEC3I1vDqBu5iPdWrijyQ85GtD1
         zLg4OgBF0L5wYDUTprJzq9MzgXux+iDitjyhV/04zV6+ysGVupjwiBgl7YyHZkBquwdC
         4ADA==
X-Gm-Message-State: APjAAAXeopoUh6IBdtJ2Qag4XVOJaHANvDQiJ/DeyXwYv+jbjG1qVyuo
        U7Ujmt7lAoMgvaSOdEhWJDI=
X-Google-Smtp-Source: APXvYqzjZj9XNDplo9K8xz5FP6It/ttb5phyls9Ghq466QbupeG7mB4RZ5clPNQYTblZAbDlhR6BZA==
X-Received: by 2002:a63:c23:: with SMTP id b35mr39089612pgl.265.1563815545061;
        Mon, 22 Jul 2019 10:12:25 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t26sm31196528pgu.43.2019.07.22.10.12.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 10:12:24 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 4/5] block: Simplify blk_bio_segment_split()
Date:   Mon, 22 Jul 2019 10:12:09 -0700
Message-Id: <20190722171210.149443-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722171210.149443-1-bvanassche@acm.org>
References: <20190722171210.149443-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the max_sectors check into bvec_split_segs() such that a single
call to that function can do all the necessary checks. This patch
optimizes the fast path further, namely if a bvec fits in a page.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-merge.c | 68 +++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 7cea5050bbcf..a6bc08255b1b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -157,22 +157,36 @@ static unsigned get_max_segment_size(const struct request_queue *q,
 		     queue_max_segment_size(q));
 }
 
-/*
- * Split the bvec @bv into segments, and update all kinds of
- * variables.
+/**
+ * bvec_split_segs - verify whether or not a bvec should be split in the middle
+ * @q:        [in] request queue associated with the bio associated with @bv
+ * @bv:       [in] bvec to examine
+ * @nsegs:    [in,out] Number of segments in the bio being built. Incremented
+ *            by the number of segments from @bv that may be appended to that
+ *            bio without exceeding @max_segs
+ * @sectors:  [in,out] Number of sectors in the bio being built. Incremented
+ *            by the number of sectors from @bv that may be appended to that
+ *            bio without exceeding @max_sectors
+ * @max_segs: [in] upper bound for *@nsegs
+ * @max_sectors: [in] upper bound for *@sectors
+ *
+ * When splitting a bio, it can happen that a bvec is encountered that is too
+ * big to fit in a single segment and hence that it has to be split in the
+ * middle. This function verifies whether or not that should happen. The value
+ * %true is returned if and only if appending the entire @bv to a bio with
+ * *@nsegs segments and *@sectors sectors would make that bio unacceptable for
+ * the block driver.
  */
 static bool bvec_split_segs(const struct request_queue *q,
 			    const struct bio_vec *bv, unsigned *nsegs,
-			    unsigned *sectors, unsigned max_segs)
+			    unsigned *sectors, unsigned max_segs,
+			    unsigned max_sectors)
 {
-	unsigned len = bv->bv_len;
+	unsigned max_len = (min(max_sectors, UINT_MAX >> 9) - *sectors) << 9;
+	unsigned len = min(bv->bv_len, max_len);
 	unsigned total_len = 0;
 	unsigned seg_size = 0;
 
-	/*
-	 * Multi-page bvec may be too big to hold in one segment, so the
-	 * current bvec has to be splitted as multiple segments.
-	 */
 	while (len && *nsegs < max_segs) {
 		seg_size = get_max_segment_size(q, bv->bv_offset + total_len);
 		seg_size = min(seg_size, len);
@@ -187,8 +201,8 @@ static bool bvec_split_segs(const struct request_queue *q,
 
 	*sectors += total_len >> 9;
 
-	/* split in the middle of the bvec if len != 0 */
-	return !!len;
+	/* tell the caller to split the bvec if it is too big to fit */
+	return len > 0 || bv->bv_len > max_len;
 }
 
 /**
@@ -229,34 +243,18 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 		if (bvprvp && bvec_gap_to_prev(q, bvprvp, bv.bv_offset))
 			goto split;
 
-		if (sectors + (bv.bv_len >> 9) > max_sectors) {
-			/*
-			 * Consider this a new segment if we're splitting in
-			 * the middle of this vector.
-			 */
-			if (nsegs < max_segs &&
-			    sectors < max_sectors) {
-				/* split in the middle of bvec */
-				bv.bv_len = (max_sectors - sectors) << 9;
-				bvec_split_segs(q, &bv, &nsegs,
-						&sectors, max_segs);
-			}
+		if (nsegs < max_segs &&
+		    sectors + (bv.bv_len >> 9) <= max_sectors &&
+		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
+			nsegs++;
+			sectors += bv.bv_len >> 9;
+		} else if (bvec_split_segs(q, &bv, &nsegs, &sectors, max_segs,
+					 max_sectors)) {
 			goto split;
 		}
 
-		if (nsegs == max_segs)
-			goto split;
-
 		bvprv = bv;
 		bvprvp = &bvprv;
-
-		if (bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
-			nsegs++;
-			sectors += bv.bv_len >> 9;
-		} else if (bvec_split_segs(q, &bv, &nsegs, &sectors,
-				max_segs)) {
-			goto split;
-		}
 	}
 
 	*segs = nsegs;
@@ -363,7 +361,7 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
 
 	rq_for_each_bvec(bv, rq, iter)
 		bvec_split_segs(rq->q, &bv, &nr_phys_segs, &nr_sectors,
-				UINT_MAX);
+				UINT_MAX, UINT_MAX);
 	return nr_phys_segs;
 }
 
-- 
2.22.0.657.g960e92d24f-goog

