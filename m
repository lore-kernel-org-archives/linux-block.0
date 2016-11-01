Return-Path: <prvs=011358c635=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <jack@suse.cz>, <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 1/8] block: add WRITE_BACKGROUND
Date: Tue, 1 Nov 2016 15:08:44 -0600
Message-ID: <1478034531-28559-2-git-send-email-axboe@fb.com>
In-Reply-To: <1478034531-28559-1-git-send-email-axboe@fb.com>
References: <1478034531-28559-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

This adds a new request flag, REQ_BACKGROUND, that callers can use to
tell the block layer that this is background (non-urgent) IO.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 include/linux/blk_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index bb921028e7c5..562ac46cb790 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -177,6 +177,7 @@ enum req_flag_bits {
 	__REQ_FUA,		/* forced unit access */
 	__REQ_PREFLUSH,		/* request for cache flush */
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
+	__REQ_BACKGROUND,	/* background IO */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -192,6 +193,7 @@ enum req_flag_bits {
 #define REQ_FUA			(1ULL << __REQ_FUA)
 #define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
 #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
+#define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
-- 
2.7.4
