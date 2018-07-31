Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/3] blk-cgroup: hold the queue ref during throttling
Date: Tue, 31 Jul 2018 12:39:03 -0400
Message-Id: <20180731163904.21856-3-josef@toxicpanda.com>
In-Reply-To: <20180731163904.21856-1-josef@toxicpanda.com>
References: <20180731163904.21856-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

The blkg lifetime is protected by the queue lifetime, so we need to put
the queue _after_ we're done using the blkg.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 1942357d7165..694595b29b8f 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1759,10 +1759,10 @@ void blkcg_maybe_throttle_current(void)
 	if (!blkg)
 		goto out;
 	rcu_read_unlock();
-	blk_put_queue(q);
 
 	blkcg_maybe_throttle_blkg(blkg, use_memdelay);
 	blkg_put(blkg);
+	blk_put_queue(q);
 	return;
 out:
 	rcu_read_unlock();
-- 
2.14.3
