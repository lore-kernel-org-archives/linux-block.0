Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7423C433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Apr 2022 05:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiDEFd5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiDEFd4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Apr 2022 01:33:56 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BD3CF5
        for <linux-block@vger.kernel.org>; Mon,  4 Apr 2022 22:31:59 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id b130so10116207pga.13
        for <linux-block@vger.kernel.org>; Mon, 04 Apr 2022 22:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aXRz0EkWJNGUKj9FcrT3RlKSXvjHH2nO+rpSazhP1Rw=;
        b=hTVYU4NAR4dRjdqTT7IcHOz0enI391NAJQeeVCvSiWZ2njw2Ag2+aakmlSKSBGLEbf
         Nd247tKwVv4nb5MB4Mwexya2p0EIZVwO+fRISVWqTOywLpEA+jgg3NfPdfkX16rYsia1
         H+GLid8i8fH1zcVCQRevIjkr/ot04HSwJoyd7uANouZW9kbdc9IQhohCIktGR2/qcSDl
         AVV+y5ZvvbJpHddzZU2b2PNOsPIoVf8dZlOzZBIgdX5zUlZhSeuu0mvrco3xCEJ+iP2C
         ia1bfGz/6+fpXPtq52LqEMlmuSnrcVeEFojQiUacLEOFTd9NUcIcFtmO35disCpLf4ZT
         fiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aXRz0EkWJNGUKj9FcrT3RlKSXvjHH2nO+rpSazhP1Rw=;
        b=3DzxC0KcP6gAF85H2h5cRqBj7xKgnTrB4OxcmqWrP3Wzi/bUotCq5nC1sAQBJ4cBbA
         R5asZd4o4ZljpIa1XyHCW5C8b+Qfqnqj2woy7Dy+h/Af7kN1E/irOPMh4grSYOT+0ZlC
         6dj9jhpsxiHfKpoUQtRFCxIlduYf2AGhBPVb+U4KdzARyB2erUH1HoirWNMZMRQxxQLj
         TS+903YFT5khqhuEwV0n5rxaWjYN/c2qkrPOlb79j1Cnwol8r4uF6YCT7iRCEKMzfOg+
         QGI20TnXbz+ZO41S4S82Ceo78NF9qvvb3Tn8daIu8cP07RKV2C4xuLJqlcJCC9dThSXO
         fhBQ==
X-Gm-Message-State: AOAM530AneXIexH3licn/gPolJ6eTzW9Y78QZW26X70d1RI0TWpn1uRC
        yJVmMGy51QhcLuu/4zA+TMk=
X-Google-Smtp-Source: ABdhPJxtffzcZpmViA/40aCJPeOBkeyZWzUJLgi50xs6D7vZiy7wX9fLxcXO0zNRtkMU0kFQASjCyg==
X-Received: by 2002:a63:5b48:0:b0:381:10:43e5 with SMTP id l8-20020a635b48000000b00381001043e5mr1477982pgm.544.1649136718743;
        Mon, 04 Apr 2022 22:31:58 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id g1-20020a17090adac100b001c67cedd84esm866141pjx.42.2022.04.04.22.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 22:31:58 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com, dongli.zhang@oracle.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v4 2/2] virtio-blk: support mq_ops->queue_rqs()
Date:   Tue,  5 Apr 2022 14:31:22 +0900
Message-Id: <20220405053122.77626-3-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220405053122.77626-1-suwan.kim027@gmail.com>
References: <20220405053122.77626-1-suwan.kim027@gmail.com>
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
index 712579dcd3cc..a091034bc551 100644
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

