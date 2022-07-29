Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF62BC00144
	for <linux-block@archiver.kernel.org>; Fri, 29 Jul 2022 07:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbiG2Hjy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jul 2022 03:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbiG2Hjx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 03:39:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE4021E04
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 00:39:51 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LvK9y3ZFzzmVMK;
        Fri, 29 Jul 2022 15:37:58 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Jul
 2022 15:39:49 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC:     <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
        <axboe@kernel.dk>, <lengchao@huawei.com>
Subject: [PATCH 2/3] nvme: improve the quiesce time for non blocking transports
Date:   Fri, 29 Jul 2022 15:39:47 +0800
Message-ID: <20220729073948.32696-3-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20220729073948.32696-1-lengchao@huawei.com>
References: <20220729073948.32696-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When work with nvme multipathing, if one path failed, the requests will
be canceled and retry on another path. Before cancel the requests,
nvme_stop_queues quiesce queues for all namespaces, now quiesce one by
one, if there is a large set of namespaces, it will take long time.
Because every synchronize_rcu may need more than 10 milliseconds,
the total waiting time will be long.
Quiesce all queues in parallel, and it is safe to synchronize_rcu once.
The quiesce time and I/O fail over time can be reduced to one
synchronize_rcu time.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eabffbc708cd..fcfa27e1078a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4924,6 +4924,30 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
 		blk_mq_wait_quiesce_done(ns->queue);
 }
 
+static void nvme_stop_ns_queue_nosync(struct nvme_ns *ns)
+{
+	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
+		blk_mq_quiesce_queue_nowait(ns->queue);
+}
+
+static void nvme_stop_blocking_queues(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		nvme_stop_ns_queue(ns);
+}
+
+static void nvme_stop_nonblocking_queues(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		nvme_stop_ns_queue_nosync(ns);
+
+	synchronize_rcu();
+}
+
 /*
  * Prepare a queue for teardown.
  *
@@ -5017,11 +5041,13 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
-
 	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		nvme_stop_ns_queue(ns);
+
+	if (ctrl->tagset->flags & BLK_MQ_F_BLOCKING)
+		nvme_stop_blocking_queues(ctrl);
+	else
+		nvme_stop_nonblocking_queues(ctrl);
+
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
-- 
2.16.4

