Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5580C43219
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 03:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiJTDx7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 23:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJTDxy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 23:53:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458A618D80D
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 20:53:52 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtD9Y3XGRzmV7w;
        Thu, 20 Oct 2022 11:49:05 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 11:53:50 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC:     <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
        <lengchao@huawei.com>, <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <paulmck@kernel.org>
Subject: [PATCH v3 1/2] blk-mq: add tagset quiesce interface
Date:   Thu, 20 Oct 2022 11:53:47 +0800
Message-ID: <20221020035348.10163-2-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20221020035348.10163-1-lengchao@huawei.com>
References: <20221020035348.10163-1-lengchao@huawei.com>
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
of request queues that all share a single tagset (e.g. nvme). Add an
interface to quiesce all the queues on a given tagset. This interface is
useful because it can speedup the quiesce by doing it in parallel.

For tagsets that have BLK_MQ_F_BLOCKING set, we first call
start_poll_synchronize_srcu for all queues of the tagset, and then call
poll_state_synchronize_srcu such that all of them wait for the same srcu
elapsed period. For tagsets that don't have BLK_MQ_F_BLOCKING set,
we simply call a single synchronize_rcu as this is sufficient.

Because some queues should not need to be quiesced(e.g. nvme connect_q)
when quiesce the tagset. So introduce QUEUE_FLAG_SKIP_TAGSET_QUIESCE to
tagset quiesce interface to skip the queue.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 block/blk-mq.c         | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 include/linux/blkdev.h |  3 ++
 3 files changed, 81 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8070b6c10e8d..f064ecda425b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -311,6 +311,82 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
+static void blk_mq_quiesce_blocking_tagset(struct blk_mq_tag_set *set)
+{
+	int i, count = 0;
+	struct request_queue *q;
+	unsigned long *rcu;
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		if (blk_queue_skip_tagset_quiesce(q))
+			continue;
+
+		blk_mq_quiesce_queue_nowait(q);
+		count++;
+	}
+
+	rcu = kvmalloc(count * sizeof(*rcu), GFP_KERNEL);
+	if (rcu) {
+		i = 0;
+		list_for_each_entry(q, &set->tag_list, tag_set_list) {
+			if (blk_queue_skip_tagset_quiesce(q))
+				continue;
+
+			rcu[i++] = start_poll_synchronize_srcu(q->srcu);
+		}
+
+		i = 0;
+		list_for_each_entry(q, &set->tag_list, tag_set_list) {
+			if (blk_queue_skip_tagset_quiesce(q))
+				continue;
+
+			if (!poll_state_synchronize_srcu(q->srcu, rcu[i++]))
+				synchronize_srcu(q->srcu);
+		}
+
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
+		if (blk_queue_skip_tagset_quiesce(q))
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
index 50e358a19d98..efa3fa771dce 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -579,6 +579,7 @@ struct request_queue {
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
 #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
+#define QUEUE_FLAG_SKIP_TAGSET_QUIESCE	31 /* quiesce_tagset skip the queue*/
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
 				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
@@ -619,6 +620,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
+#define blk_queue_skip_tagset_quiesce(q) \
+	test_bit(QUEUE_FLAG_SKIP_TAGSET_QUIESCE, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.16.4

