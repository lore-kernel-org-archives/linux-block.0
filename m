Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50260 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424284AbcKANk3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2016 09:40:29 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/16] fs: decouple READ and WRITE from the block layer ops
Date: Tue,  1 Nov 2016 07:40:11 -0600
Message-Id: <1478007617-18715-11-git-send-email-hch@lst.de>
In-Reply-To: <1478007617-18715-1-git-send-email-hch@lst.de>
References: <1478007617-18715-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Move READ and WRITE to kernel.h and don't define them in terms of block
layer ops; they are our generic data direction indicators these days
and have no more resemblance with the block layer ops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bio.h    |  6 ++++++
 include/linux/fs.h     | 13 -------------
 include/linux/kernel.h |  4 ++++
 include/linux/uio.h    |  2 +-
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 87ce64d..fe9a170 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -63,6 +63,12 @@
 #define bio_end_sector(bio)	((bio)->bi_iter.bi_sector + bio_sectors((bio)))
 
 /*
+ * Return the data direction, READ or WRITE.
+ */
+#define bio_data_dir(bio) \
+	(op_is_write(bio_op(bio)) ? WRITE : READ)
+
+/*
  * Check whether this bio carries any data or not. A NULL bio is allowed.
  */
 static inline bool bio_has_data(struct bio *bio)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7a1b78a..0ad36e0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -151,11 +151,6 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
  */
 #define CHECK_IOVEC_ONLY -1
 
-#define RW_MASK			REQ_OP_WRITE
-
-#define READ			REQ_OP_READ
-#define WRITE			REQ_OP_WRITE
-
 /*
  * Attribute flags.  These should be or-ed together to figure out what
  * has been changed!
@@ -2452,14 +2447,6 @@ extern void make_bad_inode(struct inode *);
 extern bool is_bad_inode(struct inode *);
 
 #ifdef CONFIG_BLOCK
-/*
- * return data direction, READ or WRITE
- */
-static inline int bio_data_dir(struct bio *bio)
-{
-	return op_is_write(bio_op(bio)) ? WRITE : READ;
-}
-
 extern void check_disk_size_change(struct gendisk *disk,
 				   struct block_device *bdev);
 extern int revalidate_disk(struct gendisk *);
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index bc6ed52..8c09962 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -50,6 +50,10 @@
 #define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
 #define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
 
+/* generic data direction defintions */
+#define READ			0
+#define WRITE			1
+
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 
 #define u64_to_user_ptr(x) (		\
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 6e22b54..d5aba15 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -125,7 +125,7 @@ static inline bool iter_is_iovec(const struct iov_iter *i)
  *
  * The ?: is just for type safety.
  */
-#define iov_iter_rw(i) ((0 ? (struct iov_iter *)0 : (i))->type & RW_MASK)
+#define iov_iter_rw(i) ((0 ? (struct iov_iter *)0 : (i))->type & (READ | WRITE))
 
 /*
  * Cap the iov_iter by given limit; note that the second argument is
-- 
2.1.4

