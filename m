Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF314C433EF
	for <linux-block@archiver.kernel.org>; Mon,  4 Apr 2022 09:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347122AbiDDJap (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Apr 2022 05:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiDDJal (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Apr 2022 05:30:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4047A22B2B
        for <linux-block@vger.kernel.org>; Mon,  4 Apr 2022 02:28:45 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p17so7628859plo.9
        for <linux-block@vger.kernel.org>; Mon, 04 Apr 2022 02:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O2dQ/xAFxjh1YaGRXT309dq1U3WwKPaBP+AWNXb/eVE=;
        b=iPRycRF66NFZ4zyadclcZ34dnUxQUGbFTv/oze9hDUlskLbmzPjB9EvZhjQNF9azxv
         mAmkQvgGTzIrVGL0sCdCaNS6GZXNp2PxDyyPJto7cgy4mmoHvlFmZ2bYe6QSp6aYRvJh
         GmbDIMcNf+DFqHx06ahvhe9XHsaO4B3ugMZuD08ayYOCOSqBMD7qb1BRI69tCRByUhAL
         d28kS7l2WoyWMP+GynJmbbYGu5sHSTCpmfQPrTSVIPMThC8au8m0DnmHDMe6cukMgM7r
         EmHxiqqA7/vhHBEro2zRy0q3vhtQsU/tY9Rc7RJfRZN6Okd66olwLM16+YQr18w/eKxC
         xy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O2dQ/xAFxjh1YaGRXT309dq1U3WwKPaBP+AWNXb/eVE=;
        b=nxq1cvTwKxNCt67gexyv+ssM3DfQPZZqo0bJqxeYyIPO9b8TH2nQ75nmm3U0zJh8eV
         445191kyKjj6qBGSVE/npLcMZcOrbFgBI4VE1Mw1MFKtW4cSdELbGaxA9uXvu45MwJTp
         ESJeF4/i+NZ06FL7khlvflL5K/uE/9hnEVlRD2dgYcwTpGtElppEBhmjz5EUmN0Kbc1u
         tVoXIKh7UUirDRtzZbCLyVW4Gdqhk37B2P3K9riXkWJc+Y55nP4JB6QmrOWUWJnAhQrP
         O8xUPfOOQrBX+7EbYbvW7ercOr4W14+1sBn07s8eJ0owVPzIwn9ugHwNGxugPPGYcDSd
         C4bQ==
X-Gm-Message-State: AOAM5326y5UuSMv7044vnfkwHoOaakQiF+1W9zazBMzMheh9mFY8fNLI
        p8ocizm/2vryBykPiTRzSPE=
X-Google-Smtp-Source: ABdhPJzfNi/zp46Bh8LXol0dcZZ4Gw1PFeGe2hXHlDNumSiiaRuQh3MkPf/uKFzY4LXua2MxgvJVHA==
X-Received: by 2002:a17:902:f68e:b0:154:6518:69ba with SMTP id l14-20020a170902f68e00b00154651869bamr22268306plg.60.1649064524698;
        Mon, 04 Apr 2022 02:28:44 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id x9-20020a17090a970900b001ca6c59b350sm6187675pjo.2.2022.04.04.02.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 02:28:43 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com, dongli.zhang@oracle.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v4 2/2] virtio-blk: support mq_ops->queue_rqs()
Date:   Mon,  4 Apr 2022 18:28:05 +0900
Message-Id: <20220404092805.77643-3-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220404092805.77643-1-suwan.kim027@gmail.com>
References: <20220404092805.77643-1-suwan.kim027@gmail.com>
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
belong to same HW queue until it encounters a request from other
HW queue or sees the end of the list.
Then, virtio-blk adds requests into virtqueue and kicks virtqueue
to submit requests.

If there is an error, it inserts error request to requeue_list and
passes it to ordinary block layer path.

For verification, I did fio test.
(io_uring, randread, direct=1, bs=4K, iodepth=64 numjobs=N)
I set 4 vcpu and 2 virtio-blk queues for VM and run fio test 5 times.
It shows about 2% improvement.

                                 |   numjobs=2   |   numjobs=4
      -----------------------------------------------------------
        fio without queue_rqs()  |   291K IOPS   |   238K IOPS
      -----------------------------------------------------------
        fio with queue_rqs()     |   295K IOPS   |   243K IOPS

For polling I/O performance, I also did fio test as below.
(io_uring, hipri, randread, direct=1, bs=512, iodepth=64 numjobs=4)
I set 4 vcpu and 2 poll queues for VM.
It shows about 2% improvement in polling I/O.

                                      |   IOPS   |  avg latency
      -----------------------------------------------------------
        fio poll without queue_rqs()  |   424K   |   613.05 usec
      -----------------------------------------------------------
        fio poll with queue_rqs()     |   435K   |   601.01 usec

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/block/virtio_blk.c | 110 +++++++++++++++++++++++++++++++++----
 1 file changed, 99 insertions(+), 11 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c2d955da0006..03e4455c23e3 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -92,6 +92,7 @@ struct virtio_blk {
 struct virtblk_req {
 	struct virtio_blk_outhdr out_hdr;
 	u8 status;
+	int sg_num;
 	struct sg_table sg_table;
 	struct scatterlist sg[];
 };
@@ -311,18 +312,13 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
 		virtqueue_notify(vq->vq);
 }
 
-static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
-			   const struct blk_mq_queue_data *bd)
+static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
+					struct virtio_blk *vblk,
+					struct request *req,
+					struct virtblk_req *vbr)
 {
-	struct virtio_blk *vblk = hctx->queue->queuedata;
-	struct request *req = bd->rq;
-	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
-	unsigned long flags;
-	int num;
-	int qid = hctx->queue_num;
-	bool notify = false;
 	blk_status_t status;
-	int err;
+	int num;
 
 	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
 	if (unlikely(status))
@@ -335,9 +331,30 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 		virtblk_cleanup_cmd(req);
 		return BLK_STS_RESOURCE;
 	}
+	vbr->sg_num = num;
+
+	return BLK_STS_OK;
+}
+
+static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
+			   const struct blk_mq_queue_data *bd)
+{
+	struct virtio_blk *vblk = hctx->queue->queuedata;
+	struct request *req = bd->rq;
+	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
+	unsigned long flags;
+	int qid = hctx->queue_num;
+	bool notify = false;
+	blk_status_t status;
+	int err;
+
+	status = virtblk_prep_rq(hctx, vblk, req, vbr);
+	if (unlikely(status))
+		return status;
 
 	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
-	err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg_table.sgl, num);
+	err = virtblk_add_req(vblk->vqs[qid].vq, vbr,
+				vbr->sg_table.sgl, vbr->sg_num);
 	if (err) {
 		virtqueue_kick(vblk->vqs[qid].vq);
 		/* Don't stop the queue if -ENOMEM: we may have failed to
@@ -367,6 +384,76 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
+static bool virtblk_prep_rq_batch(struct request *req)
+{
+	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
+	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
+
+	req->mq_hctx->tags->rqs[req->tag] = req;
+
+	return virtblk_prep_rq(req->mq_hctx, vblk, req, vbr) == BLK_STS_OK;
+}
+
+static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
+					struct request **rqlist,
+					struct request **requeue_list)
+{
+	unsigned long flags;
+	int err;
+	bool kick;
+
+	spin_lock_irqsave(&vq->lock, flags);
+
+	while (!rq_list_empty(*rqlist)) {
+		struct request *req = rq_list_pop(rqlist);
+		struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
+
+		err = virtblk_add_req(vq->vq, vbr,
+					vbr->sg_table.sgl, vbr->sg_num);
+		if (err) {
+			virtblk_unmap_data(req, vbr);
+			virtblk_cleanup_cmd(req);
+			rq_list_add(requeue_list, req);
+		}
+	}
+
+	kick = virtqueue_kick_prepare(vq->vq);
+	spin_unlock_irqrestore(&vq->lock, flags);
+
+	return kick;
+}
+
+static void virtio_queue_rqs(struct request **rqlist)
+{
+	struct request *req, *next, *prev = NULL;
+	struct request *requeue_list = NULL;
+
+	rq_list_for_each_safe(rqlist, req, next) {
+		struct virtio_blk_vq *vq = req->mq_hctx->driver_data;
+		bool kick;
+
+		if (!virtblk_prep_rq_batch(req)) {
+			rq_list_move(rqlist, &requeue_list, req, prev);
+			req = prev;
+			if (!req)
+				continue;
+		}
+
+		if (!next || req->mq_hctx != next->mq_hctx) {
+			req->rq_next = NULL;
+			kick = virtblk_add_req_batch(vq, rqlist, &requeue_list);
+			if (kick)
+				virtqueue_notify(vq->vq);
+
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
@@ -834,6 +921,7 @@ static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 
 static const struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
+	.queue_rqs	= virtio_queue_rqs,
 	.commit_rqs	= virtio_commit_rqs,
 	.init_hctx	= virtblk_init_hctx,
 	.complete	= virtblk_request_done,
-- 
2.26.3

