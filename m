Return-Path: <prvs=9107f69a83=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <jack@suse.cz>, <kernel@kolivas.org>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 1/8] block: add WRITE_BG
Date: Wed, 26 Oct 2016 14:52:08 -0600
Message-ID: <1477515135-16469-2-git-send-email-axboe@fb.com>
In-Reply-To: <1477515135-16469-1-git-send-email-axboe@fb.com>
References: <1477515135-16469-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

This adds a new request flag, REQ_BG, that callers can use to tell
the block layer that this is background (non-urgent) IO.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 include/linux/blk_types.h | 4 +++-
 include/linux/fs.h        | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index cd395ecec99d..765994c5b2c5 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -162,6 +162,7 @@ enum rq_flag_bits {
 	__REQ_INTEGRITY,	/* I/O includes block integrity payload */
 	__REQ_FUA,		/* forced unit access */
 	__REQ_PREFLUSH,		/* request for cache flush */
+	__REQ_BG,		/* background activity */
 
 	/* bio only flags */
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
@@ -205,7 +206,7 @@ enum rq_flag_bits {
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
 #define REQ_COMMON_MASK \
 	(REQ_FAILFAST_MASK | REQ_SYNC | REQ_META | REQ_PRIO | REQ_NOIDLE | \
-	 REQ_PREFLUSH | REQ_FUA | REQ_INTEGRITY | REQ_NOMERGE)
+	 REQ_PREFLUSH | REQ_FUA | REQ_INTEGRITY | REQ_NOMERGE | REQ_BG)
 #define REQ_CLONE_MASK		REQ_COMMON_MASK
 
 /* This mask is used for both bio and request merge checking */
@@ -230,6 +231,7 @@ enum rq_flag_bits {
 #define REQ_COPY_USER		(1ULL << __REQ_COPY_USER)
 #define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
 #define REQ_FLUSH_SEQ		(1ULL << __REQ_FLUSH_SEQ)
+#define REQ_BG			(1ULL << __REQ_BG)
 #define REQ_IO_STAT		(1ULL << __REQ_IO_STAT)
 #define REQ_MIXED_MERGE		(1ULL << __REQ_MIXED_MERGE)
 #define REQ_PM			(1ULL << __REQ_PM)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 16d2b6e874d6..baaedb05e5b2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -189,6 +189,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
  * WRITE_FLUSH_FUA	Combination of WRITE_FLUSH and FUA. The IO is preceded
  *			by a cache flush and data is guaranteed to be on
  *			non-volatile media on completion.
+ * WRITE_BG		Background write. This is for background activity like
+ *			the periodic flush and background threshold writeback
  *
  */
 #define RW_MASK			REQ_OP_WRITE
@@ -202,6 +204,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define WRITE_FLUSH		(REQ_SYNC | REQ_NOIDLE | REQ_PREFLUSH)
 #define WRITE_FUA		(REQ_SYNC | REQ_NOIDLE | REQ_FUA)
 #define WRITE_FLUSH_FUA		(REQ_SYNC | REQ_NOIDLE | REQ_PREFLUSH | REQ_FUA)
+#define WRITE_BG		(REQ_NOIDLE | REQ_BG)
 
 /*
  * Attribute flags.  These should be or-ed together to figure out what
-- 
2.7.4
