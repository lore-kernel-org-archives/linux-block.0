Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E7DC5517A
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 07:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4334221FB
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 07:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AM8hAqyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgKLHzs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Nov 2020 02:55:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725884AbgKLHzr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 02:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605167747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zMa9j1Ic6vfYNhR/+7IRmEKlqAutSm9s2QkmMOInxCQ=;
        b=AM8hAqyq1Yn9tXIHAsAJGZ07995a0mNwWzt1zVAMZFsIJ5+kMOnbOLdmQdqB6iBoxIUuje
        ZMruaElxSnBkepzA6OVOZVGWP+yePoI42a3Zs5/6vKMpFURKwn2dlKTc1vlm7VRZASJdxB
        E4G837Sj/a91pBCmbnaa24x0maKBUZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-YPELfsR9Nr6GGXG1ubt9Qw-1; Thu, 12 Nov 2020 02:55:43 -0500
X-MC-Unique: YPELfsR9Nr6GGXG1ubt9Qw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADCCA190A3E0;
        Thu, 12 Nov 2020 07:55:41 +0000 (UTC)
Received: from localhost (ovpn-12-132.pek2.redhat.com [10.72.12.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECB1F5C62B;
        Thu, 12 Nov 2020 07:55:40 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Qian Cai <cai@redhat.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/3] blk-mq: add new API of blk_mq_hctx_set_fq_lock_class
Date:   Thu, 12 Nov 2020 15:55:24 +0800
Message-Id: <20201112075526.947079-2-ming.lei@redhat.com>
In-Reply-To: <20201112075526.947079-1-ming.lei@redhat.com>
References: <20201112075526.947079-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
index e32958f0b687..657743524e15 100644
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
2.25.4

