Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEFEC433DF
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 19:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F20220723
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 19:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593457615;
	bh=3xClpJBPNLC08/oirvKhxgs8ayLaUb+vP83nGBXxTsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u/wHxXAZXcrsddx1s6N02lqqqkgfKPXwOClr9Kzqt14tkjb42pGUQm9smkqneNR/6
	 dBQxQSS95UttfbsILgOgfN0lntFE5a9JBjp+w0P6+wlCzFV3xL6EHgdDMy2uJS/hk/
	 aeY4o4CMaTwYzg9P562zAyxQdSuL7iJzouVuQQ3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgF2TGy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730559AbgF2TGu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 15:06:50 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F33920702;
        Mon, 29 Jun 2020 19:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593457609;
        bh=3xClpJBPNLC08/oirvKhxgs8ayLaUb+vP83nGBXxTsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXClzJcvoFZZy/07zx7KPVoBEtwKXQ5ZkYg9GrGfAVXPgKlZ4jjbgAs/IGBDfg2V+
         exHUx8XjOxijIWjg/d1gdYO5sU90u9KP5m6+t5joVReDzgXPeYVu31UPhPBCUlNdTu
         tNjy/uF/ss3DU9mtrxTxUZ46Nhj3/LNLadYCP8dw=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Keith Busch <keith.busch@wdc.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCHv4 4/5] nvme: support for multi-command set effects
Date:   Mon, 29 Jun 2020 12:06:40 -0700
Message-Id: <20200629190641.1986462-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200629190641.1986462-1-kbusch@kernel.org>
References: <20200629190641.1986462-1-kbusch@kernel.org>
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Matias Bjørling <matias.bjorling@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <keith.busch@wdc.com>
---
 drivers/nvme/host/core.c      | 79 ++++++++++++++++++++++++++---------
 drivers/nvme/host/hwmon.c     |  2 +-
 drivers/nvme/host/lightnvm.c  |  4 +-
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/nvme.h      | 10 ++++-
 include/linux/nvme.h          |  4 +-
 6 files changed, 76 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b7d12eb42fd8..a4a61d7e793d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1370,8 +1370,8 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	u32 effects = 0;
 
 	if (ns) {
-		if (ctrl->effects)
-			effects = le32_to_cpu(ctrl->effects->iocs[opcode]);
+		if (ns->head->effects)
+			effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
 		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
 			dev_warn(ctrl->device,
 				 "IO command:%02x has unhandled effects:%08x\n",
@@ -2850,7 +2850,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	return ret;
 }
 
-int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
+int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 		void *log, size_t size, u64 offset)
 {
 	struct nvme_command c = { };
@@ -2864,27 +2864,55 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
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
@@ -2917,7 +2945,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	}
 
 	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
-		ret = nvme_get_effects_log(ctrl);
+		ret = nvme_get_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
 		if (ret < 0)
 			goto out_free;
 	}
@@ -3550,6 +3578,13 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
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
@@ -3890,8 +3925,8 @@ static void nvme_clear_changed_ns_log(struct nvme_ctrl *ctrl)
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
@@ -4035,8 +4070,8 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
 	if (!log)
 		return;
 
-	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, log,
-			sizeof(*log), 0))
+	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, NVME_CSI_NVM,
+			log, sizeof(*log), 0))
 		dev_warn(ctrl->device, "Get FW SLOT INFO log error\n");
 	kfree(log);
 }
@@ -4173,11 +4208,16 @@ static void nvme_free_ctrl(struct device *dev)
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
 
@@ -4208,6 +4248,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
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
index 18d084ed497e..b551e9884430 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -529,7 +529,7 @@ static int nvme_read_ana_log(struct nvme_ctrl *ctrl)
 	int error;
 
 	mutex_lock(&ctrl->ana_lock);
-	error = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_ANA, 0,
+	error = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_ANA, 0, NVME_CSI_NVM,
 			ctrl->ana_log_buf, ctrl->ana_log_size, 0);
 	if (error) {
 		dev_warn(ctrl->device, "Failed to get ANA log: %d\n", error);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4aa321b16eaa..dd24a94c42ff 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -191,6 +191,12 @@ struct nvme_fault_inject {
 #endif
 };
 
+struct nvme_cel {
+	struct list_head	entry;
+	struct nvme_effects_log	log;
+	u8			csi;
+};
+
 struct nvme_ctrl {
 	bool comp_seen;
 	enum nvme_ctrl_state state;
@@ -257,6 +263,7 @@ struct nvme_ctrl {
 	unsigned long quirks;
 	struct nvme_id_power_state psd[32];
 	struct nvme_effects_log *effects;
+	struct list_head cels;
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
@@ -359,6 +366,7 @@ struct nvme_ns_head {
 	struct kref		ref;
 	bool			shared;
 	int			instance;
+	struct nvme_effects_log *effects;
 #ifdef CONFIG_NVME_MULTIPATH
 	struct gendisk		*disk;
 	struct bio_list		requeue_list;
@@ -561,7 +569,7 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
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

