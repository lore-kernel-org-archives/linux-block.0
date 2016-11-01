Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50233 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424317AbcKANk0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2016 09:40:26 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/16] block: treat REQ_FUA and REQ_PREFLUSH as synchronous
Date: Tue,  1 Nov 2016 07:40:08 -0600
Message-Id: <1478007617-18715-8-git-send-email-hch@lst.de>
In-Reply-To: <1478007617-18715-1-git-send-email-hch@lst.de>
References: <1478007617-18715-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Instead of requiring everyone to specify the REQ_SYNC flag aѕ well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk_types.h | 8 +++++++-
 include/linux/fs.h        | 6 +++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3fa62ca..107d23d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -216,9 +216,15 @@ static inline bool op_is_write(unsigned int op)
 	return (op & 1);
 }
 
+/*
+ * Reads are always treated as synchronous, as are requests with the FUA or
+ * PREFLUSH flag.  Other operations may be marked as synchronous using the
+ * REQ_SYNC flag.
+ */
 static inline bool op_is_sync(unsigned int op)
 {
-	return (op & REQ_OP_MASK) == REQ_OP_READ || (op & REQ_SYNC);
+	return (op & REQ_OP_MASK) == REQ_OP_READ ||
+		(op & (REQ_SYNC | REQ_FUA | REQ_PREFLUSH));
 }
 
 typedef unsigned int blk_qc_t;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5e0078f..ccedccb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -199,9 +199,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define READ_SYNC		0
 #define WRITE_SYNC		(REQ_SYNC | REQ_NOIDLE)
 #define WRITE_ODIRECT		REQ_SYNC
-#define WRITE_FLUSH		(REQ_SYNC | REQ_NOIDLE | REQ_PREFLUSH)
-#define WRITE_FUA		(REQ_SYNC | REQ_NOIDLE | REQ_FUA)
-#define WRITE_FLUSH_FUA		(REQ_SYNC | REQ_NOIDLE | REQ_PREFLUSH | REQ_FUA)
+#define WRITE_FLUSH		(REQ_NOIDLE | REQ_PREFLUSH)
+#define WRITE_FUA		(REQ_NOIDLE | REQ_FUA)
+#define WRITE_FLUSH_FUA		(REQ_NOIDLE | REQ_PREFLUSH | REQ_FUA)
 
 /*
  * Attribute flags.  These should be or-ed together to figure out what
-- 
2.1.4

