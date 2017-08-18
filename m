Return-Path: <prvs=9403a763c3=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: <Kernel-team@fb.com>, <axboe@kernel.dk>
Subject: [PATCH] blk-throttle: ignore discard request size
Date: Fri, 18 Aug 2017 08:13:06 -0700
Message-ID: <67ffcf14c2d15622b84c60a493b590dd81a07f51.1503068984.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

discard request usually is very big and easily use all bandwidth budget
of a cgroup. discard request size doesn't really mean the size of data
written, so it doesn't make sense to account it into bandwidth budget.
This patch ignores discard requests size. It makes sense to account
discard request into iops budget though.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 6a4c4c4..f80acc1 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -380,6 +380,13 @@ static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
 	}								\
 } while (0)
 
+static inline unsigned int throtl_bio_data_size(struct bio *bio)
+{
+	if (unlikely(bio_op(bio) == REQ_OP_DISCARD))
+		return 0;
+	return bio->bi_iter.bi_size;
+}
+
 static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg)
 {
 	INIT_LIST_HEAD(&qn->node);
@@ -932,6 +939,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	bool rw = bio_data_dir(bio);
 	u64 bytes_allowed, extra_bytes, tmp;
 	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
+	unsigned int bio_size = throtl_bio_data_size(bio);
 
 	jiffy_elapsed = jiffy_elapsed_rnd = jiffies - tg->slice_start[rw];
 
@@ -945,14 +953,14 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	do_div(tmp, HZ);
 	bytes_allowed = tmp;
 
-	if (tg->bytes_disp[rw] + bio->bi_iter.bi_size <= bytes_allowed) {
+	if (tg->bytes_disp[rw] + bio_size <= bytes_allowed) {
 		if (wait)
 			*wait = 0;
 		return true;
 	}
 
 	/* Calc approx time to dispatch */
-	extra_bytes = tg->bytes_disp[rw] + bio->bi_iter.bi_size - bytes_allowed;
+	extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
 	jiffy_wait = div64_u64(extra_bytes * HZ, tg_bps_limit(tg, rw));
 
 	if (!jiffy_wait)
@@ -1032,11 +1040,12 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 {
 	bool rw = bio_data_dir(bio);
+	unsigned int bio_size = throtl_bio_data_size(bio);
 
 	/* Charge the bio to the group */
-	tg->bytes_disp[rw] += bio->bi_iter.bi_size;
+	tg->bytes_disp[rw] += bio_size;
 	tg->io_disp[rw]++;
-	tg->last_bytes_disp[rw] += bio->bi_iter.bi_size;
+	tg->last_bytes_disp[rw] += bio_size;
 	tg->last_io_disp[rw]++;
 
 	/*
-- 
2.9.5
