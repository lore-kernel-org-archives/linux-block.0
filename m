Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40201 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763235AbcINOT3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2016 10:19:29 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com, tglx@linutronix.de
Cc: agordeev@redhat.com, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] blk-mq: don't redistribute hardware queues on a CPU hotplug event
Date: Wed, 14 Sep 2016 16:18:52 +0200
Message-Id: <1473862739-15032-7-git-send-email-hch@lst.de>
In-Reply-To: <1473862739-15032-1-git-send-email-hch@lst.de>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently blk-mq will totally remap hardware context when a CPU hotplug
even happened, which causes major havoc for drivers, as they are never
told about this remapping.  E.g. any carefully sorted out CPU affinity
will just be completely messed up.

The rebuild also doesn't really help for the common case of cpu
hotplug, which is soft onlining / offlining of cpus - in this case we
should just leave the queue and irq mapping as is.  If it actually
worked it would have helped in the case of physical cpu hotplug,
although for that we'd need a way to actually notify the driver.
Note that drivers may already be able to accommodate such a topology
change on their own, e.g. using the reset_controller sysfs file in NVMe
will cause the driver to get things right for this case.

With the rebuild removed we will simplify retain the queue mapping for
a soft offlined CPU that will work when it comes back online, and will
map any newly onlined CPU to queue 0 until the driver initiates
a rebuild of the queue map.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 13f5a6c..b29e7b2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2147,8 +2147,6 @@ static void blk_mq_queue_reinit(struct request_queue *q,
 
 	blk_mq_sysfs_unregister(q);
 
-	blk_mq_update_queue_map(q->mq_map, q->nr_hw_queues, online_mask);
-
 	/*
 	 * redo blk_mq_init_cpu_queues and blk_mq_init_hw_queues. FIXME: maybe
 	 * we should change hctx numa_node according to new topology (this
-- 
2.1.4

