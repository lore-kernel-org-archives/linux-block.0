Return-Path: <BATV+7138d8dfc060164c836f+5389+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org
Subject: [PATCH 13/14] nvme: use the changed namespaces list log to clear ns data changed AENs
Date: Sat, 26 May 2018 12:27:34 +0200
Message-Id: <20180526102735.31404-14-hch@lst.de>
In-Reply-To: <20180526102735.31404-1-hch@lst.de>
References: <20180526102735.31404-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Per section 5.2 we need to issue the corresponding log page to clear an
AEN, so for a namespace data changed AEN we need to read the changed
namespace list log.  And once we read that log anyway we might as well
use it to optimize the rescan.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 51 ++++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 06cd04dcffbc..1ae77428a1a5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3194,6 +3194,42 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl, unsigned nn)
 	nvme_remove_invalid_namespaces(ctrl, nn);
 }
 
+static bool nvme_scan_changed_ns_log(struct nvme_ctrl *ctrl)
+{
+	size_t log_size = NVME_MAX_CHANGED_NAMESPACES * sizeof(__le32);
+	__le32 *log;
+	int error, i;
+	bool ret = false;
+
+	log = kzalloc(log_size, GFP_KERNEL);
+	if (!log)
+		return false;
+
+	error = nvme_get_log(ctrl, NVME_LOG_CHANGED_NS, log, log_size);
+	if (error) {
+		dev_warn(ctrl->device,
+			"reading changed ns log failed: %d\n", error);
+		goto out_free_log;
+	}
+
+	if (log[0] == cpu_to_le32(0xffffffff))
+		goto out_free_log;
+
+	for (i = 0; i < NVME_MAX_CHANGED_NAMESPACES; i++) {
+		u32 nsid = le32_to_cpu(log[i]);
+
+		if (nsid == 0)
+			break;
+		dev_info(ctrl->device, "rescanning namespace %d.\n", nsid);
+		nvme_validate_ns(ctrl, nsid);
+	}
+	ret = true;
+
+out_free_log:
+	kfree(log);
+	return ret;
+}
+
 static void nvme_scan_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
@@ -3206,6 +3242,12 @@ static void nvme_scan_work(struct work_struct *work)
 
 	WARN_ON_ONCE(!ctrl->tagset);
 
+	if (test_and_clear_bit(EVENT_NS_CHANGED, &ctrl->events)) {
+		if (nvme_scan_changed_ns_log(ctrl))
+			goto out_sort_namespaces;
+		dev_info(ctrl->device, "rescanning namespaces.\n");
+	}
+
 	if (nvme_identify_ctrl(ctrl, &id))
 		return;
 
@@ -3213,14 +3255,15 @@ static void nvme_scan_work(struct work_struct *work)
 	if (ctrl->vs >= NVME_VS(1, 1, 0) &&
 	    !(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)) {
 		if (!nvme_scan_ns_list(ctrl, nn))
-			goto done;
+			goto out_free_id;
 	}
 	nvme_scan_ns_sequential(ctrl, nn);
- done:
+out_free_id:
+	kfree(id);
+out_sort_namespaces:
 	down_write(&ctrl->namespaces_rwsem);
 	list_sort(NULL, &ctrl->namespaces, ns_cmp);
 	up_write(&ctrl->namespaces_rwsem);
-	kfree(id);
 }
 
 /*
@@ -3340,7 +3383,7 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 {
 	switch ((result & 0xff00) >> 8) {
 	case NVME_AER_NOTICE_NS_CHANGED:
-		dev_info(ctrl->device, "rescanning\n");
+		set_bit(EVENT_NS_CHANGED, &ctrl->events);
 		nvme_queue_scan(ctrl);
 		break;
 	case NVME_AER_NOTICE_FW_ACT_STARTING:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 11681278fdf6..07e8bfe705c6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -189,6 +189,8 @@ struct nvme_ctrl {
 	struct delayed_work ka_work;
 	struct nvme_command ka_cmd;
 	struct work_struct fw_act_work;
+#define EVENT_NS_CHANGED		(1 << 0)
+	unsigned long events;
 
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
-- 
2.17.0
