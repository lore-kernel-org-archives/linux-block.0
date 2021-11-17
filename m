Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F092C433EF
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 08:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6E17617E5
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 08:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhKQImQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 03:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbhKQImP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 03:42:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177C8C061746
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 00:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=adqCtY5zGAB9eoGZWzXNfQM5VM8YhPFJd/L/mmYDk6s=; b=lb2LfNIY46vbjbDtyKApbw+CgY
        QjAjXgSDEYQZsRJDJdsL6Wpw6gJycua31srWgzs2jR8bvBywvgeoNanCbRCwCh1/aKE2HMEFfzLJ9
        URu3HRrIJGx1D5tZjWUrQspvVYjgKySt6HrfM62spG2mvLyc2bWvezEvNbLhrNnsqo9GzknQsz6Ml
        g/4QeqyJjQXjFdVqgQkPSzWjYUSXaPo2zwbNY2BG0rf/9KTlCSbewuVDlajW61KHsdxCY8QCXS3bv
        n1HMyGIv4TClh9vwsrnZOas4fD/mKKrTOWVWHS4WiQWLRyv7oljPpVxLhpXtrndriehKJbKftdr3J
        CUlric/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnGTM-003yvD-5C; Wed, 17 Nov 2021 08:39:16 +0000
Date:   Wed, 17 Nov 2021 00:39:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
Message-ID: <YZS/tKW/I55Kus+D@infradead.org>
References: <20211117033807.185715-1-axboe@kernel.dk>
 <20211117033807.185715-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117033807.185715-5-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 16, 2021 at 08:38:07PM -0700, Jens Axboe wrote:
> This enables the block layer to send us a full plug list of requests
> that need submitting. The block layer guarantees that they all belong
> to the same queue, but we do have to check the hardware queue mapping
> for each request.
> 
> If errors are encountered, leave them in the passed in list. Then the
> block layer will handle them individually.
> 
> This is good for about a 4% improvement in peak performance, taking us
> from 9.6M to 10M IOPS/core.

The concept looks sensible, but the loop in nvme_queue_rqs is a complete
mess to follow. What about something like this (untested) on top?

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 13722cc400c2c..555a7609580c7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -509,21 +509,6 @@ static inline void nvme_copy_cmd(struct nvme_queue *nvmeq,
 		nvmeq->sq_tail = 0;
 }
 
-/**
- * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
- * @nvmeq: The queue to use
- * @cmd: The command to send
- * @write_sq: whether to write to the SQ doorbell
- */
-static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
-			    bool write_sq)
-{
-	spin_lock(&nvmeq->sq_lock);
-	nvme_copy_cmd(nvmeq, cmd);
-	nvme_write_sq_db(nvmeq, write_sq);
-	spin_unlock(&nvmeq->sq_lock);
-}
-
 static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
@@ -918,8 +903,7 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 	return BLK_STS_OK;
 }
 
-static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct nvme_ns *ns,
-				 struct request *req, struct nvme_command *cmnd)
+static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	blk_status_t ret;
@@ -928,18 +912,18 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct nvme_ns *ns,
 	iod->npages = -1;
 	iod->nents = 0;
 
-	ret = nvme_setup_cmd(ns, req);
+	ret = nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
 		return ret;
 
 	if (blk_rq_nr_phys_segments(req)) {
-		ret = nvme_map_data(dev, req, cmnd);
+		ret = nvme_map_data(dev, req, &iod->cmd);
 		if (ret)
 			goto out_free_cmd;
 	}
 
 	if (blk_integrity_rq(req)) {
-		ret = nvme_map_metadata(dev, req, cmnd);
+		ret = nvme_map_metadata(dev, req, &iod->cmd);
 		if (ret)
 			goto out_unmap_data;
 	}
@@ -959,7 +943,6 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct nvme_ns *ns,
 static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 			 const struct blk_mq_queue_data *bd)
 {
-	struct nvme_ns *ns = hctx->queue->queuedata;
 	struct nvme_queue *nvmeq = hctx->driver_data;
 	struct nvme_dev *dev = nvmeq->dev;
 	struct request *req = bd->rq;
@@ -976,12 +959,15 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (!nvme_check_ready(&dev->ctrl, req, true))
 		return nvme_fail_nonready_command(&dev->ctrl, req);
 
-	ret = nvme_prep_rq(dev, ns, req, &iod->cmd);
-	if (ret == BLK_STS_OK) {
-		nvme_submit_cmd(nvmeq, &iod->cmd, bd->last);
-		return BLK_STS_OK;
-	}
-	return ret;
+	ret = nvme_prep_rq(dev, req);
+	if (ret)
+		return ret;
+
+	spin_lock(&nvmeq->sq_lock);
+	nvme_copy_cmd(nvmeq, &iod->cmd);
+	nvme_write_sq_db(nvmeq, bd->last);
+	spin_unlock(&nvmeq->sq_lock);
+	return BLK_STS_OK;
 }
 
 static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct request **rqlist)
@@ -997,56 +983,47 @@ static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct request **rqlist)
 	spin_unlock(&nvmeq->sq_lock);
 }
 
-static void nvme_queue_rqs(struct request **rqlist)
+static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
 {
-	struct request *requeue_list = NULL, *req, *prev = NULL;
-	struct blk_mq_hw_ctx *hctx;
-	struct nvme_queue *nvmeq;
-	struct nvme_ns *ns;
-
-restart:
-	req = rq_list_peek(rqlist);
-	hctx = req->mq_hctx;
-	nvmeq = hctx->driver_data;
-	ns = hctx->queue->queuedata;
-
 	/*
 	 * We should not need to do this, but we're still using this to
 	 * ensure we can drain requests on a dying queue.
 	 */
 	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
-		return;
+		return false;
+	if (unlikely(!nvme_check_ready(&nvmeq->dev->ctrl, req, true)))
+		return false;
 
-	rq_list_for_each(rqlist, req) {
-		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-		blk_status_t ret;
+	req->mq_hctx->tags->rqs[req->tag] = req;
+	return nvme_prep_rq(nvmeq->dev, req) == BLK_STS_OK;
+}
 
-		if (unlikely(!nvme_check_ready(&nvmeq->dev->ctrl, req, true)))
-			goto requeue;
+static void nvme_queue_rqs(struct request **rqlist)
+{
+	struct request *req = rq_list_peek(rqlist), *prev = NULL;
+	struct request *requeue_list = NULL;
+
+	do {
+		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+
+		if (!nvme_prep_rq_batch(nvmeq, req)) {
+			/* detach 'req' and add to remainder list */
+			if (prev)
+				prev->rq_next = req->rq_next;
+			rq_list_add(&requeue_list, req);
+		} else {
+			prev = req;
+		}
 
-		if (req->mq_hctx != hctx) {
+		req = rq_list_next(req);
+		if (!req || (prev && req->mq_hctx != prev->mq_hctx)) {
 			/* detach rest of list, and submit */
 			prev->rq_next = NULL;
 			nvme_submit_cmds(nvmeq, rqlist);
-			/* req now start of new list for this hw queue */
 			*rqlist = req;
-			goto restart;
-		}
-
-		hctx->tags->rqs[req->tag] = req;
-		ret = nvme_prep_rq(nvmeq->dev, ns, req, &iod->cmd);
-		if (ret == BLK_STS_OK) {
-			prev = req;
-			continue;
 		}
-requeue:
-		/* detach 'req' and add to remainder list */
-		if (prev)
-			prev->rq_next = req->rq_next;
-		rq_list_add(&requeue_list, req);
-	}
+	} while (req);
 
-	nvme_submit_cmds(nvmeq, rqlist);
 	*rqlist = requeue_list;
 }
 
@@ -1224,7 +1201,11 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 
 	c.common.opcode = nvme_admin_async_event;
 	c.common.command_id = NVME_AQ_BLK_MQ_DEPTH;
-	nvme_submit_cmd(nvmeq, &c, true);
+
+	spin_lock(&nvmeq->sq_lock);
+	nvme_copy_cmd(nvmeq, &c);
+	nvme_write_sq_db(nvmeq, true);
+	spin_unlock(&nvmeq->sq_lock);
 }
 
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
