Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBF7C76186
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 03:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9552080C
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 03:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfGXDtP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 23:49:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60631 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfGXDtP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 23:49:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC1F6307D85B;
        Wed, 24 Jul 2019 03:49:14 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5B1419C58;
        Wed, 24 Jul 2019 03:49:13 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Ming Lei <ming.lei@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 4/5] nvme: wait until all completed request's complete fn is called
Date:   Wed, 24 Jul 2019 11:48:42 +0800
Message-Id: <20190724034843.10879-5-ming.lei@redhat.com>
In-Reply-To: <20190724034843.10879-1-ming.lei@redhat.com>
References: <20190724034843.10879-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 24 Jul 2019 03:49:14 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When aborting in-flight request for recovering controller, we have
to make sure that queue's complete function is called on completed
request before moving on. Otherwise, for example, the warning of
WARN_ON_ONCE(qp->mrs_used > 0) in ib_destroy_qp_user() may be
triggered on nvme-rdma.

Fix this issue by using blk_mq_tagset_wait_completed_request.

Cc: Max Gurtovoy <maxg@mellanox.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/fc.c     | 2 ++
 drivers/nvme/host/pci.c    | 2 ++
 drivers/nvme/host/rdma.c   | 8 ++++++--
 drivers/nvme/host/tcp.c    | 8 ++++++--
 drivers/nvme/target/loop.c | 2 ++
 5 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 232d8094091b..f39ed8cc23a2 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2774,6 +2774,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 		nvme_stop_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
+		blk_mq_tagset_wait_completed_request(&ctrl->tag_set);
 	}
 
 	/*
@@ -2796,6 +2797,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
+	blk_mq_tagset_wait_completed_request(&ctrl->admin_tag_set);
 
 	/* kill the aens as they are a separate path */
 	nvme_fc_abort_aen_ops(ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bb970ca82517..47f37d9d9aa7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2403,6 +2403,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 
 	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
 	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
+	blk_mq_tagset_wait_completed_request(&dev->tagset);
+	blk_mq_tagset_wait_completed_request(&dev->admin_tagset);
 
 	/*
 	 * The driver will not be starting up queues again if shutting down so
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a249db528d54..b313a60be1ca 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -901,9 +901,11 @@ static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
 {
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
-	if (ctrl->ctrl.admin_tagset)
+	if (ctrl->ctrl.admin_tagset) {
 		blk_mq_tagset_busy_iter(ctrl->ctrl.admin_tagset,
 			nvme_cancel_request, &ctrl->ctrl);
+		blk_mq_tagset_wait_completed_request(ctrl->ctrl.admin_tagset);
+	}
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_destroy_admin_queue(ctrl, remove);
 }
@@ -914,9 +916,11 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
-		if (ctrl->ctrl.tagset)
+		if (ctrl->ctrl.tagset) {
 			blk_mq_tagset_busy_iter(ctrl->ctrl.tagset,
 				nvme_cancel_request, &ctrl->ctrl);
+			blk_mq_tagset_wait_completed_request(ctrl->ctrl.tagset);
+		}
 		if (remove)
 			nvme_start_queues(&ctrl->ctrl);
 		nvme_rdma_destroy_io_queues(ctrl, remove);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 606b13d35d16..cf2eaf834b36 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1748,9 +1748,11 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 {
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
-	if (ctrl->admin_tagset)
+	if (ctrl->admin_tagset) {
 		blk_mq_tagset_busy_iter(ctrl->admin_tagset,
 			nvme_cancel_request, ctrl);
+		blk_mq_tagset_wait_completed_request(ctrl->admin_tagset);
+	}
 	blk_mq_unquiesce_queue(ctrl->admin_q);
 	nvme_tcp_destroy_admin_queue(ctrl, remove);
 }
@@ -1762,9 +1764,11 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 		return;
 	nvme_stop_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
-	if (ctrl->tagset)
+	if (ctrl->tagset) {
 		blk_mq_tagset_busy_iter(ctrl->tagset,
 			nvme_cancel_request, ctrl);
+		blk_mq_tagset_wait_completed_request(ctrl->tagset);
+	}
 	if (remove)
 		nvme_start_queues(ctrl);
 	nvme_tcp_destroy_io_queues(ctrl, remove);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index b16dc3981c69..95c8f1732215 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -407,6 +407,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 		nvme_stop_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 					nvme_cancel_request, &ctrl->ctrl);
+		blk_mq_tagset_wait_completed_request(&ctrl->tag_set);
 		nvme_loop_destroy_io_queues(ctrl);
 	}
 
@@ -416,6 +417,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_cancel_request, &ctrl->ctrl);
+	blk_mq_tagset_wait_completed_request(&ctrl->admin_tag_set);
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 	nvme_loop_destroy_admin_queue(ctrl);
 }
-- 
2.20.1

