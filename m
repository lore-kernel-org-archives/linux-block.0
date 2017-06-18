Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52126 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbdFRPWY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:24 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 10/30] nvme: Add admin_tagset pointer to nvme_ctrl
Date: Sun, 18 Jun 2017 18:21:44 +0300
Message-Id: <1497799324-19598-11-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Will be used when we centralize control flows. only
rdma for now.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/nvme.h | 1 +
 drivers/nvme/host/rdma.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 415a5ea4759c..3be59634b4af 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -126,6 +126,7 @@ struct nvme_ctrl {
 	struct kref kref;
 	int instance;
 	struct blk_mq_tag_set *tagset;
+	struct blk_mq_tag_set *admin_tagset;
 	struct list_head namespaces;
 	struct mutex namespaces_mutex;
 	struct device *device;	/* char device */
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2b23f88bedfe..58ed2ae3cd35 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -801,6 +801,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new
 		error = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
 		if (error)
 			goto out_put_dev;
+		ctrl->ctrl.admin_tagset = &ctrl->admin_tag_set;
 
 		ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
 		if (IS_ERR(ctrl->ctrl.admin_q)) {
-- 
2.7.4
