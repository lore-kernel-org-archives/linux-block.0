Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB41C433EF
	for <linux-block@archiver.kernel.org>; Mon, 21 Mar 2022 14:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349407AbiCUOaQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 10:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349638AbiCUO3d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 10:29:33 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B530E57B04
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 07:25:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h5so12881703plf.7
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 07:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BMWQ8PLTGdTt25YhzE6plaN/G1l1UHmHYhoorS9G8ec=;
        b=QDJufOvbKtkkXT59h458nkwXtPfQA9VJab9nHgaGtS1t8RgyDTEc7qB/yz01Dd31gW
         IFme4PtdZdhdmEZacVlXvl5Lh9F6KXcJxYgYe8nANs/fAunbloblxHyGAKbvLhThqQXy
         8QIqLa6W+N9kcgNxeDk5/ykGYWm6MeYDnKNzJMmvyEUigPsx37ilCVzrPJwU6QWMf+wp
         11h7ct77Cv5FivdFxJ20iLwlQCfPu9uhcSpoZzerQcMCrf0Bxv5OtdIWKucIrfn8SmhZ
         YCRVcEZQtmrAedaP+UdIwzP4FLIbzAvebgxpXMiaOcyYXWEh4KD91T+TjcPQB8gtx9t8
         SEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BMWQ8PLTGdTt25YhzE6plaN/G1l1UHmHYhoorS9G8ec=;
        b=rlMCQahy+0hucUVZoeNykdI3t11JAkDWDF3WdyEMtl0qpBnADzpGnZZ0oGVPuPQzij
         nCuuQBoU1MOLDtVkHvxFUgtQ5dxGdk6Eo6pj54049lrjG/NXJP/3IwsGcY3a+Kss84qV
         +nvCX1/bFXaw2xmdzLUvnDx2BsxOi3AnMusop+YqbRmnUyohLf4YLOaYga+uniEt7Yw3
         BEvxVIQCsYO4UJkNjtMFxUZa7ljvQbKNLYQpGe5fzFhKdAd1rILJvPGe9M4AaZ6efSWj
         t2IDln4J1iR/4e2JwZ9FpHNOqYF15JdrxNvtnS4fetC2s6nxrLmky9XQpCWUUNcejoEL
         KHhA==
X-Gm-Message-State: AOAM530L/UhO6EQQ5rwuKMYp+BMYPxMdt2UOp2IGOQLmvLlIbPx0Zt50
        /GaEJYTZXcEdmiN0cPsjWmfebEXBNfoXIA==
X-Google-Smtp-Source: ABdhPJzPdjMNCF6/1K7lsuAGZC/ag7Ozg/N4rGFDcF5dqR0zqBg/JQ1V5uoK1CnSld9wkR6IWJkrAQ==
X-Received: by 2002:a17:902:7fc1:b0:151:f80f:494a with SMTP id t1-20020a1709027fc100b00151f80f494amr13308638plb.81.1647872717039;
        Mon, 21 Mar 2022 07:25:17 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id e6-20020a056a001a8600b004f78e446ff5sm20503225pfv.15.2022.03.21.07.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 07:25:16 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v2 1/2] virtio-blk: support polling I/O
Date:   Mon, 21 Mar 2022 23:24:40 +0900
Message-Id: <20220321142441.132888-2-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220321142441.132888-1-suwan.kim027@gmail.com>
References: <20220321142441.132888-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch supports polling I/O via virtio-blk driver. Polling
feature is enabled by module parameter "num_poll_queues" and it
sets dedicated polling queues for virtio-blk. This patch improves
the polling I/O throughput and latency.

The virtio-blk driver doesn't not have a poll function and a poll
queue and it has been operating in interrupt driven method even if
the polling function is called in the upper layer.

virtio-blk polling is implemented upon 'batched completion' of block
layer. virtblk_poll() queues completed request to io_comp_batch->req_list
and later, virtblk_complete_batch() calls unmap function and ends
the requests in batch.

virtio-blk reads the number of poll queues from module parameter
"num_poll_queues". If VM sets queue parameter as below,
("num-queues=N" [QEMU property], "num_poll_queues=M" [module parameter])
It allocates N virtqueues to virtio_blk->vqs[N] and it uses [0..(N-M-1)]
as default queues and [(N-M)..(N-1)] as poll queues. Unlike the default
queues, the poll queues have no callback function.

Regarding HW-SW queue mapping, the default queue mapping uses the
existing method that condsiders MSI irq vector. But the poll queue
doesn't have an irq, so it uses the regular blk-mq cpu mapping.

For verifying the improvement, I did Fio polling I/O performance test
with io_uring engine with the options below.
(io_uring, hipri, randread, direct=1, bs=512, iodepth=64 numjobs=N)
I set 4 vcpu and 4 virtio-blk queues - 2 default queues and 2 poll
queues for VM.

As a result, IOPS and average latency improved about 10%.

Test result:

- Fio io_uring poll without virtio-blk poll support
	-- numjobs=1 : IOPS = 339K, avg latency = 188.33us
	-- numjobs=2 : IOPS = 367K, avg latency = 347.33us
	-- numjobs=4 : IOPS = 383K, avg latency = 682.06us

- Fio io_uring poll with virtio-blk poll support
	-- numjobs=1 : IOPS = 380K, avg latency = 167.87us
	-- numjobs=2 : IOPS = 409K, avg latency = 312.6us
	-- numjobs=4 : IOPS = 413K, avg latency = 619.72us

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/block/virtio_blk.c | 101 +++++++++++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 8c415be86732..cd3e11bb8559 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -37,6 +37,10 @@ MODULE_PARM_DESC(num_request_queues,
 		 "0 for no limit. "
 		 "Values > nr_cpu_ids truncated to nr_cpu_ids.");
 
+static unsigned int num_poll_queues;
+module_param(num_poll_queues, uint, 0644);
+MODULE_PARM_DESC(num_poll_queues, "The number of dedicated virtqueues for polling I/O");
+
 static int major;
 static DEFINE_IDA(vd_index_ida);
 
@@ -81,6 +85,7 @@ struct virtio_blk {
 
 	/* num of vqs */
 	int num_vqs;
+	int io_queues[HCTX_MAX_TYPES];
 	struct virtio_blk_vq *vqs;
 };
 
@@ -548,6 +553,7 @@ static int init_vq(struct virtio_blk *vblk)
 	const char **names;
 	struct virtqueue **vqs;
 	unsigned short num_vqs;
+	unsigned int num_poll_vqs;
 	struct virtio_device *vdev = vblk->vdev;
 	struct irq_affinity desc = { 0, };
 
@@ -556,6 +562,7 @@ static int init_vq(struct virtio_blk *vblk)
 				   &num_vqs);
 	if (err)
 		num_vqs = 1;
+
 	if (!err && !num_vqs) {
 		dev_err(&vdev->dev, "MQ advertised but zero queues reported\n");
 		return -EINVAL;
@@ -565,6 +572,13 @@ static int init_vq(struct virtio_blk *vblk)
 			min_not_zero(num_request_queues, nr_cpu_ids),
 			num_vqs);
 
+	num_poll_vqs = min_t(unsigned int, num_poll_queues, num_vqs - 1);
+
+	memset(vblk->io_queues, 0, sizeof(int) * HCTX_MAX_TYPES);
+	vblk->io_queues[HCTX_TYPE_DEFAULT] = num_vqs - num_poll_vqs;
+	vblk->io_queues[HCTX_TYPE_READ] = 0;
+	vblk->io_queues[HCTX_TYPE_POLL] = num_poll_vqs;
+
 	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
 	if (!vblk->vqs)
 		return -ENOMEM;
@@ -578,8 +592,13 @@ static int init_vq(struct virtio_blk *vblk)
 	}
 
 	for (i = 0; i < num_vqs; i++) {
-		callbacks[i] = virtblk_done;
-		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
+		if (i < num_vqs - num_poll_vqs) {
+			callbacks[i] = virtblk_done;
+			snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
+		} else {
+			callbacks[i] = NULL;
+			snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
+		}
 		names[i] = vblk->vqs[i].name;
 	}
 
@@ -728,16 +747,87 @@ static const struct attribute_group *virtblk_attr_groups[] = {
 static int virtblk_map_queues(struct blk_mq_tag_set *set)
 {
 	struct virtio_blk *vblk = set->driver_data;
+	int i, qoff;
+
+	for (i = 0, qoff = 0; i < set->nr_maps; i++) {
+		struct blk_mq_queue_map *map = &set->map[i];
+
+		map->nr_queues = vblk->io_queues[i];
+		map->queue_offset = qoff;
+		qoff += map->nr_queues;
+
+		if (map->nr_queues == 0)
+			continue;
+
+		/*
+		 * Regular queues have interrupts and hence CPU affinity is
+		 * defined by the core virtio code, but polling queues have
+		 * no interrupts so we let the block layer assign CPU affinity.
+		 */
+		if (i == HCTX_TYPE_DEFAULT)
+			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);
+		else
+			blk_mq_map_queues(&set->map[i]);
+	}
+
+	return 0;
+}
+
+static void virtblk_complete_batch(struct io_comp_batch *iob)
+{
+	struct request *req;
+	struct virtblk_req *vbr;
 
-	return blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_DEFAULT],
-					vblk->vdev, 0);
+	rq_list_for_each(&iob->req_list, req) {
+		vbr = blk_mq_rq_to_pdu(req);
+		virtblk_unmap_data(req, vbr);
+		virtblk_cleanup_cmd(req);
+	}
+	blk_mq_end_request_batch(iob);
+}
+
+static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
+{
+	struct virtio_blk_vq *vq = hctx->driver_data;
+	struct virtblk_req *vbr;
+	unsigned long flags;
+	unsigned int len;
+	int found = 0;
+
+	spin_lock_irqsave(&vq->lock, flags);
+
+	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
+		struct request *req = blk_mq_rq_from_pdu(vbr);
+
+		found++;
+		if (!blk_mq_add_to_batch(req, iob, virtblk_result(vbr),
+						virtblk_complete_batch))
+			blk_mq_complete_request(req);
+	}
+
+	spin_unlock_irqrestore(&vq->lock, flags);
+
+	return found;
+}
+
+static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
+			  unsigned int hctx_idx)
+{
+	struct virtio_blk *vblk = data;
+	struct virtio_blk_vq *vq = &vblk->vqs[hctx_idx];
+
+	WARN_ON(vblk->tag_set.tags[hctx_idx] != hctx->tags);
+	hctx->driver_data = vq;
+	return 0;
 }
 
 static const struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
 	.commit_rqs	= virtio_commit_rqs,
+	.init_hctx	= virtblk_init_hctx,
 	.complete	= virtblk_request_done,
 	.map_queues	= virtblk_map_queues,
+	.poll		= virtblk_poll,
 };
 
 static unsigned int virtblk_queue_depth;
@@ -816,6 +906,9 @@ static int virtblk_probe(struct virtio_device *vdev)
 		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
 	vblk->tag_set.driver_data = vblk;
 	vblk->tag_set.nr_hw_queues = vblk->num_vqs;
+	vblk->tag_set.nr_maps = 1;
+	if (vblk->io_queues[HCTX_TYPE_POLL])
+		vblk->tag_set.nr_maps = 3;
 
 	err = blk_mq_alloc_tag_set(&vblk->tag_set);
 	if (err)
-- 
2.26.3

