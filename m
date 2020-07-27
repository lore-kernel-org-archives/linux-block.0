Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBA2C433E1
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 03:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF5F206D8
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 03:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgG0Ddw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jul 2020 23:33:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56022 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbgG0Ddv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jul 2020 23:33:51 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B0F86CE653F6DD44F11F;
        Mon, 27 Jul 2020 11:33:47 +0800 (CST)
Received: from [10.27.125.30] (10.27.125.30) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Jul 2020
 11:33:44 +0800
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
To:     Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
CC:     <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>,
        "Keith Busch" <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me> <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <f9ed3baa-2a83-c483-6ba0-70a84d40f569@huawei.com>
Date:   Mon, 27 Jul 2020 11:33:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200727020803.GC1129253@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.27.125.30]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/7/27 10:08, Ming Lei wrote:
>> It is at the end and contains exactly what is needed to synchronize. Not
> The sync is simply single global synchronize_rcu(), and why bother to add
> extra >=40bytes for each hctx.
> 
>> sure what you mean by reuse hctx->srcu?
> You already reuses hctx->srcu, but not see reason to add extra rcu_synchronize
> to each hctx for just simulating one single synchronize_rcu().

To sync srcu together, the extra bytes must be needed, seperate blocking
and non blocking queue to two hctx may be a not good choice.

There is two choice: the struct rcu_synchronize is added in hctx or in srcu.
Though add rcu_synchronize in srcu has a  weakness: the extra bytes is
not need if which do not need batch sync srcu, I still think it's better
for the SRCU to provide the batch synchronization interface.

We can add check ctrl->tagset->flags to provide same interface both for
blocking and non blocking queue. The code for TINY_SRCU:

---
  block/blk-mq.c           | 29 +++++++++++++++++++++++++++++
  drivers/nvme/host/core.c |  9 ++++++++-
  include/linux/blk-mq.h   |  2 ++
  include/linux/srcu.h     |  2 ++
  include/linux/srcutiny.h |  1 +
  kernel/rcu/srcutiny.c    | 16 ++++++++++++++++
  6 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4e0d173beaa3..3117fc3082ff 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -235,6 +235,35 @@ void blk_mq_quiesce_queue(struct request_queue *q)
  }
  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);

+void blk_mq_quiesce_queue_async(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	blk_mq_quiesce_queue_nowait(q);
+
+	queue_for_each_hw_ctx(q, hctx, i)
+		if (hctx->flags & BLK_MQ_F_BLOCKING)
+			synchronize_srcu_async(hctx->srcu);
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
+
+void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	if (q == NULL) {
+		synchronize_rcu();
+		return;
+	}
+
+	queue_for_each_hw_ctx(q, hctx, i)
+		if (hctx->flags & BLK_MQ_F_BLOCKING)
+			synchronize_srcu_async_wait(hctx->srcu);
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
+
  /*
   * blk_mq_unquiesce_queue() - counterpart of blk_mq_quiesce_queue()
   * @q: request queue.
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a3b1157561f5..f13aa447ab64 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4322,7 +4322,14 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)

  	down_read(&ctrl->namespaces_rwsem);
  	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_quiesce_queue(ns->queue);
+		blk_mq_quiesce_queue_async(ns->queue);
+
+	if (ctrl->tagset->flags & BLK_MQ_F_BLOCKING) {
+		list_for_each_entry(ns, &ctrl->namespaces, list)
+			blk_mq_quiesce_queue_async_wait(ns->queue);
+	} else {
+		blk_mq_quiesce_queue_async_wait(NULL);
+	}
  	up_read(&ctrl->namespaces_rwsem);
  }
  EXPORT_SYMBOL_GPL(nvme_stop_queues);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d6fcae17da5a..092470c63558 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -515,6 +515,8 @@ void blk_mq_start_hw_queues(struct request_queue *q);
  void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
  void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
  void blk_mq_quiesce_queue(struct request_queue *q);
+void blk_mq_quiesce_queue_async(struct request_queue *q);
+void blk_mq_quiesce_queue_async_wait(struct request_queue *q);
  void blk_mq_unquiesce_queue(struct request_queue *q);
  void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
  void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index e432cc92c73d..7e006e51ccf9 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -60,6 +60,8 @@ void cleanup_srcu_struct(struct srcu_struct *ssp);
  int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
  void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
  void synchronize_srcu(struct srcu_struct *ssp);
+void synchronize_srcu_async(struct srcu_struct *ssp);
+void synchronize_srcu_async_wait(struct srcu_struct *ssp);

  #ifdef CONFIG_DEBUG_LOCK_ALLOC

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 5a5a1941ca15..3d7d871bef61 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -23,6 +23,7 @@ struct srcu_struct {
  	struct rcu_head *srcu_cb_head;	/* Pending callbacks: Head. */
  	struct rcu_head **srcu_cb_tail;	/* Pending callbacks: Tail. */
  	struct work_struct srcu_work;	/* For driving grace periods. */
+	struct rcu_synchronize rcu_sync;
  #ifdef CONFIG_DEBUG_LOCK_ALLOC
  	struct lockdep_map dep_map;
  #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 6208c1dae5c9..6e1468175a45 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -190,6 +190,22 @@ void synchronize_srcu(struct srcu_struct *ssp)
  }
  EXPORT_SYMBOL_GPL(synchronize_srcu);

+void synchronize_srcu_async(struct srcu_struct *ssp)
+{
+	init_rcu_head(&ssp->rcu_sync.head);
+	init_completion(&ssp->rcu_sync.completion);
+	call_srcu(ssp, &ssp->rcu_sync.head, wakeme_after_rcu_batch);
+
+}
+EXPORT_SYMBOL_GPL(synchronize_srcu_async);
+
+void synchronize_srcu_async_wait(struct srcu_struct *ssp)
+{
+	wait_for_completion(&ssp->rcu_sync.completion);
+	destroy_rcu_head(&ssp->rcu_sync.head);
+}
+EXPORT_SYMBOL_GPL(synchronize_srcu_async_wait);
+
  /* Lockdep diagnostics.  */
  void __init rcu_scheduler_starting(void)
  {
-- 
2.16.4
