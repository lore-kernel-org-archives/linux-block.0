Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71573C433E0
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 04:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3892922D06
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 04:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbhALE2G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 23:28:06 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45032 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbhALE2F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 23:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610425684; x=1641961684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5oJdIDGlpsP6n3kwAZZVN2mir1iK0wjOoG2w4OEl0H0=;
  b=H4Zg9ko8X4KWWFMJDsGVmNzov55P+y4fYk+HK2C795k+TkXuYrgMjvpW
   a4CKr4LhdKpqeeFWucO0hjreA+KbU/BS3BRwelaIQ5uf9MnrP7qBGKjg4
   NNP74IvfJ/MkJxIpkKwQWRYdRtmNLYyrtRTNKJRqVrYlIzShMPMIIPxxR
   /uXCbOAbKPrGENgZ1TqASAqWDsa0NOheAi0U5pSru/XMcOPmWIMTsiIAV
   qi+2Hr+Hx474ZtPw1QzFUKNWObrmvlkx5zEWRRmtdAwOvR35rfZhNi6uT
   VR4Xn1YEjMDTlT701TdW/zbhMWWf57V7KNDKgtj86SNNVrE8QtxfFtu/y
   w==;
IronPort-SDR: 3zAwU/N415il4CRQdRplPz12XVI2S+hR8RmOOgxZhJtnxP2WG+BD83ytWjAx/tpVYFynzr1Mts
 lwiRbsS2sdvJayaLegHZYqHt4ScI+2hvBTtO+hSzlXyoABWpy++vZ4KMdc0XN+DJmG1xGXOJvg
 hh+LFMzHp1iTj8MrGKy48yX7WoH0JwDjMZ7Er/qkjHlNxH/vLvelxOaPhZw04DiL7rBrIcTCxt
 iGPF2nh8W+raATnwcLA9vZkibUlMf0j3Kq07tcrXN2oIdEQEYd/EyjTlQWcxPLdsvFwAkzMDwV
 G60=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="157206004"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 12:26:59 +0800
IronPort-SDR: TO+BnsI22XRb3zWeDv1z2th1n4Ht3HPOPSsdK1FKN6esBmrNqwhX9B9tLJ8NSKQLt47iNJIWOP
 Vlz9Sb+3FGw34I8CWokGhWpJlmrVJi74QSDH6jAOBJbZIVx/c13MoPOLlQbZIv52y+At2HYRTT
 fUax0CEYnYfmfNrstzsmsodRFAAJLe26aqdSpJoC+AfinUlmsO3vnH1vjo30Cnrhl2ce09euVs
 EC6/81UCvfNcLyBSDmgyDRAk/q3KexDxJQfz/x8wGlcorMubguvyg/PfcEeGZO77c7Ankvizkl
 cfx5v++0o854xMQG6CFb36WF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 20:11:44 -0800
IronPort-SDR: 5tcbuCrnima+qrRYPl+XXvfBdfZMMg8R9+BujLNi9Hdn3yz2inYcmxD9JrRBkW0JTIipRG3L3P
 zso2NlDuXJ+8aoQBJRpAp+eLpgpKGSPMWCikVrgLAJZ726CheY34uiFjNTCxwG9jBIYgQ6XVYb
 aoza38PReyXrBY9L4EdHSAndGz0tMFW6L2/QjKb6V6pv8uk7q3PoUdMfvb65ifMGeCoIXSm8dw
 ROMMhPwEykcTRPdnnfAy8Nb5Vyt545rYdUGMSTX7YvK+Q9ljtn2fnVNxFfTL5aAlx1MfP7Tqk4
 OgE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 20:26:59 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V9 3/9] nvmet: add NVM command set identifier support
Date:   Mon, 11 Jan 2021 20:26:17 -0800
Message-Id: <20210112042623.6316-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NVMe TP 4056 allows controller to support different command sets.
NVMeoF target currently only supports namespaces that contain
traditional logical blocks that may be randomly read and written. In
some applications there is value in exposing namespaces that contain
logical blocks that have special access rules (e.g. sequentially write
required namespace such as Zoned Namespace (ZNS)).

In order to support the Zoned Block Devices (ZBD) backend, controller
needs to have support for ZNS Command Set Identifier (CSI).

In this preparation patch, we adjust the code such that it can now
support different command sets. We update the namespace data
structure to store the CSI value which defaults to NVME_CSI_NVM
which represents traditional logical blocks namespace type.

The CSI support is required to implement the ZBD backend over NVMe ZNS
interface, since ZNS commands belongs to the different command set than
the default one.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 39 ++++++++++++++++++++++-----------
 drivers/nvme/target/core.c      | 13 ++++++++++-
 drivers/nvme/target/nvmet.h     |  1 +
 3 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 220edacfccfb..a50b7bcac67a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -175,19 +175,26 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	if (!log)
 		goto out;
 
-	log->acs[nvme_admin_get_log_page]	= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_identify]		= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_abort_cmd]		= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_set_features]	= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_get_features]	= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_async_event]	= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_keep_alive]		= cpu_to_le32(1 << 0);
-
-	log->iocs[nvme_cmd_read]		= cpu_to_le32(1 << 0);
-	log->iocs[nvme_cmd_write]		= cpu_to_le32(1 << 0);
-	log->iocs[nvme_cmd_flush]		= cpu_to_le32(1 << 0);
-	log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
-	log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
+	switch (req->cmd->get_log_page.csi) {
+	case NVME_CSI_NVM:
+		log->acs[nvme_admin_get_log_page]	= cpu_to_le32(1 << 0);
+		log->acs[nvme_admin_identify]		= cpu_to_le32(1 << 0);
+		log->acs[nvme_admin_abort_cmd]		= cpu_to_le32(1 << 0);
+		log->acs[nvme_admin_set_features]	= cpu_to_le32(1 << 0);
+		log->acs[nvme_admin_get_features]	= cpu_to_le32(1 << 0);
+		log->acs[nvme_admin_async_event]	= cpu_to_le32(1 << 0);
+		log->acs[nvme_admin_keep_alive]		= cpu_to_le32(1 << 0);
+
+		log->iocs[nvme_cmd_read]		= cpu_to_le32(1 << 0);
+		log->iocs[nvme_cmd_write]		= cpu_to_le32(1 << 0);
+		log->iocs[nvme_cmd_flush]		= cpu_to_le32(1 << 0);
+		log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
+		log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
+		break;
+	default:
+		status = NVME_SC_INVALID_LOG_PAGE;
+		break;
+	}
 
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 
@@ -606,6 +613,7 @@ static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
 
 static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 {
+	u16 nvme_cis_nvm = NVME_CSI_NVM;
 	u16 status = 0;
 	off_t off = 0;
 
@@ -631,6 +639,11 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 			goto out;
 	}
 
+	status = nvmet_copy_ns_identifier(req, NVME_NIDT_CSI, NVME_NIDT_CSI_LEN,
+					  &nvme_cis_nvm, &off);
+	if (status)
+		goto out;
+
 	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
 			off) != NVME_IDENTIFY_DATA_SIZE - off)
 		status = NVME_SC_INTERNAL | NVME_SC_DNR;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8ce4d59cc9e7..672e4009f8d6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -681,6 +681,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 	uuid_gen(&ns->uuid);
 	ns->buffered_io = false;
+	ns->csi = NVME_CSI_NVM;
 
 	return ns;
 }
@@ -1103,6 +1104,16 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
 	return (cc >> NVME_CC_IOCQES_SHIFT) & 0xf;
 }
 
+static inline bool nvmet_cc_css_check(u8 cc_css)
+{
+	switch (cc_css <<= NVME_CC_CSS_SHIFT) {
+	case NVME_CC_CSS_NVM:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 {
 	lockdep_assert_held(&ctrl->lock);
@@ -1111,7 +1122,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	    nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES ||
 	    nvmet_cc_mps(ctrl->cc) != 0 ||
 	    nvmet_cc_ams(ctrl->cc) != 0 ||
-	    nvmet_cc_css(ctrl->cc) != 0) {
+	    !nvmet_cc_css_check(nvmet_cc_css(ctrl->cc))) {
 		ctrl->csts = NVME_CSTS_CFS;
 		return;
 	}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8776dd1a0490..476b3cd91c65 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -81,6 +81,7 @@ struct nvmet_ns {
 	struct pci_dev		*p2p_dev;
 	int			pi_type;
 	int			metadata_size;
+	u8			csi;
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
-- 
2.22.1

