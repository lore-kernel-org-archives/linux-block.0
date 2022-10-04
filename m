Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80F0C433FE
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 15:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJDPaa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 11:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJDPaQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 11:30:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E2B1F2F6
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 08:30:14 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294CAiZA027519
        for <linux-block@vger.kernel.org>; Tue, 4 Oct 2022 08:30:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=MIlUGZxEmiwr29TXC6rLK1RgFe5Ngz+vdiicSffGJ7E=;
 b=X2wO0v7XcWF2qegkjQu6/9BfVP73kVgdOrUeX3EZeBmJz0uXbX1/28S8U8TZDKy1rCfN
 MQUscxt+yPZ+/5YDB90516CxLi494kQ+UCvx1DSOSSRmiulhf9z3GGd+sfcSip+tg0eB
 1A/v8hhBhxEeM6RnJE9bKqpKoJlrIjiPTJhwJlcmbOsk7xZOMQ8m2daf/Czejz7i3saY
 tdElKyfCFKxNCeMAI4Iop4VcgOrfn0lnMVH8sfPUcKmQuxGl+IKKAEFVxEUNEIAcnSUM
 XEsPfepStoZznkUDZvDi2gyFYOH6SJU5D5k4DP/AKobT5BZWzYLOo958p3sFvciQUzl9 1g== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k0b2tbysa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 04 Oct 2022 08:30:13 -0700
Received: from twshared34348.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 08:30:11 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 1C1F2961C978; Tue,  4 Oct 2022 08:30:05 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC:     <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] blk-mq: aggregate ktime_get per request batch
Date:   Tue, 4 Oct 2022 08:30:04 -0700
Message-ID: <20221004153004.2058994-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: OeIWFwdY-IKF5XnX5QBEpIHxH1bo2WS2
X-Proofpoint-ORIG-GUID: OeIWFwdY-IKF5XnX5QBEpIHxH1bo2WS2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The request statistics fields' precision doesn't require each get a
timestamp at their exact location of being set. We can get the time just
once per batch to reduce the overhead from this repeated call. This is
only really helpful if requests are batched, but no harm done if sending
one at a time.

Using fio's t/io_uring benchmark with default settings, time spent in
ktime_get() reduced from ~6% to <1%, and is good for ~3% IOPs boost when
stats are enabled.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c             | 88 ++++++++++++++++++++++++--------------
 drivers/block/virtio_blk.c |  3 +-
 drivers/nvme/host/pci.c    |  3 +-
 include/linux/blk-mq.h     |  2 +-
 include/linux/blkdev.h     |  7 +++
 5 files changed, 69 insertions(+), 34 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8070b6c10e8d..c759fb36b684 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -339,7 +339,7 @@ void blk_rq_init(struct request_queue *q, struct requ=
est *rq)
 EXPORT_SYMBOL(blk_rq_init);
=20
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data=
,
-		struct blk_mq_tags *tags, unsigned int tag, u64 alloc_time_ns)
+		struct blk_mq_tags *tags, unsigned int tag, u64 now)
 {
 	struct blk_mq_ctx *ctx =3D data->ctx;
 	struct blk_mq_hw_ctx *hctx =3D data->hctx;
@@ -366,15 +366,11 @@ static struct request *blk_mq_rq_ctx_init(struct bl=
k_mq_alloc_data *data,
 	}
 	rq->timeout =3D 0;
=20
-	if (blk_mq_need_time_stamp(rq))
-		rq->start_time_ns =3D ktime_get_ns();
-	else
-		rq->start_time_ns =3D 0;
+	rq->start_time_ns =3D now;
 	rq->part =3D NULL;
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
-	rq->alloc_time_ns =3D alloc_time_ns;
+	rq->alloc_time_ns =3D now;
 #endif
-	rq->io_start_time_ns =3D 0;
 	rq->stats_sectors =3D 0;
 	rq->nr_phys_segments =3D 0;
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
@@ -407,7 +403,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_=
mq_alloc_data *data,
=20
 static inline struct request *
 __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
-		u64 alloc_time_ns)
+		u64 now)
 {
 	unsigned int tag, tag_offset;
 	struct blk_mq_tags *tags;
@@ -426,7 +422,7 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_dat=
a *data,
 		tag =3D tag_offset + i;
 		prefetch(tags->static_rqs[tag]);
 		tag_mask &=3D ~(1UL << i);
-		rq =3D blk_mq_rq_ctx_init(data, tags, tag, alloc_time_ns);
+		rq =3D blk_mq_rq_ctx_init(data, tags, tag, now);
 		rq_list_add(data->cached_rq, rq);
 		nr++;
 	}
@@ -440,13 +436,13 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_d=
ata *data,
 static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data =
*data)
 {
 	struct request_queue *q =3D data->q;
-	u64 alloc_time_ns =3D 0;
 	struct request *rq;
 	unsigned int tag;
+	u64 now =3D 0;
=20
 	/* alloc_time includes depth and tag waits */
-	if (blk_queue_rq_alloc_time(q))
-		alloc_time_ns =3D ktime_get_ns();
+	if (blk_queue_need_ts(q))
+		now =3D ktime_get_ns();
=20
 	if (data->cmd_flags & REQ_NOWAIT)
 		data->flags |=3D BLK_MQ_REQ_NOWAIT;
@@ -481,7 +477,7 @@ static struct request *__blk_mq_alloc_requests(struct=
 blk_mq_alloc_data *data)
 	 * Try batched alloc if we want more than 1 tag.
 	 */
 	if (data->nr_tags > 1) {
-		rq =3D __blk_mq_alloc_requests_batch(data, alloc_time_ns);
+		rq =3D __blk_mq_alloc_requests_batch(data, now);
 		if (rq)
 			return rq;
 		data->nr_tags =3D 1;
@@ -507,7 +503,7 @@ static struct request *__blk_mq_alloc_requests(struct=
 blk_mq_alloc_data *data)
 	}
=20
 	return blk_mq_rq_ctx_init(data, blk_mq_tags_from_data(data), tag,
-					alloc_time_ns);
+					now);
 }
=20
 static struct request *blk_mq_rq_cache_fill(struct request_queue *q,
@@ -610,14 +606,14 @@ struct request *blk_mq_alloc_request_hctx(struct re=
quest_queue *q,
 		.cmd_flags	=3D opf,
 		.nr_tags	=3D 1,
 	};
-	u64 alloc_time_ns =3D 0;
 	unsigned int cpu;
 	unsigned int tag;
+	u64 now =3D 0;
 	int ret;
=20
 	/* alloc_time includes depth and tag waits */
-	if (blk_queue_rq_alloc_time(q))
-		alloc_time_ns =3D ktime_get_ns();
+	if (blk_queue_need_ts(q))
+		now =3D ktime_get_ns();
=20
 	/*
 	 * If the tag allocator sleeps we could get an allocation for a
@@ -661,7 +657,7 @@ struct request *blk_mq_alloc_request_hctx(struct requ=
est_queue *q,
 	if (tag =3D=3D BLK_MQ_NO_TAG)
 		goto out_queue_exit;
 	return blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag,
-					alloc_time_ns);
+					now);
=20
 out_queue_exit:
 	blk_queue_exit(q);
@@ -1214,8 +1210,13 @@ void blk_mq_start_request(struct request *rq)
=20
 	trace_block_rq_issue(rq);
=20
-	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
-		rq->io_start_time_ns =3D ktime_get_ns();
+	if (blk_queue_stat(q) ) {
+		/*
+		 * io_start_time_ns may not have been set earlier if the stat
+		 * attribute was being changed.
+		 */
+		if (!rq->io_start_time_ns)
+			rq->io_start_time_ns =3D ktime_get_ns();
 		rq->stats_sectors =3D blk_rq_sectors(rq);
 		rq->rq_flags |=3D RQF_STATS;
 		rq_qos_issue(q, rq);
@@ -1944,10 +1945,14 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx=
 *hctx, struct list_head *list,
 	blk_status_t ret =3D BLK_STS_OK;
 	LIST_HEAD(zone_list);
 	bool needs_resource =3D false;
+	u64 now =3D 0;
=20
 	if (list_empty(list))
 		return false;
=20
+	if (blk_queue_stat(q))
+		now =3D ktime_get_ns();
+
 	/*
 	 * Now process all the entries, sending them to the driver.
 	 */
@@ -1983,6 +1988,8 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *=
hctx, struct list_head *list,
 		 */
 		if (nr_budgets)
 			nr_budgets--;
+
+		rq->io_start_time_ns =3D now;
 		ret =3D q->mq_ops->queue_rq(hctx, &bd);
 		switch (ret) {
 		case BLK_STS_OK:
@@ -2507,7 +2514,7 @@ static void blk_mq_bio_to_request(struct request *r=
q, struct bio *bio,
 }
=20
 static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
-					    struct request *rq, bool last)
+					    struct request *rq, bool last, u64 now)
 {
 	struct request_queue *q =3D rq->q;
 	struct blk_mq_queue_data bd =3D {
@@ -2521,6 +2528,7 @@ static blk_status_t __blk_mq_issue_directly(struct =
blk_mq_hw_ctx *hctx,
 	 * Any other error (busy), just add it to our list as we
 	 * previously would have done.
 	 */
+	rq->io_start_time_ns =3D now;
 	ret =3D q->mq_ops->queue_rq(hctx, &bd);
 	switch (ret) {
 	case BLK_STS_OK:
@@ -2541,7 +2549,7 @@ static blk_status_t __blk_mq_issue_directly(struct =
blk_mq_hw_ctx *hctx,
=20
 static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hc=
tx,
 						struct request *rq,
-						bool bypass_insert, bool last)
+						bool bypass_insert, bool last, u64 now)
 {
 	struct request_queue *q =3D rq->q;
 	bool run_queue =3D true;
@@ -2574,7 +2582,7 @@ static blk_status_t __blk_mq_try_issue_directly(str=
uct blk_mq_hw_ctx *hctx,
 		goto insert;
 	}
=20
-	return __blk_mq_issue_directly(hctx, rq, last);
+	return __blk_mq_issue_directly(hctx, rq, last, now);
 insert:
 	if (bypass_insert)
 		return BLK_STS_RESOURCE;
@@ -2597,8 +2605,13 @@ static blk_status_t __blk_mq_try_issue_directly(st=
ruct blk_mq_hw_ctx *hctx,
 static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		struct request *rq)
 {
-	blk_status_t ret =3D
-		__blk_mq_try_issue_directly(hctx, rq, false, true);
+	blk_status_t ret;
+	u64 now =3D 0;
+
+	if (blk_queue_stat(rq->q))
+		now =3D ktime_get_ns();
+
+	ret =3D __blk_mq_try_issue_directly(hctx, rq, false, true, now);
=20
 	if (ret =3D=3D BLK_STS_RESOURCE || ret =3D=3D BLK_STS_DEV_RESOURCE)
 		blk_mq_request_bypass_insert(rq, false, true);
@@ -2606,14 +2619,15 @@ static void blk_mq_try_issue_directly(struct blk_=
mq_hw_ctx *hctx,
 		blk_mq_end_request(rq, ret);
 }
=20
-static blk_status_t blk_mq_request_issue_directly(struct request *rq, bo=
ol last)
+static blk_status_t blk_mq_request_issue_directly(struct request *rq, bo=
ol last, u64 now)
 {
-	return __blk_mq_try_issue_directly(rq->mq_hctx, rq, true, last);
+	return __blk_mq_try_issue_directly(rq->mq_hctx, rq, true, last, now);
 }
=20
 static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_sc=
hedule)
 {
 	struct blk_mq_hw_ctx *hctx =3D NULL;
+	u64 now =3D ktime_get_ns();
 	struct request *rq;
 	int queued =3D 0;
 	int errors =3D 0;
@@ -2628,7 +2642,7 @@ static void blk_mq_plug_issue_direct(struct blk_plu=
g *plug, bool from_schedule)
 			hctx =3D rq->mq_hctx;
 		}
=20
-		ret =3D blk_mq_request_issue_directly(rq, last);
+		ret =3D blk_mq_request_issue_directly(rq, last, now);
 		switch (ret) {
 		case BLK_STS_OK:
 			queued++;
@@ -2656,9 +2670,14 @@ static void blk_mq_plug_issue_direct(struct blk_pl=
ug *plug, bool from_schedule)
 static void __blk_mq_flush_plug_list(struct request_queue *q,
 				     struct blk_plug *plug)
 {
+	u64 now =3D 0;
+
 	if (blk_queue_quiesced(q))
 		return;
-	q->mq_ops->queue_rqs(&plug->mq_list);
+	if (blk_queue_stat(q))
+		now =3D ktime_get_ns();
+
+	q->mq_ops->queue_rqs(&plug->mq_list, now);
 }
=20
 static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_s=
ched)
@@ -2736,6 +2755,10 @@ void blk_mq_try_issue_list_directly(struct blk_mq_=
hw_ctx *hctx,
 {
 	int queued =3D 0;
 	int errors =3D 0;
+	u64 now =3D 0;
+
+	if (blk_queue_stat(hctx->queue))
+		now =3D ktime_get_ns();
=20
 	while (!list_empty(list)) {
 		blk_status_t ret;
@@ -2743,7 +2766,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_h=
w_ctx *hctx,
 				queuelist);
=20
 		list_del_init(&rq->queuelist);
-		ret =3D blk_mq_request_issue_directly(rq, list_empty(list));
+		ret =3D blk_mq_request_issue_directly(rq, list_empty(list), now);
 		if (ret !=3D BLK_STS_OK) {
 			errors++;
 			if (ret =3D=3D BLK_STS_RESOURCE ||
@@ -2938,6 +2961,7 @@ blk_status_t blk_insert_cloned_request(struct reque=
st *rq)
 	struct request_queue *q =3D rq->q;
 	unsigned int max_sectors =3D blk_queue_get_max_sectors(q, req_op(rq));
 	blk_status_t ret;
+	u64 now =3D 0;
=20
 	if (blk_rq_sectors(rq) > max_sectors) {
 		/*
@@ -2975,6 +2999,8 @@ blk_status_t blk_insert_cloned_request(struct reque=
st *rq)
 	if (blk_crypto_insert_cloned_request(rq))
 		return BLK_STS_IOERR;
=20
+	if (blk_do_io_stat(rq))
+		now =3D ktime_get_ns();
 	blk_account_io_start(rq);
=20
 	/*
@@ -2983,7 +3009,7 @@ blk_status_t blk_insert_cloned_request(struct reque=
st *rq)
 	 * insert.
 	 */
 	blk_mq_run_dispatch_ops(q,
-			ret =3D blk_mq_request_issue_directly(rq, true));
+			ret =3D blk_mq_request_issue_directly(rq, true, now));
 	if (ret)
 		blk_account_io_done(rq, ktime_get_ns());
 	return ret;
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 3f4739d52268..b3b391c56d8b 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -417,7 +417,7 @@ static bool virtblk_add_req_batch(struct virtio_blk_v=
q *vq,
 	return kick;
 }
=20
-static void virtio_queue_rqs(struct request **rqlist)
+static void virtio_queue_rqs(struct request **rqlist, u64 now)
 {
 	struct request *req, *next, *prev =3D NULL;
 	struct request *requeue_list =3D NULL;
@@ -426,6 +426,7 @@ static void virtio_queue_rqs(struct request **rqlist)
 		struct virtio_blk_vq *vq =3D get_virtio_blk_vq(req->mq_hctx);
 		bool kick;
=20
+		req->io_start_time_ns =3D now;
 		if (!virtblk_prep_rq_batch(req)) {
 			rq_list_move(rqlist, &requeue_list, req, prev);
 			req =3D prev;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5b796efa325b..6fc14a3f2980 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -981,7 +981,7 @@ static bool nvme_prep_rq_batch(struct nvme_queue *nvm=
eq, struct request *req)
 	return nvme_prep_rq(nvmeq->dev, req) =3D=3D BLK_STS_OK;
 }
=20
-static void nvme_queue_rqs(struct request **rqlist)
+static void nvme_queue_rqs(struct request **rqlist, u64 now)
 {
 	struct request *req, *next, *prev =3D NULL;
 	struct request *requeue_list =3D NULL;
@@ -989,6 +989,7 @@ static void nvme_queue_rqs(struct request **rqlist)
 	rq_list_for_each_safe(rqlist, req, next) {
 		struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
=20
+		req->io_start_time_ns =3D now;
 		if (!nvme_prep_rq_batch(nvmeq, req)) {
 			/* detach 'req' and add to remainder list */
 			rq_list_move(rqlist, &requeue_list, req, prev);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ba18e9bdb799..071ebd7fd6c9 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -562,7 +562,7 @@ struct blk_mq_ops {
 	 * empty the @rqlist completely, then the rest will be queued
 	 * individually by the block layer upon return.
 	 */
-	void (*queue_rqs)(struct request **rqlist);
+	void (*queue_rqs)(struct request **rqlist, u64 now);
=20
 	/**
 	 * @get_budget: Reserve budget before queue request, once .queue_rq is
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 49373d002631..6bda1414cca0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -599,6 +599,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, s=
truct request_queue *q);
 #define blk_queue_stable_writes(q) \
 	test_bit(QUEUE_FLAG_STABLE_WRITES, &(q)->queue_flags)
 #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_fl=
ags)
+#define blk_queue_stat(q)	test_bit(QUEUE_FLAG_STATS, &(q)->queue_flags)
 #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->qu=
eue_flags)
 #define blk_queue_zone_resetall(q)	\
 	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
@@ -612,6 +613,12 @@ bool blk_queue_flag_test_and_set(unsigned int flag, =
struct request_queue *q);
 #define blk_queue_rq_alloc_time(q)	false
 #endif
=20
+#define blk_queue_need_ts(q)		\
+	(blk_queue_rq_alloc_time(q) ||	\
+	 blk_queue_stat(q) || 		\
+	 blk_queue_io_stat(q) || 	\
+	 q->elevator)
+
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
 			     REQ_FAILFAST_DRIVER))
--=20
2.30.2

