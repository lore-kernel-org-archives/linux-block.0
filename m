Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A14C4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 03:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiJTDxz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 23:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJTDxy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 23:53:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BA618DA82
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 20:53:52 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtD9h6cz4zVhmt;
        Thu, 20 Oct 2022 11:49:12 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 11:53:50 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC:     <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
        <lengchao@huawei.com>, <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <paulmck@kernel.org>
Subject: [PATCH v3 2/2] nvme: use blk_mq_[un]quiesce_tagset
Date:   Thu, 20 Oct 2022 11:53:48 +0800
Message-ID: <20221020035348.10163-3-lengchao@huawei.com>
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

All controller namespaces share the same tagset, so we can use this
interface which does the optimal operation for parallel quiesce based on
the tagset type(e.g. blocking tagsets and non-blocking tagsets).

nvme connect_q should not be quiesced when quiesce tagset, so set the
QUEUE_FLAG_SKIP_TAGSET_QUIESCE to skip it when init connect_q.

Currntely we use NVME_NS_STOPPED to ensure pairing quiescing and
unquiescing. If use blk_mq_[un]quiesce_tagset, NVME_NS_STOPPED will be
invalided, so introduce NVME_CTRL_STOPPED to replace NVME_NS_STOPPED.
In addition, we never really quiesce a single namespace. It is a better
choice to move the flag from ns to ctrl.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c | 57 +++++++++++++++++++-----------------------------
 drivers/nvme/host/nvme.h |  3 ++-
 2 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 059737c1a2c1..c7727d1f228e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4890,6 +4890,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 			ret = PTR_ERR(ctrl->connect_q);
 			goto out_free_tag_set;
 		}
+		blk_queue_flag_set(QUEUE_FLAG_SKIP_TAGSET_QUIESCE, ctrl->connect_q);
 	}
 
 	ctrl->tagset = set;
@@ -5013,6 +5014,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
+	mutex_init(&ctrl->queue_state_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
 	xa_init(&ctrl->cels);
 	init_rwsem(&ctrl->namespaces_rwsem);
@@ -5089,36 +5091,21 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
 
-static void nvme_start_ns_queue(struct nvme_ns *ns)
-{
-	if (test_and_clear_bit(NVME_NS_STOPPED, &ns->flags))
-		blk_mq_unquiesce_queue(ns->queue);
-}
-
-static void nvme_stop_ns_queue(struct nvme_ns *ns)
-{
-	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
-		blk_mq_quiesce_queue(ns->queue);
-	else
-		blk_mq_wait_quiesce_done(ns->queue);
-}
-
 /*
  * Prepare a queue for teardown.
  *
- * This must forcibly unquiesce queues to avoid blocking dispatch, and only set
- * the capacity to 0 after that to avoid blocking dispatchers that may be
- * holding bd_butex.  This will end buffered writers dirtying pages that can't
- * be synced.
+ * The caller should unquiesce the queue to avoid blocking dispatch.
  */
 static void nvme_set_queue_dying(struct nvme_ns *ns)
 {
 	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
 		return;
 
+	/*
+	 * Mark the disk dead to prevent new opens, and set the capacity to 0
+	 * to end buffered writers dirtying pages that can't be synced.
+	 */
 	blk_mark_disk_dead(ns->disk);
-	nvme_start_ns_queue(ns);
-
 	set_capacity_and_notify(ns->disk, 0);
 }
 
@@ -5134,15 +5121,17 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		nvme_set_queue_dying(ns);
+
+	up_read(&ctrl->namespaces_rwsem);
 
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
 		nvme_start_admin_queue(ctrl);
 
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		nvme_set_queue_dying(ns);
-
-	up_read(&ctrl->namespaces_rwsem);
+	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
+		nvme_start_queues(ctrl);
 }
 EXPORT_SYMBOL_GPL(nvme_kill_queues);
 
@@ -5196,23 +5185,23 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
+	mutex_lock(&ctrl->queue_state_lock);
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		nvme_stop_ns_queue(ns);
-	up_read(&ctrl->namespaces_rwsem);
+	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
+		blk_mq_quiesce_tagset(ctrl->tagset);
+
+	mutex_unlock(&ctrl->queue_state_lock);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
 void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
+	mutex_lock(&ctrl->queue_state_lock);
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		nvme_start_ns_queue(ns);
-	up_read(&ctrl->namespaces_rwsem);
+	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
+		blk_mq_unquiesce_tagset(ctrl->tagset);
+
+	mutex_unlock(&ctrl->queue_state_lock);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a29877217ee6..23be055fb425 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -237,6 +237,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_FAILFAST_EXPIRED	= 0,
 	NVME_CTRL_ADMIN_Q_STOPPED	= 1,
 	NVME_CTRL_STARTED_ONCE		= 2,
+	NVME_CTRL_STOPPED		= 3,
 };
 
 struct nvme_ctrl {
@@ -245,6 +246,7 @@ struct nvme_ctrl {
 	bool identified;
 	spinlock_t lock;
 	struct mutex scan_lock;
+	struct mutex queue_state_lock;
 	const struct nvme_ctrl_ops *ops;
 	struct request_queue *admin_q;
 	struct request_queue *connect_q;
@@ -487,7 +489,6 @@ struct nvme_ns {
 #define NVME_NS_ANA_PENDING	2
 #define NVME_NS_FORCE_RO	3
 #define NVME_NS_READY		4
-#define NVME_NS_STOPPED		5
 
 	struct cdev		cdev;
 	struct device		cdev_device;
-- 
2.16.4

