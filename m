Return-Path: <zhangweiping@didichuxing.com>
Date: Thu, 23 Nov 2017 21:39:40 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH 3/5] blk-sysfs: remove NULL pointer checking in
 queue_wb_lat_store
Message-ID: <fc9f69cd121692fc490e7ed53467791486195bbf.1511444141.git.zhangweiping@didichuxing.com>
References: <cover.1511444141.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1511444141.git.zhangweiping@didichuxing.com>
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

wbt_init doesn't set q->rq_wb to NULL, if wbt_init return 0,
so check return value is enough, remove NULL checking.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-sysfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b8362c0..9b1093a 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -449,12 +449,9 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 		ret = wbt_init(q);
 		if (ret)
 			return ret;
-
-		rwb = q->rq_wb;
-		if (!rwb)
-			return -EINVAL;
 	}
 
+	rwb = q->rq_wb;
 	if (val == -1)
 		rwb->min_lat_nsec = wbt_default_latency_nsec(q);
 	else if (val >= 0)
-- 
2.9.4
