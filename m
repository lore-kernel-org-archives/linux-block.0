Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A21FC433E6
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 14:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E282F208C3
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 14:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592492052;
	bh=OV+y07xPypWNqkS7VfpwEmHhlmBWYGWAfCTr4f4JAoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EqzxKjg+jwXI3MiAuOzbz/SbBWqS1c92ngyKGXSMiC7pOOcb60tKAHyUr7Pt+X6gv
	 SVb+QEJpC2vrEmWcSzHbkCyZ7jWwx+mx5uxGvgSQ1u5ptjXSsIH3RLDHP7eWEeLQEv
	 OAZdknTObL4MUKwLeTb3cFOHbRqPiT+m4fws0sIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgFROyL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:54:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731096AbgFROyK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 10:54:10 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74B9B208B3;
        Thu, 18 Jun 2020 14:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592492049;
        bh=OV+y07xPypWNqkS7VfpwEmHhlmBWYGWAfCTr4f4JAoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J689i7Wn1NhxQzY4hQDzWWKEeVnrjL7Ll1hHxXnPazzORfRxXPAvW7OTEiBq6NnIk
         +7jhPr6FaTKo6NeQbB/rqk4U3VXJzwEMlMPBiyYoylB9xBbtVc1Qa0JqIYr14E9ksK
         pmJ4TGtwPPXjt9CDlS+fJB+ktbmxMaypnbktKiVo=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me
Cc:     axboe@kernel.dk, Keith Busch <keith.busch@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Aravind Ramesh <aravind.ramesh@wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCHv2 5/5] nvme: support for zoned namespaces
Date:   Thu, 18 Jun 2020 07:53:54 -0700
Message-Id: <20200618145354.1139350-6-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200618145354.1139350-1-kbusch@kernel.org>
References: <20200618145354.1139350-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <keith.busch@wdc.com>

Add support for NVM Express Zoned Namespaces (ZNS) Command Set defined
in NVM Express TP4053. Zoned namespaces are discovered based on their
Command Set Identifier reported in the namespaces Namespace
Identification Descriptor list. A successfully discovered Zoned
Namespace will be registered with the block layer as a host managed
zoned block device with Zone Append command support. A namespace that
does not support append is not supported by the driver.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Keith Busch <keith.busch@wdc.com>
---
 block/Kconfig              |   5 +-
 drivers/nvme/host/Makefile |   1 +
 drivers/nvme/host/core.c   |  91 ++++++++++++--
 drivers/nvme/host/nvme.h   |  39 ++++++
 drivers/nvme/host/zns.c    | 238 +++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h       | 114 +++++++++++++++++-
 6 files changed, 473 insertions(+), 15 deletions(-)
 create mode 100644 drivers/nvme/host/zns.c

diff --git a/block/Kconfig b/block/Kconfig
index 9357d7302398..bbad5e8bbffe 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -86,9 +86,10 @@ config BLK_DEV_ZONED
 	select MQ_IOSCHED_DEADLINE
 	help
 	Block layer zoned block device support. This option enables
-	support for ZAC/ZBC host-managed and host-aware zoned block devices.
+	support for ZAC/ZBC/ZNS host-managed and host-aware zoned block
+	devices.
 
-	Say yes here if you have a ZAC or ZBC storage device.
+	Say yes here if you have a ZAC, ZBC, or ZNS storage device.
 
 config BLK_DEV_THROTTLING
 	bool "Block layer bio throttling support"
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index fc7b26be692d..d7f6a87687b8 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -13,6 +13,7 @@ nvme-core-y				:= core.o
 nvme-core-$(CONFIG_TRACING)		+= trace.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_NVM)			+= lightnvm.o
+nvme-core-$(CONFIG_BLK_DEV_ZONED)	+= zns.o
 nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+= fault_inject.o
 nvme-core-$(CONFIG_NVME_HWMON)		+= hwmon.o
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 64b7b9fc2817..885db561de17 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -89,7 +89,7 @@ static dev_t nvme_chr_devt;
 static struct class *nvme_class;
 static struct class *nvme_subsys_class;
 
-static int nvme_revalidate_disk(struct gendisk *disk);
+static int _nvme_revalidate_disk(struct gendisk *disk);
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
@@ -287,6 +287,10 @@ void nvme_complete_rq(struct request *req)
 			nvme_retry_req(req);
 			return;
 		}
+	} else if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+		   req_op(req) == REQ_OP_ZONE_APPEND) {
+		req->__sector = nvme_lba_to_sect(req->q->queuedata,
+			le64_to_cpu(nvme_req(req)->result.u64));
 	}
 
 	nvme_trace_bio_complete(req, status);
@@ -673,7 +677,8 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 }
 
 static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
-		struct request *req, struct nvme_command *cmnd)
+		struct request *req, struct nvme_command *cmnd,
+		enum nvme_opcode op)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	u16 control = 0;
@@ -687,7 +692,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	if (req->cmd_flags & REQ_RAHEAD)
 		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
 
-	cmnd->rw.opcode = (rq_data_dir(req) ? nvme_cmd_write : nvme_cmd_read);
+	cmnd->rw.opcode = op;
 	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
 	cmnd->rw.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
@@ -716,6 +721,8 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		case NVME_NS_DPS_PI_TYPE2:
 			control |= NVME_RW_PRINFO_PRCHK_GUARD |
 					NVME_RW_PRINFO_PRCHK_REF;
+			if (op == nvme_cmd_zone_append)
+				control |= NVME_RW_APPEND_PIREMAP;
 			cmnd->rw.reftag = cpu_to_le32(t10_pi_ref_tag(req));
 			break;
 		}
@@ -756,6 +763,19 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	case REQ_OP_FLUSH:
 		nvme_setup_flush(ns, cmd);
 		break;
+	case REQ_OP_ZONE_RESET_ALL:
+	case REQ_OP_ZONE_RESET:
+		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_RESET);
+		break;
+	case REQ_OP_ZONE_OPEN:
+		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OPEN);
+		break;
+	case REQ_OP_ZONE_CLOSE:
+		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_CLOSE);
+		break;
+	case REQ_OP_ZONE_FINISH:
+		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);
+		break;
 	case REQ_OP_WRITE_ZEROES:
 		ret = nvme_setup_write_zeroes(ns, req, cmd);
 		break;
@@ -763,8 +783,13 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 		ret = nvme_setup_discard(ns, req, cmd);
 		break;
 	case REQ_OP_READ:
+		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_read);
+		break;
 	case REQ_OP_WRITE:
-		ret = nvme_setup_rw(ns, req, cmd);
+		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_write);
+		break;
+	case REQ_OP_ZONE_APPEND:
+		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -1391,14 +1416,23 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return effects;
 }
 
-static void nvme_update_formats(struct nvme_ctrl *ctrl)
+static void nvme_update_formats(struct nvme_ctrl *ctrl, u32 *effects)
 {
 	struct nvme_ns *ns;
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		if (ns->disk && nvme_revalidate_disk(ns->disk))
+		if (ns->disk && _nvme_revalidate_disk(ns->disk))
 			nvme_set_queue_dying(ns);
+		else if (blk_queue_is_zoned(ns->disk->queue)) {
+			/*
+			 * IO commands are required to fully revalidate a zoned
+			 * device. Force the command effects to trigger rescan
+			 * work so report zones can run in a context with
+			 * unfrozen IO queues.
+			 */
+			*effects |= NVME_CMD_EFFECTS_NCC;
+		}
 	up_read(&ctrl->namespaces_rwsem);
 }
 
@@ -1410,7 +1444,7 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 	 * this command.
 	 */
 	if (effects & NVME_CMD_EFFECTS_LBCC)
-		nvme_update_formats(ctrl);
+		nvme_update_formats(ctrl, &effects);
 	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK)) {
 		nvme_unfreeze(ctrl);
 		nvme_mpath_unfreeze(ctrl->subsys);
@@ -1525,7 +1559,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
  * Issue ioctl requests on the first available path.  Note that unlike normal
  * block layer requests we will not retry failed request on another controller.
  */
-static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
+struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
 		struct nvme_ns_head **head, int *srcu_idx)
 {
 #ifdef CONFIG_NVME_MULTIPATH
@@ -1545,7 +1579,7 @@ static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
 	return disk->private_data;
 }
 
-static void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx)
+void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx)
 {
 	if (head)
 		srcu_read_unlock(&head->srcu, idx);
@@ -1938,21 +1972,28 @@ static void nvme_update_disk_info(struct gendisk *disk,
 
 static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 {
+	unsigned lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
 	struct nvme_ns *ns = disk->private_data;
 	struct nvme_ctrl *ctrl = ns->ctrl;
+	int ret;
 	u32 iob;
 
 	/*
 	 * If identify namespace failed, use default 512 byte block size so
 	 * block layer can use before failing read/write for 0 capacity.
 	 */
-	ns->lba_shift = id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ds;
+	ns->lba_shift = id->lbaf[lbaf].ds;
 	if (ns->lba_shift == 0)
 		ns->lba_shift = 9;
 
 	switch (ns->head->ids.csi) {
 	case NVME_CSI_NVM:
 		break;
+	case NVME_CSI_ZNS:
+		ret = nvme_update_zone_info(disk, ns, lbaf);
+		if (ret)
+			return ret;
+		break;
 	default:
 		dev_warn(ctrl->device, "unknown csi:%d ns:%d\n",
 			ns->head->ids.csi, ns->head->ns_id);
@@ -1966,7 +2007,7 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		iob = nvme_lba_to_sect(ns, le16_to_cpu(id->noiob));
 
 	ns->features = 0;
-	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
+	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
 	/* the PI implementation requires metadata equal t10 pi tuple size */
 	if (ns->ms == sizeof(struct t10_pi_tuple))
 		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
@@ -2009,7 +2050,7 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	return 0;
 }
 
-static int nvme_revalidate_disk(struct gendisk *disk)
+static int _nvme_revalidate_disk(struct gendisk *disk)
 {
 	struct nvme_ns *ns = disk->private_data;
 	struct nvme_ctrl *ctrl = ns->ctrl;
@@ -2057,6 +2098,28 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	return ret;
 }
 
+static int nvme_revalidate_disk(struct gendisk *disk)
+{
+	int ret;
+
+	ret = _nvme_revalidate_disk(disk);
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (blk_queue_is_zoned(disk->queue)) {
+		struct nvme_ns *ns = disk->private_data;
+		struct nvme_ctrl *ctrl = ns->ctrl;
+
+		ret = blk_revalidate_disk_zones(disk, NULL);
+		if (!ret)
+			blk_queue_max_zone_append_sectors(disk->queue,
+							  ctrl->max_zone_append);
+	}
+#endif
+	return ret;
+}
+
 static char nvme_pr_type(enum pr_type type)
 {
 	switch (type) {
@@ -2187,6 +2250,7 @@ static const struct block_device_operations nvme_fops = {
 	.release	= nvme_release,
 	.getgeo		= nvme_getgeo,
 	.revalidate_disk= nvme_revalidate_disk,
+	.report_zones	= nvme_report_zones,
 	.pr_ops		= &nvme_pr_ops,
 };
 
@@ -2212,6 +2276,7 @@ const struct block_device_operations nvme_ns_head_ops = {
 	.ioctl		= nvme_ioctl,
 	.compat_ioctl	= nvme_compat_ioctl,
 	.getgeo		= nvme_getgeo,
+	.report_zones	= nvme_report_zones,
 	.pr_ops		= &nvme_pr_ops,
 };
 #endif /* CONFIG_NVME_MULTIPATH */
@@ -4439,6 +4504,8 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != NVME_IDENTIFY_DATA_SIZE);
+	BUILD_BUG_ON(sizeof(struct nvme_id_ns_zns) != NVME_IDENTIFY_DATA_SIZE);
+	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl_zns) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
 	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 58428e3a590e..662f95fbd909 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -239,6 +239,9 @@ struct nvme_ctrl {
 	u32 max_hw_sectors;
 	u32 max_segments;
 	u32 max_integrity_segments;
+#ifdef CONFIG_BLK_DEV_ZONED
+	u32 max_zone_append;
+#endif
 	u16 crdt[3];
 	u16 oncs;
 	u16 oacs;
@@ -403,6 +406,9 @@ struct nvme_ns {
 	u16 sgs;
 	u32 sws;
 	u8 pi_type;
+#ifdef CONFIG_BLK_DEV_ZONED
+	u64 zsze;
+#endif
 	unsigned long features;
 	unsigned long flags;
 #define NVME_NS_REMOVING	0
@@ -568,6 +574,9 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 		void *log, size_t size, u64 offset);
+struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
+		struct nvme_ns_head **head, int *srcu_idx);
+void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx);
 
 extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct block_device_operations nvme_ns_head_ops;
@@ -689,6 +698,36 @@ static inline void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 }
 #endif /* CONFIG_NVME_MULTIPATH */
 
+#ifdef CONFIG_BLK_DEV_ZONED
+int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
+			  unsigned lbaf);
+
+int nvme_report_zones(struct gendisk *disk, sector_t sector,
+		      unsigned int nr_zones, report_zones_cb cb, void *data);
+
+blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
+				       struct nvme_command *cmnd,
+				       enum nvme_zone_mgmt_action action);
+#else
+#define nvme_report_zones NULL
+
+static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns,
+		struct request *req, struct nvme_command *cmnd,
+		enum nvme_zone_mgmt_action action)
+{
+	return BLK_STS_NOTSUPP;
+}
+
+static inline int nvme_update_zone_info(struct gendisk *disk,
+					struct nvme_ns *ns,
+					unsigned lbaf)
+{
+	dev_warn(ns->ctrl->device,
+		 "Please enable CONFIG_BLK_DEV_ZONED to support ZNS devices\n");
+	return -EPROTONOSUPPORT;
+}
+#endif
+
 #ifdef CONFIG_NVM
 int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
 void nvme_nvm_unregister(struct nvme_ns *ns);
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
new file mode 100644
index 000000000000..d57fbbfe15e8
--- /dev/null
+++ b/drivers/nvme/host/zns.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Western Digital Corporation or its affiliates.
+ */
+
+#include <linux/blkdev.h>
+#include <linux/vmalloc.h>
+#include "nvme.h"
+
+static int nvme_set_max_append(struct nvme_ctrl *ctrl)
+{
+	struct nvme_command c = { };
+	struct nvme_id_ctrl_zns *id;
+	int status;
+
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id)
+		return -ENOMEM;
+
+	c.identify.opcode = nvme_admin_identify;
+	c.identify.cns = NVME_ID_CNS_CS_CTRL;
+	c.identify.csi = NVME_CSI_ZNS;
+
+	status = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
+	if (status) {
+		kfree(id);
+		return status;
+	}
+
+	ctrl->max_zone_append = 1 << (id->zamds + 3);
+	kfree(id);
+	return 0;
+}
+
+int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
+			  unsigned lbaf)
+{
+	struct nvme_effects_log *log = ns->head->effects;
+	struct request_queue *q = disk->queue;
+	struct nvme_command c = { };
+	struct nvme_id_ns_zns *id;
+	int status;
+
+	/* Driver requires zone append support */
+	if (!(log->iocs[nvme_cmd_zone_append] & NVME_CMD_EFFECTS_CSUPP))
+		return -ENODEV;
+
+	/* Lazily query controller append limit for the first zoned namespace */
+	if (!ns->ctrl->max_zone_append) {
+		status = nvme_set_max_append(ns->ctrl);
+		if (status)
+			return status;
+	}
+
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id)
+		return -ENOMEM;
+
+	c.identify.opcode = nvme_admin_identify;
+	c.identify.nsid = cpu_to_le32(ns->head->ns_id);
+	c.identify.cns = NVME_ID_CNS_CS_NS;
+	c.identify.csi = NVME_CSI_ZNS;
+
+	status = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, id, sizeof(*id));
+	if (status)
+		goto free_data;
+
+	/*
+	 * We currently do not handle devices requiring any of the zoned
+	 * operation characteristics.
+	 */
+	if (id->zoc) {
+		status = -EINVAL;
+		goto free_data;
+	}
+
+	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
+	if (!ns->zsze) {
+		status = -EINVAL;
+		goto free_data;
+	}
+
+	q->limits.zoned = BLK_ZONED_HM;
+	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
+free_data:
+	kfree(id);
+	return status;
+}
+
+static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
+					  unsigned int nr_zones, size_t *buflen)
+{
+	struct request_queue *q = ns->disk->queue;
+	size_t bufsize;
+	void *buf;
+
+	const size_t min_bufsize = sizeof(struct nvme_zone_report) +
+				   sizeof(struct nvme_zone_descriptor);
+
+	nr_zones = min_t(unsigned int, nr_zones,
+			 get_capacity(ns->disk) >> ilog2(ns->zsze));
+
+	bufsize = sizeof(struct nvme_zone_report) +
+		nr_zones * sizeof(struct nvme_zone_descriptor);
+	bufsize = min_t(size_t, bufsize,
+			queue_max_hw_sectors(q) << SECTOR_SHIFT);
+	bufsize = min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT);
+
+	while (bufsize >= min_bufsize) {
+		buf = __vmalloc(bufsize,
+				GFP_KERNEL | __GFP_ZERO | __GFP_NORETRY);
+		if (buf) {
+			*buflen = bufsize;
+			return buf;
+		}
+		bufsize >>= 1;
+	}
+	return NULL;
+}
+
+static int __nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
+				  struct nvme_zone_report *report,
+				  size_t buflen)
+{
+	struct nvme_command c = { };
+	int ret;
+
+	c.zmr.opcode = nvme_cmd_zone_mgmt_recv;
+	c.zmr.nsid = cpu_to_le32(ns->head->ns_id);
+	c.zmr.slba = cpu_to_le64(nvme_sect_to_lba(ns, sector));
+	c.zmr.numd = cpu_to_le32(nvme_bytes_to_numd(buflen));
+	c.zmr.zra = NVME_ZRA_ZONE_REPORT;
+	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
+	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
+
+	ret = nvme_submit_sync_cmd(ns->queue, &c, report, buflen);
+	if (ret)
+		return ret;
+
+	return le64_to_cpu(report->nr_zones);
+}
+
+static int nvme_zone_parse_entry(struct nvme_ns *ns,
+				 struct nvme_zone_descriptor *entry,
+				 unsigned int idx, report_zones_cb cb,
+				 void *data)
+{
+	struct blk_zone zone = { };
+
+	if ((entry->zt & 0xf) != NVME_ZONE_TYPE_SEQWRITE_REQ) {
+		dev_err(ns->ctrl->device, "invalid zone type %#x\n",
+				entry->zt);
+		return -EINVAL;
+	}
+
+	zone.type = BLK_ZONE_TYPE_SEQWRITE_REQ;
+	zone.cond = entry->zs >> 4;
+	zone.len = ns->zsze;
+	zone.capacity = nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
+	zone.start = nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
+	zone.wp = nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
+
+	return cb(&zone, idx, data);
+}
+
+static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
+			unsigned int nr_zones, report_zones_cb cb, void *data)
+{
+	struct nvme_zone_report *report;
+	int ret, zone_idx = 0;
+	unsigned int nz, i;
+	size_t buflen;
+
+	report = nvme_zns_alloc_report_buffer(ns, nr_zones, &buflen);
+	if (!report)
+		return -ENOMEM;
+
+	sector &= ~(ns->zsze - 1);
+	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
+		memset(report, 0, buflen);
+		ret = __nvme_ns_report_zones(ns, sector, report, buflen);
+		if (ret < 0)
+			goto out_free;
+
+		nz = min_t(unsigned int, ret, nr_zones);
+		if (!nz)
+			break;
+
+		for (i = 0; i < nz && zone_idx < nr_zones; i++) {
+			ret = nvme_zone_parse_entry(ns, &report->entries[i],
+						    zone_idx, cb, data);
+			if (ret)
+				goto out_free;
+			zone_idx++;
+		}
+
+		sector += ns->zsze * nz;
+	}
+
+	ret = zone_idx;
+out_free:
+	kvfree(report);
+	return ret;
+}
+
+int nvme_report_zones(struct gendisk *disk, sector_t sector,
+		      unsigned int nr_zones, report_zones_cb cb, void *data)
+{
+	struct nvme_ns_head *head = NULL;
+	struct nvme_ns *ns;
+	int srcu_idx, ret;
+
+	ns = nvme_get_ns_from_disk(disk, &head, &srcu_idx);
+	if (unlikely(!ns))
+		return -EWOULDBLOCK;
+
+	if (ns->head->ids.csi == NVME_CSI_ZNS)
+		ret = nvme_ns_report_zones(ns, sector, nr_zones, cb, data);
+	else
+		ret = -EINVAL;
+	nvme_put_ns_from_disk(head, srcu_idx);
+
+	return ret;
+}
+
+blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
+		struct nvme_command *c, enum nvme_zone_mgmt_action action)
+{
+	c->zms.opcode = nvme_cmd_zone_mgmt_send;
+	c->zms.nsid = cpu_to_le32(ns->head->ns_id);
+	c->zms.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
+	c->zms.zsa = action;
+
+	if (req_op(req) == REQ_OP_ZONE_RESET_ALL)
+		c->zms.select_all = 1;
+
+	return BLK_STS_OK;
+}
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 95cd03e240a1..d862e5d70818 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Definitions for the NVM Express interface
+ * Definitions for the NVM Ex
+ * ress interface
  * Copyright (c) 2011-2014, Intel Corporation.
  */
 
@@ -374,6 +375,30 @@ struct nvme_id_ns {
 	__u8			vs[3712];
 };
 
+struct nvme_zns_lbafe {
+	__le64			zsze;
+	__u8			zdes;
+	__u8			rsvd9[7];
+};
+
+struct nvme_id_ns_zns {
+	__le16			zoc;
+	__le16			ozcs;
+	__le32			mar;
+	__le32			mor;
+	__le32			rrl;
+	__le32			frl;
+	__u8			rsvd20[2796];
+	struct nvme_zns_lbafe	lbafe[16];
+	__u8			rsvd3072[768];
+	__u8			vs[256];
+};
+
+struct nvme_id_ctrl_zns {
+	__u8	zamds;
+	__u8	rsvd1[4095];
+};
+
 enum {
 	NVME_ID_CNS_NS			= 0x00,
 	NVME_ID_CNS_CTRL		= 0x01,
@@ -392,6 +417,7 @@ enum {
 
 enum {
 	NVME_CSI_NVM			= 0,
+	NVME_CSI_ZNS			= 2,
 };
 
 enum {
@@ -532,6 +558,27 @@ struct nvme_ana_rsp_hdr {
 	__le16	rsvd10[3];
 };
 
+struct nvme_zone_descriptor {
+	__u8		zt;
+	__u8		zs;
+	__u8		za;
+	__u8		rsvd3[5];
+	__le64		zcap;
+	__le64		zslba;
+	__le64		wp;
+	__u8		rsvd32[32];
+};
+
+enum {
+	NVME_ZONE_TYPE_SEQWRITE_REQ	= 0x2,
+};
+
+struct nvme_zone_report {
+	__le64		nr_zones;
+	__u8		resv8[56];
+	struct nvme_zone_descriptor entries[];
+};
+
 enum {
 	NVME_SMART_CRIT_SPARE		= 1 << 0,
 	NVME_SMART_CRIT_TEMPERATURE	= 1 << 1,
@@ -626,6 +673,9 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_zone_mgmt_send	= 0x79,
+	nvme_cmd_zone_mgmt_recv	= 0x7a,
+	nvme_cmd_zone_append	= 0x7d,
 };
 
 #define nvme_opcode_name(opcode)	{ opcode, #opcode }
@@ -764,6 +814,7 @@ struct nvme_rw_command {
 enum {
 	NVME_RW_LR			= 1 << 15,
 	NVME_RW_FUA			= 1 << 14,
+	NVME_RW_APPEND_PIREMAP		= 1 << 9,
 	NVME_RW_DSM_FREQ_UNSPEC		= 0,
 	NVME_RW_DSM_FREQ_TYPICAL	= 1,
 	NVME_RW_DSM_FREQ_RARE		= 2,
@@ -829,6 +880,53 @@ struct nvme_write_zeroes_cmd {
 	__le16			appmask;
 };
 
+enum nvme_zone_mgmt_action {
+	NVME_ZONE_CLOSE		= 0x1,
+	NVME_ZONE_FINISH	= 0x2,
+	NVME_ZONE_OPEN		= 0x3,
+	NVME_ZONE_RESET		= 0x4,
+	NVME_ZONE_OFFLINE	= 0x5,
+	NVME_ZONE_SET_DESC_EXT	= 0x10,
+};
+
+struct nvme_zone_mgmt_send_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__le32			cdw2[2];
+	__le64			metadata;
+	union nvme_data_ptr	dptr;
+	__le64			slba;
+	__le32			cdw12;
+	__u8			zsa;
+	__u8			select_all;
+	__u8			rsvd13[2];
+	__le32			cdw14[2];
+};
+
+struct nvme_zone_mgmt_recv_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__le64			rsvd2[2];
+	union nvme_data_ptr	dptr;
+	__le64			slba;
+	__le32			numd;
+	__u8			zra;
+	__u8			zrasf;
+	__u8			pr;
+	__u8			rsvd13;
+	__le32			cdw14[2];
+};
+
+enum {
+	NVME_ZRA_ZONE_REPORT		= 0,
+	NVME_ZRASF_ZONE_REPORT_ALL	= 0,
+	NVME_REPORT_ZONE_PARTIAL	= 1,
+};
+
 /* Features */
 
 enum {
@@ -1300,6 +1398,8 @@ struct nvme_command {
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
 		struct nvme_write_zeroes_cmd write_zeroes;
+		struct nvme_zone_mgmt_send_cmd zms;
+		struct nvme_zone_mgmt_recv_cmd zmr;
 		struct nvme_abort_cmd abort;
 		struct nvme_get_log_page_command get_log_page;
 		struct nvmf_common_command fabrics;
@@ -1433,6 +1533,18 @@ enum {
 	NVME_SC_DISCOVERY_RESTART	= 0x190,
 	NVME_SC_AUTH_REQUIRED		= 0x191,
 
+	/*
+	 * I/O Command Set Specific - Zoned commands:
+	 */
+	NVME_SC_ZONE_BOUNDARY_ERROR	= 0x1b8,
+	NVME_SC_ZONE_FULL		= 0x1b9,
+	NVME_SC_ZONE_READ_ONLY		= 0x1ba,
+	NVME_SC_ZONE_OFFLINE		= 0x1bb,
+	NVME_SC_ZONE_INVALID_WRITE	= 0x1bc,
+	NVME_SC_ZONE_TOO_MANY_ACTIVE	= 0x1bd,
+	NVME_SC_ZONE_TOO_MANY_OPEN	= 0x1be,
+	NVME_SC_ZONE_INVALID_TRANSITION	= 0x1bf,
+
 	/*
 	 * Media and Data Integrity Errors:
 	 */
-- 
2.24.1

