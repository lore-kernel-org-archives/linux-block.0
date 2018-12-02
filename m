Return-Path: <SRS0=EAuX=OL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5396BC64EB4
	for <linux-block@archiver.kernel.org>; Sun,  2 Dec 2018 16:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D2420851
	for <linux-block@archiver.kernel.org>; Sun,  2 Dec 2018 16:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tK25USxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D2420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbeLBQsI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Dec 2018 11:48:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55136 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbeLBQsI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Dec 2018 11:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JsXyoO/ZKgVVTIilZXvL7ZUN+eZTEnZ6tRHAghGZKbs=; b=tK25USxBKDqwh2uFZ+F+ADVqNd
        C+eCo7Y2BJ/kVSR3bZm+5UG93Uvl7iRR/znShCxh17/DMOpkO8Z5TuUhoXjkukjaBuSJwM38wI1Ly
        kZbktnHXgx9i7DGqLQrA5fLYHuy8L+b4RbsBHG78q4tMtZnFcVX5iVwSpD8IWKdNkyTFSTrQ7ZHNA
        o0qE3a5ptgWzQFe2nC02zSOCroq91BitLWpf9wdp8mbjCyO5d/gmb/99axnmlpBiQhqiSf643+HOw
        oQLtvM/GIslDrYq2m+BGYzAClcXhkDve01lrtR9TrPoaQGDiByyrsdmvhTJtnyTLMj7y7O3CfWtI5
        ZAwij5RQ==;
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTUuV-0002TN-4f; Sun, 02 Dec 2018 16:47:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 07/13] nvme-pci: don't poll from irq context when deleting queues
Date:   Sun,  2 Dec 2018 17:46:22 +0100
Message-Id: <20181202164628.1116-8-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181202164628.1116-1-hch@lst.de>
References: <20181202164628.1116-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is the last place outside of nvme_irq that handles CQEs from
interrupt context, and thus is in the way of removing the cq_lock for
normal queues, and avoiding lockdep warnings on the poll queues, for
which we already take it without IRQ disabling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9ceba9900ca3..2d5a468c35b1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -122,7 +122,6 @@ struct nvme_dev {
 	u32 cmbsz;
 	u32 cmbloc;
 	struct nvme_ctrl ctrl;
-	struct completion ioq_wait;
 
 	mempool_t *iod_mempool;
 
@@ -203,10 +202,12 @@ struct nvme_queue {
 	unsigned long flags;
 #define NVMEQ_ENABLED		0
 #define NVMEQ_SQ_CMB		1
+#define NVMEQ_DELETE_ERROR	2
 	u32 *dbbuf_sq_db;
 	u32 *dbbuf_cq_db;
 	u32 *dbbuf_sq_ei;
 	u32 *dbbuf_cq_ei;
+	struct completion delete_done;
 };
 
 /*
@@ -1535,6 +1536,8 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	int result;
 	s16 vector;
 
+	clear_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags);
+
 	/*
 	 * A queue's vector matches the queue identifier unless the controller
 	 * has only one vector available.
@@ -2208,15 +2211,15 @@ static void nvme_del_queue_end(struct request *req, blk_status_t error)
 	struct nvme_queue *nvmeq = req->end_io_data;
 
 	blk_mq_free_request(req);
-	complete(&nvmeq->dev->ioq_wait);
+	complete(&nvmeq->delete_done);
 }
 
 static void nvme_del_cq_end(struct request *req, blk_status_t error)
 {
 	struct nvme_queue *nvmeq = req->end_io_data;
 
-	if (!error)
-		nvme_poll_irqdisable(nvmeq, -1);
+	if (error)
+		set_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags);
 
 	nvme_del_queue_end(req, error);
 }
@@ -2238,6 +2241,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	req->timeout = ADMIN_TIMEOUT;
 	req->end_io_data = nvmeq;
 
+	init_completion(&nvmeq->delete_done);
 	blk_execute_rq_nowait(q, NULL, req, false,
 			opcode == nvme_admin_delete_cq ?
 				nvme_del_cq_end : nvme_del_queue_end);
@@ -2249,7 +2253,6 @@ static bool nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 	int nr_queues = dev->online_queues - 1, sent = 0;
 	unsigned long timeout;
 
-	reinit_completion(&dev->ioq_wait);
  retry:
 	timeout = ADMIN_TIMEOUT;
 	while (nr_queues > 0) {
@@ -2258,11 +2261,20 @@ static bool nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 		nr_queues--;
 		sent++;
 	}
-	while (sent--) {
-		timeout = wait_for_completion_io_timeout(&dev->ioq_wait,
+	while (sent) {
+		struct nvme_queue *nvmeq = &dev->queues[nr_queues + sent];
+
+		timeout = wait_for_completion_io_timeout(&nvmeq->delete_done,
 				timeout);
 		if (timeout == 0)
 			return false;
+
+		/* handle any remaining CQEs */
+		if (opcode == nvme_admin_delete_cq &&
+		    !test_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags))
+			nvme_poll_irqdisable(nvmeq, -1);
+
+		sent--;
 		if (nr_queues)
 			goto retry;
 	}
@@ -2746,7 +2758,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
 	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
 	mutex_init(&dev->shutdown_lock);
-	init_completion(&dev->ioq_wait);
 
 	result = nvme_setup_prp_pools(dev);
 	if (result)
-- 
2.19.1

