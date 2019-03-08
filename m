Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1159CC10F0C
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 17:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E751620868
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 17:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfCHRjh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:39:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:33276 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfCHRjh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 12:39:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 09:39:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="132430653"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2019 09:39:36 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 5/5] nvme/pci: Remove queue IO flushing hack
Date:   Fri,  8 Mar 2019 10:40:06 -0700
Message-Id: <20190308174006.5032-5-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190308174006.5032-1-keith.busch@intel.com>
References: <20190308174006.5032-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The nvme driver checked the queue state on every IO so this path could
be used to flush out entered requests to a failed completion. The code
even mentions in comments that we shouldn't have to do this, so let's
not do it.

Use the blk-mq's tag iterator to end all entered requests when the queue
isn't going to be restarted so the IO path doesn't have to deal with
these conditions.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/pci.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f54718b63637..398c6333cf77 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -918,13 +918,6 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
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
@@ -1403,10 +1396,6 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
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
@@ -1616,15 +1605,29 @@ static const struct blk_mq_ops nvme_mq_ops = {
 	.poll		= nvme_poll,
 };
 
+static bool nvme_fail_queue_request(struct request *req, void *data, bool reserved)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = iod->nvmeq;
+
+	if (!test_bit(NVMEQ_ENABLED, &nvmeq->flags))
+		blk_mq_end_request(req, BLK_STS_IOERR);
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
+		blk_mq_tagset_busy_iter(&dev->admin_tagset,
+					nvme_fail_queue_request,
+					NULL);
 		blk_cleanup_queue(dev->ctrl.admin_q);
 		blk_mq_free_tag_set(&dev->admin_tagset);
 	}
@@ -2435,6 +2438,14 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 	}
 }
 
+static void nvme_fail_requests(struct nvme_dev *dev)
+{
+	if (!dev->ctrl.tagset)
+		return;
+	blk_mq_tagset_busy_iter(dev->ctrl.tagset, nvme_fail_queue_request,
+				NULL);
+}
+
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
 	bool dead = true;
@@ -2475,11 +2486,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 
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
 
@@ -2624,6 +2635,8 @@ static void nvme_reset_work(struct work_struct *work)
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

