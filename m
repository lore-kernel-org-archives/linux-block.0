Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Shaohua Li <shli@kernel.org>,
	Kyungchan Koh <kkc6196@fb.com>,
	weiping zhang <zhangweiping@didichuxing.com>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: null_blk: fix 'Invalid parameters' failure when loading module
Date: Sat,  3 Mar 2018 10:24:36 +0800
Message-Id: <20180303022436.11444-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On ARM64, the default page size has been 64K on some distributions, and
we should allow ARM64 people to play null_blk.

This patch fixes the issue by extend page bitmap size for supporting
other non-4KB PAGE_SIZE.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/null_blk.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 51b16249028a..388c5212a181 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -72,6 +72,7 @@ enum nullb_device_flags {
 	NULLB_DEV_FL_CACHE	= 3,
 };
 
+#define MAP_SZ		((PAGE_SIZE >> SECTOR_SHIFT) + 2)
 /*
  * nullb_page is a page in memory for nullb devices.
  *
@@ -86,10 +87,10 @@ enum nullb_device_flags {
  */
 struct nullb_page {
 	struct page *page;
-	unsigned long bitmap;
+	unsigned long bitmap[DIV_ROUND_UP(MAP_SZ, sizeof(unsigned long) * 8)];
 };
-#define NULLB_PAGE_LOCK (sizeof(unsigned long) * 8 - 1)
-#define NULLB_PAGE_FREE (sizeof(unsigned long) * 8 - 2)
+#define NULLB_PAGE_LOCK (MAP_SZ - 1)
+#define NULLB_PAGE_FREE (MAP_SZ - 2)
 
 struct nullb_device {
 	struct nullb *nullb;
@@ -732,7 +733,7 @@ static struct nullb_page *null_alloc_page(gfp_t gfp_flags)
 	if (!t_page->page)
 		goto out_freepage;
 
-	t_page->bitmap = 0;
+	memset(t_page->bitmap, 0, sizeof(t_page->bitmap));
 	return t_page;
 out_freepage:
 	kfree(t_page);
@@ -742,13 +743,20 @@ static struct nullb_page *null_alloc_page(gfp_t gfp_flags)
 
 static void null_free_page(struct nullb_page *t_page)
 {
-	__set_bit(NULLB_PAGE_FREE, &t_page->bitmap);
-	if (test_bit(NULLB_PAGE_LOCK, &t_page->bitmap))
+	__set_bit(NULLB_PAGE_FREE, t_page->bitmap);
+	if (test_bit(NULLB_PAGE_LOCK, t_page->bitmap))
 		return;
 	__free_page(t_page->page);
 	kfree(t_page);
 }
 
+static bool null_page_empty(struct nullb_page *page)
+{
+	int size = MAP_SZ - 2;
+
+	return find_first_bit(page->bitmap, size) == size;
+}
+
 static void null_free_sector(struct nullb *nullb, sector_t sector,
 	bool is_cache)
 {
@@ -763,9 +771,9 @@ static void null_free_sector(struct nullb *nullb, sector_t sector,
 
 	t_page = radix_tree_lookup(root, idx);
 	if (t_page) {
-		__clear_bit(sector_bit, &t_page->bitmap);
+		__clear_bit(sector_bit, t_page->bitmap);
 
-		if (!t_page->bitmap) {
+		if (null_page_empty(t_page)) {
 			ret = radix_tree_delete_item(root, idx, t_page);
 			WARN_ON(ret != t_page);
 			null_free_page(ret);
@@ -836,7 +844,7 @@ static struct nullb_page *__null_lookup_page(struct nullb *nullb,
 	t_page = radix_tree_lookup(root, idx);
 	WARN_ON(t_page && t_page->page->index != idx);
 
-	if (t_page && (for_write || test_bit(sector_bit, &t_page->bitmap)))
+	if (t_page && (for_write || test_bit(sector_bit, t_page->bitmap)))
 		return t_page;
 
 	return NULL;
@@ -899,10 +907,10 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 
 	t_page = null_insert_page(nullb, idx << PAGE_SECTORS_SHIFT, true);
 
-	__clear_bit(NULLB_PAGE_LOCK, &c_page->bitmap);
-	if (test_bit(NULLB_PAGE_FREE, &c_page->bitmap)) {
+	__clear_bit(NULLB_PAGE_LOCK, c_page->bitmap);
+	if (test_bit(NULLB_PAGE_FREE, c_page->bitmap)) {
 		null_free_page(c_page);
-		if (t_page && t_page->bitmap == 0) {
+		if (t_page && null_page_empty(t_page)) {
 			ret = radix_tree_delete_item(&nullb->dev->data,
 				idx, t_page);
 			null_free_page(t_page);
@@ -918,11 +926,11 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 
 	for (i = 0; i < PAGE_SECTORS;
 			i += (nullb->dev->blocksize >> SECTOR_SHIFT)) {
-		if (test_bit(i, &c_page->bitmap)) {
+		if (test_bit(i, c_page->bitmap)) {
 			offset = (i << SECTOR_SHIFT);
 			memcpy(dst + offset, src + offset,
 				nullb->dev->blocksize);
-			__set_bit(i, &t_page->bitmap);
+			__set_bit(i, t_page->bitmap);
 		}
 	}
 
@@ -959,10 +967,10 @@ static int null_make_cache_space(struct nullb *nullb, unsigned long n)
 		 * We found the page which is being flushed to disk by other
 		 * threads
 		 */
-		if (test_bit(NULLB_PAGE_LOCK, &c_pages[i]->bitmap))
+		if (test_bit(NULLB_PAGE_LOCK, c_pages[i]->bitmap))
 			c_pages[i] = NULL;
 		else
-			__set_bit(NULLB_PAGE_LOCK, &c_pages[i]->bitmap);
+			__set_bit(NULLB_PAGE_LOCK, c_pages[i]->bitmap);
 	}
 
 	one_round = 0;
@@ -1015,7 +1023,7 @@ static int copy_to_nullb(struct nullb *nullb, struct page *source,
 		kunmap_atomic(dst);
 		kunmap_atomic(src);
 
-		__set_bit(sector & SECTOR_MASK, &t_page->bitmap);
+		__set_bit(sector & SECTOR_MASK, t_page->bitmap);
 
 		if (is_fua)
 			null_free_sector(nullb, sector, true);
@@ -1808,10 +1816,6 @@ static int __init null_init(void)
 	struct nullb *nullb;
 	struct nullb_device *dev;
 
-	/* check for nullb_page.bitmap */
-	if (sizeof(unsigned long) * 8 - 2 < (PAGE_SIZE >> SECTOR_SHIFT))
-		return -EINVAL;
-
 	if (g_bs > PAGE_SIZE) {
 		pr_warn("null_blk: invalid block size\n");
 		pr_warn("null_blk: defaults block size to %lu\n", PAGE_SIZE);
-- 
2.9.5
