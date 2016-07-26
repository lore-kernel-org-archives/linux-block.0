Return-Path: <houtao1@huawei.com>
From: Hou Tao <houtao1@huawei.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>
Subject: [PATCH] blkcg: kill unused field nr_undestroyed_grps
Date: Tue, 26 Jul 2016 17:13:42 +0800
Message-ID: <1469524422-63439-1-git-send-email-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

'nr_undestroyed_grps' in struct throtl_data was used to count
the number of throtl_grp related with throtl_data, but now
throtl_grp is tracked by blkcg_gq, so it is useless anymore.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 block/blk-throttle.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 47a3e54..c5494e4 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -145,11 +145,6 @@ struct throtl_data
 	/* Total Number of queued bios on READ and WRITE lists */
 	unsigned int nr_queued[2];
 
-	/*
-	 * number of total undestroyed groups
-	 */
-	unsigned int nr_undestroyed_grps;
-
 	/* Work for dispatching throttled bios */
 	struct work_struct dispatch_work;
 };
-- 
2.5.5
