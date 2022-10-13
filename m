Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DCCC43219
	for <linux-block@archiver.kernel.org>; Thu, 13 Oct 2022 09:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiJMJpB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Oct 2022 05:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJMJo6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Oct 2022 05:44:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890391EAE8
        for <linux-block@vger.kernel.org>; Thu, 13 Oct 2022 02:44:54 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mp4Kc5ZxjzpVdT;
        Thu, 13 Oct 2022 17:41:40 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 13 Oct
 2022 17:44:52 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC:     <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
        <lengchao@huawei.com>, <ming.lei@redhat.com>, <axboe@kernel.dk>
Subject: [PATCH v2 2/2] nvme: use blk_mq_[un]quiesce_tagset
Date:   Thu, 13 Oct 2022 17:44:50 +0800
Message-ID: <20221013094450.5947-3-lengchao@huawei.com>
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

All controller namespaces share the same tagset, so we can use this
interface which does the optimal operation for parallel quiesce based on
the tagset type(e.g. blocking tagsets and non-blocking tagsets).

Now use NVME_NS_STOPPED to ensure pairing quiescing and unquiescing.
If use blk_mq_[un]quiesce_tagset, NVME_NS_STOPPED will be invalided,
so introduce NVME_CTRL_STOPPED to replace NVME_NS_STOPPED.

nvme connect_q should be never quiesced, so set QUEUE_FLAG_NOQUIESCED
when init connect_q.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c | 42 +++++++++++++-----------------------------
 drivers/nvme/host/nvme.h |  2 +-
 2 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 059737c1a2c1..0d07a07e02ff 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4890,6 +4890,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 			ret = PTR_ERR(ctrl->connect_q);
 			goto out_free_tag_set;
 		}
+		blk_queue_flag_set(QUEUE_FLAG_NOQUIESCED, ctrl->connect_q);
 	}
 
 	ctrl->tagset = set;
@@ -5089,20 +5090,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
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
@@ -5111,13 +5098,14 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
  * holding bd_butex.  This will end buffered writers dirtying pages that can't
  * be synced.
  */
-static void nvme_set_queue_dying(struct nvme_ns *ns)
+static void nvme_set_queue_dying(struct nvme_ns *ns, bool start_queue)
 {
 	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
 		return;
 
 	blk_mark_disk_dead(ns->disk);
-	nvme_start_ns_queue(ns);
+	if (start_queue)
+		blk_mq_unquiesce_queue(ns->queue);
 
 	set_capacity_and_notify(ns->disk, 0);
 }
@@ -5132,6 +5120,7 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 void nvme_kill_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	bool start_queue = false;
 
 	down_read(&ctrl->namespaces_rwsem);
 
@@ -5139,8 +5128,11 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
 		nvme_start_admin_queue(ctrl);
 
+	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
+		start_queue = true;
+
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		nvme_set_queue_dying(ns);
+		nvme_set_queue_dying(ns, start_queue);
 
 	up_read(&ctrl->namespaces_rwsem);
 }
@@ -5196,23 +5188,15 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
-
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		nvme_stop_ns_queue(ns);
-	up_read(&ctrl->namespaces_rwsem);
+	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
+		blk_mq_quiesce_tagset(ctrl->tagset);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
 void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
-
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		nvme_start_ns_queue(ns);
-	up_read(&ctrl->namespaces_rwsem);
+	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
+		blk_mq_unquiesce_tagset(ctrl->tagset);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a29877217ee6..8e2f13a1e23a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -237,6 +237,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_FAILFAST_EXPIRED	= 0,
 	NVME_CTRL_ADMIN_Q_STOPPED	= 1,
 	NVME_CTRL_STARTED_ONCE		= 2,
+	NVME_CTRL_STOPPED		= 3,
 };
 
 struct nvme_ctrl {
@@ -487,7 +488,6 @@ struct nvme_ns {
 #define NVME_NS_ANA_PENDING	2
 #define NVME_NS_FORCE_RO	3
 #define NVME_NS_READY		4
-#define NVME_NS_STOPPED		5
 
 	struct cdev		cdev;
 	struct device		cdev_device;
-- 
2.16.4

