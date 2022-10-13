Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727A5C4332F
	for <linux-block@archiver.kernel.org>; Thu, 13 Oct 2022 09:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJMJo7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Oct 2022 05:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJMJo6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Oct 2022 05:44:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233011D655
        for <linux-block@vger.kernel.org>; Thu, 13 Oct 2022 02:44:54 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mp4J021yFzmVB6;
        Thu, 13 Oct 2022 17:40:16 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 13 Oct
 2022 17:44:51 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC:     <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
        <lengchao@huawei.com>, <ming.lei@redhat.com>, <axboe@kernel.dk>
Subject: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Date:   Thu, 13 Oct 2022 17:44:49 +0800
Message-ID: <20221013094450.5947-2-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20221013094450.5947-1-lengchao@huawei.com>
References: <20221013094450.5947-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drivers that have shared tagsets may need to quiesce potentially a lot
of request queues that all share a single tagset (e.g. nvme). Add an interface
to quiesce all the queues on a given tagset. This interface is useful because
it can speedup the quiesce by doing it in parallel.

For tagsets that have BLK_MQ_F_BLOCKING set, we use call_srcu to all hctxs
in parallel such that all of them wait for the same rcu elapsed period with
a per-hctx heap allocated rcu_synchronize. for tagsets that don't have
BLK_MQ_F_BLOCKING set, we simply call a single synchronize_rcu as this is
sufficient.

Because some queues never need to be quiesced(e.g. nvme connect_q).
So introduce QUEUE_FLAG_NOQUIESCED to tagset quiesce interface to
skip the queue.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 block/blk-mq.c         | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 include/linux/blkdev.h |  2 ++
 3 files changed, 79 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8070b6c10e8d..ebe25da08156 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -29,6 +29,7 @@
 #include <linux/prefetch.h>
 #include <linux/blk-crypto.h>
 #include <linux/part_stat.h>
+#include <linux/rcupdate_wait.h>
 
 #include <trace/events/block.h>
 
@@ -311,6 +312,80 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
+static void blk_mq_quiesce_blocking_tagset(struct blk_mq_tag_set *set)
+{
+	int i = 0;
+	int count = 0;
+	struct request_queue *q;
+	struct rcu_synchronize *rcu;
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		if (blk_queue_noquiesced(q))
+			continue;
+
+		blk_mq_quiesce_queue_nowait(q);
+		count++;
+	}
+
+	rcu = kvmalloc(count * sizeof(*rcu), GFP_KERNEL);
+	if (rcu) {
+		list_for_each_entry(q, &set->tag_list, tag_set_list) {
+			if (blk_queue_noquiesced(q))
+				continue;
+
+			init_rcu_head(&rcu[i].head);
+			init_completion(&rcu[i].completion);
+			call_srcu(q->srcu, &rcu[i].head, wakeme_after_rcu);
+			i++;
+		}
+
+		for (i = 0; i < count; i++) {
+			wait_for_completion(&rcu[i].completion);
+			destroy_rcu_head(&rcu[i].head);
+		}
+		kvfree(rcu);
+	} else {
+		list_for_each_entry(q, &set->tag_list, tag_set_list)
+			synchronize_srcu(q->srcu);
+	}
+}
+
+static void blk_mq_quiesce_nonblocking_tagset(struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		if (blk_queue_noquiesced(q))
+			continue;
+
+		blk_mq_quiesce_queue_nowait(q);
+	}
+	synchronize_rcu();
+}
+
+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
+{
+	mutex_lock(&set->tag_list_lock);
+	if (set->flags & BLK_MQ_F_BLOCKING)
+		blk_mq_quiesce_blocking_tagset(set);
+	else
+		blk_mq_quiesce_nonblocking_tagset(set);
+
+	mutex_unlock(&set->tag_list_lock);
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_tagset);
+
+void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+
+	mutex_lock(&set->tag_list_lock);
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_unquiesce_queue(q);
+	mutex_unlock(&set->tag_list_lock);
+}
+EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
+
 void blk_mq_wake_waiters(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ba18e9bdb799..1df47606d0a7 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -877,6 +877,8 @@ void blk_mq_start_hw_queues(struct request_queue *q);
 void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
 void blk_mq_quiesce_queue(struct request_queue *q);
+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set);
+void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set);
 void blk_mq_wait_quiesce_done(struct request_queue *q);
 void blk_mq_unquiesce_queue(struct request_queue *q);
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50e358a19d98..f15544299a67 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -579,6 +579,7 @@ struct request_queue {
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
 #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
+#define QUEUE_FLAG_NOQUIESCED	31	/* queue is never quiesced */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
 				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
@@ -619,6 +620,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
+#define blk_queue_noquiesced(q)	test_bit(QUEUE_FLAG_NOQUIESCED, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.16.4

