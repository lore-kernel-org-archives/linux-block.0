Return-Path: <SRS0=wHaM=BW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85D9C433E0
	for <linux-block@archiver.kernel.org>; Wed, 12 Aug 2020 08:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE90C20781
	for <linux-block@archiver.kernel.org>; Wed, 12 Aug 2020 08:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgHLISs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:18:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726182AbgHLISr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 04:18:47 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 14F469375A531B2A7560;
        Wed, 12 Aug 2020 16:18:44 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 12 Aug 2020
 16:18:37 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <lengchao@huawei.com>
Subject: [PATCH 1/3] nvme-core: fix io interrupt caused by non path error
Date:   Wed, 12 Aug 2020 16:18:37 +0800
Message-ID: <20200812081837.22144-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For nvme multipath configured, just fail over to retry IO for path error,
but maybe blk_queue_dying return true, IO can not be retry at current
path, thus IO will interrupted.

For nvme multipath configured, blk_queue_dying and path error both need
fail over to retry. We need check whether path-related errors first, and
then retry local or fail over to retry.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c      | 18 ++++++++++++++----
 drivers/nvme/host/multipath.c | 11 +++--------
 drivers/nvme/host/nvme.h      |  5 ++---
 include/linux/nvme.h          |  9 +++++++++
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4ee2330c603e..52d19a4d3bc8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -252,6 +252,14 @@ static inline bool nvme_req_needs_retry(struct request *req)
 	return true;
 }
 
+static inline bool nvme_req_path_error(struct request *req)
+{
+	if ((nvme_req(req)->status & NVME_SCT_MASK) == NVME_SCT_PATH ||
+		blk_queue_dying(req->q))
+		return true;
+	return false;
+}
+
 static void nvme_retry_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
@@ -280,10 +288,12 @@ void nvme_complete_rq(struct request *req)
 		nvme_req(req)->ctrl->comp_seen = true;
 
 	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
-		if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
-			return;
-
-		if (!blk_queue_dying(req->q)) {
+		if (nvme_req_path_error(req)) {
+			if (req->cmd_flags & REQ_NVME_MPATH) {
+				nvme_failover_req(req);
+				return;
+			}
+		} else {
 			nvme_retry_req(req);
 			return;
 		}
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 66509472fe06..e182fb3bcd0c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -65,7 +65,7 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	}
 }
 
-bool nvme_failover_req(struct request *req)
+void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
 	u16 status = nvme_req(req)->status;
@@ -90,17 +90,13 @@ bool nvme_failover_req(struct request *req)
 			queue_work(nvme_wq, &ns->ctrl->ana_work);
 		}
 		break;
-	case NVME_SC_HOST_PATH_ERROR:
-	case NVME_SC_HOST_ABORTED_CMD:
+	default:
 		/*
-		 * Temporary transport disruption in talking to the controller.
+		 * Normal error path.
 		 * Try to send on a new path.
 		 */
 		nvme_mpath_clear_current_path(ns);
 		break;
-	default:
-		/* This was a non-ANA error so follow the normal error path. */
-		return false;
 	}
 
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
@@ -109,7 +105,6 @@ bool nvme_failover_req(struct request *req)
 	blk_mq_end_request(req, 0);
 
 	kblockd_schedule_work(&ns->head->requeue_work);
-	return true;
 }
 
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 09ffc3246f60..cbb5d4ba6241 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -582,7 +582,7 @@ void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 			struct nvme_ctrl *ctrl, int *flags);
-bool nvme_failover_req(struct request *req);
+void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
@@ -640,9 +640,8 @@ static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
 }
 
-static inline bool nvme_failover_req(struct request *req)
+static inline void nvme_failover_req(struct request *req)
 {
-	return false;
 }
 static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 5ce51ab4c50e..8c4a5b4d5b4d 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1441,6 +1441,15 @@ enum {
 	NVME_SC_DNR			= 0x4000,
 };
 
+#define NVME_SCT_MASK 0x700
+enum {
+	NVME_SCT_GENERIC = 0,
+	NVME_SCT_COMMAND_SPECIFIC = 0x100,
+	NVME_SCT_MEDIA = 0x200,
+	NVME_SCT_PATH = 0x300,
+	NVME_SCT_VENDOR = 0x700
+};
+
 struct nvme_completion {
 	/*
 	 * Used by Admin and Fabrics commands to return data:
-- 
2.16.4

