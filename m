Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178B7ECDFA1
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 14:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiJYOkn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 10:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbiJYOkg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 10:40:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFE466867
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ucIosG/GH5IunEgzdR/FtVW2stYyqBAEOqngYE0Dkds=; b=gB1w2LMCh3delNot1LYnmor9Ls
        IJbHJrDVCNBR5i6q4TlQPUg+v0u3lhUMgMxXEHYwmwjKfo62+L3wqLy/01/f1ni8V5TFSQv/th8T1
        BJ1kwtgDwMf76Mpqxv5Du6NX6qL9MSZ5m0HwCpwtZtSbuPKeE+2y5IwfkJZ/tW+EFd6AogBnGR9Ae
        CkLYI9EHWZD/LfZSaxFEflkHwc5pul5zud1N6C8Tb0lmySVNeQ7cgtFjErR5VpmWBMrDmpXiITlmj
        I7ynTOiMIg8l7JBec7sOW/KDhJL+aBnbUy/Zy/UsFtgpi8FQLL29ZLpm1+MglPQGY8mWDk/r0bXBM
        MVP9PXpQ==;
Received: from [12.47.128.130] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onL6N-005pnS-9F; Tue, 25 Oct 2022 14:40:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 09/17] nvme: don't unquiesce the I/O queues in nvme_kill_queues
Date:   Tue, 25 Oct 2022 07:40:12 -0700
Message-Id: <20221025144020.260458-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025144020.260458-1-hch@lst.de>
References: <20221025144020.260458-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nvme_kill_queues does two things:

 1) mark the gendisk of all namespaces dead
 2) unquiesce all I/O queues

These used to be be intertwined due to block layer issues, but aren't
any more.  So move the unquiscing of the I/O queues into the callers,
and rename the rest of the function to the now more descriptive
nvme_mark_namespaces_dead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/apple.c |  3 ++-
 drivers/nvme/host/core.c  | 31 ++++---------------------------
 drivers/nvme/host/nvme.h  |  3 +--
 drivers/nvme/host/pci.c   | 12 ++++++++----
 4 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index ff8b083dc5c6d..14bee207316a0 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1153,7 +1153,8 @@ static void apple_nvme_reset_work(struct work_struct *work)
 	nvme_change_ctrl_state(&anv->ctrl, NVME_CTRL_DELETING);
 	nvme_get_ctrl(&anv->ctrl);
 	apple_nvme_disable(anv, false);
-	nvme_kill_queues(&anv->ctrl);
+	nvme_mark_namespaces_dead(&anv->ctrl);
+	nvme_start_queues(&anv->ctrl);
 	if (!queue_work(nvme_wq, &anv->remove_work))
 		nvme_put_ctrl(&anv->ctrl);
 }
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d4d25f1dd6dba..00612e6857295 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5093,40 +5093,17 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
 		blk_mq_wait_quiesce_done(ns->queue);
 }
 
-/*
- * Prepare a queue for teardown.
- *
- * This must forcibly unquiesce queues to avoid blocking dispatch.
- */
-static void nvme_set_queue_dying(struct nvme_ns *ns)
-{
-	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
-		return;
-
-	blk_mark_disk_dead(ns->disk);
-	nvme_start_ns_queue(ns);
-}
-
-/**
- * nvme_kill_queues(): Ends all namespace queues
- * @ctrl: the dead controller that needs to end
- *
- * Call this function when the driver determines it is unable to get the
- * controller in a state capable of servicing IO.
- */
-void nvme_kill_queues(struct nvme_ctrl *ctrl)
+/* let I/O to all namespaces fail in preparation for surprise removal */
+void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
 	down_read(&ctrl->namespaces_rwsem);
-
-	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		nvme_set_queue_dying(ns);
-
+		blk_mark_disk_dead(ns->disk);
 	up_read(&ctrl->namespaces_rwsem);
 }
-EXPORT_SYMBOL_GPL(nvme_kill_queues);
+EXPORT_SYMBOL_GPL(nvme_mark_namespaces_dead);
 
 void nvme_unfreeze(struct nvme_ctrl *ctrl)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a29877217ee65..1cd7168002438 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -483,7 +483,6 @@ struct nvme_ns {
 	unsigned long features;
 	unsigned long flags;
 #define NVME_NS_REMOVING	0
-#define NVME_NS_DEAD     	1
 #define NVME_NS_ANA_PENDING	2
 #define NVME_NS_FORCE_RO	3
 #define NVME_NS_READY		4
@@ -758,7 +757,7 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
 void nvme_stop_admin_queue(struct nvme_ctrl *ctrl);
 void nvme_start_admin_queue(struct nvme_ctrl *ctrl);
-void nvme_kill_queues(struct nvme_ctrl *ctrl);
+void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl);
 void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl);
 void nvme_unfreeze(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f971e96ffd3f6..8ab54857cfd50 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2793,7 +2793,8 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	nvme_get_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, false);
-	nvme_kill_queues(&dev->ctrl);
+	nvme_mark_namespaces_dead(&dev->ctrl);
+	nvme_start_queues(&dev->ctrl);
 	if (!queue_work(nvme_wq, &dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
 }
@@ -2919,7 +2920,8 @@ static void nvme_reset_work(struct work_struct *work)
 		} else {
 			if (dev->ctrl.cntrltype != NVME_CTRL_ADMIN)
 				dev_warn(dev->ctrl.device, "IO queues lost\n");
-			nvme_kill_queues(&dev->ctrl);
+			nvme_mark_namespaces_dead(&dev->ctrl);
+			nvme_start_queues(&dev->ctrl);
 			nvme_remove_namespaces(&dev->ctrl);
 			nvme_free_tagset(dev);
 		}
@@ -3256,8 +3258,10 @@ static void nvme_remove(struct pci_dev *pdev)
 	 * removing the namespaces' disks; fail all the queues now to avoid
 	 * potentially having to clean up the failed sync later.
 	 */
-	if (dev->ctrl.state == NVME_CTRL_DEAD)
-		nvme_kill_queues(&dev->ctrl);
+	if (dev->ctrl.state == NVME_CTRL_DEAD) {
+		nvme_mark_namespaces_dead(&dev->ctrl);
+		nvme_start_queues(&dev->ctrl);
+	}
 
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_disable(dev, true);
-- 
2.30.2

