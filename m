Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4774EC433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 11:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2834760F5D
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 11:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbhITL20 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 07:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbhITL20 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 07:28:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED88FC061574
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rLJOwjEHSR/J3IAXz3ZjCCEPrwz4qVAr5JIRlaNcMMY=; b=mjAa+a0D+Gqhr0IXXThVrkoMK8
        jZqaUSsx5IfnQGeiNXW/Tt+xhj2NcCPZ6jJlFt5Loh5r/yJt8j2wzQqDrMehWZdNPeYEtItRyStbn
        MSra7ITSN9M2l1rLB+BRVJMcyNFa5ccJV+/6fn7/oo9p+41x5sNMiWWCQULIC1FG0TUae+ZVLyguo
        mz7M0F9v8MHQA/B9J6AyLEnpedmSysyYw6Vip9SaxSpQWs2N/4k2/VW53lW0InB9r+K+64JcR6eDE
        2E5sW/vT1V6ZFddHHGMhaJ0mPjBdQ2Mx2E9haF7tEyZn01LPRUik6z0hHLhlj382q7VTm6fJXbHdV
        XaAOdWZQ==;
Received: from 213-225-6-64.nat.highway.a1.net ([213.225.6.64] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSHR9-002c3r-99; Mon, 20 Sep 2021 11:26:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/4] block: keep q_usage_counter in atomic mode after del_gendisk
Date:   Mon, 20 Sep 2021 13:24:05 +0200
Message-Id: <20210920112405.1299667-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920112405.1299667-1-hch@lst.de>
References: <20210920112405.1299667-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Don't switch back to percpu mode to avoid the double RCU grace period
when tearing down SCSI devices.  After removing the disk only passthrough
commands can be send anyway.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 9 ++++++++-
 block/blk.h    | 1 +
 block/genhd.c  | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 108a352051be5..bc026372de439 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -188,9 +188,11 @@ void blk_mq_freeze_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
 
-void blk_mq_unfreeze_queue(struct request_queue *q)
+void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 {
 	mutex_lock(&q->mq_freeze_lock);
+	if (force_atomic)
+		q->q_usage_counter.data->force_atomic = true;
 	q->mq_freeze_depth--;
 	WARN_ON_ONCE(q->mq_freeze_depth < 0);
 	if (!q->mq_freeze_depth) {
@@ -199,6 +201,11 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 	}
 	mutex_unlock(&q->mq_freeze_lock);
 }
+
+void blk_mq_unfreeze_queue(struct request_queue *q)
+{
+	__blk_mq_unfreeze_queue(q, false);
+}
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
 /*
diff --git a/block/blk.h b/block/blk.h
index e2ed2257709ae..6c3c00a8fe19d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -51,6 +51,7 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
 void blk_freeze_queue(struct request_queue *q);
+void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_queue_start_drain(struct request_queue *q);
 
 #define BIO_INLINE_VECS 4
diff --git a/block/genhd.c b/block/genhd.c
index b3c33495d7208..fe23085ddddd6 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -596,6 +596,7 @@ void del_gendisk(struct gendisk *disk)
 	/*
 	 * Allow using passthrough request again after the queue is torn down.
 	 */
+	blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
 	blk_mq_unfreeze_queue(q);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
-- 
2.30.2

