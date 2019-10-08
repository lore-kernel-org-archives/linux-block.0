Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4FDC4360C
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 04:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434C5206BB
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 04:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbfJHESp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 00:18:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfJHESp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Oct 2019 00:18:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0769300C22E;
        Tue,  8 Oct 2019 04:18:44 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 913BF5D9C9;
        Tue,  8 Oct 2019 04:18:41 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH V3 2/5] blk-mq: prepare for draining IO when hctx's all CPUs are offline
Date:   Tue,  8 Oct 2019 12:18:18 +0800
Message-Id: <20191008041821.2782-3-ming.lei@redhat.com>
In-Reply-To: <20191008041821.2782-1-ming.lei@redhat.com>
References: <20191008041821.2782-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 08 Oct 2019 04:18:44 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Most of blk-mq drivers depend on managed IRQ's auto-affinity to setup
up queue mapping. Thomas mentioned the following point[1]:

"
 That was the constraint of managed interrupts from the very beginning:

  The driver/subsystem has to quiesce the interrupt line and the associated
  queue _before_ it gets shutdown in CPU unplug and not fiddle with it
  until it's restarted by the core when the CPU is plugged in again.
"

However, current blk-mq implementation doesn't quiesce hw queue before
the last CPU in the hctx is shutdown. Even worse, CPUHP_BLK_MQ_DEAD is
one cpuhp state handled after the CPU is down, so there isn't any chance
to quiesce hctx for blk-mq wrt. CPU hotplug.

Add new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE for blk-mq to stop queues
and wait for completion of in-flight requests.

We will stop hw queue and wait for completion of in-flight requests
when one hctx is becoming dead in the following patch. This way may
cause dead-lock for some stacking blk-mq drivers, such as dm-rq and
loop.

Add blk-mq flag of BLK_MQ_F_NO_MANAGED_IRQ and mark it for dm-rq and
loop, so we needn't to wait for completion of in-flight requests from
dm-rq & loop, then the potential dead-lock can be avoided.

[1] https://lore.kernel.org/linux-block/alpine.DEB.2.21.1904051331270.1802@nanos.tec.linutronix.de/

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c     |  1 +
 block/blk-mq.c             | 13 +++++++++++++
 drivers/block/loop.c       |  2 +-
 drivers/md/dm-rq.c         |  2 +-
 include/linux/blk-mq.h     |  2 ++
 include/linux/cpuhotplug.h |  1 +
 6 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index af40a02c46ee..24fff8c90942 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -240,6 +240,7 @@ static const char *const hctx_flag_name[] = {
 	HCTX_FLAG_NAME(TAG_SHARED),
 	HCTX_FLAG_NAME(BLOCKING),
 	HCTX_FLAG_NAME(NO_SCHED),
+	HCTX_FLAG_NAME(NO_MANAGED_IRQ),
 };
 #undef HCTX_FLAG_NAME
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ec791156e9cc..a664f196782a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2225,6 +2225,11 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	return -ENOMEM;
 }
 
+static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
+{
+	return 0;
+}
+
 /*
  * 'cpu' is going away. splice any existing rq_list entries from this
  * software queue to the hw queue dispatch list, and ensure that it
@@ -2261,6 +2266,9 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 
 static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
 {
+	if (!(hctx->flags & BLK_MQ_F_NO_MANAGED_IRQ))
+		cpuhp_state_remove_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
+						    &hctx->cpuhp_online);
 	cpuhp_state_remove_instance_nocalls(CPUHP_BLK_MQ_DEAD,
 					    &hctx->cpuhp_dead);
 }
@@ -2320,6 +2328,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
 {
 	hctx->queue_num = hctx_idx;
 
+	if (!(hctx->flags & BLK_MQ_F_NO_MANAGED_IRQ))
+		cpuhp_state_add_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
+				&hctx->cpuhp_online);
 	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
 
 	hctx->tags = set->tags[hctx_idx];
@@ -3547,6 +3558,8 @@ static int __init blk_mq_init(void)
 {
 	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
 				blk_mq_hctx_notify_dead);
+	cpuhp_setup_state_multi(CPUHP_AP_BLK_MQ_ONLINE, "block/mq:online",
+				NULL, blk_mq_hctx_notify_online);
 	return 0;
 }
 subsys_initcall(blk_mq_init);
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f6f77eaa7217..751a28a1d4b0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1999,7 +1999,7 @@ static int loop_add(struct loop_device **l, int i)
 	lo->tag_set.queue_depth = 128;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
-	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_MANAGED_IRQ;
 	lo->tag_set.driver_data = lo;
 
 	err = blk_mq_alloc_tag_set(&lo->tag_set);
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 3f8577e2c13b..5f1ff70ac029 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -547,7 +547,7 @@ int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t)
 	md->tag_set->ops = &dm_mq_ops;
 	md->tag_set->queue_depth = dm_get_blk_mq_queue_depth();
 	md->tag_set->numa_node = md->numa_node_id;
-	md->tag_set->flags = BLK_MQ_F_SHOULD_MERGE;
+	md->tag_set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_MANAGED_IRQ;
 	md->tag_set->nr_hw_queues = dm_get_blk_mq_nr_hw_queues();
 	md->tag_set->driver_data = md;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 079c282e4471..a345f2cf920d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -58,6 +58,7 @@ struct blk_mq_hw_ctx {
 
 	atomic_t		nr_active;
 
+	struct hlist_node	cpuhp_online;
 	struct hlist_node	cpuhp_dead;
 	struct kobject		kobj;
 
@@ -226,6 +227,7 @@ struct blk_mq_ops {
 enum {
 	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
 	BLK_MQ_F_TAG_SHARED	= 1 << 1,
+	BLK_MQ_F_NO_MANAGED_IRQ	= 1 << 2,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
 	BLK_MQ_F_NO_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 068793a619ca..bb80f52040cb 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -147,6 +147,7 @@ enum cpuhp_state {
 	CPUHP_AP_SMPBOOT_THREADS,
 	CPUHP_AP_X86_VDSO_VMA_ONLINE,
 	CPUHP_AP_IRQ_AFFINITY_ONLINE,
+	CPUHP_AP_BLK_MQ_ONLINE,
 	CPUHP_AP_ARM_MVEBU_SYNC_CLOCKS,
 	CPUHP_AP_X86_INTEL_EPB_ONLINE,
 	CPUHP_AP_PERF_ONLINE,
-- 
2.20.1

