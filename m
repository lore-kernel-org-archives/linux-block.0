Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/3] blk-iolatency: fix blkg leak in timer_fn
Date: Tue, 31 Jul 2018 12:39:02 -0400
Message-Id: <20180731163904.21856-2-josef@toxicpanda.com>
In-Reply-To: <20180731163904.21856-1-josef@toxicpanda.com>
References: <20180731163904.21856-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

At this point we have a ref on the blkg, we need to drop it if we don't
have a iolat.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-iolatency.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index bb59b2929e0d..b0dc4fc64b3e 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -627,7 +627,7 @@ static void blkiolatency_timer_fn(struct timer_list *t)
 
 		iolat = blkg_to_lat(blkg);
 		if (!iolat)
-			continue;
+			goto next;
 
 		lat_info = &iolat->child_lat;
 		cookie = atomic_read(&lat_info->scale_cookie);
-- 
2.14.3
