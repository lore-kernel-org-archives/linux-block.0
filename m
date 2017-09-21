Return-Path: <zhangweiping@didichuxing.com>
Date: Thu, 21 Sep 2017 23:17:56 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH v2 2/2] blk-sysfs: return EINVAL when user modify nr_request
 less than BLKDEV_MIN_RQ
Message-ID: <da25b8d7b8ddd34e6e5f62f8c001f551ff3f1e04.1506006064.git.zhangweiping@didichuxing.com>
References: <cover.1506006064.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1506006064.git.zhangweiping@didichuxing.com>
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b8362c0..03a6e19 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -75,7 +75,7 @@ queue_requests_store(struct request_queue *q, const char *page, size_t count)
 		return ret;
 
 	if (nr < BLKDEV_MIN_RQ)
-		nr = BLKDEV_MIN_RQ;
+		return -EINVAL;
 
 	if (q->request_fn)
 		err = blk_update_nr_requests(q, nr);
-- 
2.9.4
