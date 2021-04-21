Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B63AC43460
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 00:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE01C61417
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 00:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhDUADV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 20:03:21 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:42927 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbhDUADT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 20:03:19 -0400
Received: by mail-pl1-f174.google.com with SMTP id v13so7002292ple.9
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 17:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O5RU06VCS740SesFX5PqSljZxf/UePUb3diVzKbRFO4=;
        b=F9Xzdaz5akL11s6f0RHSdJkzlDt9iwFu+42ckn1asMbzCDaNusNGyxUWx282LlDOTn
         VLV9qzezYVSeY5TSszzeGX5hoic9d7HnDNn+6oG3tpLHwJqde2B3y/Ik/NdK4P/sGadL
         0Slr+U/51D1qdNPIdmOG5z/hpX/u0tqcFKUnC3hwAXA4QabAgMNU8bi1df+9/NFEU/vs
         lgaxTbyrKyQjOeDAURtK/ir5C3CPCE1jPTevNZR0PIPhpQZzp8VQI1e9oRHrDw2bJufs
         3EfP0PmnE2awtV0Dxa8ufQ64dpOHnXEZH5/zFMHjxancpF2S5Haxev4sd/KwAeifjzrn
         AzlA==
X-Gm-Message-State: AOAM530GrtRgFjejzypg4KDnCSrvboSiJgADqsbIubUoVjIpilRQE53T
        kBjHUIjtJm8D6b2sFKINR8c=
X-Google-Smtp-Source: ABdhPJw9atDlYHfUEMAaktHG8V3U7HLmhaiWBx6RbRdg/NMvgM/4JIu+sDtAJyxoyRyuIRfg3iT8jg==
X-Received: by 2002:a17:902:6b02:b029:e9:8e2:d107 with SMTP id o2-20020a1709026b02b02900e908e2d107mr31486910plk.61.1618963367129;
        Tue, 20 Apr 2021 17:02:47 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:6cb:4566:9005:c2af])
        by smtp.gmail.com with ESMTPSA id 33sm149560pgq.21.2021.04.20.17.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 17:02:46 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v7 3/5] blk-mq: Fix races between iterating over requests and freeing requests
Date:   Tue, 20 Apr 2021 17:02:33 -0700
Message-Id: <20210421000235.2028-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421000235.2028-1-bvanassche@acm.org>
References: <20210421000235.2028-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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
* Protect hctx->tags->rqs[] reads with an RCU read-side lock or with a
  semaphore. Which mechanism is used depends on whether or not it is allowed
  to sleep and also on whether or not the callback function may sleep.
* Wait for all preexisting readers to finish before freeing scheduler
  requests.

Another race is as follows:
* blk_mq_sched_free_requests() is called to free hctx->sched_tags.
* blk_mq_queue_tag_busy_iter() iterates over the same tag set but for another
  request queue than the queue for which scheduler tags are being freed.
* bt_iter() examines rq->q after *rq has been freed.

Fix this race by protecting the rq->q read in bt_iter() with an RCU read
lock and by calling synchronize_rcu() before freeing scheduler tags.

Multiple users have reported use-after-free complaints similar to the
following (from https://lore.kernel.org/linux-block/1545261885.185366.488.camel@acm.org/ ):

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

Reviewed-by: Khazhismel Kumykov <khazhy@google.com>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Khazhy Kumykov <khazhy@google.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c   | 34 ++++++++++++++++++++++++++++++-
 block/blk-mq-tag.c | 51 ++++++++++++++++++++++++++++++++++++++++------
 block/blk-mq-tag.h |  4 +++-
 block/blk-mq.c     | 21 +++++++++++++++----
 block/blk-mq.h     |  1 +
 block/blk.h        |  2 ++
 block/elevator.c   |  1 +
 7 files changed, 102 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9bcdae93f6d4..ca7f833e25a8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -279,6 +279,36 @@ void blk_dump_rq_flags(struct request *rq, char *msg)
 }
 EXPORT_SYMBOL(blk_dump_rq_flags);
 
+/**
+ * blk_mq_wait_for_tag_iter - wait for preexisting tag iteration functions to finish
+ * @set: Tag set to wait on.
+ *
+ * Waits for preexisting calls of blk_mq_all_tag_iter(),
+ * blk_mq_tagset_busy_iter() and also for their atomic variants to finish
+ * accessing hctx->tags->rqs[]. New readers may start while this function is
+ * in progress or after this function has returned. Use this function to make
+ * sure that hctx->tags->rqs[] changes have become globally visible.
+ *
+ * Waits for preexisting blk_mq_queue_tag_busy_iter(q, fn, priv) calls to
+ * finish accessing requests associated with other request queues than 'q'.
+ */
+void blk_mq_wait_for_tag_iter(struct blk_mq_tag_set *set)
+{
+	struct blk_mq_tags *tags;
+	int i;
+
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
@@ -412,8 +442,10 @@ void blk_cleanup_queue(struct request_queue *q)
 	 * it is safe to free requests now.
 	 */
 	mutex_lock(&q->sysfs_lock);
-	if (q->elevator)
+	if (q->elevator) {
+		blk_mq_wait_for_tag_iter(q->tag_set);
 		blk_mq_sched_free_requests(q);
+	}
 	mutex_unlock(&q->sysfs_lock);
 
 	percpu_ref_exit(&q->q_usage_counter);
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index d8eaa38a1bd1..39d5c9190a6b 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -209,14 +209,24 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 
 	if (!reserved)
 		bitnr += tags->nr_reserved_tags;
-	rq = tags->rqs[bitnr];
-
+	rcu_read_lock();
+	/*
+	 * The request 'rq' points at is protected by an RCU read lock until
+	 * its queue pointer has been verified and by q_usage_count while the
+	 * callback function is being invoked. See also the
+	 * percpu_ref_tryget() and blk_queue_exit() calls in
+	 * blk_mq_queue_tag_busy_iter().
+	 */
+	rq = rcu_dereference(tags->rqs[bitnr]);
 	/*
 	 * We can hit rq == NULL here, because the tagging functions
 	 * test and set the bit before assigning ->rqs[].
 	 */
-	if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
+	if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx) {
+		rcu_read_unlock();
 		return iter_data->fn(hctx, rq, iter_data->data, reserved);
+	}
+	rcu_read_unlock();
 	return true;
 }
 
@@ -254,11 +264,17 @@ struct bt_tags_iter_data {
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
@@ -275,7 +291,8 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	if (iter_data->flags & BT_TAG_ITER_STATIC_RQS)
 		rq = tags->static_rqs[bitnr];
 	else
-		rq = tags->rqs[bitnr];
+		rq = rcu_dereference_check(tags->rqs[bitnr],
+					   lockdep_is_held(&tags->iter_rwsem));
 	if (!rq)
 		return true;
 	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
@@ -284,6 +301,25 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
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
@@ -357,10 +393,12 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
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
@@ -544,6 +582,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
+	init_rwsem(&tags->iter_rwsem);
 
 	if (blk_mq_is_sbitmap_shared(flags))
 		return tags;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 0290c308ece9..d1d73d7cc7df 100644
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
index 79c01b1f885c..8b59f6b4ec8e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -496,8 +496,10 @@ static void __blk_mq_free_request(struct request *rq)
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
@@ -839,9 +841,20 @@ EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
 {
+	struct request *rq;
+
 	if (tag < tags->nr_tags) {
-		prefetch(tags->rqs[tag]);
-		return tags->rqs[tag];
+		/*
+		 * Freeing tags happens with the request queue frozen so the
+		 * rcu dereference below is protected by the request queue
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
@@ -1112,7 +1125,7 @@ static bool blk_mq_get_driver_tag(struct request *rq)
 		rq->rq_flags |= RQF_MQ_INFLIGHT;
 		__blk_mq_inc_active_requests(hctx);
 	}
-	hctx->tags->rqs[rq->tag] = rq;
+	rcu_assign_pointer(hctx->tags->rqs[rq->tag], rq);
 	return true;
 }
 
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
index 529233957207..d88b0823738c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -185,6 +185,8 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 void blk_account_io_start(struct request *req);
 void blk_account_io_done(struct request *req, u64 now);
 
+void blk_mq_wait_for_tag_iter(struct blk_mq_tag_set *set);
+
 /*
  * Internal elevator interface
  */
diff --git a/block/elevator.c b/block/elevator.c
index 7c486ce858e0..aae9cff6d5ae 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -201,6 +201,7 @@ static void elevator_exit(struct request_queue *q, struct elevator_queue *e)
 {
 	lockdep_assert_held(&q->sysfs_lock);
 
+	blk_mq_wait_for_tag_iter(q->tag_set);
 	blk_mq_sched_free_requests(q);
 	__elevator_exit(q, e);
 }
