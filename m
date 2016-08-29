Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37447 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932498AbcH2Kx4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Aug 2016 06:53:56 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: keith.busch@intel.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 6/7] nvme: remove the post_scan callout
Date: Mon, 29 Aug 2016 12:53:32 +0200
Message-Id: <1472468013-29936-7-git-send-email-hch@lst.de>
In-Reply-To: <1472468013-29936-1-git-send-email-hch@lst.de>
References: <1472468013-29936-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

No need now that we don't have to reverse engineer the irq affinity.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 3 ---
 drivers/nvme/host/nvme.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2feacc7..b245616 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1826,9 +1826,6 @@ static void nvme_scan_work(struct work_struct *work)
 	list_sort(NULL, &ctrl->namespaces, ns_cmp);
 	mutex_unlock(&ctrl->namespaces_mutex);
 	kfree(id);
-
-	if (ctrl->ops->post_scan)
-		ctrl->ops->post_scan(ctrl);
 }
 
 void nvme_queue_scan(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ab18b78..99e4c16 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -184,7 +184,6 @@ struct nvme_ctrl_ops {
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 	int (*reset_ctrl)(struct nvme_ctrl *ctrl);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
-	void (*post_scan)(struct nvme_ctrl *ctrl);
 	void (*submit_async_event)(struct nvme_ctrl *ctrl, int aer_idx);
 	int (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	const char *(*get_subsysnqn)(struct nvme_ctrl *ctrl);
-- 
2.1.4

