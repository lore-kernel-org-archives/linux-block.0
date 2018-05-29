Return-Path: <cgxu519@gmx.com>
From: Chengguang Xu <cgxu519@gmx.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] blk-throttle: return proper bool type to caller instead of 0/1
Date: Tue, 29 May 2018 18:32:44 +0800
Message-Id: <1527589964-138223-1-git-send-email-cgxu519@gmx.com>
List-ID: <linux-block@vger.kernel.org>

Change to return true/false only for bool type return code.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 block/blk-throttle.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index c5a1316..3155dee 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -821,7 +821,7 @@ static bool throtl_slice_used(struct throtl_grp *tg, bool rw)
 	if (time_in_range(jiffies, tg->slice_start[rw], tg->slice_end[rw]))
 		return false;
 
-	return 1;
+	return true;
 }
 
 /* Trim the used slices and adjust slice start accordingly */
@@ -931,7 +931,7 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
 
 	if (wait)
 		*wait = jiffy_wait;
-	return 0;
+	return false;
 }
 
 static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
@@ -974,7 +974,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	jiffy_wait = jiffy_wait + (jiffy_elapsed_rnd - jiffy_elapsed);
 	if (wait)
 		*wait = jiffy_wait;
-	return 0;
+	return false;
 }
 
 /*
@@ -1024,7 +1024,7 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 	    tg_with_in_iops_limit(tg, bio, &iops_wait)) {
 		if (wait)
 			*wait = 0;
-		return 1;
+		return true;
 	}
 
 	max_wait = max(bps_wait, iops_wait);
@@ -1035,7 +1035,7 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 	if (time_before(tg->slice_end[rw], jiffies + max_wait))
 		throtl_extend_slice(tg, rw, jiffies + max_wait);
 
-	return 0;
+	return false;
 }
 
 static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
-- 
1.8.3.1
