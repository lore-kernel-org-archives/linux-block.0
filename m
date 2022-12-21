Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FD8C4332F
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 14:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiLUO4I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 09:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiLUOzw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 09:55:52 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E51C183BD
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 06:55:50 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so2531638pjj.2
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 06:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bCgZvA0kqp3iSuTat4yeXBgIoJ3hCErb5UDQaWVxOQ=;
        b=LUv7t/n9y3cadzgqZM+SQEQ5hZel/Ezp/bUxg/fkpb60ty+YjJfQOy/42bNkh92zsS
         pFiX+hX4yUzHSUbLqIJvXHFhD8HOdkI3uOxk8FTw3KbU5yib33ok1pPKAStBOD/wN9l1
         4PQ6//I5SJSbb6X8XCstL+fKF2uimT5i5CmBRZZQyE6PgKn6Hj4kiHE3OaKgABSRGFku
         sRyfQT7VlL7Qt18EPtDkB3NSxJHmGsGN1PtnEuRO0Ku+Bfk8pA74l9WA+CCDv0O9Ja/4
         ssm6ngKM6PqANWv+csjHukdO/pqv7/6Xup1J3ZxmwMTj/i3OyK7xNPBwsjTkr166k9Lz
         MmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bCgZvA0kqp3iSuTat4yeXBgIoJ3hCErb5UDQaWVxOQ=;
        b=WgLHMnzPvBrgT0jU8WSkXsoV/+F3bghghP8hAYhDaF1GaOMBAmgCA/aj3Dsw0ZHamJ
         JvfHfVS9HXuYCR1JHGBKTgl73uVUXHIWqksQjLwgvGp6pgPEylAP5yMqg7f4/gziSn5O
         y5XW3ZmdujYiav/PfUUJauOUP5hJEzfj3n0ybeneE4LA0NlZ599IAC2oPmhmGNo6T/ZR
         gkD3PQJkJe/CMsn6BsDJUuQcQ3TdD1QOotzN3Ne5BamViJdtypPGUl/NqrSeeLume+VZ
         ZUjkcJTDXViCT6WAdlv4tqsPMnoANpv9LuppJ4STNF/7CeXXi2jOEvRyEV5Vulv2vrHC
         T7BA==
X-Gm-Message-State: AFqh2kpYxS4Pziut1kozOkaoD3P3oKW2gJanNsUk2ZAAAE6132xDAwAW
        xOpfHze8OnyFhCNhFuDhlH8=
X-Google-Smtp-Source: AMrXdXugVAi0jT6JSdeS6WDHGu5GGoho7GdqWhBnBh5GQYhGWi1IEJPuFeJ302A09cltYH0NBzagWQ==
X-Received: by 2002:a17:903:30d2:b0:186:e426:ff33 with SMTP id s18-20020a17090330d200b00186e426ff33mr1987441plc.20.1671634549688;
        Wed, 21 Dec 2022 06:55:49 -0800 (PST)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id d9-20020a170903230900b00176dc67df44sm11573994plh.132.2022.12.21.06.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 06:55:49 -0800 (PST)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, hch@infradead.org, axboe@kernel.dk
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 2/2] virtio-blk: support completion batching for the IRQ path
Date:   Wed, 21 Dec 2022 23:54:56 +0900
Message-Id: <20221221145456.281218-3-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20221221145456.281218-1-suwan.kim027@gmail.com>
References: <20221221145456.281218-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds completion batching to the IRQ path. It reuses batch
completion code of virtblk_poll(). It collects requests to io_comp_batch
and processes them all at once. It can boost up the performance by 2%.

To validate the performance improvement and stabilty, I did fio test with
4 vCPU VM and 12 vCPU VM respectively. Both VMs have 8GB ram and the same
number of HW queues as vCPU.
The fio cammad is as follows and I ran the fio 5 times and got IOPS average.
(io_uring, randread, direct=1, bs=512, iodepth=64 numjobs=2,4)

Test result shows about 2% improvement.

           4 vcpu VM       |   numjobs=2   |   numjobs=4
      -----------------------------------------------------------
        fio without patch  |  367.2K IOPS  |   397.6K IOPS
      -----------------------------------------------------------
        fio with patch     |  372.8K IOPS  |   407.7K IOPS

           12 vcpu VM      |   numjobs=2   |   numjobs=4
      -----------------------------------------------------------
        fio without patch  |  363.6K IOPS  |   374.8K IOPS
      -----------------------------------------------------------
        fio with patch     |  373.8K IOPS  |   385.3K IOPS

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/virtio_blk.c | 82 +++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 75ee51aba964..91f1e008d6ab 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -272,33 +272,63 @@ static inline void virtblk_request_done(struct request *req)
 	blk_mq_end_request(req, virtblk_result(vbr));
 }
 
+static void virtblk_complete_batch(struct io_comp_batch *iob)
+{
+	struct request *req;
+
+	rq_list_for_each(&iob->req_list, req) {
+		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
+		virtblk_cleanup_cmd(req);
+	}
+	blk_mq_end_request_batch(iob);
+}
+
+static int virtblk_handle_req(struct virtio_blk_vq *vq,
+			      struct io_comp_batch *iob)
+{
+	struct virtblk_req *vbr;
+	int req_done = 0;
+	unsigned int len;
+
+	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
+		struct request *req = blk_mq_rq_from_pdu(vbr);
+
+		if (likely(!blk_should_fake_timeout(req->q)) &&
+		    !blk_mq_complete_request_remote(req) &&
+		    !blk_mq_add_to_batch(req, iob, vbr->status,
+					 virtblk_complete_batch))
+			virtblk_request_done(req);
+		req_done++;
+	}
+
+	return req_done;
+}
+
 static void virtblk_done(struct virtqueue *vq)
 {
 	struct virtio_blk *vblk = vq->vdev->priv;
-	bool req_done = false;
-	int qid = vq->index;
-	struct virtblk_req *vbr;
+	struct virtio_blk_vq *vblk_vq = &vblk->vqs[vq->index];
+	int req_done = 0;
 	unsigned long flags;
-	unsigned int len;
+	DEFINE_IO_COMP_BATCH(iob);
 
-	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
+	spin_lock_irqsave(&vblk_vq->lock, flags);
 	do {
 		virtqueue_disable_cb(vq);
-		while ((vbr = virtqueue_get_buf(vblk->vqs[qid].vq, &len)) != NULL) {
-			struct request *req = blk_mq_rq_from_pdu(vbr);
+		req_done += virtblk_handle_req(vblk_vq, &iob);
 
-			if (likely(!blk_should_fake_timeout(req->q)))
-				blk_mq_complete_request(req);
-			req_done = true;
-		}
 		if (unlikely(virtqueue_is_broken(vq)))
 			break;
 	} while (!virtqueue_enable_cb(vq));
 
-	/* In case queue is stopped waiting for more buffers. */
-	if (req_done)
+	if (req_done) {
+		if (!rq_list_empty(iob.req_list))
+			iob.complete(&iob);
+
+		/* In case queue is stopped waiting for more buffers. */
 		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
-	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
+	}
+	spin_unlock_irqrestore(&vblk_vq->lock, flags);
 }
 
 static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
@@ -832,37 +862,15 @@ static void virtblk_map_queues(struct blk_mq_tag_set *set)
 	}
 }
 
-static void virtblk_complete_batch(struct io_comp_batch *iob)
-{
-	struct request *req;
-
-	rq_list_for_each(&iob->req_list, req) {
-		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
-		virtblk_cleanup_cmd(req);
-	}
-	blk_mq_end_request_batch(iob);
-}
-
 static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct virtio_blk *vblk = hctx->queue->queuedata;
 	struct virtio_blk_vq *vq = get_virtio_blk_vq(hctx);
-	struct virtblk_req *vbr;
 	unsigned long flags;
-	unsigned int len;
 	int found = 0;
 
 	spin_lock_irqsave(&vq->lock, flags);
-
-	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
-		struct request *req = blk_mq_rq_from_pdu(vbr);
-
-		found++;
-		if (!blk_mq_complete_request_remote(req) &&
-		    !blk_mq_add_to_batch(req, iob, vbr->status,
-						virtblk_complete_batch))
-			virtblk_request_done(req);
-	}
+	found = virtblk_handle_req(vq, iob);
 
 	if (found)
 		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
-- 
2.26.3

