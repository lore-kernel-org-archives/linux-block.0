Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22610C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 23:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6ED661A0F
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 23:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbhCXXOK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 19:14:10 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:42605 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhCXXNu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 19:13:50 -0400
Received: by mail-pg1-f170.google.com with SMTP id f10so8787602pgl.9
        for <linux-block@vger.kernel.org>; Wed, 24 Mar 2021 16:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=BnAzDA6Ev8lM0vzcjuO7rivmPi38B7VXoDMg3Z48j2o=;
        b=fDKLCUqR9gYbvd7Ho8Q28zNWuVtBQAnloFAPJHfzQGQpVQR2MPu3UIMT8io1SVxPbU
         wO3uogAdwyt4nTmoHQ7Azy1jfP7csj1JP+zi7/1333RibV2nKS4vqFuARMUQmPxfU1/n
         5/LjEcB168BA8ehi5ty2S+VpOdBIZ74DkUCmRt/FrAYA6wGMTidYV4XcTWoDPOgdTmww
         cSrBzD7xmFxMghalACV3Q5+5A9a10H65KFRFbUsN4n4dHuUDhx8HCCIPl5Yt5tbZAT6c
         lXAFojeBRMjS/k3G0mN25Irm2txX7hEjA6plX5Ne7VD2nAhuZa4U0M/X0qlIGBMeuQ9m
         s1aw==
X-Gm-Message-State: AOAM532K9wRFZ0VbTZUc82YmpZBM8qbzvj2Bn6TG5+LlXPY83Cg5Aqng
        UXe8uw5TnXqWiE6ZvOEc7sxZaIwijUY=
X-Google-Smtp-Source: ABdhPJxHnhQDe4JFLl2rS2sc7T6b9K8ulCwPTloGHjfySsNcOtYoQ2JKBQXAmd9Q+IJFyHrLkqPTiw==
X-Received: by 2002:a62:8811:0:b029:1ef:2105:3594 with SMTP id l17-20020a6288110000b02901ef21053594mr5422358pfd.70.1616627630049;
        Wed, 24 Mar 2021 16:13:50 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:8b16:a907:fcf6:1a83? ([2601:647:4000:d7:8b16:a907:fcf6:1a83])
        by smtp.gmail.com with ESMTPSA id d20sm3511025pjv.47.2021.03.24.16.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 16:13:48 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2] blk-mq: Fix races between iterating over requests and
 freeing requests
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>
References: <20210324040621.6781-1-bvanassche@acm.org>
 <d1627890-fb10-7ebe-d805-621f925f80e7@suse.de>
Message-ID: <066350f7-e4bb-8598-6e0b-f4d5f85c5009@acm.org>
Date:   Wed, 24 Mar 2021 16:13:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d1627890-fb10-7ebe-d805-621f925f80e7@suse.de>
Content-Type: multipart/mixed;
 boundary="------------799FE0B371FA756BC5AF7B60"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------799FE0B371FA756BC5AF7B60
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 3/24/21 2:27 AM, Hannes Reinecke wrote:
> What I don't particularly like is the global blk_sched_srcu here;
> can't we make it per tagset?

Hi Hannes,

Thanks for having taken a look. I'm concerned about the additional
memory required for one srcu_struct per tag set. Can you take a look at
the attached patches since the approach of these patches does not rely
on SRCU at all?

Thanks,

Bart.

--------------799FE0B371FA756BC5AF7B60
Content-Type: text/x-patch; charset=UTF-8;
 name="v3-0001-blk-mq-Move-the-elevator_exit-definition.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v3-0001-blk-mq-Move-the-elevator_exit-definition.patch"

From da6b1efc51b8ae40fec6f12aeffacdeae7ce2966 Mon Sep 17 00:00:00 2001
From: Bart Van Assche <bvanassche@acm.org>
Date: Wed, 24 Mar 2021 12:00:46 -0700
Subject: [PATCH v3 1/3] blk-mq: Move the elevator_exit() definition

Since elevator_exit() only has one caller, move its definition from
block/blk.h into block/elevator.c. Remove the inline keyword since modern
compilers are smart enough to decide when to inline functions that are in
the same compilation unit.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk.h      | 9 ---------
 block/elevator.c | 8 ++++++++
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 3b53e44b967e..e0a4a7577f6c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -198,15 +198,6 @@ void __elevator_exit(struct request_queue *, struct elevator_queue *);
 int elv_register_queue(struct request_queue *q, bool uevent);
 void elv_unregister_queue(struct request_queue *q);
 
-static inline void elevator_exit(struct request_queue *q,
-		struct elevator_queue *e)
-{
-	lockdep_assert_held(&q->sysfs_lock);
-
-	blk_mq_sched_free_requests(q);
-	__elevator_exit(q, e);
-}
-
 ssize_t part_size_show(struct device *dev, struct device_attribute *attr,
 		char *buf);
 ssize_t part_stat_show(struct device *dev, struct device_attribute *attr,
diff --git a/block/elevator.c b/block/elevator.c
index 293c5c81397a..4b20d1ab29cc 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -197,6 +197,14 @@ void __elevator_exit(struct request_queue *q, struct elevator_queue *e)
 	kobject_put(&e->kobj);
 }
 
+static void elevator_exit(struct request_queue *q, struct elevator_queue *e)
+{
+	lockdep_assert_held(&q->sysfs_lock);
+
+	blk_mq_sched_free_requests(q);
+	__elevator_exit(q, e);
+}
+
 static inline void __elv_rqhash_del(struct request *rq)
 {
 	hash_del(&rq->hash);

--------------799FE0B371FA756BC5AF7B60
Content-Type: text/x-patch; charset=UTF-8;
 name="v3-0002-blk-mq-Introduce-atomic-variants-of-the-tag-itera.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="v3-0002-blk-mq-Introduce-atomic-variants-of-the-tag-itera.pa";
 filename*1="tch"

From 6b1bfc21e55798930aeb3ff6d4834c32f7edfef9 Mon Sep 17 00:00:00 2001
From: Bart Van Assche <bvanassche@acm.org>
Date: Wed, 24 Mar 2021 11:30:25 -0700
Subject: [PATCH v3 2/3] blk-mq: Introduce atomic variants of the tag iteration
 functions

Since in the next patch knowledge is required of whether or not it is
allowed to sleep inside the tag iteration functions, pass this context
information to the tag iteration functions. I have reviewed all callers of
tag iteration functions to verify these annotations by starting from the
output of the following grep command:

    git grep -nHE 'blk_mq_(all_tag|tagset_busy|queue_tag_busy)_iter'

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-tag.c        | 28 ++++++++++++++++++++++------
 block/blk-mq-tag.h        |  4 ++--
 block/blk-mq.c            | 10 +++++-----
 drivers/scsi/hosts.c      | 16 ++++++++--------
 drivers/scsi/ufs/ufshcd.c |  4 ++--
 include/linux/blk-mq.h    |  2 ++
 6 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9c92053e704d..1126aa064ecb 100644
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
  * Caller has to pass the tag map from which requests are allocated.
  */
-void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
+void blk_mq_all_tag_iter_atomic(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 		void *priv)
 {
 	__blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
@@ -362,6 +363,19 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
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
@@ -384,7 +398,7 @@ void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset)
 	while (true) {
 		unsigned count = 0;
 
-		blk_mq_tagset_busy_iter(tagset,
+		blk_mq_tagset_busy_iter_atomic(tagset,
 				blk_mq_tagset_count_completed_rqs, &count);
 		if (!count)
 			break;
@@ -400,15 +414,17 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
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

--------------799FE0B371FA756BC5AF7B60
Content-Type: text/x-patch; charset=UTF-8;
 name="v3-0003-blk-mq-Fix-races-between-iterating-over-requests-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="v3-0003-blk-mq-Fix-races-between-iterating-over-requests-.pa";
 filename*1="tch"

From b88b8eebab80ed923df5c0fdcbea53f1e373576c Mon Sep 17 00:00:00 2001
From: Bart Van Assche <bvanassche@acm.org>
Date: Wed, 24 Mar 2021 11:40:34 -0700
Subject: [PATCH v3 3/3] blk-mq: Fix races between iterating over requests and
 freeing requests

When multiple request queues share a tag set and when switching the I/O
scheduler for one of the request queues associated with that tag set, the
following race can happen:
* blk_mq_tagset_busy_iter() calls bt_tags_iter() and bt_tags_iter() assigns
  a pointer to a scheduler request to the local variable 'rq'.
* blk_mq_sched_free_requests() is called to free hctx->sched_tags.
* blk_mq_tagset_busy_iter() dereferences 'rq' and triggers a use-after-free.

Fix this race as follows:
* Use rcu_assign_pointer() and rcu_dereference() to access hctx->tags->rqs[].
  The performance impact of the assignments added to the hot path is minimal
  (about 1% according to one particular test).
* Protect hctx->tags->rqs[] reads with an RCU read-side lock or with a mutex.
* Wait for all preexisting readers to finish before freeing scheduler
  requests.

Multiple users have reported use-after-free complaints similar to the
following (from https://lore.kernel.org/linux-block/1545261885.185366.488.camel@acm.org/):

BUG: KASAN: use-after-free in bt_iter+0x86/0xf0
Read of size 8 at addr ffff88803b335240 by task fio/21412

CPU: 0 PID: 21412 Comm: fio Tainted: G        W         4.20.0-rc6-dbg+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Call Trace:
 dump_stack+0x86/0xca
 print_address_description+0x71/0x239
 kasan_report.cold.5+0x242/0x301
 __asan_load8+0x54/0x90
 bt_iter+0x86/0xf0
 blk_mq_queue_tag_busy_iter+0x373/0x5e0
 blk_mq_in_flight+0x96/0xb0
 part_in_flight+0x40/0x140
 part_round_stats+0x18e/0x370
 blk_account_io_start+0x3d7/0x670
 blk_mq_bio_to_request+0x19c/0x3a0
 blk_mq_make_request+0x7a9/0xcb0
 generic_make_request+0x41d/0x960
 submit_bio+0x9b/0x250
 do_blockdev_direct_IO+0x435c/0x4c70
 __blockdev_direct_IO+0x79/0x88
 ext4_direct_IO+0x46c/0xc00
 generic_file_direct_write+0x119/0x210
 __generic_file_write_iter+0x11c/0x280
 ext4_file_write_iter+0x1b8/0x6f0
 aio_write+0x204/0x310
 io_submit_one+0x9d3/0xe80
 __x64_sys_io_submit+0x115/0x340
 do_syscall_64+0x71/0x210

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Khazhy Kumykov <khazhy@google.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c       | 32 +++++++++++++++++++++++++++++++-
 block/blk-mq-tag.c     | 39 +++++++++++++++++++++++++++++++++++----
 block/blk-mq-tag.h     |  4 +++-
 block/blk-mq.c         | 23 +++++++++++++++++++----
 block/blk-mq.h         |  1 +
 block/blk.h            |  2 ++
 block/elevator.c       |  1 +
 include/linux/blk-mq.h |  3 +++
 8 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fc60ff208497..108397938c3f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -279,6 +279,34 @@ void blk_dump_rq_flags(struct request *rq, char *msg)
 }
 EXPORT_SYMBOL(blk_dump_rq_flags);
 
+/**
+ * blk_mq_wait_for_tagset_readers - wait for preexisting readers to finish
+ * @set: Tag set to wait on.
+ *
+ * Waits for preexisting readers of hctx->tags->rqs[] to finish. New readers
+ * may start while this function is in progress or after this function has
+ * returned. Use this function to make sure that hctx->tags->rqs[] changes have
+ * become globally visible.
+ */
+void blk_mq_wait_for_tagset_readers(struct blk_mq_tag_set *set)
+{
+	struct blk_mq_tags *tags;
+	int i;
+
+	down_write(&set->iter_rwsem);
+	up_write(&set->iter_rwsem);
+	if (set->tags) {
+		for (i = 0; i < set->nr_hw_queues; i++) {
+			tags = set->tags[i];
+			if (!tags)
+				continue;
+			down_write(&tags->iter_rwsem);
+			up_write(&tags->iter_rwsem);
+		}
+	}
+	synchronize_rcu();
+}
+
 /**
  * blk_sync_queue - cancel any pending callbacks on a queue
  * @q: the queue
@@ -412,8 +440,10 @@ void blk_cleanup_queue(struct request_queue *q)
 	 * it is safe to free requests now.
 	 */
 	mutex_lock(&q->sysfs_lock);
-	if (q->elevator)
+	if (q->elevator) {
+		blk_mq_wait_for_tagset_readers(q->tag_set);
 		blk_mq_sched_free_requests(q);
+	}
 	mutex_unlock(&q->sysfs_lock);
 
 	percpu_ref_exit(&q->q_usage_counter);
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 1126aa064ecb..f47c6138b8f4 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -209,7 +209,8 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 
 	if (!reserved)
 		bitnr += tags->nr_reserved_tags;
-	rq = tags->rqs[bitnr];
+	rq = rcu_dereference_check(tags->rqs[bitnr],
+			!percpu_ref_is_zero(&hctx->queue->q_usage_counter));
 
 	/*
 	 * We can hit rq == NULL here, because the tagging functions
@@ -254,11 +255,17 @@ struct bt_tags_iter_data {
 	unsigned int flags;
 };
 
+/* Include reserved tags. */
 #define BT_TAG_ITER_RESERVED		(1 << 0)
+/* Only include started requests. */
 #define BT_TAG_ITER_STARTED		(1 << 1)
+/* Iterate over tags->static_rqs[] instead of tags->rqs[]. */
 #define BT_TAG_ITER_STATIC_RQS		(1 << 2)
+/* The callback function may sleep. */
+#define BT_TAG_ITER_MAY_SLEEP		(1 << 3)
 
-static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
+static bool __bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr,
+			   void *data)
 {
 	struct bt_tags_iter_data *iter_data = data;
 	struct blk_mq_tags *tags = iter_data->tags;
@@ -275,7 +282,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	if (iter_data->flags & BT_TAG_ITER_STATIC_RQS)
 		rq = tags->static_rqs[bitnr];
 	else
-		rq = tags->rqs[bitnr];
+		rq = rcu_dereference_check(tags->rqs[bitnr], true);
 	if (!rq)
 		return true;
 	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
@@ -284,6 +291,25 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	return iter_data->fn(rq, iter_data->data, reserved);
 }
 
+static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
+{
+	struct bt_tags_iter_data *iter_data = data;
+	struct blk_mq_tags *tags = iter_data->tags;
+	bool res;
+
+	if (iter_data->flags & BT_TAG_ITER_MAY_SLEEP) {
+		down_read(&tags->iter_rwsem);
+		res = __bt_tags_iter(bitmap, bitnr, data);
+		up_read(&tags->iter_rwsem);
+	} else {
+		rcu_read_lock();
+		res = __bt_tags_iter(bitmap, bitnr, data);
+		rcu_read_unlock();
+	}
+
+	return res;
+}
+
 /**
  * bt_tags_for_each - iterate over the requests in a tag map
  * @tags:	Tag map to iterate over.
@@ -355,10 +381,12 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 {
 	int i;
 
+	might_sleep();
+
 	for (i = 0; i < tagset->nr_hw_queues; i++) {
 		if (tagset->tags && tagset->tags[i])
 			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
-					      BT_TAG_ITER_STARTED);
+				BT_TAG_ITER_STARTED | BT_TAG_ITER_MAY_SLEEP);
 	}
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
@@ -540,6 +568,9 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 		kfree(tags);
 		return NULL;
 	}
+
+	init_rwsem(&tags->iter_rwsem);
+
 	return tags;
 }
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index b01c806e4c2d..534377385456 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -17,9 +17,11 @@ struct blk_mq_tags {
 	struct sbitmap_queue __bitmap_tags;
 	struct sbitmap_queue __breserved_tags;
 
-	struct request **rqs;
+	struct request __rcu **rqs;
 	struct request **static_rqs;
 	struct list_head page_list;
+
+	struct rw_semaphore iter_rwsem;
 };
 
 extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 203caa14c51a..338883f3f940 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -495,8 +495,10 @@ static void __blk_mq_free_request(struct request *rq)
 	blk_crypto_free_request(rq);
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx = NULL;
-	if (rq->tag != BLK_MQ_NO_TAG)
+	if (rq->tag != BLK_MQ_NO_TAG) {
 		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
+		rcu_assign_pointer(hctx->tags->rqs[rq->tag], NULL);
+	}
 	if (sched_tag != BLK_MQ_NO_TAG)
 		blk_mq_put_tag(hctx->sched_tags, ctx, sched_tag);
 	blk_mq_sched_restart(hctx);
@@ -838,9 +840,20 @@ EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
 {
+	struct request *rq;
+
 	if (tag < tags->nr_tags) {
-		prefetch(tags->rqs[tag]);
-		return tags->rqs[tag];
+		/*
+		 * Freeing tags happens with the request queue frozen so the
+		 * srcu dereference below is protected by the request queue
+		 * usage count. We can only verify that usage count after
+		 * having read the request pointer.
+		 */
+		rq = rcu_dereference_check(tags->rqs[tag], true);
+		WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && rq &&
+			     percpu_ref_is_zero(&rq->q->q_usage_counter));
+		prefetch(rq);
+		return rq;
 	}
 
 	return NULL;
@@ -1111,7 +1124,7 @@ static bool blk_mq_get_driver_tag(struct request *rq)
 		rq->rq_flags |= RQF_MQ_INFLIGHT;
 		__blk_mq_inc_active_requests(hctx);
 	}
-	hctx->tags->rqs[rq->tag] = rq;
+	rcu_assign_pointer(hctx->tags->rqs[rq->tag], rq);
 	return true;
 }
 
@@ -3481,6 +3494,8 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	mutex_init(&set->tag_list_lock);
 	INIT_LIST_HEAD(&set->tag_list);
 
+	init_rwsem(&set->iter_rwsem);
+
 	return 0;
 
 out_free_mq_rq_maps:
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 3616453ca28c..9ccb1818303b 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -226,6 +226,7 @@ static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 					   struct request *rq)
 {
 	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
+	rcu_assign_pointer(hctx->tags->rqs[rq->tag], NULL);
 	rq->tag = BLK_MQ_NO_TAG;
 
 	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
diff --git a/block/blk.h b/block/blk.h
index e0a4a7577f6c..829d20eb6d89 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -184,6 +184,8 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 void blk_account_io_start(struct request *req);
 void blk_account_io_done(struct request *req, u64 now);
 
+void blk_mq_wait_for_tagset_readers(struct blk_mq_tag_set *set);
+
 /*
  * Internal elevator interface
  */
diff --git a/block/elevator.c b/block/elevator.c
index 4b20d1ab29cc..4f6d7dadc4dd 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -201,6 +201,7 @@ static void elevator_exit(struct request_queue *q, struct elevator_queue *e)
 {
 	lockdep_assert_held(&q->sysfs_lock);
 
+	blk_mq_wait_for_tagset_readers(q->tag_set);
 	blk_mq_sched_free_requests(q);
 	__elevator_exit(q, e);
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index dfa0114a49fd..bac4012ccb2f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -242,6 +242,7 @@ enum hctx_type {
  * @tag_list_lock: Serializes tag_list accesses.
  * @tag_list:	   List of the request queues that use this tag set. See also
  *		   request_queue.tag_set_list.
+ * @iter_rwsem:    Used to wait for tag set iteration functions to finish.
  */
 struct blk_mq_tag_set {
 	struct blk_mq_queue_map	map[HCTX_MAX_TYPES];
@@ -263,6 +264,8 @@ struct blk_mq_tag_set {
 
 	struct mutex		tag_list_lock;
 	struct list_head	tag_list;
+
+	struct rw_semaphore	iter_rwsem;
 };
 
 /**

--------------799FE0B371FA756BC5AF7B60--
