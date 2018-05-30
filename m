Return-Path: <BATV+1f4557cc97fec8e307c5+5393+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org
Subject: [PATCH 06/12] nvmet: implement the changed namespaces log
Date: Wed, 30 May 2018 18:45:54 +0200
Message-Id: <20180530164600.26856-7-hch@lst.de>
In-Reply-To: <20180530164600.26856-1-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Just keep a per-controller buffer of changed namespaces and copy it out
in the get log page implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/admin-cmd.c | 26 +++++++++++++++++
 drivers/nvme/target/core.c      | 50 +++++++++++++++++++++++++++------
 drivers/nvme/target/nvmet.h     |  3 ++
 3 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 678a393f01de..453d76db1647 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -126,6 +126,29 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+static void nvmet_execute_get_log_changed_ns(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u16 status = NVME_SC_INTERNAL;
+	size_t len;
+
+	if (req->data_len != NVME_MAX_CHANGED_NAMESPACES * sizeof(__le32))
+		goto out;
+
+	mutex_lock(&ctrl->lock);
+	if (ctrl->nr_changed_ns == U32_MAX)
+		len = sizeof(__le32);
+	else
+		len = ctrl->nr_changed_ns * sizeof(__le32);
+	status = nvmet_copy_to_sgl(req, 0, ctrl->changed_ns_list, len);
+	if (!status)
+		status = nvmet_zero_sgl(req, len, req->data_len - len);
+	ctrl->nr_changed_ns = 0;
+	mutex_unlock(&ctrl->lock);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -549,6 +572,9 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 			 */
 			req->execute = nvmet_execute_get_log_page_noop;
 			return 0;
+		case NVME_LOG_CHANGED_NS:
+			req->execute = nvmet_execute_get_log_changed_ns;
+			return 0;
 		}
 		break;
 	case nvme_admin_identify:
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 55c4bc693aa2..99fcff757608 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -144,6 +144,36 @@ static void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 	schedule_work(&ctrl->async_event_work);
 }
 
+static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
+{
+	mutex_lock(&ctrl->lock);
+	if (ctrl->nr_changed_ns < NVME_MAX_CHANGED_NAMESPACES) {
+		u32 i;
+
+		for (i = 0; i < ctrl->nr_changed_ns; i++)
+			if (ctrl->changed_ns_list[i] == nsid)
+				goto out_unlock;
+		ctrl->changed_ns_list[ctrl->nr_changed_ns++] = nsid;
+	} else if (ctrl->nr_changed_ns == NVME_MAX_CHANGED_NAMESPACES) {
+		ctrl->changed_ns_list[0] = cpu_to_le32(0xffffffff);
+		ctrl->nr_changed_ns = U32_MAX;
+	}
+out_unlock:
+	mutex_unlock(&ctrl->lock);
+}
+
+static void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid)
+{
+	struct nvmet_ctrl *ctrl;
+
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		nvmet_add_to_changed_ns_log(ctrl, cpu_to_le32(nsid));
+		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
+				NVME_AER_NOTICE_NS_CHANGED,
+				NVME_LOG_CHANGED_NS);
+	}
+}
+
 int nvmet_register_transport(const struct nvmet_fabrics_ops *ops)
 {
 	int ret = 0;
@@ -287,7 +317,6 @@ static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
 int nvmet_ns_enable(struct nvmet_ns *ns)
 {
 	struct nvmet_subsys *subsys = ns->subsys;
-	struct nvmet_ctrl *ctrl;
 	int ret = 0;
 
 	mutex_lock(&subsys->lock);
@@ -326,9 +355,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 		list_add_tail_rcu(&ns->dev_link, &old->dev_link);
 	}
 
-	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
-		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE, 0, 0);
-
+	nvmet_ns_changed(subsys, ns->nsid);
 	ns->enabled = true;
 	ret = 0;
 out_unlock:
@@ -342,7 +369,6 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 void nvmet_ns_disable(struct nvmet_ns *ns)
 {
 	struct nvmet_subsys *subsys = ns->subsys;
-	struct nvmet_ctrl *ctrl;
 
 	mutex_lock(&subsys->lock);
 	if (!ns->enabled)
@@ -368,9 +394,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	percpu_ref_exit(&ns->ref);
 
 	mutex_lock(&subsys->lock);
-	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
-		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE, 0, 0);
-
+	nvmet_ns_changed(subsys, ns->nsid);
 	nvmet_ns_dev_disable(ns);
 out_unlock:
 	mutex_unlock(&subsys->lock);
@@ -832,11 +856,16 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
 
+	ctrl->changed_ns_list = kmalloc_array(NVME_MAX_CHANGED_NAMESPACES,
+			sizeof(__le32), GFP_KERNEL);
+	if (!ctrl->changed_ns_list)
+		goto out_free_ctrl;
+
 	ctrl->cqs = kcalloc(subsys->max_qid + 1,
 			sizeof(struct nvmet_cq *),
 			GFP_KERNEL);
 	if (!ctrl->cqs)
-		goto out_free_ctrl;
+		goto out_free_changed_ns_list;
 
 	ctrl->sqs = kcalloc(subsys->max_qid + 1,
 			sizeof(struct nvmet_sq *),
@@ -894,6 +923,8 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	kfree(ctrl->sqs);
 out_free_cqs:
 	kfree(ctrl->cqs);
+out_free_changed_ns_list:
+	kfree(ctrl->changed_ns_list);
 out_free_ctrl:
 	kfree(ctrl);
 out_put_subsystem:
@@ -920,6 +951,7 @@ static void nvmet_ctrl_free(struct kref *ref)
 
 	kfree(ctrl->sqs);
 	kfree(ctrl->cqs);
+	kfree(ctrl->changed_ns_list);
 	kfree(ctrl);
 
 	nvmet_subsys_put(subsys);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 768abe203298..8cdc1e550396 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -135,6 +135,9 @@ struct nvmet_ctrl {
 
 	const struct nvmet_fabrics_ops *ops;
 
+	__le32			*changed_ns_list;
+	u32			nr_changed_ns;
+
 	char			subsysnqn[NVMF_NQN_FIELD_LEN];
 	char			hostnqn[NVMF_NQN_FIELD_LEN];
 };
-- 
2.17.0
