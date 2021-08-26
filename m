Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E6EC432BE
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 14:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D264660FE6
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 14:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhHZOmC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 10:42:02 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8784 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhHZOmB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 10:42:01 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GwQW83F7YzYsk1;
        Thu, 26 Aug 2021 22:40:36 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 22:41:11 +0800
Received: from thunder-town.china.huawei.com (10.174.178.242) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 22:41:10 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority requests
Date:   Thu, 26 Aug 2021 22:40:39 +0800
Message-ID: <20210826144039.2143-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.242]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

dd_queued() traverses the percpu variable for summation. The more cores,
the higher the performance overhead. I currently have a 128-core board and
this function takes 2.5 us. If the number of high-priority requests is
small and the number of low- and medium-priority requests is large, the
performance impact is significant.

Let's maintain a non-percpu member variable 'nr_queued', which is
incremented by 1 immediately following "inserted++" and decremented by 1
immediately following "completed++". Because both the judgment dd_queued()
in dd_dispatch_request() and operation "inserted++" in dd_insert_request()
are protected by dd->lock, lock protection needs to be added only in
dd_finish_request(), which is unlikely to cause significant performance
side effects.

Tested on my 128-core board with two ssd disks.
fio bs=4k rw=read iodepth=128 cpus_allowed=0-95 <others>
Before:
[183K/0/0 iops]
[172K/0/0 iops]

After:
[258K/0/0 iops]
[258K/0/0 iops]

Fixes: fb926032b320 ("block/mq-deadline: Prioritize high-priority requests")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 block/mq-deadline.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index a09761cbdf12e58..d8f6aa12de80049 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -79,6 +79,7 @@ struct dd_per_prio {
 	struct list_head fifo_list[DD_DIR_COUNT];
 	/* Next request in FIFO order. Read, write or both are NULL. */
 	struct request *next_rq[DD_DIR_COUNT];
+	unsigned int nr_queued;
 };
 
 struct deadline_data {
@@ -277,9 +278,9 @@ deadline_move_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 }
 
 /* Number of requests queued for a given priority level. */
-static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
+static __always_inline u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
 {
-	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
+	return dd->per_prio[prio].nr_queued;
 }
 
 /*
@@ -711,6 +712,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	prio = ioprio_class_to_prio[ioprio_class];
 	dd_count(dd, inserted, prio);
+	per_prio = &dd->per_prio[prio];
+	per_prio->nr_queued++;
 
 	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
 		blk_mq_free_requests(&free);
@@ -719,7 +722,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	trace_block_rq_insert(rq);
 
-	per_prio = &dd->per_prio[prio];
 	if (at_head) {
 		list_add(&rq->queuelist, &per_prio->dispatch);
 	} else {
@@ -790,12 +792,14 @@ static void dd_finish_request(struct request *rq)
 	const u8 ioprio_class = dd_rq_ioclass(rq);
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];
+	unsigned long flags;
 
 	dd_count(dd, completed, prio);
+	spin_lock_irqsave(&dd->lock, flags);
+	per_prio->nr_queued--;
+	spin_unlock_irqrestore(&dd->lock, flags);
 
 	if (blk_queue_is_zoned(q)) {
-		unsigned long flags;
-
 		spin_lock_irqsave(&dd->zone_lock, flags);
 		blk_req_zone_write_unlock(rq);
 		if (!list_empty(&per_prio->fifo_list[DD_WRITE]))
-- 
2.25.1

