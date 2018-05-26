Return-Path: <BATV+7138d8dfc060164c836f+5389+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH 09/14] nvmet: Add AEN configuration support
Date: Sat, 26 May 2018 12:27:30 +0200
Message-Id: <20180526102735.31404-10-hch@lst.de>
In-Reply-To: <20180526102735.31404-1-hch@lst.de>
References: <20180526102735.31404-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Hannes Reinecke <hare@suse.com>

AEN configuration via the 'Get Features' and 'Set Features' admin
command is mandatory, so we should be implemeting handling for it.

Signed-off-by: Hannes Reinecke <hare@suse.com>
[hch: use WRITE_ONCE, check for invalid values]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/admin-cmd.c | 13 ++++++++++++-
 drivers/nvme/target/core.c      |  3 +++
 drivers/nvme/target/nvmet.h     |  3 +++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 82d521f60a43..20d9ce5064f8 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -432,6 +432,16 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 		req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
 		nvmet_set_result(req, req->sq->ctrl->kato);
 		break;
+	case NVME_FEAT_ASYNC_EVENT:
+		val32 = le32_to_cpu(req->cmd->common.cdw10[1]);
+		if (val32 & ~NVMET_AEN_SUPPORTED) {
+			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+			break;
+		}
+
+		WRITE_ONCE(req->sq->ctrl->aen_enabled, val32);
+		nvmet_set_result(req, val32);
+		break;
 	case NVME_FEAT_HOST_ID:
 		status = NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 		break;
@@ -470,9 +480,10 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 		break;
 	case NVME_FEAT_WRITE_ATOMIC:
 		break;
+#endif
 	case NVME_FEAT_ASYNC_EVENT:
+		nvmet_set_result(req, READ_ONCE(req->sq->ctrl->aen_enabled));
 		break;
-#endif
 	case NVME_FEAT_VOLATILE_WC:
 		nvmet_set_result(req, 1);
 		break;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 424ad41af980..53e2386b73cf 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -162,6 +162,8 @@ static void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid)
 
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
 		nvmet_add_to_changed_ns_log(ctrl, nsid);
+		if (!(READ_ONCE(ctrl->aen_enabled) & NVME_AEN_CFG_NS_ATTR))
+			continue;
 		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
 				NVME_AER_NOTICE_NS_CHANGED,
 				NVME_LOG_CHANGED_NS);
@@ -849,6 +851,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
+	WRITE_ONCE(ctrl->aen_enabled, NVMET_AEN_SUPPORTED);
 
 	ctrl->changed_ns_list = kmalloc_array(NVME_MAX_CHANGED_NAMESPACES,
 			sizeof(__le32), GFP_KERNEL);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index bcd88b5c9d99..50c8300ea572 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -30,6 +30,8 @@
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
 
+#define NVMET_AEN_SUPPORTED	NVME_AEN_CFG_NS_ATTR
+
 /* Helper Macros when NVMe error is NVME_SC_CONNECT_INVALID_PARAM
  * The 16 bit shift is to set IATTR bit to 1, which means offending
  * offset starts in the data section of connect()
@@ -123,6 +125,7 @@ struct nvmet_ctrl {
 	u16			cntlid;
 	u32			kato;
 
+	u32			aen_enabled;
 	struct nvmet_req	*async_event_cmds[NVMET_ASYNC_EVENTS];
 	unsigned int		nr_async_event_cmds;
 	struct list_head	async_events;
-- 
2.17.0
