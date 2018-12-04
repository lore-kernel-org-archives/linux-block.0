Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4794BC04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F9F20672
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="svWp2f/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F9F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbeLDR7M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:59:12 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39008 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeLDR7M (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 12:59:12 -0500
Received: by mail-yb1-f194.google.com with SMTP id w17-v6so7217460ybl.6
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 09:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=GFRyB8WkMSBI/UzgnLSEUSzwykBa1/VmJFQwo6jL5ps=;
        b=svWp2f/DNZnSOduhqoSqjkvStyuP1fTnOaQ3UOKbUDJSbwPjMmJCg5pJkz2vmcBOGo
         O43tabssgDGvukYxVsSQF8lwS2dALF6h6S3z8XtMItkldLgma0sp3AbNYwYN3XOi8c1V
         RciyXu+1DjFd429uSLdc+MmmuiS6TFQ5znT8pjsj8cm8dQkx84pExPFWRYFvDVeVaHdO
         SSE+hO6B39v4770Su8nhcqFCQDGtBoqWKLo8rzzOFVUuzHVx4lFBdo9/1uWi0uRMcC9w
         Rdl+xcroOc3Rg9SB66UHKMW6R1Eg79KKI03hoeQsf2DaGGM6j5WvS/nk0Ua5dZwpg5Aw
         RgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=GFRyB8WkMSBI/UzgnLSEUSzwykBa1/VmJFQwo6jL5ps=;
        b=EsX7qEbh61jbEX0IaTZ5ncCKaAqN8ljFoTlwf/RTCqu6g+tWSmdX+Oy99m4JbMR0bV
         YDct2kxYTOS4GeOzJ1daUZBeRurxdClP2AfklPnkbwmNTI3rdjpB2jjWwM46XFcQahqH
         56S0FnQhymCQZJ6/wQY2NZZA5rPfVjwUYf/gxgKDoqVFTi9xedTefjUqZuXqrA8t0yL6
         gyKaWMB2FGV+98dOQYrcoXBzWWebtol72Fwy/5B+n+SD4t5+vJe1M10CqjCSf47e0uUe
         QUXoQRSjlzqIo1zToVPHbyh8VoU3YQcS3UK7MIrMPS741M6TwIaCIkuFrkZXd6lRrKDL
         30mQ==
X-Gm-Message-State: AA+aEWbmU7mRusoiZQj9oKqPSh5DKBYJmgO6ERhBn4iB0wS88ecCu6pM
        Qro1iyIHUnL6tw3BwEHe7XVBtA==
X-Google-Smtp-Source: AFSGD/VAiCgXAj+RCav6dU+9tRippvnvINtHqIRHT2oJik5oHpflibd3P0JarNGa2IkVjxCXcAQjVQ==
X-Received: by 2002:a25:1043:: with SMTP id 64-v6mr20119581ybq.159.1543946351200;
        Tue, 04 Dec 2018 09:59:11 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d4sm7002555ywe.104.2018.12.04.09.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 09:59:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, axboe@kernel.dk
Subject: [PATCH 1/3] block: add rq_qos_wait to rq_qos
Date:   Tue,  4 Dec 2018 12:59:02 -0500
Message-Id: <20181204175904.8486-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181204175904.8486-1-josef@toxicpanda.com>
References: <20181204175904.8486-1-josef@toxicpanda.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Originally when I split out the common code from blk-wbt into rq_qos I
left the wbt_wait() where it was and simply copied and modified it
slightly to work for io-latency.  However they are both basically the
same thing, and as time has gone on wbt_wait() has ended up much smarter
and kinder than it was when I copied it into io-latency, which means
io-latency has lost out on these improvements.

Since they are the same thing essentially except for a few minor things,
create rq_qos_wait() that replicates what wbt_wait() currently does with
callbacks that can be passed in for the snowflakes to do their own thing
as appropriate.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-rq-qos.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-rq-qos.h |  6 ++++
 2 files changed, 92 insertions(+)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 80f603b76f61..e932ef9d2718 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -176,6 +176,92 @@ void rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle)
 	rq_depth_calc_max_depth(rqd);
 }
 
+struct rq_qos_wait_data {
+	struct wait_queue_entry wq;
+	struct task_struct *task;
+	struct rq_wait *rqw;
+	acquire_inflight_cb_t *cb;
+	void *private_data;
+	bool got_token;
+};
+
+static int rq_qos_wake_function(struct wait_queue_entry *curr,
+				unsigned int mode, int wake_flags, void *key)
+{
+	struct rq_qos_wait_data *data = container_of(curr,
+						     struct rq_qos_wait_data,
+						     wq);
+
+	/*
+	 * If we fail to get a budget, return -1 to interrupt the wake up loop
+	 * in __wake_up_common.
+	 */
+	if (!data->cb(data->rqw, data->private_data))
+		return -1;
+
+	data->got_token = true;
+	list_del_init(&curr->entry);
+	wake_up_process(data->task);
+	return 1;
+}
+
+/**
+ * rq_qos_wait - throttle on a rqw if we need to
+ * @private_data - caller provided specific data
+ * @acquire_inflight_cb - inc the rqw->inflight counter if we can
+ * @cleanup_cb - the callback to cleanup in case we race with a waker
+ *
+ * This provides a uniform place for the rq_qos users to do their throttling.
+ * Since you can end up with a lot of things sleeping at once, this manages the
+ * waking up based on the resources available.  The acquire_inflight_cb should
+ * inc the rqw->inflight if we have the ability to do so, or return false if not
+ * and then we will sleep until the room becomes available.
+ *
+ * cleanup_cb is in case that we race with a waker and need to cleanup the
+ * inflight count accordingly.
+ */
+void rq_qos_wait(struct rq_wait *rqw, void *private_data,
+		 acquire_inflight_cb_t *acquire_inflight_cb,
+		 cleanup_cb_t *cleanup_cb)
+{
+	struct rq_qos_wait_data data = {
+		.wq = {
+			.func	= rq_qos_wake_function,
+			.entry	= LIST_HEAD_INIT(data.wq.entry),
+		},
+		.task = current,
+		.rqw = rqw,
+		.cb = acquire_inflight_cb,
+		.private_data = private_data,
+	};
+	bool has_sleeper;
+
+	has_sleeper = wq_has_sleeper(&rqw->wait);
+	if (!has_sleeper && acquire_inflight_cb(rqw, private_data))
+		return;
+
+	prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);
+	do {
+		if (data.got_token)
+			break;
+		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
+			finish_wait(&rqw->wait, &data.wq);
+
+			/*
+			 * We raced with wbt_wake_function() getting a token,
+			 * which means we now have two. Put our local token
+			 * and wake anyone else potentially waiting for one.
+			 */
+			if (data.got_token)
+				cleanup_cb(rqw, private_data);
+			break;
+		}
+		io_schedule();
+		has_sleeper = false;
+	} while (1);
+	finish_wait(&rqw->wait, &data.wq);
+}
+
 void rq_qos_exit(struct request_queue *q)
 {
 	while (q->rq_qos) {
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 6e09e98b93ea..8678875de420 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -93,6 +93,12 @@ static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
 	}
 }
 
+typedef bool (acquire_inflight_cb_t)(struct rq_wait *rqw, void *private_data);
+typedef void (cleanup_cb_t)(struct rq_wait *rqw, void *private_data);
+
+void rq_qos_wait(struct rq_wait *rqw, void *private_data,
+		 acquire_inflight_cb_t *acquire_inflight_cb,
+		 cleanup_cb_t *cleanup_cb);
 bool rq_wait_inc_below(struct rq_wait *rq_wait, unsigned int limit);
 void rq_depth_scale_up(struct rq_depth *rqd);
 void rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle);
-- 
2.14.3

