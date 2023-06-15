Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5C5EB64DB
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 14:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245753AbjFOOeX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 10:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343925AbjFOOeV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 10:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41416199
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 07:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686839618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NbT70Ripxefh/dyxSh5FIxBtVpQLdaJ3GeiltD+UFes=;
        b=Wq7+zFVkDLw4OcQx9ayklBSNA+xZftlERiVCl4gaPlScxvxDtcU8/RIi3D8ozXPbmsYn5i
        1TZkFfuXv5KNaKXwxtCj0JFkzSoj7xgbz7YTBvoPBC5kdo5RKHBWC5KTbEvE/QPlpB4sMp
        0FFuZ+gIJNUBx9Vx7Nefl4XR0sjeH5w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-Bt5IQZPHMPOxXczjz9gVRQ-1; Thu, 15 Jun 2023 10:33:24 -0400
X-MC-Unique: Bt5IQZPHMPOxXczjz9gVRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E16A21C07846;
        Thu, 15 Jun 2023 14:32:47 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1119DC1603B;
        Thu, 15 Jun 2023 14:32:46 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/4] blk-mq: add API of blk_mq_unfreeze_queue_force
Date:   Thu, 15 Jun 2023 22:32:33 +0800
Message-Id: <20230615143236.297456-2-ming.lei@redhat.com>
In-Reply-To: <20230615143236.297456-1-ming.lei@redhat.com>
References: <20230615143236.297456-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NVMe calls freeze/unfreeze in different contexts, and controller removal
may break in-progress error recovery, then leave queues in frozen state.
So cause IO hang in del_gendisk() because pending writeback IOs are
still waited in bio_queue_enter().

Prepare for fixing this issue by calling the added
blk_mq_unfreeze_queue_force when removing device.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 25 ++++++++++++++++++++++---
 block/blk.h            |  3 ++-
 block/genhd.c          |  2 +-
 include/linux/blk-mq.h |  1 +
 4 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 24dc8fe0a9d2..6ac58dc9e648 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -185,12 +185,16 @@ void blk_mq_freeze_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
 
-void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
+void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic,
+		bool force)
 {
 	mutex_lock(&q->mq_freeze_lock);
 	if (force_atomic)
 		q->q_usage_counter.data->force_atomic = true;
-	q->mq_freeze_depth--;
+	if (force)
+		q->mq_freeze_depth = 0;
+	else
+		q->mq_freeze_depth--;
 	WARN_ON_ONCE(q->mq_freeze_depth < 0);
 	if (!q->mq_freeze_depth) {
 		percpu_ref_resurrect(&q->q_usage_counter);
@@ -201,10 +205,25 @@ void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 
 void blk_mq_unfreeze_queue(struct request_queue *q)
 {
-	__blk_mq_unfreeze_queue(q, false);
+	__blk_mq_unfreeze_queue(q, false, false);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
+/*
+ * Force to unfreeze queue
+ *
+ * Be careful: this API should only be used for avoiding IO hang in
+ * bio_queue_enter() when going to remove disk which needs to drain pending
+ * writeback IO.
+ *
+ * Please don't use it for other cases.
+ */
+void blk_mq_unfreeze_queue_force(struct request_queue *q)
+{
+	__blk_mq_unfreeze_queue(q, false, true);
+}
+EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue_force);
+
 /*
  * FIXME: replace the scsi_internal_device_*block_nowait() calls in the
  * mpt3sas driver such that this function can be removed.
diff --git a/block/blk.h b/block/blk.h
index 768852a84fef..5c9f99051837 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -33,7 +33,8 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
 void blk_freeze_queue(struct request_queue *q);
-void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
+void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic, bool
+		force);
 void blk_queue_start_drain(struct request_queue *q);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
 void submit_bio_noacct_nocheck(struct bio *bio);
diff --git a/block/genhd.c b/block/genhd.c
index f71f82991434..184aa968b453 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -708,7 +708,7 @@ void del_gendisk(struct gendisk *disk)
 	 */
 	if (!test_bit(GD_OWNS_QUEUE, &disk->state)) {
 		blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
-		__blk_mq_unfreeze_queue(q, true);
+		__blk_mq_unfreeze_queue(q, true, false);
 	} else {
 		if (queue_is_mq(q))
 			blk_mq_exit_queue(q);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f401067ac03a..fa265e85d753 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -890,6 +890,7 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
+void blk_mq_unfreeze_queue_force(struct request_queue *q);
 void blk_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
-- 
2.40.1

