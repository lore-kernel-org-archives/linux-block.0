Return-Path: <BATV+c9ebeb9e9cafa2a765ab+5448+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: simplify bio_check_pages_dirty
Date: Tue, 24 Jul 2018 14:04:12 +0200
Message-Id: <20180724120413.15689-2-hch@lst.de>
In-Reply-To: <20180724120413.15689-1-hch@lst.de>
References: <20180724120413.15689-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

bio_check_pages_dirty currently inviolates the invariant that bv_page of
a bio_vec inside bi_vcnt shouldn't be zero, and that is going to become
really annoying with multpath biovecs.  Fortunately there isn't any
all that good reason for it - once we decide to defer freeing the bio
to a workqueue holding onto a few additional pages isn't really an
issue anymore.  So just check if there is a clean page that needs
dirtying in the first path, and do a second pass to free them if there
was none, while the cache is still hot.

Also use the chance to micro-optimize bio_dirty_fn a bit by not saving
irq state - we know we are called from a workqueue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 56 ++++++++++++++++++++---------------------------------
 1 file changed, 21 insertions(+), 35 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 8ecc95615941..504b42278099 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1649,19 +1649,15 @@ static void bio_release_pages(struct bio *bio)
 	struct bio_vec *bvec;
 	int i;
 
-	bio_for_each_segment_all(bvec, bio, i) {
-		struct page *page = bvec->bv_page;
-
-		if (page)
-			put_page(page);
-	}
+	bio_for_each_segment_all(bvec, bio, i)
+		put_page(bvec->bv_page);
 }
 
 /*
  * bio_check_pages_dirty() will check that all the BIO's pages are still dirty.
  * If they are, then fine.  If, however, some pages are clean then they must
  * have been written out during the direct-IO read.  So we take another ref on
- * the BIO and the offending pages and re-dirty the pages in process context.
+ * the BIO and re-dirty the pages in process context.
  *
  * It is expected that bio_check_pages_dirty() will wholly own the BIO from
  * here on.  It will run one put_page() against each page and will run one
@@ -1679,52 +1675,42 @@ static struct bio *bio_dirty_list;
  */
 static void bio_dirty_fn(struct work_struct *work)
 {
-	unsigned long flags;
-	struct bio *bio;
+	struct bio *bio, *next;
 
-	spin_lock_irqsave(&bio_dirty_lock, flags);
-	bio = bio_dirty_list;
+	spin_lock_irq(&bio_dirty_lock);
+	next = bio_dirty_list;
 	bio_dirty_list = NULL;
-	spin_unlock_irqrestore(&bio_dirty_lock, flags);
+	spin_unlock_irq(&bio_dirty_lock);
 
-	while (bio) {
-		struct bio *next = bio->bi_private;
+	while ((bio = next) != NULL) {
+		next = bio->bi_private;
 
 		bio_set_pages_dirty(bio);
 		bio_release_pages(bio);
 		bio_put(bio);
-		bio = next;
 	}
 }
 
 void bio_check_pages_dirty(struct bio *bio)
 {
 	struct bio_vec *bvec;
-	int nr_clean_pages = 0;
+	unsigned long flags;
 	int i;
 
 	bio_for_each_segment_all(bvec, bio, i) {
-		struct page *page = bvec->bv_page;
-
-		if (PageDirty(page) || PageCompound(page)) {
-			put_page(page);
-			bvec->bv_page = NULL;
-		} else {
-			nr_clean_pages++;
-		}
+		if (!PageDirty(bvec->bv_page) && !PageCompound(bvec->bv_page))
+			goto defer;
 	}
 
-	if (nr_clean_pages) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&bio_dirty_lock, flags);
-		bio->bi_private = bio_dirty_list;
-		bio_dirty_list = bio;
-		spin_unlock_irqrestore(&bio_dirty_lock, flags);
-		schedule_work(&bio_dirty_work);
-	} else {
-		bio_put(bio);
-	}
+	bio_release_pages(bio);
+	bio_put(bio);
+	return;
+defer:
+	spin_lock_irqsave(&bio_dirty_lock, flags);
+	bio->bi_private = bio_dirty_list;
+	bio_dirty_list = bio;
+	spin_unlock_irqrestore(&bio_dirty_lock, flags);
+	schedule_work(&bio_dirty_work);
 }
 EXPORT_SYMBOL_GPL(bio_check_pages_dirty);
 
-- 
2.18.0
