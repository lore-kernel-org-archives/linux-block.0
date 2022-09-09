Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6DFECAAA1
	for <linux-block@archiver.kernel.org>; Fri,  9 Sep 2022 13:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiIINHe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Sep 2022 09:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiIINHD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Sep 2022 09:07:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC76F1238C4
        for <linux-block@vger.kernel.org>; Fri,  9 Sep 2022 06:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=CYplu0iWPgVbpdO0qO7w7HmolA1MTwDWjSllYe0AYrY=; b=Qh+oc06ckI+D9E4FF48cxZbIN3
        8a8FNQPNvrpRXnJAvLUwfSNG6I0pn/M6PWB30b4q/u8nWiXrecxhCMHQNw7zKe8MS/AGT53YtsnKB
        xk0fZiZe06TYt+no5mYfwMFryXStximconL865s5mj03+wIYHidbsVn7N2z3SM3WAEwTdiPTl8P9N
        E7VocTVXp/dZO+K9wyuTAZ14ez1HuB92FqvGJHk2q4c8+zmW9puwU2DSmgKfxMNWTKethz9sLmyvY
        +V7kuwuM4P3QTy0KEJXrFTy165q3+VRq9K9VBOuNvtD8A15aFz4W0JiTmUhKUsj3oiQKswWJTvpIn
        PzShCiIA==;
Received: from [2001:4bb8:198:38af:a077:6a38:dc23:be2c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWdhJ-00GEKu-QA; Fri, 09 Sep 2022 13:05:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: split bio_check_pages_dirty
Date:   Fri,  9 Sep 2022 15:05:22 +0200
Message-Id: <20220909130522.3262828-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split out bio_should_redirty_pages and bio_queue_for_redirty helpers and
let the callers use their normal bio release path for the non-redirty
case.

Note that this changes the refcounting for the redirty case as
bio_queue_for_redirty takes a reference now, which allows the caller to
unconditionally drop its reference instead of special casing this path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c          | 54 ++++++++++++++++++++++++++------------------
 block/fops.c         | 18 +++++++--------
 fs/direct-io.c       | 11 ++++-----
 fs/iomap/direct-io.c |  9 ++++----
 include/linux/bio.h  |  3 ++-
 5 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d3154d8beed72..692e53561e4e0 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1399,7 +1399,7 @@ void bio_free_pages(struct bio *bio)
 EXPORT_SYMBOL(bio_free_pages);
 
 /*
- * bio_set_pages_dirty() and bio_check_pages_dirty() are support functions
+ * bio_set_pages_dirty() and bio_queue_for_redirty() are support functions
  * for performing direct-IO in BIOs.
  *
  * The problem is that we cannot run set_page_dirty() from interrupt context
@@ -1438,17 +1438,6 @@ void bio_set_pages_dirty(struct bio *bio)
 	}
 }
 
-/*
- * bio_check_pages_dirty() will check that all the BIO's pages are still dirty.
- * If they are, then fine.  If, however, some pages are clean then they must
- * have been written out during the direct-IO read.  So we take another ref on
- * the BIO and re-dirty the pages in process context.
- *
- * It is expected that bio_check_pages_dirty() will wholly own the BIO from
- * here on.  It will run one put_page() against each page and will run one
- * bio_put() against the BIO.
- */
-
 static void bio_dirty_fn(struct work_struct *work);
 
 static DECLARE_WORK(bio_dirty_work, bio_dirty_fn);
@@ -1475,25 +1464,46 @@ static void bio_dirty_fn(struct work_struct *work)
 	}
 }
 
-void bio_check_pages_dirty(struct bio *bio)
+/**
+ * bio_should_redirty_pages - check that all the BIO's pages are still dirty
+ * @bio:	BIO to check
+ *
+ * Check if all pages in a direct read are still dirty.  If they aren't the
+ * caller must call bio_queue_for_redirty() to redirty all pages that have been
+ * marked clean.
+ */
+bool bio_should_redirty_pages(struct bio *bio)
 {
-	struct bio_vec *bvec;
-	unsigned long flags;
 	struct bvec_iter_all iter_all;
+	struct bio_vec *bvec;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
+	bio_for_each_segment_all(bvec, bio, iter_all)
 		if (!PageDirty(bvec->bv_page) && !PageCompound(bvec->bv_page))
-			goto defer;
-	}
+			return true;
+	return false;
+}
+
+/**
+ * bio_queue_for_redirty - queue up a bio to ensure all pages are marked dirty
+ * 
+ * If some pages are clean after a direct read has completed, then they must
+ * have been written out during the direct read.  Take another ref on the BIO
+ * and re-dirty the pages in process context.
+ *
+ * It is expected that bio_queue_for_redirty() owns the pages in the BIO from
+ * here on.  It will run one put_page() against each page one finished.
+ */
+void bio_queue_for_redirty(struct bio *bio)
+{
+	unsigned long flags;
+
+	bio_get(bio);
 
-	bio_release_pages(bio, false);
-	bio_put(bio);
-	return;
-defer:
 	spin_lock_irqsave(&bio_dirty_lock, flags);
 	bio->bi_private = bio_dirty_list;
 	bio_dirty_list = bio;
 	spin_unlock_irqrestore(&bio_dirty_lock, flags);
+
 	schedule_work(&bio_dirty_work);
 }
 
diff --git a/block/fops.c b/block/fops.c
index b90742595317e..164b47f836ae6 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -159,12 +159,11 @@ static void blkdev_bio_end_io(struct bio *bio)
 		}
 	}
 
-	if (should_dirty) {
-		bio_check_pages_dirty(bio);
-	} else {
+	if (should_dirty && bio_should_redirty_pages(bio))
+		bio_queue_for_redirty(bio);
+	else
 		bio_release_pages(bio, false);
-		bio_put(bio);
-	}
+	bio_put(bio);
 }
 
 static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
@@ -283,12 +282,11 @@ static void blkdev_bio_end_io_async(struct bio *bio)
 
 	iocb->ki_complete(iocb, ret);
 
-	if (dio->flags & DIO_SHOULD_DIRTY) {
-		bio_check_pages_dirty(bio);
-	} else {
+	if ((dio->flags & DIO_SHOULD_DIRTY) && bio_should_redirty_pages(bio))
+		bio_queue_for_redirty(bio);
+	else
 		bio_release_pages(bio, false);
-		bio_put(bio);
-	}
+	bio_put(bio);
 }
 
 static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
diff --git a/fs/direct-io.c b/fs/direct-io.c
index f669163d5860f..8d7fe8e15509b 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -410,7 +410,7 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 /*
  * In the AIO read case we speculatively dirty the pages before starting IO.
  * During IO completion, any of these pages which happen to have been written
- * back will be redirtied by bio_check_pages_dirty().
+ * back will be redirtied by bio_queue_for_redirty().
  *
  * bios hold a dio reference between submit_bio and ->end_io.
  */
@@ -504,12 +504,11 @@ static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
 			dio->io_error = -EIO;
 	}
 
-	if (dio->is_async && should_dirty) {
-		bio_check_pages_dirty(bio);	/* transfers ownership */
-	} else {
+	if (dio->is_async && should_dirty && bio_should_redirty_pages(bio))
+		bio_queue_for_redirty(bio);	/* transfers ownership */
+	else
 		bio_release_pages(bio, should_dirty);
-		bio_put(bio);
-	}
+	bio_put(bio);
 	return err;
 }
 
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 4eb559a16c9ed..1699b3d4895c1 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -179,12 +179,11 @@ void iomap_dio_bio_end_io(struct bio *bio)
 		}
 	}
 
-	if (should_dirty) {
-		bio_check_pages_dirty(bio);
-	} else {
+	if (should_dirty && bio_should_redirty_pages(bio))
+		bio_queue_for_redirty(bio);
+	else
 		bio_release_pages(bio, false);
-		bio_put(bio);
-	}
+	bio_put(bio);
 }
 EXPORT_SYMBOL_GPL(iomap_dio_bio_end_io);
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index ca22b06700a94..f1e6d13c2c0da 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -473,7 +473,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
 void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
-extern void bio_check_pages_dirty(struct bio *bio);
+bool bio_should_redirty_pages(struct bio *bio);
+void bio_queue_for_redirty(struct bio *bio);
 
 extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 			       struct bio *src, struct bvec_iter *src_iter);
-- 
2.30.2

