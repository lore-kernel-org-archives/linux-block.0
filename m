Return-Path: <dennisszhou@gmail.com>
Return-Path: <dennisszhou@gmail.com>
From: Dennis Zhou <dennis@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>,
	Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	kernel-team@fb.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 1/2] blkcg: fix edge case for blk_get_rl() under memory pressure
Date: Sat, 20 Oct 2018 14:56:11 -0400
Message-Id: <20181020185612.51587-2-dennis@kernel.org>
In-Reply-To: <20181020185612.51587-1-dennis@kernel.org>
References: <20181020185612.51587-1-dennis@kernel.org>
List-ID: <linux-block@vger.kernel.org>

It is possible for blkg creation to fail when in blk_get_rl(). In this
situation, the fallback logic returns the nearest created blkg. There is
however special handling for the request_list for the root blkcg. This
fixes the missing edge case from the earlier series changing
blk_get_rl().

Fixes: e2b0989954ae ("blkcg: cleanup and make blk_get_rl use blkg_lookup_create")
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 include/linux/blk-cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index b7fd08013de2..1e76ceebeb5d 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -597,7 +597,7 @@ static inline struct request_list *blk_get_rl(struct request_queue *q,
 	if (unlikely(!blkg))
 		blkg = __blkg_lookup_create(blkcg, q);
 
-	if (!blkg_tryget(blkg))
+	if (blkg->blkcg == &blkcg_root || !blkg_tryget(blkg))
 		goto rl_use_root;
 
 	rcu_read_unlock();
-- 
2.17.1
