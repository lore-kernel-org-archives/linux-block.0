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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8603DC433E6
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 19:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57EF720754
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 19:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbhAETr6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbhAETr6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jan 2021 14:47:58 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B3CC061795
        for <linux-block@vger.kernel.org>; Tue,  5 Jan 2021 11:47:18 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t30so385486wrb.0
        for <linux-block@vger.kernel.org>; Tue, 05 Jan 2021 11:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=obG11weUh1EuuY/9b4/cqS1RN6m1CnK3RujvKyyQ8XY=;
        b=nY5Xz2MBATIIcVSEZpuxiUH8bGdC4BuJ+5R8S36p05+RSfr6pVepM1oaHfcojIEV41
         jNl9oj+u8pCJdNbW1sucanEa6ReWpyT9eZWHEBT1llKtQJcoP/AQSYziY/x6OUDsxayL
         i9WwhUaFNqdplZ09VSRlw634nBw3nKJpRoWhcwiYdQtM4/Y21MBI/4Asb3IZx+vR+3Ua
         uGPOffrh9Xdml8Y5BqvU6kRST+tIdYvSPKYO9C01RbfFIRW0GWNyXNWkiLuJJOaQSumn
         Ta9clMZ1s1e8aQI3j34ndkvT4x/XDltU/lwfzNVDFHkYkZErbiRAn6heBtAVNhI6agfM
         dIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=obG11weUh1EuuY/9b4/cqS1RN6m1CnK3RujvKyyQ8XY=;
        b=YYmWk/b1kwBept7Xo9Zll5+sAYphDEu4AeFKbXenan9PcSN5JkBQ+97X4dRkiuLjLR
         3dL8I5kC0emWwp1jEvqCYcTwBdD4sXkakhAGu7/otVG8YlndrvP5RR+L7Dn+K7QCCixz
         iBDAMUe0/jiA0pveWBIdn2EZ+7UZ5sQCD30akov117SRyMSFOtWoXXoFt+BgKuKZUx65
         YF4oLC3mXlIWcXI1+yi5RRGdLuPCkCTs75fAjaQ/XXjHJaJQuxMoAoKn8vPCBvC3Lfa4
         BOHbQy539YCHwEB7Rw0e/jKAN5TPiqHzGloy3PXYVxTfSV6myDb1qFNfvaBv8d0X7Hy8
         8fOQ==
X-Gm-Message-State: AOAM531XWNfEgSnZ/Ly1CMCp5cJsLFsTUlCvV0HpjcyeCtP2kTx3G+Gi
        KTFsKL3pK8DCgNJ4jRHBdjE=
X-Google-Smtp-Source: ABdhPJzf+NRQR6vLAmk8pzVGkd/H1SowWqAT3SA6kYoFalHrvHfRPNLThNk7oY3isrICa2jVOygjIg==
X-Received: by 2002:a5d:6789:: with SMTP id v9mr1086655wru.86.1609876036804;
        Tue, 05 Jan 2021 11:47:16 -0800 (PST)
Received: from localhost.localdomain ([185.69.144.125])
        by smtp.gmail.com with ESMTPSA id z6sm238014wmi.15.2021.01.05.11.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:47:16 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC 2/2] block: add a fast path for seg split of large bio
Date:   Tue,  5 Jan 2021 19:43:38 +0000
Message-Id: <53b86d4e86c4913658cb0f472dcc3e22ef75396b.1609875589.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1609875589.git.asml.silence@gmail.com>
References: <cover.1609875589.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_bio_segment_split() is very heavy, but the current fast path covers
only one-segment under PAGE_SIZE bios. Add another one by estimating an
upper bound of sectors a bio can contain.

One restricting factor here is queue_max_segment_size(), which it
compare against full iter size to not dig into bvecs. By default it's
64KB, and so for requests under 64KB, but for those falling under the
conditions it's much faster.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-merge.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 84b9635b5d57..15d75f3ffc30 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -226,12 +226,12 @@ static bool bvec_split_segs(const struct request_queue *q,
 static struct bio *__blk_bio_segment_split(struct request_queue *q,
 					   struct bio *bio,
 					   struct bio_set *bs,
-					   unsigned *segs)
+					   unsigned *segs,
+					   const unsigned max_sectors)
 {
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
 	struct bvec_iter iter;
 	unsigned nsegs = 0, sectors = 0;
-	const unsigned max_sectors = get_max_io_size(q, bio);
 	const unsigned max_segs = queue_max_segments(q);
 
 	bio_for_each_bvec(bv, bio, iter) {
@@ -295,6 +295,9 @@ static inline struct bio *blk_bio_segment_split(struct request_queue *q,
 						struct bio_set *bs,
 						unsigned *nr_segs)
 {
+	unsigned int max_sectors, q_max_sectors;
+	unsigned int bio_segs = bio->bi_vcnt;
+
 	/*
 	 * All drivers must accept single-segments bios that are <=
 	 * PAGE_SIZE.  This is a quick and dirty check that relies on
@@ -303,14 +306,32 @@ static inline struct bio *blk_bio_segment_split(struct request_queue *q,
 	 * are cloned, but compared to the performance impact of cloned
 	 * bios themselves the loop below doesn't matter anyway.
 	 */
-	if (!q->limits.chunk_sectors && bio->bi_vcnt == 1 &&
+	if (!q->limits.chunk_sectors && bio_segs == 1 &&
 	    (bio->bi_io_vec[0].bv_len +
 	     bio->bi_io_vec[0].bv_offset) <= PAGE_SIZE) {
 		*nr_segs = 1;
 		return NULL;
 	}
 
-	return __blk_bio_segment_split(q, bio, bs, nr_segs);
+	q_max_sectors = get_max_io_size(q, bio);
+	if (!queue_virt_boundary(q) && bio_segs < queue_max_segments(q) &&
+	    bio->bi_iter.bi_size <= queue_max_segment_size(q)) {
+		/*
+		 * Segments are contiguous, so only their ends may be not full.
+		 * An upper bound for them would to assume that each takes 1B
+		 * but adds a sector, and all left are just full sectors.
+		 * Note: it's ok to round size down because all not full
+		 * sectors are accounted by the first term.
+		 */
+		max_sectors = bio_segs * 2;
+		max_sectors += bio->bi_iter.bi_size >> 9;
+
+		if (max_sectors < q_max_sectors) {
+			*nr_segs = bio_segs;
+			return NULL;
+		}
+	}
+	return __blk_bio_segment_split(q, bio, bs, nr_segs, q_max_sectors);
 }
 
 /**
-- 
2.24.0

