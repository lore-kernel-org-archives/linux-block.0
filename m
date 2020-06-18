Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83155C433E1
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 14:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5918F208C3
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 14:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592492051;
	bh=OsV2e+PrANXQbKd1rLIzwqqagQ2DDLNXwifleLm6Y1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wGmwPuP4NWh/veP2QBiqGNq2qMmPbOVidWB6r4lGkZrQlxtGrTRO1YPsl8qiGgc0A
	 dTNhk4Nb7IBrMJyMWDJdN4nW7csYinbwye3oDaQlVFgb0F3q7vAQsl2eV9pbeF8ul8
	 k1OmZVy4bfjMz0zXBR3acbeskP/DFqK2bb2RO2mU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbgFROyK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:54:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731107AbgFROyJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 10:54:09 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD91620897;
        Thu, 18 Jun 2020 14:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592492048;
        bh=OsV2e+PrANXQbKd1rLIzwqqagQ2DDLNXwifleLm6Y1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ALbU1sGI6BLHPBh33wl729i6H8rNCLyknb316aGS4tAqA/54VHP2hNqN8GuNciX1a
         Xiw5VsURTfFnhtJD/diRxXvrO9Fi9wypDCctfKBHULlvRgB8XwHj8BajeeGRv8JCvR
         yiZIerFMhZD/JLw6vLIPxOLSez78M/S7sbxedSGY=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me
Cc:     axboe@kernel.dk, Keith Busch <keith.busch@wdc.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCHv2 4/5] nvme: support for multi-command set effects
Date:   Thu, 18 Jun 2020 07:53:53 -0700
Message-Id: <20200618145354.1139350-5-kbusch@kernel.org>
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

The Commands Supported and Effects log page was extended with a CSI
field that enables the host to query the log page for each command set
supported. Retrieve this log page for each command set that an attached
namespace supports, and save a pointer to that log in the namespace head.

Reviewed-by: Javier González <javier.gonz@samsung.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <keith.busch@wdc.com>
---
 drivers/nvme/host/core.c      | 79 ++++++++++++++++++++++++++---------
 drivers/nvme/host/hwmon.c     |  2 +-
 drivers/nvme/host/lightnvm.c  |  4 +-
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/nvme.h      | 11 ++++-
 include/linux/nvme.h          |  4 +-
 6 files changed, 77 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 45a3cb5a35bd..64b7b9fc2817 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1363,8 +1363,8 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	u32 effects = 0;
 
 	if (ns) {
-		if (ctrl->effects)
-			effects = le32_to_cpu(ctrl->effects->iocs[opcode]);
+		if (ns->head->effects)
+			effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
 		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
 			dev_warn(ctrl->device,
 				 "IO command:%02x has unhandled effects:%08x\n",
@@ -2844,7 +2844,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	return ret;
 }
 
-int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
+int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 		void *log, size_t size, u64 offset)
 {
 	struct nvme_command c = { };
@@ -2858,27 +2858,55 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
 	c.get_log_page.numdu = cpu_to_le16(dwlen >> 16);
 	c.get_log_page.lpol = cpu_to_le32(lower_32_bits(offset));
 	c.get_log_page.lpou = cpu_to_le32(upper_32_bits(offset));
+	c.get_log_page.csi = csi;
 
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
 }
 
-static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
+struct nvme_cel *nvme_find_cel(struct nvme_ctrl *ctrl, u8 csi)
 {
+	struct nvme_cel *cel, *ret = NULL;
+
+	spin_lock(&ctrl->lock);
+	list_for_each_entry(cel, &ctrl->cels, entry) {
+		if (cel->csi == csi) {
+			ret = cel;
+			break;
+		}
+	}
+	spin_unlock(&ctrl->lock);
+
+	return ret;
+}
+
+static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
+				struct nvme_effects_log **log)
+{
+	struct nvme_cel *cel = nvme_find_cel(ctrl, csi);
 	int ret;
 
-	if (!ctrl->effects)
-		ctrl->effects = kzalloc(sizeof(*ctrl->effects), GFP_KERNEL);
+	if (cel)
+		goto out;
 
-	if (!ctrl->effects)
-		return 0;
+	cel = kzalloc(sizeof(*cel), GFP_KERNEL);
+	if (!cel)
+		return -ENOMEM;
 
-	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_CMD_EFFECTS, 0,
-			ctrl->effects, sizeof(*ctrl->effects), 0);
+	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_CMD_EFFECTS, 0, csi,
+			&cel->log, sizeof(cel->log), 0);
 	if (ret) {
-		kfree(ctrl->effects);
-		ctrl->effects = NULL;
+		kfree(cel);
+		return ret;
 	}
-	return ret;
+
+	cel->csi = csi;
+
+	spin_lock(&ctrl->lock);
+	list_add_tail(&cel->entry, &ctrl->cels);
+	spin_unlock(&ctrl->lock);
+out:
+	*log = &cel->log;
+	return 0;
 }
 
 /*
@@ -2911,7 +2939,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	}
 
 	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
-		ret = nvme_get_effects_log(ctrl);
+		ret = nvme_get_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
 		if (ret < 0)
 			goto out_free;
 	}
@@ -3544,6 +3572,13 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 		goto out_cleanup_srcu;
 	}
 
+	if (head->ids.csi) {
+		ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects);
+		if (ret)
+			goto out_cleanup_srcu;
+	} else
+		head->effects = ctrl->effects;
+
 	ret = nvme_mpath_alloc_disk(ctrl, head);
 	if (ret)
 		goto out_cleanup_srcu;
@@ -3884,8 +3919,8 @@ static void nvme_clear_changed_ns_log(struct nvme_ctrl *ctrl)
 	 * raced with us in reading the log page, which could cause us to miss
 	 * updates.
 	 */
-	error = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_CHANGED_NS, 0, log,
-			log_size, 0);
+	error = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_CHANGED_NS, 0,
+			NVME_CSI_NVM, log, log_size, 0);
 	if (error)
 		dev_warn(ctrl->device,
 			"reading changed ns log failed: %d\n", error);
@@ -4029,8 +4064,8 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
 	if (!log)
 		return;
 
-	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, log,
-			sizeof(*log), 0))
+	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, NVME_CSI_NVM,
+			log, sizeof(*log), 0))
 		dev_warn(ctrl->device, "Get FW SLOT INFO log error\n");
 	kfree(log);
 }
@@ -4167,11 +4202,16 @@ static void nvme_free_ctrl(struct device *dev)
 	struct nvme_ctrl *ctrl =
 		container_of(dev, struct nvme_ctrl, ctrl_device);
 	struct nvme_subsystem *subsys = ctrl->subsys;
+	struct nvme_cel *cel, *next;
 
 	if (subsys && ctrl->instance != subsys->instance)
 		ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 
-	kfree(ctrl->effects);
+	list_for_each_entry_safe(cel, next, &ctrl->cels, entry) {
+		list_del(&cel->entry);
+		kfree(cel);
+	}
+
 	nvme_mpath_uninit(ctrl);
 	__free_page(ctrl->discard_page);
 
@@ -4202,6 +4242,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
+	INIT_LIST_HEAD(&ctrl->cels);
 	init_rwsem(&ctrl->namespaces_rwsem);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 2e6477ed420f..23ba8bf678ae 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -62,7 +62,7 @@ static int nvme_hwmon_get_smart_log(struct nvme_hwmon_data *data)
 	int ret;
 
 	ret = nvme_get_log(data->ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
-			   &data->log, sizeof(data->log), 0);
+			   NVME_CSI_NVM, &data->log, sizeof(data->log), 0);
 
 	return ret <= 0 ? ret : -EIO;
 }
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 69608755d415..8e562d0f2c30 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -593,8 +593,8 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 		dev_meta_off = dev_meta;
 
 		ret = nvme_get_log(ctrl, ns->head->ns_id,
-				NVME_NVM_LOG_REPORT_CHUNK, 0, dev_meta, len,
-				offset);
+				NVME_NVM_LOG_REPORT_CHUNK, 0, NVME_CSI_NVM,
+				dev_meta, len, offset);
 		if (ret) {
 			dev_err(ctrl->device, "Get REPORT CHUNK log error\n");
 			break;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index da78e499947a..e4bbdf2acc09 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -531,7 +531,7 @@ static int nvme_read_ana_log(struct nvme_ctrl *ctrl)
 	int error;
 
 	mutex_lock(&ctrl->ana_lock);
-	error = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_ANA, 0,
+	error = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_ANA, 0, NVME_CSI_NVM,
 			ctrl->ana_log_buf, ctrl->ana_log_size, 0);
 	if (error) {
 		dev_warn(ctrl->device, "Failed to get ANA log: %d\n", error);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a84f71459caa..58428e3a590e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -191,6 +191,13 @@ struct nvme_fault_inject {
 #endif
 };
 
+
+struct nvme_cel {
+	struct list_head	entry;
+	struct nvme_effects_log	log;
+	u8			csi;
+};
+
 struct nvme_ctrl {
 	bool comp_seen;
 	enum nvme_ctrl_state state;
@@ -257,6 +264,7 @@ struct nvme_ctrl {
 	unsigned long quirks;
 	struct nvme_id_power_state psd[32];
 	struct nvme_effects_log *effects;
+	struct list_head cels;
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
@@ -359,6 +367,7 @@ struct nvme_ns_head {
 	struct kref		ref;
 	bool			shared;
 	int			instance;
+	struct nvme_effects_log *effects;
 #ifdef CONFIG_NVME_MULTIPATH
 	struct gendisk		*disk;
 	struct bio_list		requeue_list;
@@ -557,7 +566,7 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 
-int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
+int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 		void *log, size_t size, u64 offset);
 
 extern const struct attribute_group *nvme_ns_id_attr_groups[];
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 81ffe5247505..95cd03e240a1 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1101,7 +1101,9 @@ struct nvme_get_log_page_command {
 		};
 		__le64 lpo;
 	};
-	__u32			rsvd14[2];
+	__u8			rsvd14[3];
+	__u8			csi;
+	__u32			rsvd15;
 };
 
 struct nvme_directive_cmd {
-- 
2.24.1

