Return-Path: <SRS0=i0oD=EB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C0AC388F9
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 06:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E930222B9
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 06:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420395AbgJZGl6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Oct 2020 02:41:58 -0400
Received: from mx2.didiglobal.com ([111.202.154.82]:9324 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1420847AbgJZGl6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Oct 2020 02:41:58 -0400
X-ASG-Debug-ID: 1603694510-0e41086da21f39e0004-Cu09wu
Received: from mail.didiglobal.com (bogon [172.20.36.203]) by bsf02.didichuxing.com with ESMTP id qAA3DfzG1roLyNNB; Mon, 26 Oct 2020 14:41:51 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 26 Oct
 2020 14:15:57 +0800
Date:   Mon, 26 Oct 2020 14:15:51 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <snitzer@redhat.com>,
        <mpatocka@redhat.com>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH v4 2/2] blk-mq: break more earlier when interate hctx
Message-ID: <20201026061550.GA24417@192.168.3.9>
X-ASG-Orig-Subj: [PATCH v4 2/2] blk-mq: break more earlier when interate hctx
Mail-Followup-To: axboe@kernel.dk, ming.lei@redhat.com, snitzer@redhat.com,
        mpatocka@redhat.com, linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bogon[172.20.36.203]
X-Barracuda-Start-Time: 1603694511
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 5543
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -1.52
X-Barracuda-Spam-Status: No, SCORE=-1.52 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.85498
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For blk_mq_part_is_in_inflight and blk_mq_queue_inflight they do not
care how many inflight IOs, so they stop interate other hxtc when find
a request meets their requirement. Some cpu cycles can be saved in such
way.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-mq-tag.c     | 11 +++++++++--
 block/blk-mq-tag.h     |  2 +-
 block/blk-mq.c         | 34 +++++++++++++++++++++++++++++-----
 include/linux/blk-mq.h |  1 +
 4 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9c92053e704d..f364682dabe1 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -401,14 +401,17 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
  *		reserved) where rq is a pointer to a request and hctx points
  *		to the hardware queue associated with the request. 'reserved'
  *		indicates whether or not @rq is a reserved request.
- * @priv:	Will be passed as third argument to @fn.
+ *@check_break: Pointer to the function that will callbed for earch hctx on @q.
+ *		@check_break will break the loop for hctx when it return false,
+ *		if you want to iterate all hctx, set it to NULL.
+ * @priv:	Will be passed as third argument to @fn, or arg to @check_break
  *
  * Note: if @q->tag_set is shared with other request queues then @fn will be
  * called for all requests on all queues that share that tag set and not only
  * for requests associated with @q.
  */
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
-		void *priv)
+		check_break_fn *check_break, void *priv)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
@@ -434,7 +437,11 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		if (tags->nr_reserved_tags)
 			bt_for_each(hctx, tags->breserved_tags, fn, priv, true);
 		bt_for_each(hctx, tags->bitmap_tags, fn, priv, false);
+
+		if (check_break && !check_break(priv))
+			goto out;
 	}
+out:
 	blk_queue_exit(q);
 }
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 7d3e6b333a4a..d122be9f87cb 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -42,7 +42,7 @@ extern void blk_mq_tag_resize_shared_sbitmap(struct blk_mq_tag_set *set,
 
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
-		void *priv);
+		check_break_fn *check_break, void *priv);
 void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 		void *priv);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 126a6a6f7035..458ade751b01 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -115,7 +115,7 @@ unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part)
 {
 	struct mq_inflight mi = { .part = part };
 
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, NULL, &mi);
 
 	return mi.inflight[0] + mi.inflight[1];
 }
@@ -125,11 +125,22 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 {
 	struct mq_inflight mi = { .part = part };
 
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, NULL, &mi);
 	inflight[0] = mi.inflight[0];
 	inflight[1] = mi.inflight[1];
 }
 
+static bool blk_mq_part_check_break(void *priv)
+{
+	struct mq_inflight *mi = priv;
+
+	/* return false to stop interate other hctx */
+	if (mi->inflight[0] || mi->inflight[1])
+		return false;
+
+	return true;
+}
+
 static bool blk_mq_part_check_inflight(struct blk_mq_hw_ctx *hctx,
 				  struct request *rq, void *priv,
 				  bool reserved)
@@ -151,7 +162,8 @@ bool blk_mq_part_is_in_flight(struct request_queue *q, struct hd_struct *part)
 
 	mi.inflight[0] = mi.inflight[1] = 0;
 
-	blk_mq_queue_tag_busy_iter(q, blk_mq_part_check_inflight, &mi);
+	blk_mq_queue_tag_busy_iter(q, blk_mq_part_check_inflight,
+					blk_mq_part_check_break, &mi);
 
 	return mi.inflight[0] + mi.inflight[1] > 0;
 }
@@ -909,11 +921,23 @@ static bool blk_mq_rq_inflight(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	return true;
 }
 
+static bool blk_mq_rq_check_break(void *priv)
+{
+	bool *busy = priv;
+
+	/* return false to stop interate other hctx */
+	if (*busy)
+		return false;
+
+	return true;
+}
+
 bool blk_mq_queue_inflight(struct request_queue *q)
 {
 	bool busy = false;
 
-	blk_mq_queue_tag_busy_iter(q, blk_mq_rq_inflight, &busy);
+	blk_mq_queue_tag_busy_iter(q, blk_mq_rq_inflight,
+			blk_mq_rq_check_break, &busy);
 	return busy;
 }
 EXPORT_SYMBOL_GPL(blk_mq_queue_inflight);
@@ -1018,7 +1042,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
 
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, NULL, &next);
 
 	if (next != 0) {
 		mod_timer(&q->timeout, next);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b23eeca4d677..efd1e8269f0b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -280,6 +280,7 @@ struct blk_mq_queue_data {
 typedef bool (busy_iter_fn)(struct blk_mq_hw_ctx *, struct request *, void *,
 		bool);
 typedef bool (busy_tag_iter_fn)(struct request *, void *, bool);
+typedef bool (check_break_fn)(void *);
 
 /**
  * struct blk_mq_ops - Callback functions that implements block driver
-- 
2.18.4

