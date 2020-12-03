Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15797C64E7C
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 01:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B877222228
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 01:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgLCB2a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 20:28:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60211 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgLCB2a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 20:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606958823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDimu4Rkgk5+WAwUIHzTdVZRQCclc6B61tJQP9FjUgU=;
        b=BZBrDyE5RiXEAiFe1EisZE5mu3M2Df650f7q4irGxYw96f2TZVf7JF+1FPeEG90PkK4Lf4
        8+3WyMG5lWrsRBuWmp3gCtg3wyly6BmH0ULgAhJn21iWMpJFO+CQPtTtImpwCcvR9KdCkr
        7c4xLK+N2QtqHcRMV3DTjGtU8p5M5Yk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-Y6YzRUrgPPC0NqH5EoFW6w-1; Wed, 02 Dec 2020 20:27:02 -0500
X-MC-Unique: Y6YzRUrgPPC0NqH5EoFW6w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A026D393A6;
        Thu,  3 Dec 2020 01:27:00 +0000 (UTC)
Received: from localhost (ovpn-12-87.pek2.redhat.com [10.72.12.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB9B15D9CA;
        Thu,  3 Dec 2020 01:26:53 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Qian Cai <cai@redhat.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V2 1/3] blk-mq: add new API of blk_mq_hctx_set_fq_lock_class
Date:   Thu,  3 Dec 2020 09:26:36 +0800
Message-Id: <20201203012638.543321-2-ming.lei@redhat.com>
In-Reply-To: <20201203012638.543321-1-ming.lei@redhat.com>
References: <20201203012638.543321-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

flush_end_io() may be called recursively from some driver, such as
nvme-loop, so lockdep may complain 'possible recursive locking'.
Commit b3c6a5997541("block: Fix a lockdep complaint triggered by
request queue flushing") tried to address this issue by assigning
dynamically allocated per-flush-queue lock class. This solution
adds synchronize_rcu() for each hctx's release handler, and causes
horrible SCSI MQ probe delay(more than half an hour on megaraid sas).

Add new API of blk_mq_hctx_set_fq_lock_class() for these drivers, so
we just need to use driver specific lock class for avoiding the
lockdep warning of 'possible recursive locking'.

Tested-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reported-by: Qian Cai <cai@redhat.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c      | 25 +++++++++++++++++++++++++
 include/linux/blk-mq.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 9507dcdd5881..bf51588762d8 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -490,3 +490,28 @@ void blk_free_flush_queue(struct blk_flush_queue *fq)
 	kfree(fq->flush_rq);
 	kfree(fq);
 }
+
+/*
+ * Allow driver to set its own lock class to fq->mq_flush_lock for
+ * avoiding lockdep complaint.
+ *
+ * flush_end_io() may be called recursively from some driver, such as
+ * nvme-loop, so lockdep may complain 'possible recursive locking' because
+ * all 'struct blk_flush_queue' instance share same mq_flush_lock lock class
+ * key. We need to assign different lock class for these driver's
+ * fq->mq_flush_lock for avoiding the lockdep warning.
+ *
+ * Use dynamically allocated lock class key for each 'blk_flush_queue'
+ * instance is over-kill, and more worse it introduces horrible boot delay
+ * issue because synchronize_rcu() is implied in lockdep_unregister_key which
+ * is called for each hctx release. SCSI probing may synchronously create and
+ * destroy lots of MQ request_queues for non-existent devices, and some robot
+ * test kernel always enable lockdep option. It is observed that more than half
+ * an hour is taken during SCSI MQ probe with per-fq lock class.
+ */
+void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
+		struct lock_class_key *key)
+{
+	lockdep_set_class(&hctx->fq->mq_flush_lock, key);
+}
+EXPORT_SYMBOL_GPL(blk_mq_hctx_set_fq_lock_class);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 794b2a33a2c3..5f639240760e 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -5,6 +5,7 @@
 #include <linux/blkdev.h>
 #include <linux/sbitmap.h>
 #include <linux/srcu.h>
+#include <linux/lockdep.h>
 
 struct blk_mq_tags;
 struct blk_flush_queue;
@@ -594,5 +595,7 @@ static inline void blk_mq_cleanup_rq(struct request *rq)
 }
 
 blk_qc_t blk_mq_submit_bio(struct bio *bio);
+void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
+		struct lock_class_key *key);
 
 #endif
-- 
2.28.0

