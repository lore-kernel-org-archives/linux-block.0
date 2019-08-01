Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F14C32753
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 22:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD322084C
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 22:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbfHAWu7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:50:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37907 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388942AbfHAWu6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 18:50:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id f5so26176064pgu.5
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2019 15:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Em7UK3RYeN+WOGI1E/PxkPUM7IdJO+sUsMzC6fv5ULA=;
        b=puMarA9cPTrFR4t/itHv/ugMEJtFSCh5dbO+toYNqZhDumHastLDn4OMu4+iSe62Jr
         6RvwThZ8GNMsZKRTSaMAboLVRBherb2mP4kEx5CC0jVvWqBdQuoGUw8w8Bobx46evB9s
         2fWqbGJ79MlJuoy0qH0aCoQg7KHQAU6gjTT2uOYVpwOYQPirNt3SLUwy+hg9bWPZr1cF
         TTBOG5Q0UjYXdn5zUGfl3aqx2wS/VU4zP8Wa7ecrcVVQWMYHngWnwcTl2FbGcO1v4VWM
         dFhNS7PYvuBdO9560XVyUfkVJN4ttBx45K9x8iKWcFLn0yGMnrgD55/bXogSUveKJpAX
         epIw==
X-Gm-Message-State: APjAAAUzevmp91nTGrHzL1wjWD/6TCm+oKdKP3scuyYLQh4uzc0qqthb
        imrKywVA/FsbICVQ9NOmEiw=
X-Google-Smtp-Source: APXvYqzxuKfEtD7jGxVxS+GQp3FGBazzlOHztLaVHNHDCb9RlzduLmGBS31zQZKKcxG0fL6IUdrD2Q==
X-Received: by 2002:a17:90a:346c:: with SMTP id o99mr1139951pjb.20.1564699857856;
        Thu, 01 Aug 2019 15:50:57 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id d12sm35472010pfn.11.2019.08.01.15.50.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 15:50:57 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH v2 4/5] block: Simplify blk_bio_segment_split()
Date:   Thu,  1 Aug 2019 15:50:43 -0700
Message-Id: <20190801225044.143478-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801225044.143478-1-bvanassche@acm.org>
References: <20190801225044.143478-1-bvanassche@acm.org>
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
2.22.0.770.g0f2c4a37fd-goog

