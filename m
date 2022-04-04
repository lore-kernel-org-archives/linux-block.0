Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72219C433F5
	for <linux-block@archiver.kernel.org>; Mon,  4 Apr 2022 09:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353733AbiDDJal (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Apr 2022 05:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347122AbiDDJah (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Apr 2022 05:30:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C9D1C914
        for <linux-block@vger.kernel.org>; Mon,  4 Apr 2022 02:28:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n9so2957224plc.4
        for <linux-block@vger.kernel.org>; Mon, 04 Apr 2022 02:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ep1sHyncwPFmrV4yxIycNkHc5iTuUAR5AyvfLy/8F4=;
        b=KwMJVcGqNu19VrD/oyTFcghkoa3oayoUQnLiaG4Os9WwyJfaRi0lIA9Qj+IA+qWVjN
         W4qY4cLIP4T8jBjT+rbmTTAP1ByccZXGUHL1l1Jjn8kEAzyLT8IZ2mkMghGQxaRHPT8U
         dOz9UC9OFaaLGX0g8Op3NbIfiNP93rHtt0XJRY/O9omEStI2CM7QnSnkFeztcbE/sWFt
         79rBax5BK8j6qOe+x/fV/9DYGBzuF0Dds/BaDhtzySxihfxULeB9BKOEd1P+B3kMY0XH
         x7lP49ndrRiAcK/Ex8nxW+XVdJC5/DlBU9BqB9pLQ054ZG6pc0OCpEQHRr5Hpd5KiMUp
         KCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ep1sHyncwPFmrV4yxIycNkHc5iTuUAR5AyvfLy/8F4=;
        b=0DfGDtMmvHoF3Tve/Xc4AfbwQwuHGpIpGsiVt1JHe942TIgNMnvAxaObJxdoEADcLu
         131OIOx3RL+2K6/VDuRtTsE4ygkUldJpj4lWU62qR9bdgysXZ8uDbqeP6AgzZCBym7VA
         +FtFHuoOvLqVrEEzeRs0LMejyWpdysyc6lUg/LSswiL4RlF/dyba4dGaUGa/BhqLhSyx
         9YZwV6G3jHaqEw+b+uJKRDWSnPCqh2NHXQ2QIM6hsffjKAHVP5NcGCBEnUTZd5+h4YBL
         e6XkCAXTtpQV6m3FqNDSDrH1k3iuFfAtV07tiA329K9Qa5KLizxnjrjGd4KgKHfZncOQ
         ezmA==
X-Gm-Message-State: AOAM530Woa0kAeZ0G0pfj/p6N9QvNXVGwPLzQppHyvNxCfEaYqveZgcW
        yfjgwFAvlsDww7RVr/JZ1tc=
X-Google-Smtp-Source: ABdhPJyWn6Enzwz5PDIYyPX1FkUceoMXaBY8vkzmOQXnq5iRAqIhffKAUPFgFu4eS+ZMJA24eXuZzw==
X-Received: by 2002:a17:90b:4d08:b0:1c7:7567:9f6b with SMTP id mw8-20020a17090b4d0800b001c775679f6bmr25761675pjb.134.1649064519769;
        Mon, 04 Apr 2022 02:28:39 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id x9-20020a17090a970900b001ca6c59b350sm6187675pjo.2.2022.04.04.02.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 02:28:38 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com, dongli.zhang@oracle.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v4 1/2] virtio-blk: support polling I/O
Date:   Mon,  4 Apr 2022 18:28:04 +0900
Message-Id: <20220404092805.77643-2-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220404092805.77643-1-suwan.kim027@gmail.com>
References: <20220404092805.77643-1-suwan.kim027@gmail.com>
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
	-- numjobs=1 : IOPS = 385K, avg latency = 165.94us
	-- numjobs=2 : IOPS = 408K, avg latency = 313.28us
	-- numjobs=4 : IOPS = 424K, avg latency = 613.05us

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/block/virtio_blk.c | 112 +++++++++++++++++++++++++++++++++++--
 1 file changed, 108 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 8c415be86732..c2d955da0006 100644
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
@@ -565,6 +572,18 @@ static int init_vq(struct virtio_blk *vblk)
 			min_not_zero(num_request_queues, nr_cpu_ids),
 			num_vqs);
 
+	num_poll_vqs = min_t(unsigned int, num_poll_queues, num_vqs - 1);
+
+	memset(vblk->io_queues, 0, sizeof(int) * HCTX_MAX_TYPES);
+	vblk->io_queues[HCTX_TYPE_DEFAULT] = num_vqs - num_poll_vqs;
+	vblk->io_queues[HCTX_TYPE_READ] = 0;
+	vblk->io_queues[HCTX_TYPE_POLL] = num_poll_vqs;
+
+	dev_info(&vdev->dev, "%d/%d/%d default/read/poll queues\n",
+				vblk->io_queues[HCTX_TYPE_DEFAULT],
+				vblk->io_queues[HCTX_TYPE_READ],
+				vblk->io_queues[HCTX_TYPE_POLL]);
+
 	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
 	if (!vblk->vqs)
 		return -ENOMEM;
@@ -578,8 +597,13 @@ static int init_vq(struct virtio_blk *vblk)
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
 
@@ -728,16 +752,93 @@ static const struct attribute_group *virtblk_attr_groups[] = {
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
+
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
+	struct virtio_blk *vblk = hctx->queue->queuedata;
+	struct virtio_blk_vq *vq = hctx->driver_data;
+	struct virtblk_req *vbr;
+	bool req_done = false;
+	unsigned long flags;
+	unsigned int len;
+	int found = 0;
+
+	spin_lock_irqsave(&vq->lock, flags);
+
+	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
+		struct request *req = blk_mq_rq_from_pdu(vbr);
 
-	return blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_DEFAULT],
-					vblk->vdev, 0);
+		found++;
+		if (!blk_mq_add_to_batch(req, iob, vbr->status,
+						virtblk_complete_batch))
+			blk_mq_complete_request(req);
+		req_done = true;
+	}
+
+	if (req_done)
+		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
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
@@ -816,6 +917,9 @@ static int virtblk_probe(struct virtio_device *vdev)
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

