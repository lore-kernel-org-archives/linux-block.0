Return-Path: <anish.jhaveri@paviliondata.com>
Date: Mon, 11 Sep 2017 21:28:56 -0700
From: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
To: sagi@grimberg.me, hch@lst.de, keith.busch@intel.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org;, linux-nvme@lists.infradead.org
Subject: [PATCH 07/10] Selection of active namespace.
Message-ID: <20170912042856.sb4uevo2bzxkckm6@haynes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: anish.jhaveri@paviliondata.com
List-ID: <linux-block@vger.kernel.org>

Failover logic iterates over the list of namespaces to figure out which namespace is available to become active. If failover is in progress exit the functionality. If we fail to set new namespace to active state, we will cancel all pending IO's from congestion queue.

Signed-off-by: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
---
 drivers/nvme/host/core.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cefa506..cb2c90f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2669,6 +2669,111 @@ static void nvme_shared_ns(struct nvme_ns *shared_ns)
 	if (ret == shared_ns)
 		nvme_add_ns_mpath_ctrl(shared_ns);
 }
+
+static void nvme_trigger_failover_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl =
+		container_of(work, struct nvme_ctrl, failover_work);
+
+	pr_debug("Trigger failover on controller nvme%d\n", ctrl->instance);
+
+	nvme_trigger_failover(ctrl);
+}
+
+/*
+ This will only be called in IO Failure scenario
+ or on device removal
+ or on device disconnect.
+*/
+void nvme_trigger_failover(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *active_ns = NULL;
+	struct nvme_ns *standby_ns = NULL;
+	struct nvme_ns *ns = NULL, *next;
+	struct nvme_ctrl *mpath_ctrl = NULL;
+	struct nvme_ns *mpath_ns = NULL;
+
+	if (test_bit(NVME_CTRL_MPATH_CHILD, &ctrl->flags)) {
+		list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
+			mpath_ctrl = ns->mpath_ctrl;
+			break;
+		}
+	} else {
+		/*We are not part of multipath group.*/
+		return;
+	}
+
+	if (ns && !ns->active) {
+		pr_info("No Failover as nvme%dn%d is not active.\n", ctrl->instance, ns->instance);
+		return;
+	}
+	if (!mpath_ctrl) {
+		pr_info("No namespace with multipath support found.\n");
+		return;
+	}
+
+	/*Find the namespace for above multipath controller.
+	  There is only one namespace per given multipath controller.
+	  We just use same mechanism of list even if we have single
+	  mulipath namespace.*/
+	list_for_each_entry_safe(mpath_ns, next, &mpath_ctrl->mpath_namespace, list) {
+		if (mpath_ns)
+			break;
+	}
+	if (!mpath_ns) {
+		pr_info("No multipath namespace found.\n");
+		return;
+	}
+
+	if (test_and_set_bit(NVME_NS_FO_IN_PROGRESS, &mpath_ns->flags))  {
+		return;
+	}
+	/* Iterate through all namespaces related to Multipath controller.
+	   Find a different one from the one in use. This will be the
+	   namespace we will failover to.*/
+	if (test_bit(NVME_NS_ROOT, &mpath_ns->flags)) {
+		mutex_lock(&mpath_ns->ctrl->namespaces_mutex);
+		list_for_each_entry_safe(ns, next, &mpath_ns->ctrl->namespaces, mpathlist) {
+			if (ns) {
+				if (ns->active)
+					active_ns = ns;
+				else
+					standby_ns = ns;
+			}
+			if (active_ns && standby_ns) {
+				if (active_ns == standby_ns) {
+					test_and_clear_bit(NVME_NS_FO_IN_PROGRESS, &mpath_ns->flags);
+					break;
+				}
+				if ((jiffies - standby_ns->start_time) < (ns_failover_interval * HZ)) {
+					pr_debug(" Failed to meet timeout between failover on same volume.\n");
+					test_and_clear_bit(NVME_NS_FO_IN_PROGRESS, &mpath_ns->flags);
+					schedule_delayed_work(&mpath_ctrl->cu_work, HZ);
+					break;
+				}
+				active_ns->mpath_ctrl->cleanup_done = 0;
+				active_ns->active = 0;
+				active_ns->start_time = jiffies;
+				if (nvme_set_ns_active(standby_ns, mpath_ns, NVME_FAILOVER_RETRIES)) {
+					pr_info("Failed to set nvme%dn%d\n active", standby_ns->ctrl->instance, standby_ns->instance);
+					test_and_clear_bit(NVME_NS_FO_IN_PROGRESS, &mpath_ns->flags);
+					schedule_delayed_work(&mpath_ctrl->cu_work, HZ);
+				}
+				break;
+			}
+		}
+
+		if (active_ns && !standby_ns) {
+			test_and_clear_bit(NVME_NS_FO_IN_PROGRESS, &mpath_ns->flags);
+		}
+
+		if (!test_bit(NVME_NS_FO_IN_PROGRESS, &mpath_ns->flags)) {
+		}
+		mutex_unlock(&mpath_ns->ctrl->namespaces_mutex);
+	}
+}
+EXPORT_SYMBOL_GPL(nvme_trigger_failover);
+
 static struct nvme_ns *nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns;
-- 
2.9.3
