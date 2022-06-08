Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01AAC43334
	for <linux-block@archiver.kernel.org>; Wed,  8 Jun 2022 06:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiFHGoE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jun 2022 02:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245646AbiFHGeX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jun 2022 02:34:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C214CD42
        for <linux-block@vger.kernel.org>; Tue,  7 Jun 2022 23:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UdZSCEsLRpAGi8czk+fKN4XQfjZ7ouzZjvFceRqLSu8=; b=YC5i8ksVaOep/YVD4l8GkJ3YDD
        uYB880zOdmCbVV618jMn5D9vnTbjTK0ExES0YMLaVjBZj5UndJ07ySUu0RuiuTnUI9Ex7Pk+QFQ78
        GObv5Sw9eyq8DCgoQgiD+CkUa4H9pFpdCkkL1K+s+7h1+0JWDW6nZRgXCOk0gsSTvH9evkUwb96tU
        vcODRQ4pyRXMoSxHMkVoLeCWQWm8UsB7edKA3QBSVB0+3pX+0yGW+klB0KzxaSqksK/b0nSUt/l0M
        3FlImtZ6vyCesX53jTbvlXbvni3Ruo2HRU8VMaY38M2Sg6By5FGDijnesiCVzRTlt0aWTVVdBxYFC
        NdmHRCPg==;
Received: from [2001:4bb8:190:726c:66c4:f635:4b37:bdda] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nypGj-00BJTz-Jv; Wed, 08 Jun 2022 06:34:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 2/4] block: remove bioset_init_from_src
Date:   Wed,  8 Jun 2022 08:34:07 +0200
Message-Id: <20220608063409.1280968-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220608063409.1280968-1-hch@lst.de>
References: <20220608063409.1280968-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Unused now, and the interface never really made a whole lot of sense to
start with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 20 --------------------
 include/linux/bio.h |  1 -
 2 files changed, 21 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index be3937b84e68a..f3cce7f267a98 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1745,26 +1745,6 @@ int bioset_init(struct bio_set *bs,
 }
 EXPORT_SYMBOL(bioset_init);
 
-/*
- * Initialize and setup a new bio_set, based on the settings from
- * another bio_set.
- */
-int bioset_init_from_src(struct bio_set *bs, struct bio_set *src)
-{
-	int flags;
-
-	flags = 0;
-	if (src->bvec_pool.min_nr)
-		flags |= BIOSET_NEED_BVECS;
-	if (src->rescue_workqueue)
-		flags |= BIOSET_NEED_RESCUER;
-	if (src->cache)
-		flags |= BIOSET_PERCPU_CACHE;
-
-	return bioset_init(bs, src->bio_pool.min_nr, src->front_pad, flags);
-}
-EXPORT_SYMBOL(bioset_init_from_src);
-
 static int __init init_bio(void)
 {
 	int i;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 1cf3738ef1ea6..992ee987f2738 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -403,7 +403,6 @@ enum {
 extern int bioset_init(struct bio_set *, unsigned int, unsigned int, int flags);
 extern void bioset_exit(struct bio_set *);
 extern int biovec_init_pool(mempool_t *pool, int pool_entries);
-extern int bioset_init_from_src(struct bio_set *bs, struct bio_set *src);
 
 struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 			     unsigned int opf, gfp_t gfp_mask,
-- 
2.30.2

