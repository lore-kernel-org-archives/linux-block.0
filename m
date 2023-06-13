Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD9DC7EE2F
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 01:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbjFMBAF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 21:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFMBAE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 21:00:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1379110E3
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 17:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686617957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fB4DDMTeECqSQtz0i10W2IVCPDEDaSMyFNfYRlcPc90=;
        b=D0Q9slEMEIiOQGasftIM2WaEjF4mYPI8lsVCEsNUgEenucx9NQkXCwAx2I8wYHYMQcRJ5p
        JW8sJpGt4LHEAltTmMKlwf+Jzy85+1P8M4FOUNgqb4U5ePWraopKOOl2gh9NTWZyTjfNlh
        59AbG0v+qDL3wuwyb7SzbHd3/3RzDfc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-jVDGzZeeOWKIjRjL7wVeVQ-1; Mon, 12 Jun 2023 20:59:12 -0400
X-MC-Unique: jVDGzZeeOWKIjRjL7wVeVQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88BDC811E85;
        Tue, 13 Jun 2023 00:59:11 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97061492C1B;
        Tue, 13 Jun 2023 00:59:10 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] nvme: don't freeze/unfreeze queues from different contexts
Date:   Tue, 13 Jun 2023 08:58:47 +0800
Message-Id: <20230613005847.1762378-3-ming.lei@redhat.com>
In-Reply-To: <20230613005847.1762378-1-ming.lei@redhat.com>
References: <20230613005847.1762378-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For block layer freeze/unfreeze APIs, the caller is required to call the
two in strict pair, so most of users simply call them from same context,
and everything works just fine.

For NVMe, the two are done from different contexts, this way has caused
all kinds of IO hang issue, such as:

1) When io queue connect fails, this controller is deleted without being
marked as DEAD. Upper layer may wait forever in __bio_queue_enter(), because
in del_gendisk(), disk won't be marked as DEAD unless bdev sync & invalidate
returns. If any writeback IO waits in __bio_queue_enter(), IO deadlock is
caused. Reported from Yi Zhang.

2) error recovering vs. namespace deletiong, if any IO originated from
scan work is waited in __bio_queue_enter(), flushing scan work hangs for
ever in nvme_remove_namespaces() because controller is left as frozen
when error recovery is interrupted by controller removal. Reported from
Chunguang.

Fix the issue by calling the two in same context just when reset is done
and not starting freeze from beginning of error recovery. Not only IO hang
is solved, correctness of freeze & unfreeze is respected.

And this way is correct because quiesce is enough for driver to handle
error recovery. The only difference is where to wait during error recovery.
With this way, IO is just queued in block layer queue instead of
__bio_queue_enter(), finally waiting for completion is done in upper
layer. Either way, IO can't move on during error recovery.

Reported-by: Chunguang Xu <brookxu.cn@gmail.com>
Closes: https://lore.kernel.org/linux-nvme/cover.1685350577.git.chunguang.xu@shopee.com/
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 4 +---
 drivers/nvme/host/pci.c  | 8 +++++---
 drivers/nvme/host/rdma.c | 3 ++-
 drivers/nvme/host/tcp.c  | 3 ++-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4ef5eaecaa75..d5d9b6f6ec74 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4707,10 +4707,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 * removing the namespaces' disks; fail all the queues now to avoid
 	 * potentially having to clean up the failed sync later.
 	 */
-	if (ctrl->state == NVME_CTRL_DEAD) {
+	if (ctrl->state == NVME_CTRL_DEAD)
 		nvme_mark_namespaces_dead(ctrl);
-		nvme_unquiesce_io_queues(ctrl);
-	}
 
 	/* this is a no-op when called from the controller reset handler */
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 492f319ebdf3..5d775b76baca 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2578,14 +2578,15 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	dead = nvme_pci_ctrl_is_dead(dev);
 	if (dev->ctrl.state == NVME_CTRL_LIVE ||
 	    dev->ctrl.state == NVME_CTRL_RESETTING) {
-		if (pci_is_enabled(pdev))
-			nvme_start_freeze(&dev->ctrl);
 		/*
 		 * Give the controller a chance to complete all entered requests
 		 * if doing a safe shutdown.
 		 */
-		if (!dead && shutdown)
+		if (!dead && shutdown & pci_is_enabled(pdev)) {
+			nvme_start_freeze(&dev->ctrl);
 			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
+			nvme_unfreeze(&dev->ctrl);
+		}
 	}
 
 	nvme_quiesce_io_queues(&dev->ctrl);
@@ -2740,6 +2741,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 * controller around but remove all namespaces.
 	 */
 	if (dev->online_queues > 1) {
+		nvme_start_freeze(&dev->ctrl);
 		nvme_unquiesce_io_queues(&dev->ctrl);
 		nvme_wait_freeze(&dev->ctrl);
 		nvme_pci_update_nr_queues(dev);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0eb79696fb73..354cce8853c1 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -918,6 +918,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		goto out_cleanup_tagset;
 
 	if (!new) {
+		nvme_start_freeze(&ctrl->ctrl);
 		nvme_unquiesce_io_queues(&ctrl->ctrl);
 		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -926,6 +927,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			 * to be safe.
 			 */
 			ret = -ENODEV;
+			nvme_unfreeze(&ctrl->ctrl);
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
@@ -975,7 +977,6 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
 	if (ctrl->ctrl.queue_count > 1) {
-		nvme_start_freeze(&ctrl->ctrl);
 		nvme_quiesce_io_queues(&ctrl->ctrl);
 		nvme_sync_io_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bf0230442d57..5ae08e9cb16d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1909,6 +1909,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		goto out_cleanup_connect_q;
 
 	if (!new) {
+		nvme_start_freeze(ctrl);
 		nvme_unquiesce_io_queues(ctrl);
 		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -1917,6 +1918,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			 * to be safe.
 			 */
 			ret = -ENODEV;
+			nvme_unfreeze(ctrl);
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->tagset,
@@ -2021,7 +2023,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	if (ctrl->queue_count <= 1)
 		return;
 	nvme_quiesce_admin_queue(ctrl);
-	nvme_start_freeze(ctrl);
 	nvme_quiesce_io_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
-- 
2.40.1

