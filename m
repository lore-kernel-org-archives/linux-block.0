Return-Path: <SRS0=6LXE=TW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D45DC282DC
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 17:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E970220879
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 17:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfEVRxR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 May 2019 13:53:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:57850 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728450AbfEVRxR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 13:53:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 10:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,500,1549958400"; 
   d="scan'208";a="174471736"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga002.fm.intel.com with ESMTP; 22 May 2019 10:53:15 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/2] nvme: reset request timeouts during fw activation
Date:   Wed, 22 May 2019 11:48:12 -0600
Message-Id: <20190522174812.5597-3-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190522174812.5597-1-keith.busch@intel.com>
References: <20190522174812.5597-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The nvme controller may pause command processing during firmware
activation. The driver will quiesce queues during this time, but commands
dispatched prior to the notification will not be processed until the
hardware completes this activation.

We do not want those requests to time out while the hardware is in
this paused state as we don't expect those commands to complete during
this time, and that handling will interfere with the firmware activation
process.

In addition to quiescing the queues, halt timeout detection during the
paused state and reset the dispatched request deadlines when the hardware
exists that state. This action applies to IO and admin queues.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1b7c2afd84cb..37a9a66ada22 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -89,6 +89,7 @@ static dev_t nvme_chr_devt;
 static struct class *nvme_class;
 static struct class *nvme_subsys_class;
 
+static void nvme_reset_queues(struct nvme_ctrl *ctrl);
 static int nvme_revalidate_disk(struct gendisk *disk);
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
@@ -3605,6 +3606,11 @@ static void nvme_fw_act_work(struct work_struct *work)
 				msecs_to_jiffies(admin_timeout * 1000);
 
 	nvme_stop_queues(ctrl);
+	nvme_sync_queues(ctrl);
+
+	blk_mq_quiesce_queue(ctrl->admin_q);
+	blk_sync_queue(ctrl->admin_q);
+
 	while (nvme_ctrl_pp_status(ctrl)) {
 		if (time_after(jiffies, fw_act_timeout)) {
 			dev_warn(ctrl->device,
@@ -3618,7 +3624,12 @@ static void nvme_fw_act_work(struct work_struct *work)
 	if (ctrl->state != NVME_CTRL_LIVE)
 		return;
 
+	blk_mq_reset_rqs(ctrl->admin_q);
+	blk_mq_unquiesce_queue(ctrl->admin_q);
+
+	nvme_reset_queues(ctrl);
 	nvme_start_queues(ctrl);
+
 	/* read FW slot information to clear the AER */
 	nvme_get_fw_slot_info(ctrl);
 }
@@ -3901,6 +3912,15 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
+static void nvme_reset_queues(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_mq_reset_rqs(ns->queue);
+	up_read(&ctrl->namespaces_rwsem);
+}
 
 void nvme_sync_queues(struct nvme_ctrl *ctrl)
 {
-- 
2.14.4

