Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B567DC433E3
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 02:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B4561A4A
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 02:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhCZC3v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 22:29:51 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:43913 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhCZC3c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 22:29:32 -0400
Received: by mail-pj1-f51.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso1009122pjh.2
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 19:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BzWsFa5Wc88vUiCthq0YfkpdZpJxNdXplIDligZF2co=;
        b=mS8tu7Mkq+nyEZqUTyCQcenGsetFpSlMLM8MUrmXhQQFgZxiUgmmRApjX7b8JLFa9J
         Jd1cwDDXnh1b+Np7h9XvIUNV7aKIXXCBxkzkQHucwQE7X7v0C/k8kwE87STPQssX1jlK
         reVCQNFGOjIn/lf+K93/xDLefJPF8HBh1YSXq7esHf5CPTvC8rCLJSjluKQfIByFciRY
         fE2aU4pMzygZJ22SEjRjtLtsv7aM26c2OXKF/6JmhRUUChn1eiLk8fwSoWvuRv4a46kX
         rzhYFsXeUCZrlpIC4Xk+2tUWCOC0RrV0JoQWiVYsxXJSfU7XiYqjwc5VXZLC6lpG83cR
         UyjA==
X-Gm-Message-State: AOAM530da44JvT+QhisOMPcKX4npAzg5HRopW2AxA5cXUP81/uDLPt+B
        /w6XRrnvPuiXxq3OMfp911I=
X-Google-Smtp-Source: ABdhPJx6Iyz36izCYahKN6gizdwa4XjB6z5fqN4RfCwdNJAVeumDEIbbdFDYgfGgbZQnWs95RjZ1Zw==
X-Received: by 2002:a17:902:c394:b029:e7:1029:8de3 with SMTP id g20-20020a170902c394b02900e710298de3mr12675372plg.72.1616725772411;
        Thu, 25 Mar 2021 19:29:32 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:c5af:7b7c:edac:ee67])
        by smtp.gmail.com with ESMTPSA id v18sm7031135pfn.117.2021.03.25.19.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 19:29:31 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3 2/3] blk-mq: Introduce atomic variants of the tag iteration functions
Date:   Thu, 25 Mar 2021 19:29:18 -0700
Message-Id: <20210326022919.19638-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326022919.19638-1-bvanassche@acm.org>
References: <20210326022919.19638-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since in the next patch knowledge is required of whether or not it is
allowed to sleep inside the tag iteration functions, pass this context
information to the tag iteration functions. I have reviewed all callers of
tag iteration functions to verify these annotations by starting from the
output of the following grep command:

    git grep -nHE 'blk_mq_(all_tag|tagset_busy|queue_tag_busy)_iter'

My conclusions from that analysis are as follows:
- The callback functions passed to blk_mq_queue_tag_busy_iter() from the
  block layer core do not sleep except the block driver timeout handler.
- Sleeping is allowed in the blk-mq-debugfs code that iterates over tags.
- Since the blk_mq_tagset_busy_iter() calls in the mtip32xx driver are
  preceded by a function that sleeps (blk_mq_quiesce_queue()), sleeping is
  safe in the context of the blk_mq_tagset_busy_iter() calls.
- The same reasoning also applies to the nbd driver.
- All blk_mq_tagset_busy_iter() calls in the NVMe drivers are followed by a
  call to a function that sleeps so sleeping inside blk_mq_tagset_busy_iter()
  when called from the NVMe driver is fine.
- scsi_host_busy(), scsi_host_complete_all_commands() and
  scsi_host_busy_iter() are used by multiple SCSI LLDs so analyzing whether
  or not these functions may sleep is hard. Instead of performing that
  analysis, make it safe to call these functions from atomic context.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Khazhy Kumykov <khazhy@google.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-tag.c        | 44 ++++++++++++++++++++++++++++++++-------
 block/blk-mq-tag.h        |  4 ++--
 block/blk-mq.c            | 10 ++++-----
 drivers/scsi/hosts.c      | 16 +++++++-------
 drivers/scsi/ufs/ufshcd.c |  4 ++--
 include/linux/blk-mq.h    |  2 ++
 6 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index e5bfecf2940d..975626f755c2 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -322,18 +322,19 @@ static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
 }
 
 /**
- * blk_mq_all_tag_iter - iterate over all requests in a tag map
+ * blk_mq_all_tag_iter_atomic - iterate over all requests in a tag map
  * @tags:	Tag map to iterate over.
  * @fn:		Pointer to the function that will be called for each
  *		request. @fn will be called as follows: @fn(rq, @priv,
  *		reserved) where rq is a pointer to a request. 'reserved'
  *		indicates whether or not @rq is a reserved request. Return
- *		true to continue iterating tags, false to stop.
+ *		true to continue iterating tags, false to stop. Must not
+ *		sleep.
  * @priv:	Will be passed as second argument to @fn.
  *
- * Caller has to pass the tag map from which requests are allocated.
+ * Does not sleep.
  */
-void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
+void blk_mq_all_tag_iter_atomic(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 		void *priv)
 {
 	__blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
@@ -348,6 +349,8 @@ void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
  *		indicates whether or not @rq is a reserved request. Return
  *		true to continue iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
+ *
+ * May sleep.
  */
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv)
@@ -362,6 +365,31 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
+/**
+ * blk_mq_tagset_busy_iter - iterate over all started requests in a tag set
+ * @tagset:	Tag set to iterate over.
+ * @fn:		Pointer to the function that will be called for each started
+ *		request. @fn will be called as follows: @fn(rq, @priv,
+ *		reserved) where rq is a pointer to a request. 'reserved'
+ *		indicates whether or not @rq is a reserved request. Return
+ *		true to continue iterating tags, false to stop. Must not sleep.
+ * @priv:	Will be passed as second argument to @fn.
+ *
+ * Does not sleep.
+ */
+void blk_mq_tagset_busy_iter_atomic(struct blk_mq_tag_set *tagset,
+		busy_tag_iter_fn *fn, void *priv)
+{
+	int i;
+
+	for (i = 0; i < tagset->nr_hw_queues; i++) {
+		if (tagset->tags && tagset->tags[i])
+			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
+					      BT_TAG_ITER_STARTED);
+	}
+}
+EXPORT_SYMBOL(blk_mq_tagset_busy_iter_atomic);
+
 static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
 		void *data, bool reserved)
 {
@@ -384,7 +412,7 @@ void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset)
 	while (true) {
 		unsigned count = 0;
 
-		blk_mq_tagset_busy_iter(tagset,
+		blk_mq_tagset_busy_iter_atomic(tagset,
 				blk_mq_tagset_count_completed_rqs, &count);
 		if (!count)
 			break;
@@ -400,15 +428,17 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
  *		on @q. @fn will be called as follows: @fn(hctx, rq, @priv,
  *		reserved) where rq is a pointer to a request and hctx points
  *		to the hardware queue associated with the request. 'reserved'
- *		indicates whether or not @rq is a reserved request.
+ *		indicates whether or not @rq is a reserved request. Must not
+ *		sleep if @in_atomic_context is %true.
  * @priv:	Will be passed as third argument to @fn.
+ * @in_atomic_context: If true, do not sleep.
  *
  * Note: if @q->tag_set is shared with other request queues then @fn will be
  * called for all requests on all queues that share that tag set and not only
  * for requests associated with @q.
  */
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
-		void *priv)
+		void *priv, bool in_atomic_context)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 7d3e6b333a4a..b01c806e4c2d 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -42,8 +42,8 @@ extern void blk_mq_tag_resize_shared_sbitmap(struct blk_mq_tag_set *set,
 
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
-		void *priv);
-void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
+		void *priv, bool in_atomic_context);
+void blk_mq_all_tag_iter_atomic(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 		void *priv);
 
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d4d7c1caa439..203caa14c51a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -117,7 +117,7 @@ unsigned int blk_mq_in_flight(struct request_queue *q,
 {
 	struct mq_inflight mi = { .part = part };
 
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi, true);
 
 	return mi.inflight[0] + mi.inflight[1];
 }
@@ -127,7 +127,7 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
 {
 	struct mq_inflight mi = { .part = part };
 
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi, true);
 	inflight[0] = mi.inflight[0];
 	inflight[1] = mi.inflight[1];
 }
@@ -868,7 +868,7 @@ bool blk_mq_queue_inflight(struct request_queue *q)
 {
 	bool busy = false;
 
-	blk_mq_queue_tag_busy_iter(q, blk_mq_rq_inflight, &busy);
+	blk_mq_queue_tag_busy_iter(q, blk_mq_rq_inflight, &busy, true);
 	return busy;
 }
 EXPORT_SYMBOL_GPL(blk_mq_queue_inflight);
@@ -973,7 +973,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
 
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next, false);
 
 	if (next != 0) {
 		mod_timer(&q->timeout, next);
@@ -2483,7 +2483,7 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
 		.hctx	= hctx,
 	};
 
-	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
+	blk_mq_all_tag_iter_atomic(tags, blk_mq_has_request, &data);
 	return data.has_rq;
 }
 
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 2f162603876f..f09e1520a241 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -578,8 +578,8 @@ int scsi_host_busy(struct Scsi_Host *shost)
 {
 	int cnt = 0;
 
-	blk_mq_tagset_busy_iter(&shost->tag_set,
-				scsi_host_check_in_flight, &cnt);
+	blk_mq_tagset_busy_iter_atomic(&shost->tag_set,
+				       scsi_host_check_in_flight, &cnt);
 	return cnt;
 }
 EXPORT_SYMBOL(scsi_host_busy);
@@ -677,8 +677,8 @@ static bool complete_all_cmds_iter(struct request *rq, void *data, bool rsvd)
  */
 void scsi_host_complete_all_commands(struct Scsi_Host *shost, int status)
 {
-	blk_mq_tagset_busy_iter(&shost->tag_set, complete_all_cmds_iter,
-				&status);
+	blk_mq_tagset_busy_iter_atomic(&shost->tag_set, complete_all_cmds_iter,
+				       &status);
 }
 EXPORT_SYMBOL_GPL(scsi_host_complete_all_commands);
 
@@ -699,11 +699,11 @@ static bool __scsi_host_busy_iter_fn(struct request *req, void *priv,
 /**
  * scsi_host_busy_iter - Iterate over all busy commands
  * @shost:	Pointer to Scsi_Host.
- * @fn:		Function to call on each busy command
+ * @fn:		Function to call on each busy command. Must not sleep.
  * @priv:	Data pointer passed to @fn
  *
  * If locking against concurrent command completions is required
- * ithas to be provided by the caller
+ * it has to be provided by the caller.
  **/
 void scsi_host_busy_iter(struct Scsi_Host *shost,
 			 bool (*fn)(struct scsi_cmnd *, void *, bool),
@@ -714,7 +714,7 @@ void scsi_host_busy_iter(struct Scsi_Host *shost,
 		.priv = priv,
 	};
 
-	blk_mq_tagset_busy_iter(&shost->tag_set, __scsi_host_busy_iter_fn,
-				&iter_data);
+	blk_mq_tagset_busy_iter_atomic(&shost->tag_set,
+				       __scsi_host_busy_iter_fn, &iter_data);
 }
 EXPORT_SYMBOL_GPL(scsi_host_busy_iter);
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index c86760788c72..6d2f8f18e2a3 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1380,7 +1380,7 @@ static bool ufshcd_any_tag_in_use(struct ufs_hba *hba)
 	struct request_queue *q = hba->cmd_queue;
 	int busy = 0;
 
-	blk_mq_tagset_busy_iter(q->tag_set, ufshcd_is_busy, &busy);
+	blk_mq_tagset_busy_iter_atomic(q->tag_set, ufshcd_is_busy, &busy);
 	return busy;
 }
 
@@ -6269,7 +6269,7 @@ static irqreturn_t ufshcd_tmc_handler(struct ufs_hba *hba)
 		.pending = ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL),
 	};
 
-	blk_mq_tagset_busy_iter(q->tag_set, ufshcd_compl_tm, &ci);
+	blk_mq_tagset_busy_iter_atomic(q->tag_set, ufshcd_compl_tm, &ci);
 	return ci.ncpl ? IRQ_HANDLED : IRQ_NONE;
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2c473c9b8990..dfa0114a49fd 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -526,6 +526,8 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
+void blk_mq_tagset_busy_iter_atomic(struct blk_mq_tag_set *tagset,
+		busy_tag_iter_fn *fn, void *priv);
 void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
