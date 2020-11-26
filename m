Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473BDC56201
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 02:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF2C0207BC
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 02:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C9NGNvY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbgKZCm0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 21:42:26 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20535 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbgKZCm0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 21:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606358545; x=1637894545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qeI8OkQ2C+8qF4W8aVLYYaL1+taXca5eouvg6P6Gos4=;
  b=C9NGNvY4oxAOqneMofUiMq1U9I6IQtrXvP9iN0ijY9XWC8/ixHXw/wzC
   hQqo28JZ+K+kBcxe6VMR9tPW4PXcWoA+gLGpEGUAnVPDoPn16QWv2VTck
   0MGBfKa1OOXT2nJt3+eD6VO6vxTMHAxb4rLkGpCGYumQBeU/XoSEqwj6x
   fIe6G3zRkHfU0JG/wRbr58IbJAaz297Ye8PqYGnqWHvc3EG/rHioNFQB5
   VkBhcJaNwPr6OjF8OuSa6cuyF3nu1I+qtXy7Rt3+xpCtFsV3G8m2BT+ak
   8aQraRnN9yq+WmwzL5ry91ZM9V+S4JUJk666VxfpaT8GQ55EXoK1ETl3P
   g==;
IronPort-SDR: q2UqC5cQ3xDHhO12p+14N+GxzOyF1rsDDt25fD6s4kmDad4u2X14j/Rl4xnHawNiTOQ8BSp3sI
 7/IOfHLVWcJbEn+f9mIPj015KeIqXimsaQiAkoLn+yLWB+XoYYcCgzVxjpVONoCv++CapFX7eV
 kJ79Qk5DzH3jkoXFnhu8ba1t4Mauc4rvhJBmIrc+vEvUS3AlAiRSE9u35kBXGJDfyl0i15CrZJ
 bkBbXrdpL373wYRgL4+vSnacGgsdgh+K2DnJalqlLkfEeAWMaWdJNFWwZjbu1rgBbKKrwFvVdx
 FF8=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; 
   d="scan'208";a="157983172"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:42:25 +0800
IronPort-SDR: /unS0tfmQLgVGbpAkBDKfNn2JHtTfqOKwMUlqgGPbavBawHTUJIK0PrpLUmc7+6q36YwpXJORt
 ZPqNPSuPBc51p+kF6G7CjoCV4j9hDO7WU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 18:28:07 -0800
IronPort-SDR: /qUJeynUYlB2tGsiF3eBwSQA1RSvV7doTJnStkhrjI95IQtpqlEChvvEj3rYMPFM5RSRvHvUXK
 lx5jkLdKAkhQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2020 18:42:25 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 9/9] nvmet: add ZNS based I/O cmds handlers
Date:   Wed, 25 Nov 2020 18:40:43 -0800
Message-Id: <20201126024043.3392-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add zone-mgmt-send, zone-mgmt-recv and zone-zppend handlers for the
bdev backend so that it can support zbd.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/Makefile      | 3 +--
 drivers/nvme/target/io-cmd-bdev.c | 9 +++++++++
 drivers/nvme/target/zns.c         | 6 +++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index bc147ff2df5d..15307b1cc713 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -10,9 +10,8 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
 obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
 
 nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
-			discovery.o io-cmd-file.o io-cmd-bdev.o
+		   zns.o discovery.o io-cmd-file.o io-cmd-bdev.o
 nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
-nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
 
 nvme-loop-y	+= loop.o
 nvmet-rdma-y	+= rdma.o
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f8a500983abd..4fcc8374b857 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -453,6 +453,15 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
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
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 8ea6641a55e3..efd11d7a6f96 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -361,17 +361,17 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 }
 
 #else  /* CONFIG_BLK_DEV_ZONED */
-static void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
+void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
 {
 }
-static void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
+void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 {
 }
 u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)
 {
 	return 0;
 }
-static bool nvmet_bdev_zns_config(struct nvmet_ns *ns)
+bool nvmet_bdev_zns_config(struct nvmet_ns *ns)
 {
 	return false;
 }
-- 
2.22.1

