Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DC4C43381
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 16:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CEDD64F1C
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 16:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhCRQuD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Mar 2021 12:50:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231648AbhCRQtp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 12:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616086184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iduzOVbp86yy7arPyGbofc+R5X4b5q0A6YTz87JrZjs=;
        b=RMkpJL1sdEIMtktijJ2GTXRFrrwkWvNhJIgOKl0CEFdgmA05PTMW2mVc1cKTXU6P5NmIsL
        WnpxG5ETeG9VaNxQhxhhNP+6LbQBhLB8HU/5vBhz3AnzriQvSpMXsmZc+NjazrN5LivDs2
        mUUW49FLHHp3P0LCYMGadkHKgp0WVGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-kETfDDwPO-WAw8meZalcxQ-1; Thu, 18 Mar 2021 12:49:41 -0400
X-MC-Unique: kETfDDwPO-WAw8meZalcxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1D29100E334;
        Thu, 18 Mar 2021 16:49:13 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E55C519D9B;
        Thu, 18 Mar 2021 16:49:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH V2 01/13] block: add helper of blk_queue_poll
Date:   Fri, 19 Mar 2021 00:48:15 +0800
Message-Id: <20210318164827.1481133-2-ming.lei@redhat.com>
In-Reply-To: <20210318164827.1481133-1-ming.lei@redhat.com>
References: <20210318164827.1481133-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There has been 3 users, and will be more, so add one such helper.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c         | 2 +-
 block/blk-mq.c           | 3 +--
 drivers/nvme/host/core.c | 2 +-
 include/linux/blkdev.h   | 1 +
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fc60ff208497..a31371d55b9d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -836,7 +836,7 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		}
 	}
 
-	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+	if (!blk_queue_poll(q))
 		bio->bi_opf &= ~REQ_HIPRI;
 
 	switch (bio_op(bio)) {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d4d7c1caa439..63c81df3b8b5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3869,8 +3869,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	struct blk_mq_hw_ctx *hctx;
 	long state;
 
-	if (!blk_qc_t_valid(cookie) ||
-	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+	if (!blk_qc_t_valid(cookie) || !blk_queue_poll(q))
 		return 0;
 
 	if (current->plug)
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a5653892d773..1bf94f0d2e8d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -956,7 +956,7 @@ static void nvme_execute_rq_polled(struct request_queue *q,
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
 
-	WARN_ON_ONCE(!test_bit(QUEUE_FLAG_POLL, &q->queue_flags));
+	WARN_ON_ONCE(!blk_queue_poll(q));
 
 	rq->cmd_flags |= REQ_HIPRI;
 	rq->end_io_data = &wait;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bc6bc8383b43..89a01850cf12 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -665,6 +665,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
+#define blk_queue_poll(q)	test_bit(QUEUE_FLAG_POLL, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.29.2

