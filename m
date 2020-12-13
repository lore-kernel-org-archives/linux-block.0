Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB26C433FE
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 05:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6789F2312D
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 05:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgLMFvx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Dec 2020 00:51:53 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4890 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730543AbgLMFvx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Dec 2020 00:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607838713; x=1639374713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mQ0mk9gOb3GueQDoqDxI+x/4JSzU9z3SWA8da78K+fM=;
  b=Ke6/shty3LopIGawnm0FVaDn9RMbxfvXh3Nq4qjnroMGwKk3Z/ZQfM4B
   W1C/70qrVkvIpKpwmV64Zw3hnSGqcY2fBSdreMzP5bnvv9oCU8Cin4Uo1
   cFTebsNluaSs/ffgzh4QhCRJaowp8TjkyhE0VEutUHTnIPv+sZRP82sYP
   1w+ZL5zrV2qNLjmTik4mdHhU1QMloNzaAPm3jvglNLecK/7iwBWbLe8Q4
   JmN3fKnBrx9Pq2kbxdoaVBmHIoYb9An97Rxm8FvvMDr+EvbSeaYnr+LNK
   GZAk+Xxv5UK2ESZQvQrdEAZoQU9Hul1EB4f1gOmSYLjq0zkMdaHdPMnEg
   A==;
IronPort-SDR: Xa4viV49TvJph7yqwaCQzlYKzB785q5aWlNkOWowb4FoToda3uxGYDf5paWhF/6/gPJeFpX93w
 HmGVB8caM7Rw98zxJ5o5+S4UBUYCtsJdKnfcDiv+yzoJfv2bSq6l6MaILF/zFr5tonG1uA/yBu
 ib2BLuh3X+zi34L6lsLgWEOQTGUUQ3v/gLvEKDEXdkXR/hQB+0gLnuaIEMUwY13SImlLXeLfJl
 ey9n13HSNBgIKwltq5Z0nwD8h2DFKLOCsGwamBNqkSmGkYOddmbM/LBepL2NF+vuEOopm0Lr7+
 dXQ=
X-IronPort-AV: E=Sophos;i="5.78,415,1599494400"; 
   d="scan'208";a="155065875"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2020 13:50:48 +0800
IronPort-SDR: A5y8RYkaEOlF1ejcIfawxT4zyF2Ogd3wJRjSGSRRvyKeZKi+17T5tiEAnWUsk9PCw8Yn7+9psI
 ANRDjuGqWZqKNK13xDRD8R/22i91FC2P/BtQlNExGX6QMs/cXY9fqqOxO2ZlJgYerYyM/rX1CD
 /B2IxzM74TKehW+qcEXIxX7A73TqyQ5D4JI+twG+BBrIyLLwNK8EHLIuK/IvbIOFWo3iHD1V/l
 nF97DyPOKs8o8silGcC2E7t6e791fFGHPG13si/ogHvcGDBj7tn/sUEs2ymsKmn8V85JAsPO45
 VW/GC8tb+KspENfM0xpVR8m1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2020 21:34:36 -0800
IronPort-SDR: qbe7RJ22xQkaea7wiU/EEUFX/xgf07fHXqyTyqNYO/9JWJQGdSkEkmqE5BgXDaEk4gJjXnLF6d
 JptKMS4LwkxRohmk6vmusopoHPbKC0WcxoGnv4oLnQG/kVPQBePqLeekDtv1etmgGHYyr4H8FY
 LpI080nNvl8cqe6X7JQscQhQx3yOEXN8KU3BQu7gVWlweMi8Bj9msGCRcNR/hHabgmGPhtH+fD
 nLHjdINwQqFCyyVBlGe6xBxf4rQ6mzYzUPrfA7AQ4U0wgnzxoVXowB6JNqoKvhLm1M+ugVJCaq
 paI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2020 21:50:47 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V6 3/6] nvmet: add NVM command set identifier support
Date:   Sat, 12 Dec 2020 21:50:14 -0800
Message-Id: <20201213055017.7141-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
References: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
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

