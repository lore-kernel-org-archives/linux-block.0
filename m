Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156BBC19F2B
	for <linux-block@archiver.kernel.org>; Fri, 29 Jul 2022 07:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbiG2HkE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jul 2022 03:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiG2HkC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 03:40:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F28281B24
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 00:39:57 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LvK9y6vL1zmV9X;
        Fri, 29 Jul 2022 15:37:58 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Jul
 2022 15:39:50 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC:     <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
        <axboe@kernel.dk>, <lengchao@huawei.com>
Subject: [PATCH 3/3] nvme: improve the quiesce time for blocking transports
Date:   Fri, 29 Jul 2022 15:39:48 +0800
Message-ID: <20220729073948.32696-4-lengchao@huawei.com>
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
Because every synchronize_srcu may need more than 10 milliseconds,
the total waiting time will be long.
Quiesce all queues in parallel and start syncing for srcus of all
queues, and then wait for all srcus to complete synchronization.
The quiesce time and I/O fail over time can be largely reduced.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fcfa27e1078a..937d5802d41b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -21,6 +21,7 @@
 #include <linux/nvme_ioctl.h>
 #include <linux/pm_qos.h>
 #include <asm/unaligned.h>
+#include <linux/rcupdate_wait.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -4916,14 +4917,6 @@ static void nvme_start_ns_queue(struct nvme_ns *ns)
 		blk_mq_unquiesce_queue(ns->queue);
 }
 
-static void nvme_stop_ns_queue(struct nvme_ns *ns)
-{
-	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
-		blk_mq_quiesce_queue(ns->queue);
-	else
-		blk_mq_wait_quiesce_done(ns->queue);
-}
-
 static void nvme_stop_ns_queue_nosync(struct nvme_ns *ns)
 {
 	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
@@ -4933,9 +4926,34 @@ static void nvme_stop_ns_queue_nosync(struct nvme_ns *ns)
 static void nvme_stop_blocking_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int i, count;
+	struct rcu_synchronize *rcu;
 
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		nvme_stop_ns_queue(ns);
+	count = 0;
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		nvme_stop_ns_queue_nosync(ns);
+		count++;
+	}
+
+	rcu = kvmalloc(count * sizeof(*rcu), GFP_KERNEL);
+	if (rcu) {
+		i = 0;
+		list_for_each_entry(ns, &ctrl->namespaces, list) {
+			init_rcu_head(&rcu[i].head);
+			init_completion(&rcu[i].completion);
+			call_srcu(ns->queue->srcu, &rcu[i].head, wakeme_after_rcu);
+			i++;
+		}
+
+		for (i = 0; i < count; i++) {
+			wait_for_completion(&rcu[i].completion);
+			destroy_rcu_head(&rcu[i].head);
+		}
+		kvfree(rcu);
+	} else {
+		list_for_each_entry(ns, &ctrl->namespaces, list)
+			blk_mq_wait_quiesce_done(ns->queue);
+	}
 }
 
 static void nvme_stop_nonblocking_queues(struct nvme_ctrl *ctrl)
-- 
2.16.4

