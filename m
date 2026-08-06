Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDF4455177;
	Fri,  7 Aug 2026 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085900; cv=none; b=k/ZuFx7/sH1XbYM3q4igobt4mJvTmIs1CHhySAmZn/RgB4dnyWyqLz3U+9wz1Kzp1vSaQigKBMxQ95QRaZlzlev5VVWoP1BKg+uydBC0R9gLTHI8KnjRjOV57VkqVyT0uR5amlWEX1mMUFhsvn4Y4Zz4XfiCerBsPbpw6f6WO0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085900; c=relaxed/simple;
	bh=2k36wO5X9SZ8jPI9CAGiOvZvhLKcuvrAG34lp4AbnG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CwnFRa0Avv0KQOU4044uWfrWLTvVo3YBgFJ8Z2OdqqWNcNd13ja7mwE1CymkJPzcz1NBXyqQAmxuPMcf8uRbhHiu7VtzDqrfUV1tB/ym5RmUmTMthdleVNgvY3MrL4IA4G+9o96QOi6DFWbkUgNZspRm9N7zks8ZmI7Nud2eEQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5b5fcb62922d11f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a4cae2cd-ddbc-45f5-aefc-cd5e9715d49d,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:24a4393c6e3ab0dd0cda9751a340d239,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5b5fcb62922d11f1aa26b74ffac11d73-20260807
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 25166834; Fri, 07 Aug 2026 14:58:12 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-block@vger.kernel.org
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, axboe@kernel.dk, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v3 2/2] virtio-blk: add shutdown and fail queue_rq after VQ teardown
Date: Thu, 6 Aug 2026 09:20:00 +0800
Message-ID: <b2c3d4e5f0a1.v3.1785920716.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.virtio-blk-ers-v3.1785920716.git.liuxixin@kylinos.cn>
References: <cover.virtio-blk-ers-v1.1780449274.git.liuxixin@kylinos.cn> <cover.virtio-blk-ers-v2.1785468000.git.liuxixin@kylinos.cn> <cover.virtio-blk-ers-v3.1785920716.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py

Register virtio_driver.shutdown for reboot and poweroff via
virtio_dev_shutdown: freeze to reclaim in-flight requests, then
break virtqueues and mark the disk dead.

Also fail queue_rq early when vqs were removed during frozen
reset_prepare and vqs is NULL.

Assisted-by: DeepSeek:deepseek-v3
Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 drivers/block/virtio_blk.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 32bf3ba07a9d..bbbbbbbbbbbb 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -435,6 +435,12 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_status_t status;
 	int err;
 
+	/* VQs may be gone after frozen reset_prepare; avoid NULL deref. */
+	if (unlikely(!vblk->vqs || !vblk->vdev)) {
+		blk_mq_start_request(req);
+		return BLK_STS_IOERR;
+	}
+
 	status = virtblk_prep_rq(hctx, vblk, req, vbr);
 	if (unlikely(status))
 		return status;
@@ -1561,6 +1561,34 @@ static int virtblk_probe(struct virtio_device *vdev)
 	return err;
 }
 
+/* System shutdown: reclaim in-flight requests, then break and mark dead. */
+static void virtblk_shutdown(struct virtio_device *vdev)
+{
+	struct virtio_blk *vblk = vdev->priv;
+	struct request_queue *q;
+	unsigned int memflags;
+
+	if (!vblk || !vblk->disk)
+		return;
+
+	q = vblk->disk->queue;
+	/*
+	 * Reclaim request memory before break: freeze waits until
+	 * q_usage_counter is zero (PDU + chained sg freed in done path).
+	 * After virtio_break_device(), completions no longer run.
+	 */
+	memflags = blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue_nowait(q);
+
+	virtio_break_device(vdev);
+	flush_work(&vblk->config_work);
+
+	blk_mark_disk_dead(vblk->disk);
+
+	blk_mq_unquiesce_queue(q);
+	blk_mq_unfreeze_queue(q, memflags);
+}
+
 static void virtblk_remove(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
@@ -1684,6 +1712,7 @@ static struct virtio_driver virtio_blk = {
 	.probe				= virtblk_probe,
 	.remove				= virtblk_remove,
 	.config_changed			= virtblk_config_changed,
+	.shutdown			= virtblk_shutdown,
 #ifdef CONFIG_PM_SLEEP
 	.freeze				= virtblk_freeze,
 	.restore			= virtblk_restore,
-- 
2.43.0

