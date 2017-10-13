Return-Path: <linux-block-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.141]:59244 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753672AbdJMDpZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Oct 2017 23:45:25 -0400
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org, axboe@fb.com, hch@lst.de
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 2/2] block/cfq: Fix memory leak without CFQ_GROUP_IOSCHED
Date: Fri, 13 Oct 2017 11:45:07 +0800
Message-Id: <20171013034507.30823-2-jeffy.chen@rock-chips.com>
In-Reply-To: <20171013034507.30823-1-jeffy.chen@rock-chips.com>
References: <20171013034507.30823-1-jeffy.chen@rock-chips.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently we only unref the async cfqqs in cfq_pd_offline, which would
never be called without CONFIG_CFQ_GROUP_IOSCHED enabled.

Kmemleak reported:
unreferenced object 0xffffffc0cd9fc000 (size 240):
  comm "kworker/3:1", pid 52, jiffies 4294673527 (age 97.149s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 80 55 13 cf c0 ff ff ff  .........U......
    10 c0 9f cd c0 ff ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffff9008c6f720>] kmemleak_alloc+0x58/0x8c
    [<ffffff900828f87c>] kmem_cache_alloc+0x184/0x268
    [<ffffff90084ce300>] cfq_get_queue.isra.11+0x144/0x2e0
    [<ffffff90084ce8b0>] cfq_set_request+0x1bc/0x444
    [<ffffff9008495730>] elv_set_request+0x88/0x9c
    [<ffffff900849d690>] get_request+0x494/0x914
    [<ffffff900849de34>] blk_get_request+0xdc/0x160
    [<ffffff90086e8054>] scsi_execute+0x70/0x23c
    [<ffffff90086e8314>] scsi_test_unit_ready+0xf4/0x1ec

Fixes: 60a837077e2b ("cfq-iosched: charge async IOs to the appropriate blkcg's instead of the root")
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2:
Rewrite commit message and rename api.

 block/cfq-iosched.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 9f342ef1ad42..d182e81a07af 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -401,6 +401,7 @@ struct cfq_data {
 
 static struct cfq_group *cfq_get_next_cfqg(struct cfq_data *cfqd);
 static void cfq_put_queue(struct cfq_queue *cfqq);
+static void cfq_put_async_queues(struct cfq_group *cfqg);
 
 static struct cfq_rb_root *st_for(struct cfq_group *cfqg,
 					    enum wl_class_t class,
@@ -1638,17 +1639,8 @@ static void cfq_pd_init(struct blkg_policy_data *pd)
 static void cfq_pd_offline(struct blkg_policy_data *pd)
 {
 	struct cfq_group *cfqg = pd_to_cfqg(pd);
-	int i;
-
-	for (i = 0; i < IOPRIO_BE_NR; i++) {
-		if (cfqg->async_cfqq[0][i])
-			cfq_put_queue(cfqg->async_cfqq[0][i]);
-		if (cfqg->async_cfqq[1][i])
-			cfq_put_queue(cfqg->async_cfqq[1][i]);
-	}
 
-	if (cfqg->async_idle_cfqq)
-		cfq_put_queue(cfqg->async_idle_cfqq);
+	cfq_put_async_queues(cfqg);
 
 	/*
 	 * @blkg is going offline and will be ignored by
@@ -3741,6 +3733,21 @@ static void cfq_init_cfqq(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 	cfqq->pid = pid;
 }
 
+static void cfq_put_async_queues(struct cfq_group *cfqg)
+{
+	int i;
+
+	for (i = 0; i < IOPRIO_BE_NR; i++) {
+		if (cfqg->async_cfqq[0][i])
+			cfq_put_queue(cfqg->async_cfqq[0][i]);
+		if (cfqg->async_cfqq[1][i])
+			cfq_put_queue(cfqg->async_cfqq[1][i]);
+	}
+
+	if (cfqg->async_idle_cfqq)
+		cfq_put_queue(cfqg->async_idle_cfqq);
+}
+
 #ifdef CONFIG_CFQ_GROUP_IOSCHED
 static void check_blkcg_changed(struct cfq_io_cq *cic, struct bio *bio)
 {
@@ -4564,6 +4571,7 @@ static void cfq_exit_queue(struct elevator_queue *e)
 #ifdef CONFIG_CFQ_GROUP_IOSCHED
 	blkcg_deactivate_policy(q, &blkcg_policy_cfq);
 #else
+	cfq_put_async_queues(cfqd->root_group);
 	kfree(cfqd->root_group);
 #endif
 	kfree(cfqd);
-- 
2.11.0
