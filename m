Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57669C433EF
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 14:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350736AbiCXOHZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 10:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350735AbiCXOHU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 10:07:20 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474E5AC04C
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 07:05:48 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id o8so3912208pgf.9
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IBmAfRHWXsoFTijrtM1oV+vmwLucmnlLDXAqQecddn0=;
        b=O1O5EI7JckwyfBDV3JsSkek9PmaLW/qCXQ70bXFuBJNUPL642P/yuz0aSgjx/wvIsQ
         Pi8hsvFcnWE2hw25wCNQrb6yFqr06JACIWLx+zVpIX0ezH2ZpvtpDZF6i66KLUaNJ9+/
         woBToDsk5XT0S0AtXT5hF6Onkx+Nv8TBa8eo5iOAE/71NhwhvlGxS4rdRUCo4GTnLAk2
         KhjGlfcJH3qGh3BJ8B9kf2IvNuqDTuVKVuQlIIxesgKQ/fCPV4IEGJPUrcs5SIzThZ0T
         +f/xZDqCuSL3g80hprCbh7iKCW+D2Ap/YhWXMC5yW6F8eOzT3SBOiGjDwJFIot5G8Elf
         t41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBmAfRHWXsoFTijrtM1oV+vmwLucmnlLDXAqQecddn0=;
        b=SCDimEVfSytwAwUWuB74S1F6DnEobkrxOGpuizO0JdteBUA7VvCOMILpKhIIixV2eB
         Usu/fofWvzXjZvs7ll6A8do9nHgd9FxvG/B6rWzvUjxaGxI/dvRXN7/4hXY0cFo4OGWt
         CSTmW0OJxIrGp+ghW5wTBhXEJ93liEOa0v5rXbHeV+a6gf/fEfwNDWoKqBkaz+vlYxeS
         Vit8DhdEyc0NyoNhn7risudS5EP0jnMVsia/Gtkrt6ekF9A9WGk273iXabPM+6c6/XmP
         DTHKbmZbylbOpLrkIgasWdFCOp9jWC1pxIXxgv/GziuCCme88imZs2BQyE2rYYu6K0/e
         7P5A==
X-Gm-Message-State: AOAM533kl1Q8zckdb1rhE1aYb6sN/P4UxXR7SuAf0OCwMLeyy7tl5jXp
        PaQ8drBdGu72SXJ5+qGGjF4=
X-Google-Smtp-Source: ABdhPJy0BkYTP2vEIrYxPSKN2AjlEihlNeOc0pTewu01SslZ0tYErhQAf4rWZpmyeoQR23kFwBUi+w==
X-Received: by 2002:a65:4c82:0:b0:380:3aee:6948 with SMTP id m2-20020a654c82000000b003803aee6948mr4140324pgt.527.1648130747707;
        Thu, 24 Mar 2022 07:05:47 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id u12-20020a17090a890c00b001b8efcf8e48sm9441845pjn.14.2022.03.24.07.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 07:05:46 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v3 2/2] virtio-blk: support mq_ops->queue_rqs()
Date:   Thu, 24 Mar 2022 23:04:50 +0900
Message-Id: <20220324140450.33148-3-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220324140450.33148-1-suwan.kim027@gmail.com>
References: <20220324140450.33148-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch supports mq_ops->queue_rqs() hook. It has an advantage of
batch submission to virtio-blk driver. It also helps polling I/O because
polling uses batched completion of block layer. Batch submission in
queue_rqs() can boost polling performance.

In queue_rqs(), it iterates plug->mq_list, collects requests that
belong to same HW queue and adds requests into virtqueue until it
encounters a request from other HW queue or sees the end of the list.
Then, virtio-blk kicks virtqueue to submit requests.

If there is an error, it inserts error request to requeue_list and
passes it to ordinary block layer path.

For verification, I did fio test.
(io_uring, randread, direct=1, bs=4K, iodepth=64 numjobs=N)
I set 4 vcpu and 2 virtio-blk queues for VM and run fio test 5 times.
It shows about 1-4% improvement.

                                 |   numjobs=2   |    numjobs=4
      -----------------------------------------------------------
        fio without queue_rqs()  |   282K IOPS   |    245K IOPS
      -----------------------------------------------------------
        fio with queue_rqs()     |   294K IOPS   |    249K IOPS

For polling I/O performance, I also did fio test as below.
(io_uring, hipri, randread, direct=1, bs=512, iodepth=64 numjobs=4)
I set 4 vcpu and 2 poll queues for VM.
It shows upto 7% improvement in polling I/O.

                                      |   IOPS   |  avg latency
      -----------------------------------------------------------
        fio poll without queue_rqs()  |   413K   |   619.72 usec
      -----------------------------------------------------------
        fio poll with queue_rqs()     |   445K   |   581.2  usec

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/block/virtio_blk.c | 93 ++++++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 9 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 3d16f8b753e7..4a0a3b2d9caf 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -311,6 +311,28 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
 		virtqueue_notify(vq->vq);
 }
 
+static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
+					struct virtio_blk *vblk,
+					struct request *req,
+					struct virtblk_req *vbr, int *num)
+{
+	blk_status_t status;
+
+	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
+	if (unlikely(status))
+		return status;
+
+	blk_mq_start_request(req);
+
+	*num = virtblk_map_data(hctx, req, vbr);
+	if (unlikely(*num < 0)) {
+		virtblk_cleanup_cmd(req);
+		return BLK_STS_RESOURCE;
+	}
+
+	return BLK_STS_OK;
+}
+
 static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 			   const struct blk_mq_queue_data *bd)
 {
@@ -324,18 +346,10 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_status_t status;
 	int err;
 
-	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
+	status = virtblk_prep_rq(hctx, vblk, req, vbr, &num);
 	if (unlikely(status))
 		return status;
 
-	blk_mq_start_request(req);
-
-	num = virtblk_map_data(hctx, req, vbr);
-	if (unlikely(num < 0)) {
-		virtblk_cleanup_cmd(req);
-		return BLK_STS_RESOURCE;
-	}
-
 	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
 	err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg_table.sgl, num);
 	if (err) {
@@ -367,6 +381,66 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
+static bool virtblk_prep_rq_batch(struct virtio_blk_vq *vq, struct request *req)
+{
+	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
+	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
+	unsigned long flags;
+	int num, err;
+
+	req->mq_hctx->tags->rqs[req->tag] = req;
+
+	if (virtblk_prep_rq(req->mq_hctx, vblk, req, vbr, &num) != BLK_STS_OK)
+		return false;
+
+	spin_lock_irqsave(&vq->lock, flags);
+	err = virtblk_add_req(vq->vq, vbr, vbr->sg_table.sgl, num);
+	if (err) {
+		spin_unlock_irqrestore(&vq->lock, flags);
+		virtblk_unmap_data(req, vbr);
+		virtblk_cleanup_cmd(req);
+		return false;
+	}
+	spin_unlock_irqrestore(&vq->lock, flags);
+
+	return true;
+}
+
+static void virtio_queue_rqs(struct request **rqlist)
+{
+	struct request *req, *next, *prev = NULL;
+	struct request *requeue_list = NULL;
+
+	rq_list_for_each_safe(rqlist, req, next) {
+		struct virtio_blk_vq *vq = req->mq_hctx->driver_data;
+		unsigned long flags;
+		bool kick;
+
+		if (!virtblk_prep_rq_batch(vq, req)) {
+			rq_list_move(rqlist, &requeue_list, req, prev);
+			req = prev;
+
+			if (!req)
+				continue;
+		}
+
+		if (!next || req->mq_hctx != next->mq_hctx) {
+			spin_lock_irqsave(&vq->lock, flags);
+			kick = virtqueue_kick_prepare(vq->vq);
+			spin_unlock_irqrestore(&vq->lock, flags);
+			if (kick)
+				virtqueue_notify(vq->vq);
+
+			req->rq_next = NULL;
+			*rqlist = next;
+			prev = NULL;
+		} else
+			prev = req;
+	}
+
+	*rqlist = requeue_list;
+}
+
 /* return id (s/n) string for *disk to *id_str
  */
 static int virtblk_get_id(struct gendisk *disk, char *id_str)
@@ -823,6 +897,7 @@ static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 
 static const struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
+	.queue_rqs	= virtio_queue_rqs,
 	.commit_rqs	= virtio_commit_rqs,
 	.init_hctx	= virtblk_init_hctx,
 	.complete	= virtblk_request_done,
-- 
2.26.3

