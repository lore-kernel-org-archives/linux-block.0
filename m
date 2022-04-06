Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09B5C433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 17:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239079AbiDFRaO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239095AbiDFRaF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 13:30:05 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5194A1B2C46
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 08:33:05 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f3so2794305pfe.2
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUZaMqlIZslqTIAvp50tjNzPRTlwW0v6s6z7ljz2x04=;
        b=SyK4W1aNuYA/zPaey9m6E0e/QHjNc9/UVcQCe2OBeb21losYNrtfYrq6T8Pr36dJAx
         ENn5Oee2uy8flEagL+mCAtb4g6wiO0xI9ctCePDLrcAnDkwfGOik/aPpan96ZtJcaoO8
         buTmHDwWImTNJIYLdvOaX7S4SQr/9DurJ/ZthGar96ffWDQeUx4GFfiQKCdpFEJezv3b
         mvfaclSNkKquwKfFfMlUtxrw6u2eOfpp7NUdhEE7FxyTH34qdevkz3OauLiSEcw45JhB
         rbK7Nn6WgKnnY3k3b17vQFmMy2+qssAArQccnNHzXdugFA80HVH0KtueutGbBtwYaR7u
         bMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUZaMqlIZslqTIAvp50tjNzPRTlwW0v6s6z7ljz2x04=;
        b=fqU0+gg7WzTIGTng84tU0NHddVxP8iMNdvMcVLnslYbksHexx0N8HQTWhpZDezk8GN
         qBta/RtGVGsZqcU4S0E0DuFNuzoDJ3wdAGhSHiONRPpBQnwPHMMu6wD/ZIx0QfIwUoqt
         Hc57VG/7oh1t5hMVhq9ooKXdMbxuS0znNERyI1LZHEK9/UTFtj7mc9KouXprzQs3EDQE
         KD5m8XtBFzyjgD+SMlbKvY/J+rxno4xMkl6Sntb6NoHt/q3YB4kdjZ82G7cCVbo57OAy
         vTphmJj2Ez7ZKH7JU6LZcqm3b6WD/Fww6yiXEYJJcClosnlg03sYRXKEAtDfUPiYvOyS
         2/aQ==
X-Gm-Message-State: AOAM530aHPoaU5B4yZ0IxuN73HaeAR0ENHuf1qhV3BFCdYA0Uehcdw5D
        Anqfu2FqgocqqHB17cOqI1w=
X-Google-Smtp-Source: ABdhPJzuhccBeWETUUETOeLWJw5Aqz2446WFQYJIKw7lFhVZQP4Jwldbynm8zkTaFq7dhEz3gB/IHw==
X-Received: by 2002:a63:5051:0:b0:374:5fd0:f131 with SMTP id q17-20020a635051000000b003745fd0f131mr7659331pgl.431.1649259184697;
        Wed, 06 Apr 2022 08:33:04 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id f31-20020a17090a702200b001ca996866b5sm6024037pjk.12.2022.04.06.08.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:33:03 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com, dongli.zhang@oracle.com,
        hch@infradead.org, elliott@hpe.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 2/2] virtio-blk: support mq_ops->queue_rqs()
Date:   Thu,  7 Apr 2022 00:32:07 +0900
Message-Id: <20220406153207.163134-3-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220406153207.163134-1-suwan.kim027@gmail.com>
References: <20220406153207.163134-1-suwan.kim027@gmail.com>
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

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/block/virtio_blk.c | 114 +++++++++++++++++++++++++++++++------
 1 file changed, 98 insertions(+), 16 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 957e15b87651..924a1cd6cdca 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -101,8 +101,7 @@ static inline blk_status_t virtblk_result(struct virtblk_req *vbr)
 	}
 }
 
-static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr,
-		struct scatterlist *data_sg, bool have_data)
+static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
 {
 	struct scatterlist hdr, status, *sgs[3];
 	unsigned int num_out = 0, num_in = 0;
@@ -110,11 +109,11 @@ static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr,
 	sg_init_one(&hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
 	sgs[num_out++] = &hdr;
 
-	if (have_data) {
+	if (vbr->sg_table.nents) {
 		if (vbr->out_hdr.type & cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OUT))
-			sgs[num_out++] = data_sg;
+			sgs[num_out++] = vbr->sg_table.sgl;
 		else
-			sgs[num_out + num_in++] = data_sg;
+			sgs[num_out + num_in++] = vbr->sg_table.sgl;
 	}
 
 	sg_init_one(&status, &vbr->status, sizeof(vbr->status));
@@ -304,6 +303,28 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
 		virtqueue_notify(vq->vq);
 }
 
+static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
+					struct virtio_blk *vblk,
+					struct request *req,
+					struct virtblk_req *vbr)
+{
+	blk_status_t status;
+
+	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
+	if (unlikely(status))
+		return status;
+
+	blk_mq_start_request(req);
+
+	vbr->sg_table.nents = virtblk_map_data(hctx, req, vbr);
+	if (unlikely(vbr->sg_table.nents < 0)) {
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
@@ -311,26 +332,17 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *req = bd->rq;
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
 	unsigned long flags;
-	int num;
 	int qid = hctx->queue_num;
 	bool notify = false;
 	blk_status_t status;
 	int err;
 
-	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
+	status = virtblk_prep_rq(hctx, vblk, req, vbr);
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
-	err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg_table.sgl, num);
+	err = virtblk_add_req(vblk->vqs[qid].vq, vbr);
 	if (err) {
 		virtqueue_kick(vblk->vqs[qid].vq);
 		/* Don't stop the queue if -ENOMEM: we may have failed to
@@ -360,6 +372,75 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
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
+		err = virtblk_add_req(vq->vq, vbr);
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
@@ -794,6 +875,7 @@ static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 
 static const struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
+	.queue_rqs	= virtio_queue_rqs,
 	.commit_rqs	= virtio_commit_rqs,
 	.init_hctx	= virtblk_init_hctx,
 	.complete	= virtblk_request_done,
-- 
2.26.3

