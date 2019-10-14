Return-Path: <SRS0=kJgC=YH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53B1C4CECE
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 17:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BDA217D9
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 17:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388351AbfJNRNf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Oct 2019 13:13:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:39148 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387910AbfJNRNf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Oct 2019 13:13:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 10:13:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="189080576"
Received: from unknown (HELO revanth-X299-AORUS-Gaming-3-Pro.lm.intel.com) ([10.232.116.91])
  by orsmga008.jf.intel.com with ESMTP; 14 Oct 2019 10:13:34 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH] nvme: resync include/linux/nvme.h with nvmecli
Date:   Mon, 14 Oct 2019 11:16:07 -0600
Message-Id: <20191014171607.29162-1-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Update enumerations and structures in include/linux/nvme.h
to resync with the nvmecli.

All the updates are mentioned in the ratified NVMe 1.4 spec
https://nvmexpress.org/wp-content/uploads/NVM-Express-1_4-2019.06.10-Ratified.pdf

Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 include/linux/nvme.h | 53 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index f61d6906e59d..902b7e097f73 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -107,8 +107,22 @@ enum {
 	NVME_REG_AQA	= 0x0024,	/* Admin Queue Attributes */
 	NVME_REG_ASQ	= 0x0028,	/* Admin SQ Base Address */
 	NVME_REG_ACQ	= 0x0030,	/* Admin CQ Base Address */
-	NVME_REG_CMBLOC = 0x0038,	/* Controller Memory Buffer Location */
+	NVME_REG_CMBLOC	= 0x0038,	/* Controller Memory Buffer Location */
 	NVME_REG_CMBSZ	= 0x003c,	/* Controller Memory Buffer Size */
+	NVME_REG_BPINFO	= 0x0040,	/* Boot Partition Information */
+	NVME_REG_BPRSEL	= 0x0044,	/* Boot Partition Read Select */
+	NVME_REG_BPMBL	= 0x0048,	/* Boot Partition Memory Buffer
+					 * Location
+					 */
+	NVME_REG_PMRCAP	= 0x0e00,	/* Persistent Memory Capabilities */
+	NVME_REG_PMRCTL	= 0x0e04,	/* Persistent Memory Region Control */
+	NVME_REG_PMRSTS	= 0x0e08,	/* Persistent Memory Region Status */
+	NVME_REG_PMREBS	= 0x0e0c,	/* Persistent Memory Region Elasticity
+					 * Buffer Size
+					 */
+	NVME_REG_PMRSWTP = 0x0e10,	/* Persistent Memory Region Sustained
+					 * Write Throughput
+					 */
 	NVME_REG_DBS	= 0x1000,	/* SQ 0 Tail Doorbell */
 };

@@ -295,6 +309,14 @@ enum {
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
 	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 8,
 	NVME_CTRL_LPA_CMD_EFFECTS_LOG		= 1 << 1,
+	NVME_CTRL_CTRATT_128_ID			= 1 << 0,
+	NVME_CTRL_CTRATT_NON_OP_PSP		= 1 << 1,
+	NVME_CTRL_CTRATT_NVM_SETS		= 1 << 2,
+	NVME_CTRL_CTRATT_READ_RECV_LVLS		= 1 << 3,
+	NVME_CTRL_CTRATT_ENDURANCE_GROUPS	= 1 << 4,
+	NVME_CTRL_CTRATT_PREDICTABLE_LAT	= 1 << 5,
+	NVME_CTRL_CTRATT_NAMESPACE_GRANULARITY	= 1 << 7,
+	NVME_CTRL_CTRATT_UUID_LIST		= 1 << 9,
 };

 struct nvme_lbaf {
@@ -352,6 +374,9 @@ enum {
 	NVME_ID_CNS_NS_PRESENT		= 0x11,
 	NVME_ID_CNS_CTRL_NS_LIST	= 0x12,
 	NVME_ID_CNS_CTRL_LIST		= 0x13,
+	NVME_ID_CNS_SCNDRY_CTRL_LIST	= 0x15,
+	NVME_ID_CNS_NS_GRANULARITY	= 0x16,
+	NVME_ID_CNS_UUID_LIST		= 0x17,
 };

 enum {
@@ -409,7 +434,8 @@ struct nvme_smart_log {
 	__u8			avail_spare;
 	__u8			spare_thresh;
 	__u8			percent_used;
-	__u8			rsvd6[26];
+	__u8			endu_grp_crit_warn_sumry;
+	__u8			rsvd7[25];
 	__u8			data_units_read[16];
 	__u8			data_units_written[16];
 	__u8			host_reads[16];
@@ -423,7 +449,11 @@ struct nvme_smart_log {
 	__le32			warning_temp_time;
 	__le32			critical_comp_time;
 	__le16			temp_sensor[8];
-	__u8			rsvd216[296];
+	__le32			thm_temp1_trans_count;
+	__le32			thm_temp2_trans_count;
+	__le32			thm_temp1_total_time;
+	__le32			thm_temp2_total_time;
+	__u8			rsvd232[280];
 };

 struct nvme_fw_slot_info_log {
@@ -440,6 +470,7 @@ enum {
 	NVME_CMD_EFFECTS_NIC		= 1 << 3,
 	NVME_CMD_EFFECTS_CCC		= 1 << 4,
 	NVME_CMD_EFFECTS_CSE_MASK	= 3 << 16,
+	NVME_CMD_EFFECTS_UUID_SEL	= 1 << 19,
 };

 struct nvme_effects_log {
@@ -563,6 +594,7 @@ enum nvme_opcode {
 	nvme_cmd_compare	= 0x05,
 	nvme_cmd_write_zeroes	= 0x08,
 	nvme_cmd_dsm		= 0x09,
+	nvme_cmd_verify		= 0x0c,
 	nvme_cmd_resv_register	= 0x0d,
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
@@ -806,10 +838,14 @@ enum nvme_admin_opcode {
 	nvme_admin_ns_mgmt		= 0x0d,
 	nvme_admin_activate_fw		= 0x10,
 	nvme_admin_download_fw		= 0x11,
+	nvme_admin_dev_self_test	= 0x14,
 	nvme_admin_ns_attach		= 0x15,
 	nvme_admin_keep_alive		= 0x18,
 	nvme_admin_directive_send	= 0x19,
 	nvme_admin_directive_recv	= 0x1a,
+	nvme_admin_virtual_mgmt		= 0x1c,
+	nvme_admin_nvme_mi_send		= 0x1d,
+	nvme_admin_nvme_mi_recv		= 0x1e,
 	nvme_admin_dbbuf		= 0x7C,
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
@@ -873,6 +909,7 @@ enum {
 	NVME_FEAT_PLM_CONFIG	= 0x13,
 	NVME_FEAT_PLM_WINDOW	= 0x14,
 	NVME_FEAT_HOST_BEHAVIOR	= 0x16,
+	NVME_FEAT_SANITIZE	= 0x17,
 	NVME_FEAT_SW_PROGRESS	= 0x80,
 	NVME_FEAT_HOST_ID	= 0x81,
 	NVME_FEAT_RESV_MASK	= 0x82,
@@ -883,6 +920,10 @@ enum {
 	NVME_LOG_FW_SLOT	= 0x03,
 	NVME_LOG_CHANGED_NS	= 0x04,
 	NVME_LOG_CMD_EFFECTS	= 0x05,
+	NVME_LOG_DEVICE_SELF_TEST = 0x06,
+	NVME_LOG_TELEMETRY_HOST = 0x07,
+	NVME_LOG_TELEMETRY_CTRL = 0x08,
+	NVME_LOG_ENDURANCE_GROUP = 0x09,
 	NVME_LOG_ANA		= 0x0c,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
@@ -1290,7 +1331,11 @@ enum {
 	NVME_SC_SGL_INVALID_OFFSET	= 0x16,
 	NVME_SC_SGL_INVALID_SUBTYPE	= 0x17,

+	NVME_SC_SANITIZE_FAILED		= 0x1C,
+	NVME_SC_SANITIZE_IN_PROGRESS	= 0x1D,
+
 	NVME_SC_NS_WRITE_PROTECTED	= 0x20,
+	NVME_SC_CMD_INTERRUPTED		= 0x21,

 	NVME_SC_LBA_RANGE		= 0x80,
 	NVME_SC_CAP_EXCEEDED		= 0x81,
@@ -1328,6 +1373,8 @@ enum {
 	NVME_SC_NS_NOT_ATTACHED		= 0x11a,
 	NVME_SC_THIN_PROV_NOT_SUPP	= 0x11b,
 	NVME_SC_CTRL_LIST_INVALID	= 0x11c,
+	NVME_SC_BP_WRITE_PROHIBITED	= 0x11e,
+	NVME_SC_PMR_SAN_PROHIBITED	= 0x123,

 	/*
 	 * I/O Command Set Specific - NVM commands:
--
2.17.1

