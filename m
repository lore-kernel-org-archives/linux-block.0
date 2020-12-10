Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB5CC433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 06:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59AD23C43
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 06:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgLJG2O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 01:28:14 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42441 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgLJG2O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 01:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607581693; x=1639117693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a3cbrc1i+f6XdSMIC94PGM/AVELFn5l85gX6A2VwJpU=;
  b=XhqBSkqzDYBIboXDNApi14xyzMQ8MeD8TIdzrAHUeZ/LbvxioNJO09mJ
   TWTusS9gDb1SUanVVoPTW3jIOl5Hks86YUsAH4XQe7E4QVPlO80gPH5od
   S1GAN3Jc+v5FXS8E5sWlTW3wRrz3oMs/gzHFVLxqWRqHYDzOmYxbwjgWh
   gt6Mu3yt8NlmcQe3gdB5aBAxezqhhjei8vyYgKSw2IvMs46fvzibdG03a
   bA+c4uNL54aWk2dqKdwZBxSUVbZCUIfEfblyPyMas0XW7iInJzaJ6W8jr
   xX0YkgIE9STMQU2DKZNkmAh/0f35Ob9N/K47w/agNG8yIjqJOLkmHdit1
   w==;
IronPort-SDR: 2c5KWxv0yMDrpg+SnSQMaOevqmIs7zyWvK9IRdiYLgh/1aUPIx4DlicApUTo+h0WgnHyeBMZJu
 HHgUSIbLY041XV4OgTzUlljv7HvCd1xmzn3zASEhXTFapuG8Kao2OaqD5sLh4tQChS3oR5h7Me
 GsawXuPzMs+4XwmtcFmejqQ4yDkgwGlbQ7/q0Gp1lg65GSrsGDCWmKFLX10yyp40m0x7PAskkh
 UQLMErvG25Ju94I0RZJxkM3h+W+WRgInjzpRfnres6maQ9JBhGWDPmjIWp7xke7O2tdqzuQ6Dg
 agM=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; 
   d="scan'208";a="264993796"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 14:27:07 +0800
IronPort-SDR: JJYjuVy81chP9vCcyEwD3fTXEVa2nQFavnv2f7sAYgqTt6/4bAoKX7FGHMONvfbld6JxInSRZt
 CXPltdmr/K3tilxE6R/KceVuSkQw5+LUQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 22:11:03 -0800
IronPort-SDR: rMiCZkrn+/4NPj7vVwT+RPvI0fEZ6dyYykNeF4T1xLOeKY2nvVYipfkd94HXka5uI0uWGqpPYs
 g2uPOwTB5Oew==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2020 22:27:08 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V5 3/6] nvmet: add NVM command set identifier support
Date:   Wed,  9 Dec 2020 22:26:19 -0800
Message-Id: <20201210062622.62053-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
References: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
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

In this preparation patch we adjust the code such that it can now
support different command sets. We update the namespace data
structure to store the CSI value which defaults to NVME_CSI_NVM
which represents traditional logical blocks namespace type.

The CSI support is required to implement the ZBD backend over NVMe ZNS
interface, since ZNS commands belongs to different command set than
the default one.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 33 ++++++++++++++++++++-------------
 drivers/nvme/target/core.c      | 13 ++++++++++++-
 drivers/nvme/target/nvmet.h     |  1 +
 3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 74620240ac47..f4c0f3aca485 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -176,19 +176,26 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
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
index 4cb4cdae858c..0360594abd93 100644
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

