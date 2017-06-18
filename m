Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52134 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbdFRPWZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:25 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 11/30] nvme: move controller cap to struct nvme_ctrl
Date: Sun, 18 Jun 2017 18:21:45 +0300
Message-Id: <1497799324-19598-12-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Will be used in centralized code later. only rdma
for now.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/nvme.h | 1 +
 drivers/nvme/host/rdma.c | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 3be59634b4af..5b75f6a81764 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -159,6 +159,7 @@ struct nvme_ctrl {
 	u16 kas;
 	u8 npss;
 	u8 apsta;
+	u64 cap;
 	unsigned int kato;
 	bool subsystem;
 	unsigned long quirks;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 58ed2ae3cd35..cd637e28647b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -119,7 +119,6 @@ struct nvme_rdma_ctrl {
 	struct blk_mq_tag_set	admin_tag_set;
 	struct nvme_rdma_device	*device;
 
-	u64			cap;
 	u32			max_fr_pages;
 
 	struct sockaddr_storage addr;
@@ -826,7 +825,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new
 
 	set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags);
 
-	error = nvmf_reg_read64(&ctrl->ctrl, NVME_REG_CAP, &ctrl->cap);
+	error = nvmf_reg_read64(&ctrl->ctrl, NVME_REG_CAP, &ctrl->ctrl.cap);
 	if (error) {
 		dev_err(ctrl->ctrl.device,
 			"prop_get NVME_REG_CAP failed\n");
@@ -834,9 +833,9 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new
 	}
 
 	ctrl->ctrl.sqsize =
-		min_t(int, NVME_CAP_MQES(ctrl->cap), ctrl->ctrl.sqsize);
+		min_t(int, NVME_CAP_MQES(ctrl->ctrl.cap), ctrl->ctrl.sqsize);
 
-	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->cap);
+	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
 	if (error)
 		goto out_cleanup_connect_queue;
 
-- 
2.7.4
