Return-Path: <rgoldwyn@suse.de>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: axboe@kernel.dk
Cc: viro@ZenIV.linux.org.uk,
	hch@lst.de,
	jack@suse.cz,
	akpm@linux-foundation.org,
	linux-block@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 02/10] fs: Introduce filemap_range_has_page()
Date: Mon, 19 Jun 2017 11:33:40 -0500
Message-Id: <20170619163348.15542-3-rgoldwyn@suse.de>
In-Reply-To: <20170619163348.15542-1-rgoldwyn@suse.de>
References: <20170619163348.15542-1-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

filemap_range_has_page() return true if the file's mapping has
a page within the range mentioned. This function will be used
to check if a write() call will cause a writeback of previous
writes.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 include/linux/fs.h |  2 ++
 mm/filemap.c       | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 96a1a1fa54a9..0d34f5b5a6b0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2518,6 +2518,8 @@ extern int filemap_fdatawait(struct address_space *);
 extern void filemap_fdatawait_keep_errors(struct address_space *);
 extern int filemap_fdatawait_range(struct address_space *, loff_t lstart,
 				   loff_t lend);
+extern bool filemap_range_has_page(struct address_space *, loff_t lstart,
+				  loff_t lend);
 extern int filemap_write_and_wait(struct address_space *mapping);
 extern int filemap_write_and_wait_range(struct address_space *mapping,
 				        loff_t lstart, loff_t lend);
diff --git a/mm/filemap.c b/mm/filemap.c
index 6f1be573a5e6..9b39a2390b9e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -376,6 +376,38 @@ int filemap_flush(struct address_space *mapping)
 }
 EXPORT_SYMBOL(filemap_flush);
 
+/**
+ * filemap_range_has_page - check if a page exists in range.
+ * @mapping:           address space within which to check
+ * @start_byte:        offset in bytes where the range starts
+ * @end_byte:          offset in bytes where the range ends (inclusive)
+ *
+ * Find at least one page in the range supplied, usually used to check if
+ * direct writing in this range will trigger a writeback.
+ */
+bool filemap_range_has_page(struct address_space *mapping,
+			   loff_t start_byte, loff_t end_byte)
+{
+	pgoff_t index = start_byte >> PAGE_SHIFT;
+	pgoff_t end = end_byte >> PAGE_SHIFT;
+	struct pagevec pvec;
+	bool ret;
+
+	if (end_byte < start_byte)
+		return false;
+
+	if (mapping->nrpages == 0)
+		return false;
+
+	pagevec_init(&pvec, 0);
+	if (!pagevec_lookup(&pvec, mapping, index, 1))
+		return false;
+	ret = (pvec.pages[0]->index <= end);
+	pagevec_release(&pvec);
+	return ret;
+}
+EXPORT_SYMBOL(filemap_range_has_page);
+
 static int __filemap_fdatawait_range(struct address_space *mapping,
 				     loff_t start_byte, loff_t end_byte)
 {
-- 
2.12.0
