Return-Path: <cgxu519@gmx.com>
From: Chengguang Xu <cgxu519@gmx.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] block: change return type to bool
Date: Thu, 16 Aug 2018 22:51:40 +0800
Message-Id: <20180816145140.12558-1-cgxu519@gmx.com>
List-ID: <linux-block@vger.kernel.org>

Because blk_do_io_stat() only does a judgement about the request
contributes to IO statistics, it better changes return type to bool.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 block/blk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk.h b/block/blk.h
index d4d67e948920..644975e85053 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -297,7 +297,7 @@ extern int blk_update_nr_requests(struct request_queue *, unsigned int);
  *	b) the queue had IO stats enabled when this request was started, and
  *	c) it's a file system request
  */
-static inline int blk_do_io_stat(struct request *rq)
+static inline bool blk_do_io_stat(struct request *rq)
 {
 	return rq->rq_disk &&
 	       (rq->rq_flags & RQF_IO_STAT) &&
-- 
2.17.1
