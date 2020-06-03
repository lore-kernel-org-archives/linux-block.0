Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6BEC433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 07:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB07C2067B
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 07:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgFCHcj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:32:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40448 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725275AbgFCHci (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Jun 2020 03:32:38 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4089BA4DA8D343110F2D;
        Wed,  3 Jun 2020 15:32:35 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Wed, 3 Jun 2020
 15:32:25 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        Ming Lei <ming.lei@redhat.com>, <linux-block@vger.kernel.org>
CC:     Kate Stewart <kstewart@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, <houtao1@huawei.com>
Subject: [RFC PATCH] blk-mq: provide more tags for woken-up process when tag allocation is busy
Date:   Wed, 3 Jun 2020 15:39:31 +0800
Message-ID: <20200603073931.94435-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.25.0.4.g0ad7144999
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When there are many free-bit waiters, current batch wakeup method will
wake up at most wake_batch processes when wake_batch bits are freed.
The perfect result is each process will get a free bit, however the
real result is that a waken-up process may being unable to get
a free bit and will call io_schedule() multiple times. That's because
other processes (e.g. wake-up before) in the same wake-up batch
may have already allocated multiple free bits.

And the race leads to two problems. The first one is the unnecessary
context switch, because multiple processes are waken up and then
go to sleep afterwards. And the second one is the performance
degradation when there is spatial locality between requests from
one process (e.g. split IO for HDD), because one process can not
allocated requests continuously for the split IOs, and
the sequential IOs will be dispatched separatedly.

To fix the problem, we mimic the way how SQ handles this situation:
1) stash a bulk of free bits
2) wake up a process when a new bit is freed
3) woken-up process consumes the stashed free bits
4) when stashed free bits are exhausted, goto step 1)

Because the tag allocation path or io submit path is much faster than
the tag free path, so when the race for free tags is intensive,
we can ensure:
1) only few processes will be waken up and will exhaust the stashed
   free bits quickly.
2) these processes will be able to allocate multiple requests
   continuously.

An alternative fix is to dynamically adjust the number of woken-up
process according to the number of waiters and busy bits, instead of
using wake_batch each time in __sbq_wake_up(). However it will need
to record the number of busy bits all the time, so use the
stash-wake-use method instead.

The following is the result of a simple fio test:

1. fio (random read, 1MB, libaio, iodepth=1024)

(1) 4TB HDD (max_sectors_kb=256)

IOPS (bs=1MB)
jobs | 4.18-sq  | 5.6.15 | 5.6.15-patched |
1    | 120      | 120    | 119
24   | 120      | 105    | 121
48   | 122      | 102    | 121
72   | 120      | 100    | 119

context switch per second
jobs | 4.18-sq  | 5.6.15 | 5.6.15-patched |
1    | 1058     | 1162   | 1188
24   | 1047     | 1715   | 1105
48   | 1109     | 1967   | 1105
72   | 1084     | 1908   | 1106

(2) 1.8TB SSD (set max_sectors_kb=256)

IOPS (bs=1MB)
jobs | 4.18-sq  | 5.6.15 | 5.6.15-patched |
1    | 1077     | 1075   | 1076
24   | 1079     | 1075   | 1076
48   | 1077     | 1076   | 1076
72   | 1077     | 1076   | 1077

context switch per second
jobs | 4.18-sq  | 5.6.15 | 5.6.15-patched |
1    | 1833     | 5123   | 5264
24   | 2143     | 15238  | 3859
48   | 2182     | 19015  | 3617
72   | 2268     | 19050  | 3662

(3) 1.5TB nvme (set max_sectors_kb=256)

4 read queue, 72 CPU

IOPS (bs=1MB)
jobs | 5.6.15 | 5.6.15-patched |
1    | 3018   | 3018
18   | 3015   | 3016
36   | 3001   | 3005
54   | 2993   | 2997
72   | 2984   | 2990

context switch per second
jobs | 5.6.15 | 5.6.15-patched |
1    | 6292   | 6469
18   | 19428  | 4253
36   | 21290  | 3928
54   | 23060  | 3957
72   | 24221  | 4054

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
Hi,

We found the problems (excessive context switch and few performance
degradation) during the performance comparison between blk-sq (4.18)
and blk-mq (5.16) on HDD, but we can not find a better way to fix it.

It seems that in order to implement batched request allocation for
single process, we need to use an atomic variable to track
the number of busy bits. It's suitable for HDD or SDD, because the
IO latency is greater than 1ms, but no sure whether or not it's OK
for NVMe device.

Suggestions and comments are welcome.

Regards,
Tao
---
 block/blk-mq-tag.c      |  4 ++++
 include/linux/sbitmap.h |  7 ++++++
 lib/sbitmap.c           | 49 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 586c9d6e904a..fd601fa6c684 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -180,6 +180,10 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	sbitmap_finish_wait(bt, ws, &wait);
 
 found_tag:
+	if (READ_ONCE(bt->stash_ready) &&
+	    !atomic_dec_if_positive(&bt->stashed_bits))
+		WRITE_ONCE(bt->stash_ready, false);
+
 	return tag + tag_offset;
 }
 
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index e40d019c3d9d..8f51e8fca0b8 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -129,6 +129,13 @@ struct sbitmap_queue {
 	 */
 	atomic_t ws_active;
 
+	/**
+	 * @stash_ready: whether to use stashed free bit or not
+	 * @stashed_bits: the number of stashed free bits
+	 */
+	bool stash_ready;
+	atomic_t stashed_bits;
+
 	/**
 	 * @round_robin: Allocate bits in strict round-robin order.
 	 */
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index af88d1346dd7..0937e73754e7 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -374,6 +374,8 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 	sbq->wake_batch = sbq_calc_wake_batch(sbq, depth);
 	atomic_set(&sbq->wake_index, 0);
 	atomic_set(&sbq->ws_active, 0);
+	atomic_set(&sbq->stashed_bits, 0);
+	sbq->stash_ready = false;
 
 	sbq->ws = kzalloc_node(SBQ_WAIT_QUEUES * sizeof(*sbq->ws), flags, node);
 	if (!sbq->ws) {
@@ -388,6 +390,7 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 	}
 
 	sbq->round_robin = round_robin;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_init_node);
@@ -549,8 +552,52 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 	return false;
 }
 
+#define SBQ_STASH_RATIO 4
+#define SBQ_MIN_STASH_CNT 16
+#define SBQ_WS_ACTIVE_MIN_BUSY_CNT 4
+
+/*
+ * In order to support batched request allocation for one-process,
+ * we stash stashed_bits free bits first, then wake up a process
+ * when a new bit is freed. When all stashed bits are used,
+ * a new stash-wakeup-use round will be started.
+ */
+static bool sbitmap_queue_do_stash_and_wake_up(struct sbitmap_queue *sbq)
+{
+	unsigned int stash = sbq->sb.depth / SBQ_STASH_RATIO;
+	int ws_active;
+	struct sbq_wait_state *ws;
+
+	if (stash < SBQ_MIN_STASH_CNT)
+		return false;
+
+	ws_active = atomic_read(&sbq->ws_active);
+	if (ws_active < SBQ_WS_ACTIVE_MIN_BUSY_CNT)
+		return false;
+
+	if (!READ_ONCE(sbq->stash_ready)) {
+		/* TODO: need ensure the number of busy bits >= stash */
+		if (atomic_add_unless(&sbq->stashed_bits, 1, stash))
+			return true;
+
+		WRITE_ONCE(sbq->stash_ready, true);
+	}
+
+	ws = sbq_wake_ptr(sbq);
+	if (!ws)
+		return false;
+
+	sbq_index_atomic_inc(&sbq->wake_index);
+	wake_up(&ws->wait);
+
+	return true;
+}
+
 void sbitmap_queue_wake_up(struct sbitmap_queue *sbq)
 {
+	if (sbitmap_queue_do_stash_and_wake_up(sbq))
+		return;
+
 	while (__sbq_wake_up(sbq))
 		;
 }
@@ -624,6 +671,8 @@ void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m)
 	}
 	seq_puts(m, "}\n");
 
+	seq_printf(m, "stash_ready=%d\n", sbq->stash_ready);
+	seq_printf(m, "stashed_bits=%d\n", atomic_read(&sbq->stashed_bits));
 	seq_printf(m, "wake_batch=%u\n", sbq->wake_batch);
 	seq_printf(m, "wake_index=%d\n", atomic_read(&sbq->wake_index));
 	seq_printf(m, "ws_active=%d\n", atomic_read(&sbq->ws_active));
-- 
2.25.0.4.g0ad7144999

