Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47057 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750836AbdAODmh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Jan 2017 22:42:37 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v0F3bxRS021009
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:36 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 27yjpg9bk5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:36 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.103.99.99) with ESMTP  id
 a7300ee6dad411e6a0890002c9dfb610-975af6d0 for <linux-block@vger.kernel.org>;
        Sat, 14 Jan 2017 19:42:35 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <Kernel-team@fb.com>, <tj@kernel.org>, <axboe@fb.com>,
        <vgoyal@redhat.com>
Subject: [PATCH V6 02/18] blk-throttle: prepare support multiple limits
Date: Sat, 14 Jan 2017 19:42:19 -0800
Message-ID: <75b81790e65afd577e6686c6cd1b71d77155cf74.1484451062.git.shli@fb.com>
In-Reply-To: <cover.1484451062.git.shli@fb.com>
References: <cover.1484451062.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We are going to support low/max limit, each cgroup will have 2 limits
after that. This patch prepares for the multiple limits change.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 110 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 70 insertions(+), 40 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index e45bf50..b08369b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -83,6 +83,11 @@ enum tg_state_flags {
 
 #define rb_entry_tg(node)	rb_entry((node), struct throtl_grp, rb_node)
 
+enum {
+	LIMIT_MAX,
+	LIMIT_CNT,
+};
+
 struct throtl_grp {
 	/* must be the first member */
 	struct blkg_policy_data pd;
@@ -120,10 +125,10 @@ struct throtl_grp {
 	bool has_rules[2];
 
 	/* bytes per second rate limits */
-	uint64_t bps[2];
+	uint64_t bps[2][LIMIT_CNT];
 
 	/* IOPS limits */
-	unsigned int iops[2];
+	unsigned int iops[2][LIMIT_CNT];
 
 	/* Number of bytes disptached in current slice */
 	uint64_t bytes_disp[2];
@@ -147,6 +152,8 @@ struct throtl_data
 
 	/* Work for dispatching throttled bios */
 	struct work_struct dispatch_work;
+	unsigned int limit_index;
+	bool limit_valid[LIMIT_CNT];
 };
 
 static void throtl_pending_timer_fn(unsigned long arg);
@@ -198,6 +205,16 @@ static struct throtl_data *sq_to_td(struct throtl_service_queue *sq)
 		return container_of(sq, struct throtl_data, service_queue);
 }
 
+static uint64_t tg_bps_limit(struct throtl_grp *tg, int rw)
+{
+	return tg->bps[rw][tg->td->limit_index];
+}
+
+static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
+{
+	return tg->iops[rw][tg->td->limit_index];
+}
+
 /**
  * throtl_log - log debug message via blktrace
  * @sq: the service_queue being reported
@@ -334,10 +351,10 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
 	}
 
 	RB_CLEAR_NODE(&tg->rb_node);
-	tg->bps[READ] = U64_MAX;
-	tg->bps[WRITE] = U64_MAX;
-	tg->iops[READ] = UINT_MAX;
-	tg->iops[WRITE] = UINT_MAX;
+	tg->bps[READ][LIMIT_MAX] = U64_MAX;
+	tg->bps[WRITE][LIMIT_MAX] = U64_MAX;
+	tg->iops[READ][LIMIT_MAX] = UINT_MAX;
+	tg->iops[WRITE][LIMIT_MAX] = UINT_MAX;
 
 	return &tg->pd;
 }
@@ -376,11 +393,14 @@ static void throtl_pd_init(struct blkg_policy_data *pd)
 static void tg_update_has_rules(struct throtl_grp *tg)
 {
 	struct throtl_grp *parent_tg = sq_to_tg(tg->service_queue.parent_sq);
+	struct throtl_data *td = tg->td;
 	int rw;
 
 	for (rw = READ; rw <= WRITE; rw++)
 		tg->has_rules[rw] = (parent_tg && parent_tg->has_rules[rw]) ||
-			(tg->bps[rw] != U64_MAX || tg->iops[rw] != UINT_MAX);
+			(td->limit_valid[td->limit_index] &&
+			 (tg_bps_limit(tg, rw) != U64_MAX ||
+			  tg_iops_limit(tg, rw) != UINT_MAX));
 }
 
 static void throtl_pd_online(struct blkg_policy_data *pd)
@@ -632,11 +652,11 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 
 	if (!nr_slices)
 		return;
-	tmp = tg->bps[rw] * throtl_slice * nr_slices;
+	tmp = tg_bps_limit(tg, rw) * throtl_slice * nr_slices;
 	do_div(tmp, HZ);
 	bytes_trim = tmp;
 
-	io_trim = (tg->iops[rw] * throtl_slice * nr_slices)/HZ;
+	io_trim = (tg_iops_limit(tg, rw) * throtl_slice * nr_slices) / HZ;
 
 	if (!bytes_trim && !io_trim)
 		return;
@@ -682,7 +702,7 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
 	 * have been trimmed.
 	 */
 
-	tmp = (u64)tg->iops[rw] * jiffy_elapsed_rnd;
+	tmp = (u64)tg_iops_limit(tg, rw) * jiffy_elapsed_rnd;
 	do_div(tmp, HZ);
 
 	if (tmp > UINT_MAX)
@@ -697,7 +717,7 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
 	}
 
 	/* Calc approx time to dispatch */
-	jiffy_wait = ((tg->io_disp[rw] + 1) * HZ)/tg->iops[rw] + 1;
+	jiffy_wait = ((tg->io_disp[rw] + 1) * HZ) / tg_iops_limit(tg, rw) + 1;
 
 	if (jiffy_wait > jiffy_elapsed)
 		jiffy_wait = jiffy_wait - jiffy_elapsed;
@@ -724,7 +744,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 
 	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, throtl_slice);
 
-	tmp = tg->bps[rw] * jiffy_elapsed_rnd;
+	tmp = tg_bps_limit(tg, rw) * jiffy_elapsed_rnd;
 	do_div(tmp, HZ);
 	bytes_allowed = tmp;
 
@@ -736,7 +756,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 
 	/* Calc approx time to dispatch */
 	extra_bytes = tg->bytes_disp[rw] + bio->bi_iter.bi_size - bytes_allowed;
-	jiffy_wait = div64_u64(extra_bytes * HZ, tg->bps[rw]);
+	jiffy_wait = div64_u64(extra_bytes * HZ, tg_bps_limit(tg, rw));
 
 	if (!jiffy_wait)
 		jiffy_wait = 1;
@@ -771,7 +791,8 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
 
 	/* If tg->bps = -1, then BW is unlimited */
-	if (tg->bps[rw] == U64_MAX && tg->iops[rw] == UINT_MAX) {
+	if (tg_bps_limit(tg, rw) == U64_MAX &&
+	    tg_iops_limit(tg, rw) == UINT_MAX) {
 		if (wait)
 			*wait = 0;
 		return true;
@@ -1148,8 +1169,8 @@ static void tg_conf_updated(struct throtl_grp *tg)
 
 	throtl_log(&tg->service_queue,
 		   "limit change rbps=%llu wbps=%llu riops=%u wiops=%u",
-		   tg->bps[READ], tg->bps[WRITE],
-		   tg->iops[READ], tg->iops[WRITE]);
+		   tg_bps_limit(tg, READ), tg_bps_limit(tg, WRITE),
+		   tg_iops_limit(tg, READ), tg_iops_limit(tg, WRITE));
 
 	/*
 	 * Update has_rules[] flags for the updated tg's subtree.  A tg is
@@ -1226,25 +1247,25 @@ static ssize_t tg_set_conf_uint(struct kernfs_open_file *of,
 static struct cftype throtl_legacy_files[] = {
 	{
 		.name = "throttle.read_bps_device",
-		.private = offsetof(struct throtl_grp, bps[READ]),
+		.private = offsetof(struct throtl_grp, bps[READ][LIMIT_MAX]),
 		.seq_show = tg_print_conf_u64,
 		.write = tg_set_conf_u64,
 	},
 	{
 		.name = "throttle.write_bps_device",
-		.private = offsetof(struct throtl_grp, bps[WRITE]),
+		.private = offsetof(struct throtl_grp, bps[WRITE][LIMIT_MAX]),
 		.seq_show = tg_print_conf_u64,
 		.write = tg_set_conf_u64,
 	},
 	{
 		.name = "throttle.read_iops_device",
-		.private = offsetof(struct throtl_grp, iops[READ]),
+		.private = offsetof(struct throtl_grp, iops[READ][LIMIT_MAX]),
 		.seq_show = tg_print_conf_uint,
 		.write = tg_set_conf_uint,
 	},
 	{
 		.name = "throttle.write_iops_device",
-		.private = offsetof(struct throtl_grp, iops[WRITE]),
+		.private = offsetof(struct throtl_grp, iops[WRITE][LIMIT_MAX]),
 		.seq_show = tg_print_conf_uint,
 		.write = tg_set_conf_uint,
 	},
@@ -1270,18 +1291,25 @@ static u64 tg_prfill_max(struct seq_file *sf, struct blkg_policy_data *pd,
 
 	if (!dname)
 		return 0;
-	if (tg->bps[READ] == U64_MAX && tg->bps[WRITE] == U64_MAX &&
-	    tg->iops[READ] == UINT_MAX && tg->iops[WRITE] == UINT_MAX)
+
+	if (tg->bps[READ][LIMIT_MAX] == U64_MAX &&
+	    tg->bps[WRITE][LIMIT_MAX] == U64_MAX &&
+	    tg->iops[READ][LIMIT_MAX] == UINT_MAX &&
+	    tg->iops[WRITE][LIMIT_MAX] == UINT_MAX)
 		return 0;
 
-	if (tg->bps[READ] != U64_MAX)
-		snprintf(bufs[0], sizeof(bufs[0]), "%llu", tg->bps[READ]);
-	if (tg->bps[WRITE] != U64_MAX)
-		snprintf(bufs[1], sizeof(bufs[1]), "%llu", tg->bps[WRITE]);
-	if (tg->iops[READ] != UINT_MAX)
-		snprintf(bufs[2], sizeof(bufs[2]), "%u", tg->iops[READ]);
-	if (tg->iops[WRITE] != UINT_MAX)
-		snprintf(bufs[3], sizeof(bufs[3]), "%u", tg->iops[WRITE]);
+	if (tg->bps[READ][LIMIT_MAX] != U64_MAX)
+		snprintf(bufs[0], sizeof(bufs[0]), "%llu",
+			tg->bps[READ][LIMIT_MAX]);
+	if (tg->bps[WRITE][LIMIT_MAX] != U64_MAX)
+		snprintf(bufs[1], sizeof(bufs[1]), "%llu",
+			tg->bps[WRITE][LIMIT_MAX]);
+	if (tg->iops[READ][LIMIT_MAX] != UINT_MAX)
+		snprintf(bufs[2], sizeof(bufs[2]), "%u",
+			tg->iops[READ][LIMIT_MAX]);
+	if (tg->iops[WRITE][LIMIT_MAX] != UINT_MAX)
+		snprintf(bufs[3], sizeof(bufs[3]), "%u",
+			tg->iops[WRITE][LIMIT_MAX]);
 
 	seq_printf(sf, "%s rbps=%s wbps=%s riops=%s wiops=%s\n",
 		   dname, bufs[0], bufs[1], bufs[2], bufs[3]);
@@ -1310,10 +1338,10 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
 
 	tg = blkg_to_tg(ctx.blkg);
 
-	v[0] = tg->bps[READ];
-	v[1] = tg->bps[WRITE];
-	v[2] = tg->iops[READ];
-	v[3] = tg->iops[WRITE];
+	v[0] = tg->bps[READ][LIMIT_MAX];
+	v[1] = tg->bps[WRITE][LIMIT_MAX];
+	v[2] = tg->iops[READ][LIMIT_MAX];
+	v[3] = tg->iops[WRITE][LIMIT_MAX];
 
 	while (true) {
 		char tok[27];	/* wiops=18446744073709551616 */
@@ -1350,10 +1378,10 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
 			goto out_finish;
 	}
 
-	tg->bps[READ] = v[0];
-	tg->bps[WRITE] = v[1];
-	tg->iops[READ] = v[2];
-	tg->iops[WRITE] = v[3];
+	tg->bps[READ][LIMIT_MAX] = v[0];
+	tg->bps[WRITE][LIMIT_MAX] = v[1];
+	tg->iops[READ][LIMIT_MAX] = v[2];
+	tg->iops[WRITE][LIMIT_MAX] = v[3];
 
 	tg_conf_updated(tg);
 	ret = 0;
@@ -1451,8 +1479,9 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	/* out-of-limit, queue to @tg */
 	throtl_log(sq, "[%c] bio. bdisp=%llu sz=%u bps=%llu iodisp=%u iops=%u queued=%d/%d",
 		   rw == READ ? 'R' : 'W',
-		   tg->bytes_disp[rw], bio->bi_iter.bi_size, tg->bps[rw],
-		   tg->io_disp[rw], tg->iops[rw],
+		   tg->bytes_disp[rw], bio->bi_iter.bi_size,
+		   tg_bps_limit(tg, rw),
+		   tg->io_disp[rw], tg_iops_limit(tg, rw),
 		   sq->nr_queued[READ], sq->nr_queued[WRITE]);
 
 	bio_associate_current(bio);
@@ -1563,6 +1592,7 @@ int blk_throtl_init(struct request_queue *q)
 	q->td = td;
 	td->queue = q;
 
+	td->limit_valid[LIMIT_MAX] = true;
 	/* activate policy */
 	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
 	if (ret)
-- 
2.9.3

