Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B058AC433FE
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 06:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbiA0Ggu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 01:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbiA0Ggj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 01:36:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311F5C061751
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 22:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KoYCEOsyAiziWngT9DO5kVCvIPkR3kAHUy8Lnooet9k=; b=Y50XIMxIuCB6PraZk9vSXHB2Vf
        TSaHfBETrTWKurOL1WPRfs9YvXvfakmVgufhYV2I8uUVBM/8roCMitpsXwWLvL0UOpffqIxJHXCHV
        pIEBNSYkHyVjkwaeqTaOBE1l3Yxsrx+ejKmZvGqcnHJ31WpwL72/NTcJdxD6W3+Frh0nXx7/3usMp
        Ymv70cytViyAZ41UEAuJk4VGr5ElI9wwW3XjSwdLNg34bCkBR/iENU7m0xBKqxs1Z7rGxanDUPsqp
        JikA9gzk3BmsnU3y4SQnWpYYr4eswno8umrABfaCYbsfB6P8a3jPLPwreiZnWUSEhkUWqWqEZJTPR
        FTQw/8Rg==;
Received: from 213-225-10-69.nat.highway.a1.net ([213.225.10.69] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCyOZ-00EYGy-Gs; Thu, 27 Jan 2022 06:36:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com
Subject: [PATCH 13/14] block: initialize the target bio in __bio_clone_fast
Date:   Thu, 27 Jan 2022 07:35:45 +0100
Message-Id: <20220127063546.1314111-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127063546.1314111-1-hch@lst.de>
References: <20220127063546.1314111-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All callers of __bio_clone_fast initialize the bio first.  Move that
initialization into __bio_clone_fast instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c                 | 75 ++++++++++++++++++++-----------------
 drivers/md/bcache/request.c |  1 -
 drivers/md/dm.c             |  5 +--
 drivers/md/md-multipath.c   |  1 -
 4 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 60f79b33a49af..eae1deba18962 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -726,37 +726,16 @@ void bio_put(struct bio *bio)
 }
 EXPORT_SYMBOL(bio_put);
 
-/**
- * 	__bio_clone_fast - clone a bio that shares the original bio's biovec
- * 	@bio: destination bio
- * 	@bio_src: bio to clone
- *	@gfp: allocation flags
- *
- *	Clone a &bio. Caller will own the returned bio, but not
- *	the actual data it points to. Reference count of returned
- * 	bio will be one.
- *
- * 	Caller must ensure that @bio_src is not freed before @bio.
- */
-int __bio_clone_fast(struct bio *bio, struct bio *bio_src, gfp_t gfp)
+static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 {
-	WARN_ON_ONCE(bio->bi_pool && bio->bi_max_vecs);
-
-	/*
-	 * most users will be overriding ->bi_bdev with a new target,
-	 * so we don't set nor calculate new physical/hw segment counts here
-	 */
-	bio->bi_bdev = bio_src->bi_bdev;
 	bio_set_flag(bio, BIO_CLONED);
 	if (bio_flagged(bio_src, BIO_THROTTLED))
 		bio_set_flag(bio, BIO_THROTTLED);
 	if (bio_flagged(bio_src, BIO_REMAPPED))
 		bio_set_flag(bio, BIO_REMAPPED);
-	bio->bi_opf = bio_src->bi_opf;
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_iter = bio_src->bi_iter;
-	bio->bi_io_vec = bio_src->bi_io_vec;
 
 	bio_clone_blkg_association(bio, bio_src);
 	blkcg_bio_issue_init(bio);
@@ -768,33 +747,59 @@ int __bio_clone_fast(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 		return -ENOMEM;
 	return 0;
 }
-EXPORT_SYMBOL(__bio_clone_fast);
 
 /**
- *	bio_clone_fast - clone a bio that shares the original bio's biovec
- *	@bio: bio to clone
- *	@gfp_mask: allocation priority
- *	@bs: bio_set to allocate from
+ * bio_clone_fast - clone a bio that shares the original bio's biovec
+ * @bio_src: bio to clone from
+ * @gfp: allocation priority
+ * @bs: bio_set to allocate from
+ *
+ * Allocate a new bio that is a clone of @bio_src. The caller owns the returned
+ * bio, but not the actual data it points to.
  *
- * 	Like __bio_clone_fast, only also allocates the returned bio
+ * The caller must ensure that the return bio is not freed before @bio_src.
  */
-struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
+struct bio *bio_clone_fast(struct bio *bio_src, gfp_t gfp, struct bio_set *bs)
 {
-	struct bio *b;
+	struct bio *bio;
 
-	b = bio_alloc_bioset(NULL, 0, 0, gfp_mask, bs);
-	if (!b)
+	bio = bio_alloc_bioset(bio_src->bi_bdev, 0, bio_src->bi_opf, gfp, bs);
+	if (!bio)
 		return NULL;
 
-	if (__bio_clone_fast(b, bio, gfp_mask < 0)) {
-		bio_put(b);
+	if (__bio_clone(bio, bio_src, gfp) < 0) {
+		bio_put(bio);
 		return NULL;
 	}
+	bio->bi_io_vec = bio_src->bi_io_vec;
 
-	return b;
+	return bio;
 }
 EXPORT_SYMBOL(bio_clone_fast);
 
+/**
+ * __bio_clone_fast - clone a bio that shares the original bio's biovec
+ * @bio: bio to clone into
+ * @bio_src: bio to clone from
+ * @gfp: allocation priority
+ *
+ * Initialize a new bio in caller provided memory that is a clone of @bio_src.
+ * The caller owns the returned bio, but not the actual data it points to.
+ *
+ * The caller must ensure that @bio_src is not freed before @bio.
+ */
+int __bio_clone_fast(struct bio *bio, struct bio *bio_src, gfp_t gfp)
+{
+	int ret;
+
+	bio_init(bio, bio_src->bi_bdev, bio_src->bi_io_vec, 0, bio_src->bi_opf);
+	ret = __bio_clone(bio, bio_src, gfp);
+	if (ret)
+		bio_uninit(bio);
+	return ret;
+}
+EXPORT_SYMBOL(__bio_clone_fast);
+
 const char *bio_devname(struct bio *bio, char *buf)
 {
 	return bdevname(bio->bi_bdev, buf);
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 574b02b94f1a4..d2cb853bf9173 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -685,7 +685,6 @@ static void do_bio_hook(struct search *s,
 {
 	struct bio *bio = &s->bio.bio;
 
-	bio_init(bio, NULL, NULL, 0, 0);
 	__bio_clone_fast(bio, orig_bio, GFP_NOIO);
 	/*
 	 * bi_end_io can be set separately somewhere else, e.g. the
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 984ccafb11ea8..b08e0732f71d7 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -552,11 +552,8 @@ static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
 	if (!ci->io->tio.io) {
 		/* the dm_target_io embedded in ci->io is available */
 		tio = &ci->io->tio;
-		bio_init(&tio->clone, NULL, NULL, 0, 0);
-		if (__bio_clone_fast(&tio->clone, ci->bio, gfp_mask) < 0) {
-			bio_uninit(&tio->clone);
+		if (__bio_clone_fast(&tio->clone, ci->bio, gfp_mask) < 0)
 			return NULL;
-		}
 	} else {
 		struct bio *clone = bio_clone_fast(ci->bio, gfp_mask,
 						   &ci->io->md->bs);
diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
index 010c759c741ad..483a5500f83cd 100644
--- a/drivers/md/md-multipath.c
+++ b/drivers/md/md-multipath.c
@@ -121,7 +121,6 @@ static bool multipath_make_request(struct mddev *mddev, struct bio * bio)
 	}
 	multipath = conf->multipaths + mp_bh->path;
 
-	bio_init(&mp_bh->bio, NULL, NULL, 0, 0);
 	__bio_clone_fast(&mp_bh->bio, bio, GFP_NOIO);
 
 	mp_bh->bio.bi_iter.bi_sector += multipath->rdev->data_offset;
-- 
2.30.2

