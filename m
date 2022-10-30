Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E37CFA373D
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 10:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiJ3KHo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 06:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiJ3KHo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 06:07:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6531F2
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4c0WdD1P3xzEWKvGeAJDqWeuPkp65sLTQP2bAdYLIy4=; b=vthMF6oKO3m790sDU7+wMXb/fK
        /+PzWDgFpNdAYP3QFiTAHUKKQXmVwrss0DwK+jLE8iEeQcOiMo0B1Xi4yq+qHsNG7m9KVDQgCVq6B
        SbNArDL6dm5EE6UsAkLQo7aN7pmhA2HFT/pl2zKVI0lCklz9qd1nGFfibLA0mKY2tgEGasTzwjYNg
        iv7iYZi2/PVr+7oFaWLkWFNOh4+/C6nLZTR5dkTCBdCzYTEelBAIwLPFLELdNgdqQkZEAVegY3n2t
        KzJeTW/HBGmY6I2rwrZaqrXhUB6t3gF+Tzwm+5yu7OtNCpspp15LjAJ5GpzZTk1AEUzJhKf1HZUxS
        rMOTC8/g==;
Received: from [2001:4bb8:199:6818:1c2a:5f62:2eb:6092] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op5EE-00F8SJ-DU; Sun, 30 Oct 2022 10:07:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 7/7] block: split elevator_switch
Date:   Sun, 30 Oct 2022 11:07:14 +0100
Message-Id: <20221030100714.876891-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221030100714.876891-1-hch@lst.de>
References: <20221030100714.876891-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split an elevator_disable helper from elevator_switch for the case where
we want to switch to no scheduler at all.  This includes removing the
pointless elevator_switch_mq helper and removing the switch to no
schedule logic from blk_mq_init_sched.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-sched.c |  7 ----
 block/blk-mq.c       |  2 +-
 block/blk.h          |  1 +
 block/elevator.c     | 77 ++++++++++++++++++++++----------------------
 4 files changed, 40 insertions(+), 47 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 68227240fdea3..23d1a90fec427 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -564,13 +564,6 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	unsigned long i;
 	int ret;
 
-	if (!e) {
-		blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
-		q->elevator = NULL;
-		q->nr_requests = q->tag_set->queue_depth;
-		return 0;
-	}
-
 	/*
 	 * Default to double of smaller one between hw queue_depth and 128,
 	 * since we don't split into sync/async like the old code did.
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4cecf281123f6..1ebb2e68ac66f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4556,7 +4556,7 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	__elevator_get(qe->type);
 	qe->type = q->elevator->type;
 	list_add(&qe->node, head);
-	elevator_switch(q, NULL);
+	elevator_disable(q);
 	mutex_unlock(&q->sysfs_lock);
 
 	return true;
diff --git a/block/blk.h b/block/blk.h
index 7f9e089ab1f75..f1398fb96cec9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -278,6 +278,7 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 void blk_insert_flush(struct request *rq);
 
 int elevator_switch(struct request_queue *q, struct elevator_type *new_e);
+void elevator_disable(struct request_queue *q);
 void elevator_exit(struct request_queue *q);
 int elv_register_queue(struct request_queue *q, bool uevent);
 void elv_unregister_queue(struct request_queue *q);
diff --git a/block/elevator.c b/block/elevator.c
index 4042e524333e0..6fdbfca1bc61e 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -548,39 +548,6 @@ void elv_unregister(struct elevator_type *e)
 }
 EXPORT_SYMBOL_GPL(elv_unregister);
 
-static int elevator_switch_mq(struct request_queue *q,
-			      struct elevator_type *new_e)
-{
-	int ret;
-
-	lockdep_assert_held(&q->sysfs_lock);
-
-	if (q->elevator) {
-		elv_unregister_queue(q);
-		elevator_exit(q);
-	}
-
-	ret = blk_mq_init_sched(q, new_e);
-	if (ret)
-		goto out;
-
-	if (new_e) {
-		ret = elv_register_queue(q, true);
-		if (ret) {
-			elevator_exit(q);
-			goto out;
-		}
-	}
-
-	if (new_e)
-		blk_add_trace_msg(q, "elv switch: %s", new_e->elevator_name);
-	else
-		blk_add_trace_msg(q, "elv switch: none");
-
-out:
-	return ret;
-}
-
 static inline bool elv_support_iosched(struct request_queue *q)
 {
 	if (!queue_is_mq(q) ||
@@ -685,19 +652,51 @@ void elevator_init_mq(struct request_queue *q)
  */
 int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 {
-	int err;
+	int ret;
 
 	lockdep_assert_held(&q->sysfs_lock);
 
 	blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
-	err = elevator_switch_mq(q, new_e);
+	if (q->elevator) {
+		elv_unregister_queue(q);
+		elevator_exit(q);
+	}
 
+	ret = blk_mq_init_sched(q, new_e);
+	if (ret)
+		goto out_unfreeze;
+
+	ret = elv_register_queue(q, true);
+	if (ret) {
+		elevator_exit(q);
+		goto out_unfreeze;
+	}
+	blk_add_trace_msg(q, "elv switch: %s", new_e->elevator_name);
+
+out_unfreeze:
 	blk_mq_unquiesce_queue(q);
 	blk_mq_unfreeze_queue(q);
+	return ret;
+}
+
+void elevator_disable(struct request_queue *q)
+{
+	lockdep_assert_held(&q->sysfs_lock);
 
-	return err;
+	blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue(q);
+
+	elv_unregister_queue(q);
+	elevator_exit(q);
+	blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
+	q->elevator = NULL;
+	q->nr_requests = q->tag_set->queue_depth;
+	blk_add_trace_msg(q, "elv switch: none");
+
+	blk_mq_unquiesce_queue(q);
+	blk_mq_unfreeze_queue(q);
 }
 
 /*
@@ -716,9 +715,9 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 	 * Special case for mq, turn off scheduling
 	 */
 	if (!strncmp(elevator_name, "none", 4)) {
-		if (!q->elevator)
-			return 0;
-		return elevator_switch(q, NULL);
+		if (q->elevator)
+			elevator_disable(q);
+		return 0;
 	}
 
 	if (q->elevator && elevator_match(q->elevator->type, elevator_name))
-- 
2.30.2

