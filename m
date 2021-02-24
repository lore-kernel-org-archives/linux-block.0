Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D54C433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 07:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48E964ECF
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 07:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhBXHaV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 02:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbhBXHaO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 02:30:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0664C06174A
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 23:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ONLVj2QSujtOtbvfhfJgfbnxPjQkq6uN4eCX/6DvZaU=; b=Vevf+PRSI+bXtW/1SimtJ/HiWV
        1SQ8fmfY1AcTzeor5yPOaYRZgl/Y1v0oeZG13vITiGae64A+Xsglz1Rtil642Qol/x9HLlxvNvK8l
        3zK9HOqVbfOfvQhn3RN17puh6TbFDqzHVAV6RbjAT70+6N9GTU5HelzX3uziKXNYwulSjxCnKtVEy
        O2GtZrS04+pbDfuo0MZDYcIgX6WQ8g8dc+us3TAHonTOl3Cr8/RbcFEmbsDknaQxUSDB27gHVMl4d
        2UmkY3wHjFUyPgVqJh7nSdC4Nq8tleILDf1paR7E3jsMg4GHOPTsS7O6DlWUWyl3Gb10Xt26hHlER
        rBkjAI8Q==;
Received: from [2001:4bb8:188:6508:b7b:4fb9:de1e:2c81] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lEobe-0096gu-AI; Wed, 24 Feb 2021 07:29:14 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Satya Tangirala <satyat@google.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 2/4] block: fix bounce_clone_bio for passthrough bios
Date:   Wed, 24 Feb 2021 08:24:05 +0100
Message-Id: <20210224072407.46363-3-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224072407.46363-1-hch@lst.de>
References: <20210224072407.46363-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that bio_alloc_bioset does not fall back to kmalloc for a NULL
bio_set, handle that case explicitly and simplify the calling
conventions.

Based on an earlier patch from Chaitanya Kulkarni.

Fixes: 3175199ab0ac ("block: split bio_kmalloc from bio_alloc_bioset")
Reported-by: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bounce.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/bounce.c b/block/bounce.c
index fc55314aa4269a..79d81221446dfe 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -214,8 +214,7 @@ static void bounce_end_io_read_isa(struct bio *bio)
 	__bounce_end_io_read(bio, &isa_page_pool);
 }
 
-static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
-		struct bio_set *bs)
+static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask)
 {
 	struct bvec_iter iter;
 	struct bio_vec bv;
@@ -242,8 +241,11 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 	 *    asking for trouble and would force extra work on
 	 *    __bio_clone_fast() anyways.
 	 */
-
-	bio = bio_alloc_bioset(gfp_mask, bio_segments(bio_src), bs);
+	if (bio_is_passthrough(bio_src))
+		bio = bio_kmalloc(gfp_mask, bio_segments(bio_src));
+	else
+		bio = bio_alloc_bioset(gfp_mask, bio_segments(bio_src),
+				       &bounce_bio_set);
 	if (!bio)
 		return NULL;
 	bio->bi_bdev		= bio_src->bi_bdev;
@@ -296,7 +298,6 @@ static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
 	unsigned i = 0;
 	bool bounce = false;
 	int sectors = 0;
-	bool passthrough = bio_is_passthrough(*bio_orig);
 
 	bio_for_each_segment(from, *bio_orig, iter) {
 		if (i++ < BIO_MAX_PAGES)
@@ -307,14 +308,14 @@ static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
 	if (!bounce)
 		return;
 
-	if (!passthrough && sectors < bio_sectors(*bio_orig)) {
+	if (!bio_is_passthrough(*bio_orig) &&
+	    sectors < bio_sectors(*bio_orig)) {
 		bio = bio_split(*bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
 		bio_chain(bio, *bio_orig);
 		submit_bio_noacct(*bio_orig);
 		*bio_orig = bio;
 	}
-	bio = bounce_clone_bio(*bio_orig, GFP_NOIO, passthrough ? NULL :
-			&bounce_bio_set);
+	bio = bounce_clone_bio(*bio_orig, GFP_NOIO);
 
 	/*
 	 * Bvec table can't be updated by bio_for_each_segment_all(),
-- 
2.29.2

