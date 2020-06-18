Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FFCC433E2
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 14:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 179E9208DB
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 14:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592492050;
	bh=Dd1gsICS/ZMoYWrmK3dpO/j+7w9K4YS1gPxMuBdnqmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bNY/iDrMyIX7rfXmUag1rRcCREpiv0yQLSGUhtjsMlQuntDuaId8meDKtW7WLcA6D
	 DZ3M4eGnH5Ta3/pbNExHp+uF7G6uHn7QIVLxxKU2+Pe6rB0YmrA3s4oQPUs/vGj9UU
	 Qfl7xEmUjKSDY2f6L+43JSmP4+i93sC7KTYf9AMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgFROyJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:54:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731096AbgFROyI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 10:54:08 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2F0320885;
        Thu, 18 Jun 2020 14:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592492047;
        bh=Dd1gsICS/ZMoYWrmK3dpO/j+7w9K4YS1gPxMuBdnqmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yGyIEyzvm3/wU/KABs9hKTzoTKSRZ7GkinA/rfb9PCDPfNqzkpJWbHFc5JBKU/Vnw
         28oVas2wMciRAxMrDA7ae9Tt1exgyhawyBIRgikcR9Zf5hidbuV0XZHtpfseVoyDVz
         VGYxpoUqS+FAC1CwezyRsYTzrH0VdcaLU36X07N0=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me
Cc:     axboe@kernel.dk, Niklas Cassel <niklas.cassel@wdc.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCHv2 3/5] nvme: implement I/O Command Sets Command Set support
Date:   Thu, 18 Jun 2020 07:53:52 -0700
Message-Id: <20200618145354.1139350-4-kbusch@kernel.org>
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

From: Niklas Cassel <niklas.cassel@wdc.com>

Implements support for the I/O Command Sets command set. The command set
introduces a method to enumerate multiple command sets per namespace. If
the command set is exposed, this method for enumeration will be used
instead of the traditional method that uses the CC.CSS register command
set register for command set identification.

For namespaces where the Command Set Identifier is not supported or
recognized, the specific namespace will not be created.

Reviewed-by: Javier González <javier.gonz@samsung.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/nvme/host/core.c | 48 +++++++++++++++++++++++++++++++++-------
 drivers/nvme/host/nvme.h |  1 +
 include/linux/nvme.h     | 19 ++++++++++++++--
 3 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9491dbcfe81a..45a3cb5a35bd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1056,8 +1056,13 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 	return error;
 }
 
+static bool nvme_multi_css(struct nvme_ctrl *ctrl)
+{
+	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
+}
+
 static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
-		struct nvme_ns_id_desc *cur)
+		struct nvme_ns_id_desc *cur, bool *csi_seen)
 {
 	const char *warn_str = "ctrl returned bogus length:";
 	void *data = cur;
@@ -1087,6 +1092,15 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 		}
 		uuid_copy(&ids->uuid, data + sizeof(*cur));
 		return NVME_NIDT_UUID_LEN;
+	case NVME_NIDT_CSI:
+		if (cur->nidl != NVME_NIDT_CSI_LEN) {
+			dev_warn(ctrl->device, "%s %d for NVME_NIDT_CSI\n",
+				 warn_str, cur->nidl);
+			return -1;
+		}
+		memcpy(&ids->csi, data + sizeof(*cur), NVME_NIDT_CSI_LEN);
+		*csi_seen = true;
+		return NVME_NIDT_CSI_LEN;
 	default:
 		/* Skip unknown types */
 		return cur->nidl;
@@ -1097,10 +1111,9 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 		struct nvme_ns_ids *ids)
 {
 	struct nvme_command c = { };
-	int status;
+	bool csi_seen = false;
+	int status, pos, len;
 	void *data;
-	int pos;
-	int len;
 
 	c.identify.opcode = nvme_admin_identify;
 	c.identify.nsid = cpu_to_le32(nsid);
@@ -1130,13 +1143,19 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 		if (cur->nidl == 0)
 			break;
 
-		len = nvme_process_ns_desc(ctrl, ids, cur);
+		len = nvme_process_ns_desc(ctrl, ids, cur, &csi_seen);
 		if (len < 0)
 			goto free_data;
 
 		len += sizeof(*cur);
 	}
 free_data:
+	if (!status && nvme_multi_css(ctrl) && !csi_seen) {
+		dev_warn(ctrl->device, "Command set not reported for nsid:%d\n",
+			 nsid);
+		status = -EINVAL;
+	}
+
 	kfree(data);
 	return status;
 }
@@ -1792,7 +1811,7 @@ static int nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
 		memcpy(ids->eui64, id->eui64, sizeof(id->eui64));
 	if (ctrl->vs >= NVME_VS(1, 2, 0))
 		memcpy(ids->nguid, id->nguid, sizeof(id->nguid));
-	if (ctrl->vs >= NVME_VS(1, 3, 0))
+	if (ctrl->vs >= NVME_VS(1, 3, 0) || nvme_multi_css(ctrl))
 		return nvme_identify_ns_descs(ctrl, nsid, ids);
 	return 0;
 }
@@ -1808,7 +1827,8 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 {
 	return uuid_equal(&a->uuid, &b->uuid) &&
 		memcmp(&a->nguid, &b->nguid, sizeof(a->nguid)) == 0 &&
-		memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) == 0;
+		memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) == 0 &&
+		a->csi == b->csi;
 }
 
 static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
@@ -1930,6 +1950,15 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->lba_shift == 0)
 		ns->lba_shift = 9;
 
+	switch (ns->head->ids.csi) {
+	case NVME_CSI_NVM:
+		break;
+	default:
+		dev_warn(ctrl->device, "unknown csi:%d ns:%d\n",
+			ns->head->ids.csi, ns->head->ns_id);
+		return -ENODEV;
+	}
+
 	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
 	    is_power_of_2(ctrl->max_hw_sectors))
 		iob = ctrl->max_hw_sectors;
@@ -2264,7 +2293,10 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 
 	ctrl->page_size = 1 << page_shift;
 
-	ctrl->ctrl_config = NVME_CC_CSS_NVM;
+	if (NVME_CAP_CSS(ctrl->cap) & NVME_CAP_CSS_CSI)
+		ctrl->ctrl_config = NVME_CC_CSS_CSI;
+	else
+		ctrl->ctrl_config = NVME_CC_CSS_NVM;
 	ctrl->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
 	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
 	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c0f4226d3299..a84f71459caa 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -339,6 +339,7 @@ struct nvme_ns_ids {
 	u8	eui64[8];
 	u8	nguid[16];
 	uuid_t	uuid;
+	u8	csi;
 };
 
 /*
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 5ce51ab4c50e..81ffe5247505 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -132,6 +132,7 @@ enum {
 #define NVME_CAP_TIMEOUT(cap)	(((cap) >> 24) & 0xff)
 #define NVME_CAP_STRIDE(cap)	(((cap) >> 32) & 0xf)
 #define NVME_CAP_NSSRC(cap)	(((cap) >> 36) & 0x1)
+#define NVME_CAP_CSS(cap)	(((cap) >> 37) & 0xff)
 #define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
 #define NVME_CAP_MPSMAX(cap)	(((cap) >> 52) & 0xf)
 
@@ -162,7 +163,6 @@ enum {
 
 enum {
 	NVME_CC_ENABLE		= 1 << 0,
-	NVME_CC_CSS_NVM		= 0 << 4,
 	NVME_CC_EN_SHIFT	= 0,
 	NVME_CC_CSS_SHIFT	= 4,
 	NVME_CC_MPS_SHIFT	= 7,
@@ -170,6 +170,9 @@ enum {
 	NVME_CC_SHN_SHIFT	= 14,
 	NVME_CC_IOSQES_SHIFT	= 16,
 	NVME_CC_IOCQES_SHIFT	= 20,
+	NVME_CC_CSS_NVM		= 0 << NVME_CC_CSS_SHIFT,
+	NVME_CC_CSS_CSI		= 6 << NVME_CC_CSS_SHIFT,
+	NVME_CC_CSS_MASK	= 7 << NVME_CC_CSS_SHIFT,
 	NVME_CC_AMS_RR		= 0 << NVME_CC_AMS_SHIFT,
 	NVME_CC_AMS_WRRU	= 1 << NVME_CC_AMS_SHIFT,
 	NVME_CC_AMS_VS		= 7 << NVME_CC_AMS_SHIFT,
@@ -179,6 +182,8 @@ enum {
 	NVME_CC_SHN_MASK	= 3 << NVME_CC_SHN_SHIFT,
 	NVME_CC_IOSQES		= NVME_NVM_IOSQES << NVME_CC_IOSQES_SHIFT,
 	NVME_CC_IOCQES		= NVME_NVM_IOCQES << NVME_CC_IOCQES_SHIFT,
+	NVME_CAP_CSS_NVM	= 1 << 0,
+	NVME_CAP_CSS_CSI	= 1 << 6,
 	NVME_CSTS_RDY		= 1 << 0,
 	NVME_CSTS_CFS		= 1 << 1,
 	NVME_CSTS_NSSRO		= 1 << 4,
@@ -374,6 +379,8 @@ enum {
 	NVME_ID_CNS_CTRL		= 0x01,
 	NVME_ID_CNS_NS_ACTIVE_LIST	= 0x02,
 	NVME_ID_CNS_NS_DESC_LIST	= 0x03,
+	NVME_ID_CNS_CS_NS		= 0x05,
+	NVME_ID_CNS_CS_CTRL		= 0x06,
 	NVME_ID_CNS_NS_PRESENT_LIST	= 0x10,
 	NVME_ID_CNS_NS_PRESENT		= 0x11,
 	NVME_ID_CNS_CTRL_NS_LIST	= 0x12,
@@ -383,6 +390,10 @@ enum {
 	NVME_ID_CNS_UUID_LIST		= 0x17,
 };
 
+enum {
+	NVME_CSI_NVM			= 0,
+};
+
 enum {
 	NVME_DIR_IDENTIFY		= 0x00,
 	NVME_DIR_STREAMS		= 0x01,
@@ -435,11 +446,13 @@ struct nvme_ns_id_desc {
 #define NVME_NIDT_EUI64_LEN	8
 #define NVME_NIDT_NGUID_LEN	16
 #define NVME_NIDT_UUID_LEN	16
+#define NVME_NIDT_CSI_LEN	1
 
 enum {
 	NVME_NIDT_EUI64		= 0x01,
 	NVME_NIDT_NGUID		= 0x02,
 	NVME_NIDT_UUID		= 0x03,
+	NVME_NIDT_CSI		= 0x04,
 };
 
 struct nvme_smart_log {
@@ -972,7 +985,9 @@ struct nvme_identify {
 	__u8			cns;
 	__u8			rsvd3;
 	__le16			ctrlid;
-	__u32			rsvd11[5];
+	__u8			rsvd11[3];
+	__u8			csi;
+	__u32			rsvd12[4];
 };
 
 #define NVME_IDENTIFY_DATA_SIZE 4096
-- 
2.24.1

