Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595999;
	b=5ko/xJzHKMU4SyxdcjiSOOdLp8Ut5AVObYKfXSN4hThYCGNZ/uok+rteirjuqvYdNI3e
	 Tp5MwEmp1EhoToIgUCatRXjySAHOpGCk9RL6fwAgqJZwh/NOOYnGLM3jLY9mA9EiMw2E9
	 VvVw8Uz9AZUMQZgnE+3ZhqAv8A/FTPDP9NgN1P3YsN5lzjoNmRNPVSZa1akUTTIYepfac
	 0RBGGImvsB/tQpAFySim30/8Sp9kYq1vSJ0laSlgpATudITjqjE9GRYKB3bpTy1T7n69K
	 aKb2N7oUIHqJRwaP855tvCwQH7IMI4KU2ZaMepE32bj9mHfWkmwAb/0VWRnC3DFyEiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595999;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=Nl1OpKmpAE9aeda5GwFas201AAnqAuxOH/eJWrqnPiU=;
	b=lgJEoHM9LPgpfTA0SXrkpjETQQqjF7ByuWIGQROoT7gEO/DnEa1XmS22TG7+QHi7sjwH
	 lR4jzpWDGDz4DM1EnOJkXGqxlKjgHpxmifaD3HaJo8OLkr3Z/B6vmtOF3RUQQFOLfDmHb
	 2rXHDjo251dX0UuJ5w5YAfNb/Xn6TZItevpYV9iTFcW92SplAVtwJ4NFcRrpOMUqQD4om
	 kQLGWji8WqZfOJCX858DhPU9Sm5ODTKzoL6wRzQEy5Q1b7WFy+hcjeXv93nwiv1pSqmfG
	 aJYfTsgk0theGRpSR2kSaYlPXdZa1TRKcX/0+FAYWZn3g61orZYcOK6jXB58LXXgO9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d0DKhv5x;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B444606A329
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 08:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B444606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d0DKhv5x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795595997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nl1OpKmpAE9aeda5GwFas201AAnqAuxOH/eJWrqnPiU=;
	b=d0DKhv5xMatJQNMVrtCEPnv+p+gMHh34+8qSvyo8rQSIG+tpOE/IsK9fPrtarY3hN8vkxA
	zESI4Ux4K20RN47v+dJIvqhbXc1W9chyuQfgCEoC+DLaR+7HlCcGv2iBs9FQup1E+Xc7/+
	d+3WGp7Lg+k0NNaRjcEt+BT2Cte/XvU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-RKTqqLQZNLS6KwAvfQd9LQ-1; Wed,
 25 Nov 2026 08:39:55 +0000
X-MC-Unique: RKTqqLQZNLS6KwAvfQd9LQ-1
X-Mimecast-MFC-AGG-ID: RKTqqLQZNLS6KwAvfQd9LQ_1795595994
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D488180047A;
	Wed, 25 Nov 2026 08:39:54 +0000 (UTC)
Received: from desktop (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2F061800550;
	Wed, 25 Nov 2026 08:39:51 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: linux-block@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowangio@gmail.com>,
	Alberto Faria <afaria@redhat.com>
Subject: [PATCH v3 1/2] virtio_blk: add fua write support
Date: Wed, 25 Nov 2026 08:39:46 +0000
Message-ID: <20261125083947.263216-2-afaria@redhat.com>
In-Reply-To: <20261125083947.263216-1-afaria@redhat.com>
References: <20261125083947.263216-1-afaria@redhat.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add the new virtio-blk request FUA flag uapi definitions and
corresponding virtio-blk support.

Signed-off-by: Alberto Faria <afaria@redhat.com>
---
 drivers/block/virtio_blk.c      | 29 +++++++++++++++++++++++++++--
 include/uapi/linux/virtio_blk.h | 13 +++++++++++--
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2b462005cdb68..7ee2e6a6a591b 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -248,7 +248,10 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 		return BLK_STS_NOTSUPP;
 
 	/* Set fields for all request types */
-	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS))
+		vbr->out_hdr.flags = 0;
+	else
+		vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
 
 	switch (req_op(req)) {
 	case REQ_OP_READ:
@@ -258,6 +261,11 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 	case REQ_OP_WRITE:
 		type = VIRTIO_BLK_T_OUT;
 		sector = blk_rq_pos(req);
+		if ((req->cmd_flags & REQ_FUA) &&
+		    virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS) &&
+		    virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA))
+			vbr->out_hdr.flags |= cpu_to_virtio32(vdev,
+				BIT(VIRTIO_BLK_REQ_FLAG_OUT_FUA));
 		break;
 	case REQ_OP_FLUSH:
 		type = VIRTIO_BLK_T_FLUSH;
@@ -1151,10 +1159,17 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
 	virtio_cwrite8(vdev, offsetof(struct virtio_blk_config, wce), i);
 
 	lim = queue_limits_start_update(disk->queue);
+
 	if (virtblk_get_cache_mode(vdev))
 		lim.features |= BLK_FEAT_WRITE_CACHE;
 	else
 		lim.features &= ~BLK_FEAT_WRITE_CACHE;
+
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS) &&
+	    virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA) &&
+	    !(lim.features & BLK_FEAT_ZONED))
+		lim.features |= BLK_FEAT_FUA;
+
 	i = queue_limits_commit_update_frozen(disk->queue, &lim);
 	if (i)
 		return i;
@@ -1575,6 +1590,15 @@ static int virtblk_probe(struct virtio_device *vdev)
 	if (virtblk_get_cache_mode(vdev))
 		lim.features |= BLK_FEAT_WRITE_CACHE;
 
+	/*
+	 * Do not advertise FUA when the device is zoned, since we
+	 * would not be able to handle it on REQ_OP_ZONE_APPEND.
+	 */
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS) &&
+	    virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA) &&
+	    !(lim.features & BLK_FEAT_ZONED))
+		lim.features |= BLK_FEAT_FUA;
+
 	vblk->disk = blk_mq_alloc_disk(&vblk->tag_set, &lim, vblk);
 	if (IS_ERR(vblk->disk)) {
 		err = PTR_ERR(vblk->disk);
@@ -1740,7 +1764,8 @@ static unsigned int features[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
-	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_ZONED,
+	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_ZONED, VIRTIO_BLK_F_REQ_FLAGS,
+	VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA,
 };
 
 static struct virtio_driver virtio_blk = {
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 3744e4da1b2a7..c5047e6a9a9bc 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -42,6 +42,8 @@
 #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
 #define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
 #define VIRTIO_BLK_F_ZONED		17	/* Zoned block device */
+#define VIRTIO_BLK_F_REQ_FLAGS		18	/* Request flags supported */
+#define VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA	19	/* FUA flag supported */
 
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -211,6 +213,9 @@ struct virtio_blk_config {
 #define VIRTIO_BLK_T_BARRIER	0x80000000
 #endif /* !VIRTIO_BLK_NO_LEGACY */
 
+/* Request flag bits */
+#define VIRTIO_BLK_REQ_FLAG_OUT_FUA	0
+
 /*
  * This comes first in the read scatter-gather list.
  * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated,
@@ -219,8 +224,12 @@ struct virtio_blk_config {
 struct virtio_blk_outhdr {
 	/* VIRTIO_BLK_T* */
 	__virtio32 type;
-	/* io priority. */
-	__virtio32 ioprio;
+	union {
+		/* io priority. */
+		__virtio32 ioprio;
+		/* Request flags. */
+		__virtio32 flags;
+	};
 	/* Sector (ie. 512 byte offset) */
 	__virtio64 sector;
 };
-- 
2.56.1

