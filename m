Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE590C4332F
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 15:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiKAPIx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiKAPIe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 11:08:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97ED1EADA
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 08:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VbGBWZhiSpQF0UZ5IwyygVVuVA9A0T3gNpvRoR7aO0A=; b=Jq4Wuo20lSTbsmzyFLTWGOKwGQ
        fRYR4N+VfGeWAv44ZgtoqqFGW9Mre4LUOixpr2l0ui5jKSLGQdtuF0JZ78YUsdcQ+OQDXYLpVtZDA
        wM72mQtqNIzK4dpT5Pb20ayrfiWQq52jxkqeWabjO8NqrvO33ft8O5jsPIeXp+SYF2D/Za/ycki5e
        jVAJiD7UlQ/GiPv5p/GShAg2ze3fTLn9bgo5QpoxZzzto2cEE7aRjlMpXj01dCqM37hmvBBbdz67x
        ebv7oR0/5OedkOdFcXFKsXfUuGhCSYLV/7JgQLg88WMIqSsBDP+EunsV0A04ROO9AOmEQSkXjO5Go
        4uE6taWA==;
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opsli-005gy9-Ov; Tue, 01 Nov 2022 15:01:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 13/14] blk-mq: add tagset quiesce interface
Date:   Tue,  1 Nov 2022 16:00:49 +0100
Message-Id: <20221101150050.3510-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101150050.3510-1-hch@lst.de>
References: <20221101150050.3510-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chao Leng <lengchao@huawei.com>

Drivers that have shared tagsets may need to quiesce potentially a lot
of request queues that all share a single tagset (e.g. nvme). Add an
interface to quiesce all the queues on a given tagset. This interface is
useful because it can speedup the quiesce by doing it in parallel.

Because some queues should not need to be quiesced (e.g. the nvme
connect_q) when quiescing the tagset, introduce a
QUEUE_FLAG_SKIP_TAGSET_QUIESCE flag to allow this new interface to
ski quiescing a particular queue.

Signed-off-by: Chao Leng <lengchao@huawei.com>
[hch: simplify for the per-tag_set srcu_struct]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Chao Leng <lengchao@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq.c         | 27 +++++++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 include/linux/blkdev.h |  3 +++
 3 files changed, 32 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b358328a1dce3..f0dd07bbf4c16 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -315,6 +315,33 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+
+	mutex_lock(&set->tag_list_lock);
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		if (!blk_queue_skip_tagset_quiesce(q))
+			blk_mq_quiesce_queue_nowait(q);
+	}
+	blk_mq_wait_quiesce_done(set);
+	mutex_unlock(&set->tag_list_lock);
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_tagset);
+
+void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+
+	mutex_lock(&set->tag_list_lock);
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		if (!blk_queue_skip_tagset_quiesce(q))
+			blk_mq_unquiesce_queue(q);
+	}
+	mutex_unlock(&set->tag_list_lock);
+}
+EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
+
 void blk_mq_wake_waiters(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 061ea6e7af017..109a0e30c4704 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -881,6 +881,8 @@ void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
 void blk_mq_quiesce_queue(struct request_queue *q);
 void blk_mq_wait_quiesce_done(struct blk_mq_tag_set *set);
+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set);
+void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set);
 void blk_mq_unquiesce_queue(struct request_queue *q);
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6a6fa167fc828..9188aa3f62595 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -571,6 +571,7 @@ struct request_queue {
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
 #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
+#define QUEUE_FLAG_SKIP_TAGSET_QUIESCE	31 /* quiesce_tagset skip the queue*/
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
 				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
@@ -610,6 +611,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
+#define blk_queue_skip_tagset_quiesce(q) \
+	test_bit(QUEUE_FLAG_SKIP_TAGSET_QUIESCE, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.30.2

