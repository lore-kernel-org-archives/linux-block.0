Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590C535972
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746663601; cv=none; b=qzVW3s9TEIzMiHDqg5TgmOAqYVAb5ijyGl6oYWOz2KWbzcVo4YSQjvb1QjpkizPPMtZzjprF318kCwdGXKR1oRxB0xD+w03+sA0t4Rol/KxAeqqcHrTplZzTrBrzGSq5CGiIYdVMFqTjoaysLPJ2FEdD0kVWHABEh3uSOg7tGqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746663601; c=relaxed/simple;
	bh=QVw0fE3WmDfQ9acRo4yP8KaW4KrGoo76G7CFLvKpyTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5S5GX1lPnOtf/NrW9Zgd/XIF/u0EyzB+IUZ4/TQCj0l7qeYL3S3gEMFPGg0RhaxwHATu9R28m/ZAZUPvKlfYvYIYdKVTdLiGoyJwppi2TiQuAEv5MXKI5ayi0HSsa5xQ0rdiUNOpDP/5QI2s2+GomzL+d7ZSK7/KhMuKzOnVYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYoh9/wv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYoh9/wv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746663598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+UCJUqypnIqV5WkTF8+ITpHmhPTsAy9uFsOMJp5HRE=;
	b=bYoh9/wv0YgZaRzinSOSYdXNoIbEUbRYhPK8QPz0/TszMyQh47GnO1HY7otGBzcYmqcU0n
	R0sHPIsnVSoggEBk0VU0uEoG+p7tJAB26NOLr7WD40DQH5T/E2R445cb6IVwJePnoIHcvv
	2YffZn96tQvnmWa0Ic0Qdze3ZYGSZpw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-rgtai9B1Mt25QETKx3DhpQ-1; Wed,
 07 May 2025 20:19:56 -0400
X-MC-Unique: rgtai9B1Mt25QETKx3DhpQ-1
X-Mimecast-MFC-AGG-ID: rgtai9B1Mt25QETKx3DhpQ_1746663595
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C71B61955DE7
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 00:19:55 +0000 (UTC)
Received: from desktop.redhat.com (unknown [10.45.224.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F76E19560A7;
	Thu,  8 May 2025 00:19:54 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: linux-block@vger.kernel.org
Cc: Alberto Faria <afaria@redhat.com>
Subject: [RFC 1/2] virtio_blk: add fua write support
Date: Thu,  8 May 2025 01:19:50 +0100
Message-ID: <20250508001951.421467-2-afaria@redhat.com>
In-Reply-To: <20250508001951.421467-1-afaria@redhat.com>
References: <20250508001951.421467-1-afaria@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add the proposed VIRTIO_BLK_{F,T}_OUT_FUA uapi definitions and
corresponding virtio-blk support.

Signed-off-by: Alberto Faria <afaria@redhat.com>
---
 drivers/block/virtio_blk.c      | 10 +++++++---
 include/uapi/linux/virtio_blk.h |  4 ++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 7cffea01d868c..021f05c469c50 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -256,7 +256,8 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 		sector = blk_rq_pos(req);
 		break;
 	case REQ_OP_WRITE:
-		type = VIRTIO_BLK_T_OUT;
+		type = req->cmd_flags & REQ_FUA ?
+			VIRTIO_BLK_T_OUT_FUA : VIRTIO_BLK_T_OUT;
 		sector = blk_rq_pos(req);
 		break;
 	case REQ_OP_FLUSH:
@@ -1500,6 +1501,9 @@ static int virtblk_probe(struct virtio_device *vdev)
 	if (virtblk_get_cache_mode(vdev))
 		lim.features |= BLK_FEAT_WRITE_CACHE;
 
+	if (virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_OUT_FUA))
+		lim.features |= BLK_FEAT_FUA;
+
 	vblk->disk = blk_mq_alloc_disk(&vblk->tag_set, &lim, vblk);
 	if (IS_ERR(vblk->disk)) {
 		err = PTR_ERR(vblk->disk);
@@ -1650,7 +1654,7 @@ static unsigned int features_legacy[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
-	VIRTIO_BLK_F_SECURE_ERASE,
+	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_OUT_FUA,
 }
 ;
 static unsigned int features[] = {
@@ -1658,7 +1662,7 @@ static unsigned int features[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
-	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_ZONED,
+	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_ZONED, VIRTIO_BLK_F_OUT_FUA,
 };
 
 static struct virtio_driver virtio_blk = {
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 3744e4da1b2a7..52be7943f6b8d 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -42,6 +42,7 @@
 #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
 #define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
 #define VIRTIO_BLK_F_ZONED		17	/* Zoned block device */
+#define VIRTIO_BLK_F_OUT_FUA		18	/* FUA write is supported */
 
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -206,6 +207,9 @@ struct virtio_blk_config {
 /* Reset All zones command */
 #define VIRTIO_BLK_T_ZONE_RESET_ALL 26
 
+/* FUA write command */
+#define VIRTIO_BLK_T_OUT_FUA        27
+
 #ifndef VIRTIO_BLK_NO_LEGACY
 /* Barrier before this op. */
 #define VIRTIO_BLK_T_BARRIER	0x80000000
-- 
2.49.0

