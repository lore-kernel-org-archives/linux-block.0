Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F548C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF152146D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF152146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbeLAHkC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:40:02 -0500
Received: from mga12.intel.com ([192.55.52.136]:53034 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbeLAHkC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 Dec 2018 02:40:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 12:29:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,299,1539673200"; 
   d="scan'208";a="121024769"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 30 Nov 2018 12:29:33 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/2] nvme: Remove queue flushing hack
Date:   Fri, 30 Nov 2018 13:26:35 -0700
Message-Id: <20181130202635.11145-2-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181130202635.11145-1-keith.busch@intel.com>
References: <20181130202635.11145-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The nvme driver checked the queue state on every IO so the path could
drain requests. The code however declares "We shold not need to do this",
so let's not do it. Instead, use blk-mq's tag iterator to terminate
entered requests on dying queues so the IO path doesn't have to deal
with these conditions.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/core.c | 10 ++++++++--
 drivers/nvme/host/pci.c  | 43 +++++++++++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 91474b3c566c..af84c4d3c20e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -103,6 +103,13 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
 
+static bool nvme_fail_request(struct blk_mq_hw_ctx *hctx, struct request *req,
+			      void *data, bool reserved)
+{
+	blk_mq_end_request(req, BLK_STS_IOERR);
+	return true;
+}
+
 static void nvme_set_queue_dying(struct nvme_ns *ns)
 {
 	/*
@@ -113,8 +120,7 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 		return;
 	revalidate_disk(ns->disk);
 	blk_set_queue_dying(ns->queue);
-	/* Forcibly unquiesce queues to avoid blocking dispatch */
-	blk_mq_unquiesce_queue(ns->queue);
+	blk_mq_queue_tag_busy_iter(ns->queue, nvme_fail_request, NULL);
 }
 
 static void nvme_queue_scan(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3ecc0bf75a62..ec830aa52842 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -926,13 +926,6 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_command cmnd;
 	blk_status_t ret;
 
-	/*
-	 * We should not need to do this, but we're still using this to
-	 * ensure we can drain requests on a dying queue.
-	 */
-	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
-		return BLK_STS_IOERR;
-
 	ret = nvme_setup_cmd(ns, req, &cmnd);
 	if (ret)
 		return ret;
@@ -1408,10 +1401,6 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 {
 	if (!test_and_clear_bit(NVMEQ_ENABLED, &nvmeq->flags))
 		return 1;
-
-	/* ensure that nvme_queue_rq() sees NVMEQ_ENABLED cleared */
-	mb();
-
 	nvmeq->dev->online_queues--;
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
 		blk_mq_quiesce_queue(nvmeq->dev->ctrl.admin_q);
@@ -1611,15 +1600,30 @@ static const struct blk_mq_ops nvme_mq_ops = {
 	.poll		= nvme_poll,
 };
 
+static bool nvme_fail_queue_request(struct request *req, void *data, bool reserved)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = iod->nvmeq;
+
+	if (test_bit(NVMEQ_ENABLED, &nvmeq->flags))
+		return true;
+	blk_mq_end_request(req, BLK_STS_IOERR);
+	return true;
+}
+
 static void nvme_dev_remove_admin(struct nvme_dev *dev)
 {
 	if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q)) {
 		/*
 		 * If the controller was reset during removal, it's possible
-		 * user requests may be waiting on a stopped queue. Start the
-		 * queue to flush these to completion.
+		 * user requests may be waiting on a stopped queue. End all
+		 * entered requests after preventing new requests from
+		 * entering.
 		 */
-		blk_mq_unquiesce_queue(dev->ctrl.admin_q);
+		blk_set_queue_dying(dev->ctrl.admin_q);
+		blk_mq_tagset_all_iter(&dev->admin_tagset,
+				       nvme_fail_queue_request,
+				       NULL);
 		blk_cleanup_queue(dev->ctrl.admin_q);
 		blk_mq_free_tag_set(&dev->admin_tagset);
 	}
@@ -2411,6 +2415,11 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 	}
 }
 
+static void nvme_fail_requests(struct nvme_dev *dev)
+{
+	blk_mq_tagset_all_iter(&dev->tagset, nvme_fail_queue_request, NULL);
+}
+
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
 	int i;
@@ -2454,11 +2463,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 
 	/*
 	 * The driver will not be starting up queues again if shutting down so
-	 * must flush all entered requests to their failed completion to avoid
+	 * must end all entered requests to their failed completion to avoid
 	 * deadlocking blk-mq hot-cpu notifier.
 	 */
 	if (shutdown)
-		nvme_start_queues(&dev->ctrl);
+		nvme_fail_requests(dev);
 	mutex_unlock(&dev->shutdown_lock);
 }
 
@@ -2601,6 +2610,8 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_remove_namespaces(&dev->ctrl);
 		new_state = NVME_CTRL_ADMIN_ONLY;
 	} else {
+		/* Fail requests that entered an hctx that no longer exists */
+		nvme_fail_requests(dev);
 		nvme_start_queues(&dev->ctrl);
 		nvme_wait_freeze(&dev->ctrl);
 		/* hit this only when allocate tagset fails */
-- 
2.14.4

