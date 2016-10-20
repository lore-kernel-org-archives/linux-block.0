Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49757 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932211AbcJTNMi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2016 09:12:38 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 7/7] block: add a proper block layer data direction encoding
Date: Thu, 20 Oct 2016 15:12:15 +0200
Message-Id: <1476969135-32732-8-git-send-email-hch@lst.de>
In-Reply-To: <1476969135-32732-1-git-send-email-hch@lst.de>
References: <1476969135-32732-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently the block layer op_is_write, bio_data_dir and rq_data_dir
helper treat every operation that is not a READ as a data out operation.
This worked surprisingly long, but the new REQ_OP_ZONE_REPORT operation
actually adds a second operation that reads data from the device.
Surprisingly nothing critical relied on this direction, but this might
be a good opportunity to properly fix this issue up.

We take a little inspiration and use the least significant bit of the
operation number to encode the data direction, which just requires us
to renumber the operations to fix this scheme.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk_types.h | 38 ++++++++++++++++++++++++++++++--------
 include/linux/fs.h        |  5 -----
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index dca972d..70d0ef1 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -131,20 +131,37 @@ struct bio {
 /*
  * Operations and flags common to the bio and request structures.
  * We use 8 bits for encoding the operation, and the remaining 24 for flags.
+ *
+ * The least significant bit of the operation number indicates the data
+ * transfer direction:
+ *
+ *   - if the least significant bit is set transfers are TO the device
+ *   - if the least significant bit is not set transfers are FROM the device
+ *
+ * If a operation does not transfer data the least significant bit has not
+ * meaning.
  */
 #define REQ_OP_BITS	8
 #define REQ_OP_MASK	((1 << REQ_OP_BITS) - 1)
 #define REQ_FLAG_BITS	24
 
 enum req_opf {
-	REQ_OP_READ,
-	REQ_OP_WRITE,
-	REQ_OP_DISCARD,		/* request to discard sectors */
-	REQ_OP_SECURE_ERASE,	/* request to securely erase sectors */
-	REQ_OP_WRITE_SAME,	/* write same block many times */
-	REQ_OP_FLUSH,		/* request for cache flush */
-	REQ_OP_ZONE_REPORT,	/* Get zone information */
-	REQ_OP_ZONE_RESET,	/* Reset a zone write pointer */
+	/* read sectors from the device */
+	REQ_OP_READ		= 0,
+	/* write sectors to the device */
+	REQ_OP_WRITE		= 1,
+	/* flush the volatile write cache */
+	REQ_OP_FLUSH		= 2,
+	/* discard sectors */
+	REQ_OP_DISCARD		= 3,
+	/* get zone information */
+	REQ_OP_ZONE_REPORT	= 4,
+	/* securely erase sectors */
+	REQ_OP_SECURE_ERASE	= 5,
+	/* seset a zone write pointer */
+	REQ_OP_ZONE_RESET	= 6,
+	/* write the same sector many times */
+	REQ_OP_WRITE_SAME	= 7,
 
 	REQ_OP_LAST,
 };
@@ -194,6 +211,11 @@ enum req_flag_bits {
 #define bio_set_op_attrs(bio, op, op_flags) \
 	((bio)->bi_opf |= (op | op_flags))
 
+static inline bool op_is_write(unsigned int op)
+{
+	return (op & 1);
+}
+
 static inline bool op_is_sync(unsigned int op)
 {
 	return (op & REQ_OP_MASK) == REQ_OP_READ || (op & REQ_SYNC);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 16d2b6e..e3e878f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2499,11 +2499,6 @@ extern void make_bad_inode(struct inode *);
 extern bool is_bad_inode(struct inode *);
 
 #ifdef CONFIG_BLOCK
-static inline bool op_is_write(unsigned int op)
-{
-	return op == REQ_OP_READ ? false : true;
-}
-
 /*
  * return data direction, READ or WRITE
  */
-- 
2.1.4

