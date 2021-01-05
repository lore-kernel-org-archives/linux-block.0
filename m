Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B01C433DB
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 19:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 418B022CE3
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 19:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbhAETr6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbhAETr5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jan 2021 14:47:57 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083F2C061793
        for <linux-block@vger.kernel.org>; Tue,  5 Jan 2021 11:47:17 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r3so373829wrt.2
        for <linux-block@vger.kernel.org>; Tue, 05 Jan 2021 11:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SsPyP5nqiA63erlwdasnF0hLxinr5p83LSlMCrElweg=;
        b=u9KzXxRT2Oz1/dNhrK3493jDhjpSRKcr+0VUYLOxJv9yFpQa6f1G1sfhmcj9/ue7+U
         2GkXdiVggpTxAYkrNZKJgctXq++MF5FB4rkJsROUnREOy3zIsdDSsDaRRuV8EbVZR4az
         O2h8EHzmRVPPAu71/2E6R7yhghyT5B/VrM9K1SG0oz2Y+2uU3sOa5AxsCOjKlNRNbpuG
         /4BPzoEBFQC2mHztAwTctTmJYKpmFfvfM3lKJ0V813KogvH9B/3eLHg68YPluS7/4STT
         hg/l/RO1sMBAhWIb3SdyiEoekMGtU8/Sn4UXJVAGEMI6uF55E/c/qewaSme+/VWXmVf+
         7xCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SsPyP5nqiA63erlwdasnF0hLxinr5p83LSlMCrElweg=;
        b=Q2M5Fr980SvDT7YXGI9XIWrP2qkbg/npBaixOeJXEB1HayNSvnf/0yLHTTd1rUUWTh
         L84w4WuNnhpsEgMe5W6XGw812dTR/U2XqGC7LcKyqEJKBBTemsypLjhMLfbxFmbLXbCS
         k5AglyGGfWe9/0TbSxhSRaeCWhv1yLxU+N1qee0z1vlGvmpmSrpqhT04K23V2WiRR7xY
         dxEDK+NbZ7Liqj8uN01iXTtC3ejjgyuDe79iZUIdWZc5D5PafMuAyKC+BzTCxNHuuuxQ
         bYHxhuevAjsSJZJu7gZ5nTL7iLj5d2yH1QtBD4xHrFz0SA+Zp83g3Hc20NcW+23EmSeI
         CX8g==
X-Gm-Message-State: AOAM530n1s149Z9mU0OA+rJTTFwVxaIUXpObBW/TGylYN+fZbjJBuvRL
        ck8Yb0wdAZAHe9q14R0169RJWxUmKJXnAQ==
X-Google-Smtp-Source: ABdhPJydDO95pKqp7ooHt9X4RBJEK4ywMD6KY4T0KodM1jINNCYkhJdbaiOYQMlJNr0+gGDnUVSz7g==
X-Received: by 2002:adf:97d2:: with SMTP id t18mr354347wrb.228.1609876035822;
        Tue, 05 Jan 2021 11:47:15 -0800 (PST)
Received: from localhost.localdomain ([185.69.144.125])
        by smtp.gmail.com with ESMTPSA id z6sm238014wmi.15.2021.01.05.11.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:47:15 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC 1/2] block: add a function for *segment_split fast path
Date:   Tue,  5 Jan 2021 19:43:37 +0000
Message-Id: <a46250fdd157adda8b46e51518ea29116c6663f3.1609875589.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1609875589.git.asml.silence@gmail.com>
References: <cover.1609875589.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Don't keep blk_bio_segment_split()'s fast path hand coded in
__blk_queue_split(), extract it into a function. It's inlined perfectly
well.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-merge.c | 84 ++++++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 38 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 808768f6b174..84b9635b5d57 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -223,29 +223,10 @@ static bool bvec_split_segs(const struct request_queue *q,
 	return len > 0 || bv->bv_len > max_len;
 }
 
-/**
- * blk_bio_segment_split - split a bio in two bios
- * @q:    [in] request queue pointer
- * @bio:  [in] bio to be split
- * @bs:	  [in] bio set to allocate the clone from
- * @segs: [out] number of segments in the bio with the first half of the sectors
- *
- * Clone @bio, update the bi_iter of the clone to represent the first sectors
- * of @bio and update @bio->bi_iter to represent the remaining sectors. The
- * following is guaranteed for the cloned bio:
- * - That it has at most get_max_io_size(@q, @bio) sectors.
- * - That it has at most queue_max_segments(@q) segments.
- *
- * Except for discard requests the cloned bio will point at the bi_io_vec of
- * the original bio. It is the responsibility of the caller to ensure that the
- * original bio is not freed before the cloned bio. The caller is also
- * responsible for ensuring that @bs is only destroyed after processing of the
- * split bio has finished.
- */
-static struct bio *blk_bio_segment_split(struct request_queue *q,
-					 struct bio *bio,
-					 struct bio_set *bs,
-					 unsigned *segs)
+static struct bio *__blk_bio_segment_split(struct request_queue *q,
+					   struct bio *bio,
+					   struct bio_set *bs,
+					   unsigned *segs)
 {
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
 	struct bvec_iter iter;
@@ -290,6 +271,48 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	return bio_split(bio, sectors, GFP_NOIO, bs);
 }
 
+/**
+ * blk_bio_segment_split - split a bio in two bios
+ * @q:    [in] request queue pointer
+ * @bio:  [in] bio to be split
+ * @bs:	  [in] bio set to allocate the clone from
+ * @segs: [out] number of segments in the bio with the first half of the sectors
+ *
+ * Clone @bio, update the bi_iter of the clone to represent the first sectors
+ * of @bio and update @bio->bi_iter to represent the remaining sectors. The
+ * following is guaranteed for the cloned bio:
+ * - That it has at most get_max_io_size(@q, @bio) sectors.
+ * - That it has at most queue_max_segments(@q) segments.
+ *
+ * Except for discard requests the cloned bio will point at the bi_io_vec of
+ * the original bio. It is the responsibility of the caller to ensure that the
+ * original bio is not freed before the cloned bio. The caller is also
+ * responsible for ensuring that @bs is only destroyed after processing of the
+ * split bio has finished.
+ */
+static inline struct bio *blk_bio_segment_split(struct request_queue *q,
+						struct bio *bio,
+						struct bio_set *bs,
+						unsigned *nr_segs)
+{
+	/*
+	 * All drivers must accept single-segments bios that are <=
+	 * PAGE_SIZE.  This is a quick and dirty check that relies on
+	 * the fact that bi_io_vec[0] is always valid if a bio has data.
+	 * The check might lead to occasional false negatives when bios
+	 * are cloned, but compared to the performance impact of cloned
+	 * bios themselves the loop below doesn't matter anyway.
+	 */
+	if (!q->limits.chunk_sectors && bio->bi_vcnt == 1 &&
+	    (bio->bi_io_vec[0].bv_len +
+	     bio->bi_io_vec[0].bv_offset) <= PAGE_SIZE) {
+		*nr_segs = 1;
+		return NULL;
+	}
+
+	return __blk_bio_segment_split(q, bio, bs, nr_segs);
+}
+
 /**
  * __blk_queue_split - split a bio and submit the second half
  * @bio:     [in, out] bio to be split
@@ -322,21 +345,6 @@ void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
 				nr_segs);
 		break;
 	default:
-		/*
-		 * All drivers must accept single-segments bios that are <=
-		 * PAGE_SIZE.  This is a quick and dirty check that relies on
-		 * the fact that bi_io_vec[0] is always valid if a bio has data.
-		 * The check might lead to occasional false negatives when bios
-		 * are cloned, but compared to the performance impact of cloned
-		 * bios themselves the loop below doesn't matter anyway.
-		 */
-		if (!q->limits.chunk_sectors &&
-		    (*bio)->bi_vcnt == 1 &&
-		    ((*bio)->bi_io_vec[0].bv_len +
-		     (*bio)->bi_io_vec[0].bv_offset) <= PAGE_SIZE) {
-			*nr_segs = 1;
-			break;
-		}
 		split = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
 		break;
 	}
-- 
2.24.0

