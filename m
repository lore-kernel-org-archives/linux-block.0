Return-Path: <anish.jhaveri@paviliondata.com>
Date: Mon, 11 Sep 2017 21:24:04 -0700
From: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
To: sagi@grimberg.me, hch@lst.de, keith.busch@intel.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 04/10] NVME command to set namespace active.
Message-ID: <20170912042403.spqxh7ggtiaezjsx@haynes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: anish.jhaveri@paviliondata.com
List-ID: <linux-block@vger.kernel.org>

In order to support active standby multipath configuration, functionality has been provided to send a set active command to target. Functionality is provided to retrieve NGUID for multipath head namespace as this needs to be unique from sibling NGUID and storing it on target will provide persistent value. TODO: In future set active namespace command can use reserved tag and different opcode. Retrieving multipath head NGUID can also use different opcode.

Signed-off-by: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
---
 drivers/nvme/host/core.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 934548a..3839d1c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -314,8 +314,12 @@ static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk)
 	if (ns) {
 		if (!kref_get_unless_zero(&ns->kref))
 			goto fail;
-		if (!try_module_get(ns->ctrl->ops->module))
-			goto fail_put_ns;
+		/*ops is not assigned in head-parent controller.
+		  So we perform a check for non head controller
+		  case of Multipath device.*/
+		if (!test_bit(NVME_NS_ROOT, &ns->flags))
+			if (!try_module_get(ns->ctrl->ops->module))
+				goto fail_put_ns;
 	}
 	spin_unlock(&dev_list_lock);
 
@@ -928,6 +932,102 @@ static int nvme_identify_ns(struct nvme_ctrl *dev, unsigned nsid,
 	return error;
 }
 
+static void nvme_ns_active_end_io(struct request *rq, blk_status_t error)
+{
+	struct nvme_ctrl *ctrl;
+	struct nvme_ns *standby_ns, *mpath_ns;
+	struct nvme_failover_data *priv = rq->end_io_data;
+	standby_ns = priv->standby_ns;
+	mpath_ns =  priv->mpath_ns;
+	ctrl = standby_ns->ctrl;
+
+	blk_mq_free_request(rq);
+
+
+	if (error) {
+		dev_err(ctrl->device,
+			"Failed to set nvme%dn%d active with error=%d\n",
+			ctrl->instance, standby_ns->instance, error);
+	} else {
+		standby_ns->active = 1;
+		standby_ns->mpath_ctrl->cleanup_done = 1;
+		dev_info(ctrl->device,
+			 "New active ns nvme%dn%d \n", ctrl->instance,
+			 standby_ns->instance);
+	}
+	test_and_clear_bit(NVME_NS_FO_IN_PROGRESS, &mpath_ns->flags);
+
+	kfree(priv);
+}
+
+int nvme_set_ns_active(struct nvme_ns *standby_ns, struct nvme_ns *mpath_ns,
+		int retry_cnt)
+{
+	struct nvme_command c = { };
+	struct request *rq;
+	struct nvme_failover_data *priv;
+
+	/* gcc-4.4.4 (at least) has issues with initializers and anon unions */
+	c.identify.opcode = 0xFE;
+	c.identify.nsid = cpu_to_le32(standby_ns->ns_id);
+	dev_info(standby_ns->ctrl->device, "Set active ns nvme%dn%d \n",
+	standby_ns->ctrl->instance, standby_ns->instance);
+
+	priv = kmalloc(sizeof(struct nvme_failover_data), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->mpath_ns = mpath_ns;
+	priv->standby_ns = standby_ns;
+	priv->retries = retry_cnt;
+	rq = nvme_alloc_request(standby_ns->ctrl->admin_q, &c,
+		BLK_MQ_REQ_RESERVED, NVME_QID_ANY);
+	if (IS_ERR(rq)) {
+		kfree(priv);
+		return PTR_ERR(rq);
+	}
+
+	rq->timeout = standby_ns->ctrl->kato * HZ * NVME_NS_ACTIVE_TIMEOUT;
+	rq->end_io_data = priv;
+	blk_execute_rq_nowait(rq->q, NULL, rq, 0, nvme_ns_active_end_io);
+
+	return 0;
+}
+
+static int nvme_get_mpath_nguid(struct nvme_ctrl *dev, unsigned nsid,
+		char **nguid)
+{
+	struct nvme_command c = { };
+	c.identify.opcode = 0xFC;
+	c.identify.nsid = cpu_to_le32(nsid);
+
+	*nguid = kzalloc(1024, GFP_KERNEL);
+	if (!*nguid)
+		return -ENOMEM;
+
+	return nvme_submit_sync_cmd(dev->admin_q, &c, (*nguid), 1024);
+}
+
+int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned nsid,
+		dma_addr_t dma_addr, u32 *result)
+{
+	struct nvme_command c;
+	union nvme_result res;
+	int ret;
+
+	memset(&c, 0, sizeof(c));
+	c.features.opcode = nvme_admin_get_features;
+	c.features.nsid = cpu_to_le32(nsid);
+	c.features.dptr.prp1 = cpu_to_le64(dma_addr);
+	c.features.fid = cpu_to_le32(fid);
+
+	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res, NULL, 0, 0,
+			NVME_QID_ANY, 0, 0);
+	if (ret >= 0)
+		*result = le32_to_cpu(res.u32);
+	return ret;
+}
+
 static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 		      void *buffer, size_t buflen, u32 *result)
 {
-- 
2.9.3
