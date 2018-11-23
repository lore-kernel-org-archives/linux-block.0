Return-Path: <SRS0=Lvn3=OC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F20C43441
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 16:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B45720659
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 16:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B45720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632781AbeKXCtT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:49:19 -0500
Received: from mga05.intel.com ([192.55.52.43]:33877 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2632780AbeKXCtS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Nov 2018 21:49:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Nov 2018 08:04:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,270,1539673200"; 
   d="scan'208";a="110948180"
Received: from gklab-106-154.igk.intel.com ([10.102.106.154])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2018 08:04:29 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        igor.j.konopko@intel.com
Subject: [PATCH] nvme: Fix PCIe surprise removal scenario
Date:   Fri, 23 Nov 2018 16:58:10 +0100
Message-Id: <20181123155810.60246-1-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch fixes kernel OOPS for surprise removal
scenario for PCIe connected NVMe drives.

After latest changes, when PCIe device is not present,
nvme_dev_remove_admin() calls blk_cleanup_queue() on
admin queue, which frees hctx for that queue.
Moment later, on the same path nvme_kill_queues()
calls blk_mq_unquiesce_queue() on admin queue and
tries to access hctx of it, which leads to
following OOPS scenario:

Oops: 0000 [#1] SMP PTI
RIP: 0010:sbitmap_any_bit_set+0xb/0x40
Call Trace:
 blk_mq_run_hw_queue+0xd5/0x150
 blk_mq_run_hw_queues+0x3a/0x50
 nvme_kill_queues+0x26/0x50
 nvme_remove_namespaces+0xb2/0xc0
 nvme_remove+0x60/0x140
 pci_device_remove+0x3b/0xb0

Fixes: cb4bfda62afa2 ("nvme-pci: fix hot removal during error handling")
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 65c42448e904..5aff95389694 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3601,7 +3601,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 	down_read(&ctrl->namespaces_rwsem);
 
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
-	if (ctrl->admin_q)
+	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
 		blk_mq_unquiesce_queue(ctrl->admin_q);
 
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-- 
2.14.5

