Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40C6C4361B
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 06:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B2CD20791
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 06:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgLOGE6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Dec 2020 01:04:58 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50723 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgLOGE5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Dec 2020 01:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608012297; x=1639548297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QgzWV+8w7DbIWzCQSn3bHv5sDcQ6RfkMG0ZuK/gm7WY=;
  b=c8sFJfjTg4Zkt9JbI1SLcBoo02FaKXC91gU4Nn6OvEYTgdUOzA/v8SGU
   9yUjnj9Clo+7ZCFSSKb2G89HMjd2OBPpBp9b/dTwkTfjJwiL6jkpq2axe
   HrvceKwH8+rIaHUlFeuAiUgLkucYG4hDFgzgjYXm46COdLQn3CpCx/00E
   6ohzCb6ijvUjpg465DZg0EtJMb1mXbQW7K3Lt1raUKtxJXYAsNG+eX7lY
   B01hgOYKhho5Pa15PnrA1FQft66eOroreWDL4H336VHDB3fgnQRihtXOV
   8cxIMn27o2Xqlk1hsLdXl0TpolHrbzWYWFNyHx4wumh1U5F3mvBPC/w3d
   Q==;
IronPort-SDR: DcWDG5iAv9kzsepGxBAfQqyrqh0bSjQAY2y7q9uBt2Q6I9xwM1N7auIoucs5UUCUEHQxQ4OH2s
 bWBiyAHMX2+sWwdgnMzOuJHflZC3ofro/EAEbnFtay10CnVy2LGqZbiqdX8A4Ha8byHx22AeDA
 DHnktT/EB4r2RX2wfc4K0H4vonXTzg+rKZ9paj8R78abNMruhfgnUPWE+YHRqqruwGAzBZ9zcR
 SGYxvrqwxAKjPzp/KkW7p1Iv7mUAs6lSrFTRcZhhxt0RHWPdxOoKvokRX9gsbeYwrY9PnMyttJ
 zA8=
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400"; 
   d="scan'208";a="159618800"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2020 14:03:52 +0800
IronPort-SDR: bIQujIQV0IBYEk2Keh9o7CxH60U2MNuWVdCc2Fqcz0lInFMed/FXXlU0mAqZmxQeZnXZaZOfdi
 YhE45uNE4qnHi03L8Fc7Zop0KnywSebH9N40Bivd6P96rtElb08l5F1gHa986XEISbdPRqwQ2I
 U2CUkqgLwl+cbG8jG5Ocn0TbRfYilzvUX7IdlmFjKF6So3jEE7M1vROF76bHs5fLaw+hDRv+mu
 XDojs+eOO3JtZCV/4rNG/ANOKdA/khXyVDfnTiiQJacgHAmKWFt8Y6wim88GER0izXuI3xX0bq
 1zI3TdUpm4HG+3gCUYO1BWvJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 21:47:34 -0800
IronPort-SDR: XekbtZb2av2nVLIXOYbj4xQ03AUpZ48sJDCVTrC0b5NUx2h6ECZIm+D9gA/cXQgINJSIVps2Lc
 8alFIJO8FnjurG3dKziKNIeQIAjkVOYwkwzosDGEeBwIqW/9RRzI7Blj+xICLytYHh3ULLkr9b
 gneXjtHF9RC1pnTSk2vRp2C7Wjz9rK/EaIv9p+Ah2KJu/ZwHLjyjNMwiaACHcX5A5pzYt97jgw
 7adT+KjsD58nXnC35LLobNkBzNkHvxRpuC85bRJmgQQEUOO38SVuZxJPpwHHA/1rENxztOCUaN
 fhw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Dec 2020 22:03:52 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V7 4/6] nvmet: add ZBD over ZNS backend support
Date:   Mon, 14 Dec 2020 22:03:03 -0800
Message-Id: <20201215060305.28141-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
References: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NVMe TP 4053 – Zoned Namespaces (ZNS) allows host software to
communicate with a non-volatile memory subsystem using zones for
NVMe protocol based controllers. NVMeOF already support the ZNS NVMe
Protocol compliant devices on the target in the passthru mode. There
are Generic zoned block devices like  Shingled Magnetic Recording (SMR)
HDDs which are not based on the NVMe protocol.

This patch adds ZNS backend to support the ZBDs for NVMeOF target.

This support includes implementing the new command set NVME_CSI_ZNS,
adding different command handlers for ZNS command set such as
NVMe Identify Controller, NVMe Identify Namespace, NVMe Zone Append,
NVMe Zone Management Send and NVMe Zone Management Receive.

With new command set identifier we also update the target command effects
logs to reflect the ZNS compliant commands.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/Makefile      |   1 +
 drivers/nvme/target/admin-cmd.c   |  26 +++
 drivers/nvme/target/core.c        |   1 +
 drivers/nvme/target/io-cmd-bdev.c |  33 ++-
 drivers/nvme/target/nvmet.h       |  38 ++++
 drivers/nvme/target/zns.c         | 342 ++++++++++++++++++++++++++++++
 6 files changed, 433 insertions(+), 8 deletions(-)
 create mode 100644 drivers/nvme/target/zns.c

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index ebf91fc4c72e..9837e580fa7e 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
 nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
 			discovery.o io-cmd-file.o io-cmd-bdev.o
 nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
+nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
 nvme-loop-y	+= loop.o
 nvmet-rdma-y	+= rdma.o
 nvmet-fc-y	+= fc.o
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f4c0f3aca485..6f5279b15aa6 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -192,6 +192,15 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 		log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
 		log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
 		break;
+	case NVME_CSI_ZNS:
+		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+			u32 *iocs = log->iocs;
+
+			iocs[nvme_cmd_zone_append]	= cpu_to_le32(1 << 0);
+			iocs[nvme_cmd_zone_mgmt_send]	= cpu_to_le32(1 << 0);
+			iocs[nvme_cmd_zone_mgmt_recv]	= cpu_to_le32(1 << 0);
+		}
+		break;
 	default:
 		status = NVME_SC_INVALID_LOG_PAGE;
 		break;
@@ -614,6 +623,7 @@ static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
 
 static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 {
+	u16 nvme_cis_zns = NVME_CSI_ZNS;
 	u16 status = 0;
 	off_t off = 0;
 
@@ -638,6 +648,14 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 		if (status)
 			goto out;
 	}
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+		if (req->ns->csi == NVME_CSI_ZNS)
+			status = nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,
+							  NVME_NIDT_CSI_LEN,
+							  &nvme_cis_zns, &off);
+		if (status)
+			goto out;
+	}
 
 	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
 			off) != NVME_IDENTIFY_DATA_SIZE - off)
@@ -655,8 +673,16 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 	switch (req->cmd->identify.cns) {
 	case NVME_ID_CNS_NS:
 		return nvmet_execute_identify_ns(req);
+	case NVME_ID_CNS_CS_NS:
+		if (req->cmd->identify.csi == NVME_CSI_ZNS)
+			return nvmet_execute_identify_cns_cs_ns(req);
+		break;
 	case NVME_ID_CNS_CTRL:
 		return nvmet_execute_identify_ctrl(req);
+	case NVME_ID_CNS_CS_CTRL:
+		if (req->cmd->identify.csi == NVME_CSI_ZNS)
+			return nvmet_execute_identify_cns_cs_ctrl(req);
+		break;
 	case NVME_ID_CNS_NS_ACTIVE_LIST:
 		return nvmet_execute_identify_nslist(req);
 	case NVME_ID_CNS_NS_DESC_LIST:
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 672e4009f8d6..17a99c7134dc 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1107,6 +1107,7 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
 static inline bool nvmet_cc_css_check(u8 cc_css)
 {
 	switch (cc_css <<= NVME_CC_CSS_SHIFT) {
+	case NVME_CC_CSS_CSI:
 	case NVME_CC_CSS_NVM:
 		return true;
 	default:
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 23095bdfce06..6178ef643962 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -63,6 +63,14 @@ static void nvmet_bdev_ns_enable_integrity(struct nvmet_ns *ns)
 	}
 }
 
+void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
+{
+	if (ns->bdev) {
+		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
+		ns->bdev = NULL;
+	}
+}
+
 int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 {
 	int ret;
@@ -86,15 +94,15 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY_T10))
 		nvmet_bdev_ns_enable_integrity(ns);
 
-	return 0;
-}
-
-void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
-{
-	if (ns->bdev) {
-		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
-		ns->bdev = NULL;
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && bdev_is_zoned(ns->bdev)) {
+		if (!nvmet_bdev_zns_enable(ns)) {
+			nvmet_bdev_ns_disable(ns);
+			return -EINVAL;
+		}
+		ns->csi = NVME_CSI_ZNS;
 	}
+
+	return 0;
 }
 
 void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
@@ -448,6 +456,15 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_bdev_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_zone_append:
+		req->execute = nvmet_bdev_execute_zone_append;
+		return 0;
+	case nvme_cmd_zone_mgmt_recv:
+		req->execute = nvmet_bdev_execute_zone_mgmt_recv;
+		return 0;
+	case nvme_cmd_zone_mgmt_send:
+		req->execute = nvmet_bdev_execute_zone_mgmt_send;
+		return 0;
 	default:
 		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
 		       req->sq->qid);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 476b3cd91c65..7361665585a2 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -252,6 +252,10 @@ struct nvmet_subsys {
 	unsigned int		admin_timeout;
 	unsigned int		io_timeout;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
+
+#ifdef CONFIG_BLK_DEV_ZONED
+	u8			zasl;
+#endif /* CONFIG_BLK_DEV_ZONED */
 };
 
 static inline struct nvmet_subsys *to_subsys(struct config_item *item)
@@ -614,4 +618,38 @@ static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
 	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
+bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
+void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
+void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
+void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
+void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
+void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
+#else  /* CONFIG_BLK_DEV_ZONED */
+static inline bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
+{
+	return false;
+}
+static inline void
+nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
+{
+}
+static inline void
+nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
+{
+}
+static inline void
+nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
+{
+}
+static inline void
+nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
+{
+}
+static inline void
+nvmet_bdev_execute_zone_append(struct nvmet_req *req)
+{
+}
+#endif /* CONFIG_BLK_DEV_ZONED */
+
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
new file mode 100644
index 000000000000..3981baa647b2
--- /dev/null
+++ b/drivers/nvme/target/zns.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMe ZNS-ZBD command implementation.
+ * Copyright (c) 2020-2021 HGST, a Western Digital Company.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/nvme.h>
+#include <linux/blkdev.h>
+#include "nvmet.h"
+
+/*
+ * We set the Memory Page Size Minimum (MPSMIN) for target controller to 0
+ * which gets added by 12 in the nvme_enable_ctrl() which results in 2^12 = 4k
+ * as page_shift value. When calculating the ZASL use shift by 12.
+ */
+#define NVMET_MPSMIN_SHIFT	12
+
+static u16 nvmet_bdev_zns_checks(struct nvmet_req *req)
+{
+	u16 status = NVME_SC_SUCCESS;
+
+	if (!bdev_is_zoned(req->ns->bdev)) {
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		goto out;
+	}
+
+	if (req->cmd->zmr.zra != NVME_ZRA_ZONE_REPORT) {
+		status = NVME_SC_INVALID_FIELD;
+		goto out;
+	}
+
+	if (req->cmd->zmr.zrasf != NVME_ZRASF_ZONE_REPORT_ALL) {
+		status = NVME_SC_INVALID_FIELD;
+		goto out;
+	}
+
+	if (req->cmd->zmr.pr != NVME_REPORT_ZONE_PARTIAL)
+		status = NVME_SC_INVALID_FIELD;
+
+out:
+	return status;
+}
+
+/*
+ *  ZNS related command implementation and helpers.
+ */
+
+static inline u8 nvmet_zasl(unsigned int zone_append_sects)
+{
+	/*
+	 * Zone Append Size Limit is the value experessed in the units
+	 * of minimum memory page size (i.e. 12) and is reported power of 2.
+	 */
+	return ilog2((zone_append_sects << 9) >> NVMET_MPSMIN_SHIFT);
+}
+
+static inline bool nvmet_zns_update_zasl(struct nvmet_ns *ns)
+{
+	struct request_queue *q = ns->bdev->bd_disk->queue;
+	u8 zasl = nvmet_zasl(queue_max_zone_append_sectors(q));
+
+	if (ns->subsys->zasl)
+		return ns->subsys->zasl < zasl ? false : true;
+
+	ns->subsys->zasl = zasl;
+	return true;
+}
+
+
+static int nvmet_bdev_validate_zns_zones_cb(struct blk_zone *z,
+					    unsigned int idx, void *data)
+{
+	if (z->type == BLK_ZONE_TYPE_CONVENTIONAL)
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static bool nvmet_bdev_has_conv_zones(struct block_device *bdev)
+{
+	int ret;
+
+	if (bdev->bd_disk->queue->conv_zones_bitmap)
+		return true;
+
+	ret = blkdev_report_zones(bdev, 0, blkdev_nr_zones(bdev->bd_disk),
+				  nvmet_bdev_validate_zns_zones_cb, NULL);
+
+	return ret < 0 ? true : false;
+}
+
+bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
+{
+	if (nvmet_bdev_has_conv_zones(ns->bdev))
+		return false;
+
+	/*
+	 * For ZBC and ZAC devices, writes into sequential zones must be aligned
+	 * to the device physical block size. So use this value as the logical
+	 * block size to avoid errors.
+	 */
+	ns->blksize_shift = blksize_bits(bdev_physical_block_size(ns->bdev));
+
+	if (!nvmet_zns_update_zasl(ns))
+		return false;
+
+	return !(get_capacity(ns->bdev->bd_disk) &
+			(bdev_zone_sectors(ns->bdev) - 1));
+}
+
+/*
+ * ZNS related Admin and I/O command handlers.
+ */
+void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
+{
+	u8 zasl = req->sq->ctrl->subsys->zasl;
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvme_id_ctrl_zns *id;
+	u16 status;
+
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	if (ctrl->ops->get_mdts)
+		id->zasl = min_t(u8, ctrl->ops->get_mdts(ctrl), zasl);
+	else
+		id->zasl = zasl;
+
+	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
+
+	kfree(id);
+out:
+	nvmet_req_complete(req, status);
+}
+
+void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
+{
+	struct nvme_id_ns_zns *id_zns;
+	u16 status = NVME_SC_SUCCESS;
+	u64 zsze;
+
+	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
+		req->error_loc = offsetof(struct nvme_identify, nsid);
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		goto out;
+	}
+
+	id_zns = kzalloc(sizeof(*id_zns), GFP_KERNEL);
+	if (!id_zns) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
+	if (!req->ns) {
+		status = NVME_SC_INTERNAL;
+		goto done;
+	}
+
+	if (!bdev_is_zoned(req->ns->bdev)) {
+		req->error_loc = offsetof(struct nvme_identify, nsid);
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		goto done;
+	}
+
+	nvmet_ns_revalidate(req->ns);
+	zsze = (bdev_zone_sectors(req->ns->bdev) << 9) >>
+					req->ns->blksize_shift;
+	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
+	id_zns->mor = cpu_to_le32(bdev_max_open_zones(req->ns->bdev));
+	id_zns->mar = cpu_to_le32(bdev_max_active_zones(req->ns->bdev));
+
+done:
+	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
+	kfree(id_zns);
+out:
+	nvmet_req_complete(req, status);
+}
+
+struct nvmet_report_zone_data {
+	struct nvmet_ns *ns;
+	struct nvme_zone_report *rz;
+};
+
+static int nvmet_bdev_report_zone_cb(struct blk_zone *z, unsigned int idx,
+				     void *data)
+{
+	struct nvmet_report_zone_data *report_zone_data = data;
+	struct nvme_zone_descriptor *entries = report_zone_data->rz->entries;
+	struct nvmet_ns *ns = report_zone_data->ns;
+
+	entries[idx].zcap = nvmet_sect_to_lba(ns, z->capacity);
+	entries[idx].zslba = nvmet_sect_to_lba(ns, z->start);
+	entries[idx].wp = nvmet_sect_to_lba(ns, z->wp);
+	entries[idx].za = z->reset ? 1 << 2 : 0;
+	entries[idx].zt = z->type;
+	entries[idx].zs = z->cond << 4;
+
+	return 0;
+}
+
+void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
+{
+	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
+	u32 bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
+	struct nvmet_report_zone_data data = { .ns = req->ns };
+	unsigned int nr_zones;
+	int reported_zones;
+	u16 status;
+
+	nr_zones = (bufsize - sizeof(struct nvme_zone_report)) /
+			sizeof(struct nvme_zone_descriptor);
+
+	status = nvmet_bdev_zns_checks(req);
+	if (status)
+		goto out;
+
+	data.rz = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO);
+	if (!data.rz) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	reported_zones = blkdev_report_zones(req->ns->bdev, sect, nr_zones,
+					     nvmet_bdev_report_zone_cb,
+					     &data);
+	if (reported_zones < 0) {
+		status = NVME_SC_INTERNAL;
+		goto out_free_report_zones;
+	}
+
+	data.rz->nr_zones = cpu_to_le64(reported_zones);
+
+	status = nvmet_copy_to_sgl(req, 0, data.rz, bufsize);
+
+out_free_report_zones:
+	kvfree(data.rz);
+out:
+	nvmet_req_complete(req, status);
+}
+
+void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
+{
+	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);
+	sector_t nr_sect = bdev_zone_sectors(req->ns->bdev);
+	u16 status = NVME_SC_SUCCESS;
+	enum req_opf op;
+	int ret;
+
+	if (req->cmd->zms.select_all)
+		nr_sect = get_capacity(req->ns->bdev->bd_disk);
+
+	switch (req->cmd->zms.zsa) {
+	case NVME_ZONE_OPEN:
+		op = REQ_OP_ZONE_OPEN;
+		break;
+	case NVME_ZONE_CLOSE:
+		op = REQ_OP_ZONE_CLOSE;
+		break;
+	case NVME_ZONE_FINISH:
+		op = REQ_OP_ZONE_FINISH;
+		break;
+	case NVME_ZONE_RESET:
+		op = REQ_OP_ZONE_RESET;
+		break;
+	default:
+		status = NVME_SC_INVALID_FIELD;
+		goto out;
+	}
+
+	ret = blkdev_zone_mgmt(req->ns->bdev, op, sect, nr_sect, GFP_KERNEL);
+	if (ret)
+		status = NVME_SC_INTERNAL;
+out:
+	nvmet_req_complete(req, status);
+}
+
+void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
+{
+	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
+	struct request_queue *q = req->ns->bdev->bd_disk->queue;
+	unsigned int max_sects = queue_max_zone_append_sectors(q);
+	u16 status = NVME_SC_SUCCESS;
+	unsigned int total_len = 0;
+	struct scatterlist *sg;
+	int ret = 0, sg_cnt;
+	struct bio *bio;
+
+	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
+		return;
+
+	if (!req->sg_cnt) {
+		nvmet_req_complete(req, 0);
+		return;
+	}
+
+	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
+		bio = &req->b.inline_bio;
+		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
+	} else {
+		bio = bio_alloc(GFP_KERNEL, req->sg_cnt);
+	}
+
+	bio_set_dev(bio, req->ns->bdev);
+	bio->bi_iter.bi_sector = sect;
+	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
+	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
+		bio->bi_opf |= REQ_FUA;
+
+	for_each_sg(req->sg, sg, req->sg_cnt, sg_cnt) {
+		struct page *p = sg_page(sg);
+		unsigned int l = sg->length;
+		unsigned int o = sg->offset;
+		bool same_page = false;
+
+		ret = bio_add_hw_page(q, bio, p, l, o, max_sects, &same_page);
+		if (ret != sg->length) {
+			status = NVME_SC_INTERNAL;
+			goto out_bio_put;
+		}
+		if (same_page)
+			put_page(p);
+
+		total_len += sg->length;
+	}
+
+	if (total_len != nvmet_rw_data_len(req)) {
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		goto out_bio_put;
+	}
+
+	ret = submit_bio_wait(bio);
+	req->cqe->result.u64 = nvmet_sect_to_lba(req->ns,
+						 bio->bi_iter.bi_sector);
+
+out_bio_put:
+	if (bio != &req->b.inline_bio)
+		bio_put(bio);
+	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL : status);
+}
-- 
2.22.1

