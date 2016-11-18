Return-Path: <tklauser@distanz.ch>
From: Tobias Klauser <tklauser@distanz.ch>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2] block: Change extern inline to static inline
Date: Fri, 18 Nov 2016 15:16:06 +0100
Message-Id: <20161118141606.9520-1-tklauser@distanz.ch>
List-ID: <linux-block@vger.kernel.org>

With compilers which follow the C99 standard (like modern versions of
gcc and clang), "extern inline" does the opposite thing from older
versions of gcc (emits code for an externally linkable version of the
inline function).

"static inline" does the intended behavior in all cases instead.

Description taken from commit 6d91857d4826 ("staging, rtl8192e,
LLVMLinux: Change extern inline to static inline").

This also fixes the following GCC warning when building with CONFIG_PM
disabled:

  ./include/linux/blkdev.h:1143:20: warning: no previous prototype for 'blk_set_runtime_active' [-Wmissing-prototypes]

Fixes: d07ab6d11477 ("block: Add blk_set_runtime_active()")
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 00eb55e63d33..5fdad2d7e895 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1187,7 +1187,7 @@ static inline int blk_pre_runtime_suspend(struct request_queue *q)
 static inline void blk_post_runtime_suspend(struct request_queue *q, int err) {}
 static inline void blk_pre_runtime_resume(struct request_queue *q) {}
 static inline void blk_post_runtime_resume(struct request_queue *q, int err) {}
-extern inline void blk_set_runtime_active(struct request_queue *q) {}
+static inline void blk_set_runtime_active(struct request_queue *q) {}
 #endif
 
 /*
-- 
2.11.0.rc0.7.gbe5a750
