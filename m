Return-Path: <houtao1@huawei.com>
From: Hou Tao <houtao1@huawei.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>
Subject: [PATCH] blkcg: fix double free of new_blkg in blkcg_init_queue
Date: Wed, 25 Jan 2017 08:37:36 +0800
Message-ID: <1485304656-8844-1-git-send-email-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

if blkg_create fails, new_blkg passed as an argument will
be freed by blkg_create, so there is no need to free it again.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 block/blk-cgroup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 8ba0af7..58fb0dd 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1080,7 +1080,6 @@ int blkcg_init_queue(struct request_queue *q)
 		radix_tree_preload_end();
 
 	if (IS_ERR(blkg)) {
-		blkg_free(new_blkg);
 		return PTR_ERR(blkg);
 	}
 
-- 
2.5.0
