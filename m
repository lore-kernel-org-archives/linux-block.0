Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99540C433E6
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 07:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B55964DDA
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 07:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhBXHa1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 02:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbhBXHaZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 02:30:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3845C06178A
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 23:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7VSbS33hmii5fNVacrVqG4OENqpjpfyNcGrvsxPuOS0=; b=XK672Vg3xyfmCcUE3XaVksBWjK
        FKsFb86nulGh8xGQibZHbcQl5H9JJjxKfTi/Rmccdm/clTp3vt9tha5i0QgPV3/NkXH4+619kTqA7
        n0h9mcIwfAmEFh4wh4vJUyrJVTSGiEtiZdYEHsbZsLhliJUGtdOJ+sZELKMaE4p1O26O6i+jtnaIA
        /7rssUc/5VcNoRMxG/SPMGVrny9K3bFCdE/oiSznO42LucdEfy3wbUkPUyxLPT2akriCW7OYRNlkI
        zDRGr2xSwp0RSXClFYT+d9gDcnS+/Zq22XL6fcsth9ZZOJ4FGtUi3/iGvhuzIGocU93iubhl86FH9
        IgsGai5Q==;
Received: from [2001:4bb8:188:6508:b7b:4fb9:de1e:2c81] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lEobt-0096if-UO; Wed, 24 Feb 2021 07:29:29 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Satya Tangirala <satyat@google.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 3/4] block: remove the gfp_mask argument to bounce_clone_bio
Date:   Wed, 24 Feb 2021 08:24:06 +0100
Message-Id: <20210224072407.46363-4-hch@lst.de>
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

The only caller always passes GFP_NOIO.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bounce.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/bounce.c b/block/bounce.c
index 79d81221446dfe..417faaac36b691 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -214,7 +214,7 @@ static void bounce_end_io_read_isa(struct bio *bio)
 	__bounce_end_io_read(bio, &isa_page_pool);
 }
 
-static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask)
+static struct bio *bounce_clone_bio(struct bio *bio_src)
 {
 	struct bvec_iter iter;
 	struct bio_vec bv;
@@ -242,9 +242,9 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask)
 	 *    __bio_clone_fast() anyways.
 	 */
 	if (bio_is_passthrough(bio_src))
-		bio = bio_kmalloc(gfp_mask, bio_segments(bio_src));
+		bio = bio_kmalloc(GFP_NOIO, bio_segments(bio_src));
 	else
-		bio = bio_alloc_bioset(gfp_mask, bio_segments(bio_src),
+		bio = bio_alloc_bioset(GFP_NOIO, bio_segments(bio_src),
 				       &bounce_bio_set);
 	if (!bio)
 		return NULL;
@@ -271,11 +271,11 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask)
 		break;
 	}
 
-	if (bio_crypt_clone(bio, bio_src, gfp_mask) < 0)
+	if (bio_crypt_clone(bio, bio_src, GFP_NOIO) < 0)
 		goto err_put;
 
 	if (bio_integrity(bio_src) &&
-	    bio_integrity_clone(bio, bio_src, gfp_mask) < 0)
+	    bio_integrity_clone(bio, bio_src, GFP_NOIO) < 0)
 		goto err_put;
 
 	bio_clone_blkg_association(bio, bio_src);
@@ -315,7 +315,7 @@ static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
 		submit_bio_noacct(*bio_orig);
 		*bio_orig = bio;
 	}
-	bio = bounce_clone_bio(*bio_orig, GFP_NOIO);
+	bio = bounce_clone_bio(*bio_orig);
 
 	/*
 	 * Bvec table can't be updated by bio_for_each_segment_all(),
-- 
2.29.2

