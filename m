Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BE7C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C542184C
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cdVHaViv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfCOJGi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:06:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40492 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbfCOJGi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 05:06:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2F8xH1R027925;
        Fri, 15 Mar 2019 09:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=Jp9oYfN+g9q7N3MGFia2Plxo4iGg52/WEXTjkCnOtjo=;
 b=cdVHaVivR5c03QUaKgrbQoGUcG4p9h7KUPCkFYHkcor6kFlo5a6DF0KpBAdmYey6P6cC
 rM22XqUmUMse0qCf+g7W8Y8v7Mucy9X5w2muQWHG4IvRy7AcXZ6ovmstbKdpEuysy6dF
 5QD5uofljtBieaevDRQD/XTtfbOp7M6qIt4rjmT1PHPBDjigcjBJxn6c9gFlrP+armLb
 10mqSWsz3QN7v0K+Mht003nwBjoT8tu9a/+RAuABBvwV1gwFhpRI9yj+IMY+aLxp0aJv
 MatUY3JlC1cnzVsKv7AwvPI/gbcN59pj0JVlsm1YizO0PrE06I2hvNNBb2lsw5YMj8S9 Gg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2r464rwhsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 09:06:18 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2F96H5m005618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 09:06:17 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2F96FrN005261;
        Fri, 15 Mar 2019 09:06:15 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.71.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Mar 2019 09:06:14 +0000
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, sagi@grimberg.me, keith.busch@intel.com,
        jsmart2021@gmail.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] blk-mq: change the method of iterating busy tags of a request_queue
Date:   Fri, 15 Mar 2019 16:57:38 +0800
Message-Id: <1552640264-26101-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9195 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903150067
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

tags->rqs[] will not been cleaned when free driver tag and there
is a window between get driver tag and write tags->rqs[], so we
may see stale rq in tags->rqs[] which may have been freed, as
following case,
blk_mq_get_request         blk_mq_queue_tag_busy_iter
  -> blk_mq_get_tag
                             -> bt_for_each
                               -> bt_iter
                                 -> rq = taags->rqs[]
                                 -> rq->q
  -> blk_mq_rq_ctx_init
    -> data->hctx->tags->rqs[rq->tag] = rq;

To fix this, the blk_mq_queue_tag_busy_iter is changed in this
patch to use tags->static_rqs[] instead of tags->rqs[]. We have
to identify whether there is a io scheduler attached to decide
to use hctx->tags or hctx->sched_tags. And we will try to get a
non-zero q_usage_counter before that, so it is safe to access
them. Add 'inflight' parameter to determine to iterate in-flight
requests or just busy tags. A correction here is that
part_in_flight should count the busy tags instead of rqs that
have got driver tags.

Moreover, get rid of the 'hctx' parameter in iter function as
we could get it from rq->mq_hctx and export this interface for
drivers.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-tag.c     | 76 +++++++++++++++++++++++++++++++++-----------------
 block/blk-mq-tag.h     |  2 --
 block/blk-mq.c         | 31 ++++++++------------
 include/linux/blk-mq.h |  5 ++--
 4 files changed, 64 insertions(+), 50 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index b792537..cdec2cd 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -216,26 +216,38 @@ struct bt_iter_data {
 	busy_iter_fn *fn;
 	void *data;
 	bool reserved;
+	bool inflight;
 };
 
 static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 {
 	struct bt_iter_data *iter_data = data;
 	struct blk_mq_hw_ctx *hctx = iter_data->hctx;
-	struct blk_mq_tags *tags = hctx->tags;
 	bool reserved = iter_data->reserved;
+	struct blk_mq_tags *tags;
 	struct request *rq;
 
+	tags =  hctx->sched_tags ? hctx->sched_tags : hctx->tags;
+
 	if (!reserved)
 		bitnr += tags->nr_reserved_tags;
-	rq = tags->rqs[bitnr];
+	/*
+	 * Because tags->rqs[] will not been cleaned when free driver tag
+	 * and there is a window between get driver tag and write tags->rqs[],
+	 * so we may see stale rq in tags->rqs[] which may have been freed.
+	 * Using static_rqs[] is safer.
+	 */
+	rq = tags->static_rqs[bitnr];
 
 	/*
-	 * We can hit rq == NULL here, because the tagging functions
-	 * test and set the bit before assigning ->rqs[].
+	 * There is a small window between get tag and blk_mq_rq_ctx_init,
+	 * so rq->q and rq->mq_hctx maybe different.
 	 */
-	if (rq && rq->q == hctx->queue)
-		return iter_data->fn(hctx, rq, iter_data->data, reserved);
+	if (rq && rq->q == hctx->queue &&
+	    rq->mq_hctx == hctx &&
+	    (!iter_data->inflight ||
+	     blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT))
+		return iter_data->fn(rq, iter_data->data, reserved);
 	return true;
 }
 
@@ -246,7 +258,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  *		or the bitmap_tags member of struct blk_mq_tags.
  * @fn:		Pointer to the function that will be called for each request
  *		associated with @hctx that has been assigned a driver tag.
- *		@fn will be called as follows: @fn(@hctx, rq, @data, @reserved)
+ *		@fn will be called as follows: @fn(rq, @data, @reserved)
  *		where rq is a pointer to a request. Return true to continue
  *		iterating tags, false to stop.
  * @data:	Will be passed as third argument to @fn.
@@ -254,13 +266,14 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  *		bitmap_tags member of struct blk_mq_tags.
  */
 static void bt_for_each(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
-			busy_iter_fn *fn, void *data, bool reserved)
+			busy_iter_fn *fn, void *data, bool reserved, bool inflight)
 {
 	struct bt_iter_data iter_data = {
 		.hctx = hctx,
 		.fn = fn,
 		.data = data,
 		.reserved = reserved,
+		.inflight = inflight,
 	};
 
 	sbitmap_for_each_set(&bt->sb, bt_iter, &iter_data);
@@ -362,36 +375,33 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
 /**
- * blk_mq_queue_tag_busy_iter - iterate over all requests with a driver tag
+ * blk_mq_queue_tag_busy_iter - iterate over all busy tags
  * @q:		Request queue to examine.
- * @fn:		Pointer to the function that will be called for each request
- *		on @q. @fn will be called as follows: @fn(hctx, rq, @priv,
- *		reserved) where rq is a pointer to a request and hctx points
- *		to the hardware queue associated with the request. 'reserved'
- *		indicates whether or not @rq is a reserved request.
+ * @fn:		Pointer to the function that will be called for each
+ * 		in-flight request issued by @q. @fn will be called as
+ * 		follows:
+ * 		@fn(rq, @priv, reserved)
+ * 		rq is a pointer to a request.'reserved' indicates whether or
+ * 		not @rq is a reserved request.
  * @priv:	Will be passed as third argument to @fn.
- *
- * Note: if @q->tag_set is shared with other request queues then @fn will be
- * called for all requests on all queues that share that tag set and not only
- * for requests associated with @q.
  */
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
-		void *priv)
+		void *priv, bool inflight)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
 	/*
-	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and queue_hw_ctx
-	 * while the queue is frozen. So we can use q_usage_counter to avoid
-	 * racing with it.
+	 * Get a reference of the queue unless it has been zero. We use this
+	 * to avoid the race with the code that would modify the hctxs after
+	 * freeze and drain the queue, including updating nr_hw_queues, io
+	 * scheduler switching and queue clean up.
 	 */
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
-		struct blk_mq_tags *tags = hctx->tags;
-
+		struct blk_mq_tags *tags;
 		/*
 		 * If no software queues are currently mapped to this
 		 * hardware queue, there's nothing to check
@@ -399,12 +409,26 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		if (!blk_mq_hw_queue_mapped(hctx))
 			continue;
 
+		tags =  hctx->sched_tags ? hctx->sched_tags : hctx->tags;
+
 		if (tags->nr_reserved_tags)
-			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
-		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
+			bt_for_each(hctx, &tags->breserved_tags,
+				    fn, priv, true, inflight);
+		bt_for_each(hctx, &tags->bitmap_tags,
+			    fn, priv, false, inflight);
+		/*
+		 * flush_rq represents the rq with REQ_PREFLUSH and REQ_FUA
+		 * (if FUA is not supported by device) to be issued to
+		 * device. So we need to consider it when iterate inflight
+		 * rqs, but needn't to count it when iterate busy tags.
+		 */
+		if (inflight &&
+		    blk_mq_rq_state(hctx->fq->flush_rq) == MQ_RQ_IN_FLIGHT)
+			fn(hctx->fq->flush_rq, priv, false);
 	}
 	blk_queue_exit(q);
 }
+EXPORT_SYMBOL(blk_mq_queue_tag_busy_iter);
 
 static int bt_alloc(struct sbitmap_queue *bt, unsigned int depth,
 		    bool round_robin, int node)
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 61deab0..5af7ff9 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -33,8 +33,6 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_tags **tags,
 					unsigned int depth, bool can_grow);
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
-void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
-		void *priv);
 
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 						 struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 07584a9..9144ec1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -93,8 +93,7 @@ struct mq_inflight {
 	unsigned int *inflight;
 };
 
-static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
-				  struct request *rq, void *priv,
+static bool blk_mq_check_inflight(struct request *rq, void *priv,
 				  bool reserved)
 {
 	struct mq_inflight *mi = priv;
@@ -114,13 +113,12 @@ unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part)
 	struct mq_inflight mi = { .part = part, .inflight = inflight, };
 
 	inflight[0] = inflight[1] = 0;
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi, false);
 
 	return inflight[0];
 }
 
-static bool blk_mq_check_inflight_rw(struct blk_mq_hw_ctx *hctx,
-				     struct request *rq, void *priv,
+static bool blk_mq_check_inflight_rw(struct request *rq, void *priv,
 				     bool reserved)
 {
 	struct mq_inflight *mi = priv;
@@ -137,7 +135,7 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 	struct mq_inflight mi = { .part = part, .inflight = inflight, };
 
 	inflight[0] = inflight[1] = 0;
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight_rw, &mi);
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight_rw, &mi, false);
 }
 
 void blk_freeze_queue_start(struct request_queue *q)
@@ -813,28 +811,22 @@ struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
 }
 EXPORT_SYMBOL(blk_mq_tag_to_rq);
 
-static bool blk_mq_rq_inflight(struct blk_mq_hw_ctx *hctx, struct request *rq,
-			       void *priv, bool reserved)
+static bool blk_mq_rq_inflight(struct request *rq, void *priv, bool reserved)
 {
+	bool *busy = priv;
 	/*
 	 * If we find a request that is inflight and the queue matches,
 	 * we know the queue is busy. Return false to stop the iteration.
 	 */
-	if (rq->state == MQ_RQ_IN_FLIGHT && rq->q == hctx->queue) {
-		bool *busy = priv;
-
-		*busy = true;
-		return false;
-	}
-
-	return true;
+	*busy = true;
+	return false;
 }
 
 bool blk_mq_queue_inflight(struct request_queue *q)
 {
 	bool busy = false;
 
-	blk_mq_queue_tag_busy_iter(q, blk_mq_rq_inflight, &busy);
+	blk_mq_queue_tag_busy_iter(q, blk_mq_rq_inflight, &busy, true);
 	return busy;
 }
 EXPORT_SYMBOL_GPL(blk_mq_queue_inflight);
@@ -874,8 +866,7 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
 	return false;
 }
 
-static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
-		struct request *rq, void *priv, bool reserved)
+static bool blk_mq_check_expired(struct request *rq, void *priv, bool reserved)
 {
 	unsigned long *next = priv;
 
@@ -936,7 +927,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
 
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next, true);
 
 	if (next != 0) {
 		mod_timer(&q->timeout, next);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0e030f5..d6beeb5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -132,8 +132,7 @@ typedef int (init_request_fn)(struct blk_mq_tag_set *set, struct request *,
 typedef void (exit_request_fn)(struct blk_mq_tag_set *set, struct request *,
 		unsigned int);
 
-typedef bool (busy_iter_fn)(struct blk_mq_hw_ctx *, struct request *, void *,
-		bool);
+typedef bool (busy_iter_fn)(struct request *, void *, bool);
 typedef bool (busy_tag_iter_fn)(struct request *, void *, bool);
 typedef int (poll_fn)(struct blk_mq_hw_ctx *);
 typedef int (map_queues_fn)(struct blk_mq_tag_set *set);
@@ -322,6 +321,8 @@ bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
+void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
+		void *priv, bool inflight);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_freeze_queue_start(struct request_queue *q);
-- 
2.7.4

