Return-Path: <BATV+1f4557cc97fec8e307c5+5393+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org
Subject: [PATCH 01/12] nvme.h: untangle AEN notice definitions
Date: Wed, 30 May 2018 18:45:49 +0200
Message-Id: <20180530164600.26856-2-hch@lst.de>
In-Reply-To: <20180530164600.26856-1-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Stop including the event type in the definitions for the notice type.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/nvme/host/core.c | 30 ++++++++++++++++++------------
 include/linux/nvme.h     |  8 ++++++--
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2c4cf65641a6..86cb78653155 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3321,6 +3321,21 @@ static void nvme_fw_act_work(struct work_struct *work)
 	nvme_get_fw_slot_info(ctrl);
 }
 
+static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
+{
+	switch ((result & 0xff00) >> 8) {
+	case NVME_AER_NOTICE_NS_CHANGED:
+		dev_info(ctrl->device, "rescanning\n");
+		nvme_queue_scan(ctrl);
+		break;
+	case NVME_AER_NOTICE_FW_ACT_STARTING:
+		queue_work(nvme_wq, &ctrl->fw_act_work);
+		break;
+	default:
+		dev_warn(ctrl->device, "async event result %08x\n", result);
+	}
+}
+
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		volatile union nvme_result *res)
 {
@@ -3330,6 +3345,9 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		return;
 
 	switch (result & 0x7) {
+	case NVME_AER_NOTICE:
+		nvme_handle_aen_notice(ctrl, result);
+		break;
 	case NVME_AER_ERROR:
 	case NVME_AER_SMART:
 	case NVME_AER_CSS:
@@ -3339,18 +3357,6 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	default:
 		break;
 	}
-
-	switch (result & 0xff07) {
-	case NVME_AER_NOTICE_NS_CHANGED:
-		dev_info(ctrl->device, "rescanning\n");
-		nvme_queue_scan(ctrl);
-		break;
-	case NVME_AER_NOTICE_FW_ACT_STARTING:
-		queue_work(nvme_wq, &ctrl->fw_act_work);
-		break;
-	default:
-		dev_warn(ctrl->device, "async event result %08x\n", result);
-	}
 	queue_work(nvme_wq, &ctrl->async_event_work);
 }
 EXPORT_SYMBOL_GPL(nvme_complete_async_event);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 4112e2bd747f..c37103a4ad38 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -436,10 +436,14 @@ enum {
 enum {
 	NVME_AER_ERROR			= 0,
 	NVME_AER_SMART			= 1,
+	NVME_AER_NOTICE			= 2,
 	NVME_AER_CSS			= 6,
 	NVME_AER_VS			= 7,
-	NVME_AER_NOTICE_NS_CHANGED	= 0x0002,
-	NVME_AER_NOTICE_FW_ACT_STARTING = 0x0102,
+};
+
+enum {
+	NVME_AER_NOTICE_NS_CHANGED	= 0x00,
+	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
 };
 
 struct nvme_lba_range_type {
-- 
2.17.0
