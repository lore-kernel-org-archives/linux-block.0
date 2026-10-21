Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561962;
	b=22vd9bwpn4wFs2vmLsW722MA1EYKJfq/9XM3eJ2JIZcWGL8BKAMlFgmk9zB5BXyrrCcQ
	 KfsBmCSzYobAW8/4vrYpdZSGqm6lZ0IMelYfYmtWOxJV8Z5Fzc2hIQCdo7lhHLOeV776k
	 TJqqsJmgPlv4BQkM7PXhB3OnjUGL/pKmt8JnGcoYcRX7fkAcsyBqYBEgQEZ+bhsu8OWi9
	 tWdadHVpPER9+egVDjgW5jYTVsPyf3QlAadPpoRROM6g4dnw8xmSiC5XehwtL0LS1dkfm
	 XCZXAVDxE8svR+kdRGvaqT28uUALHXJD1HNJAMcQiTDpSvuW0Ut0MgY1FmxgpneAKlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561962;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=WDUKJX/pVSTEJ9If23a5pLa8WWWGr6+rMZL+Jxa8a5Y=;
	b=odo9fTTnPdcaNkdP88KGO2RatyFkjOFVXvvBT4ZOWWJOdF711mLqj/SupPVDWsEwbsPq
	 xwrSfKRcUjV0ZTpm7UVxTW5OiePbnBG/Xj2RK5yIAF+lwVfvZmPicYfKvR+YLIZkUZv3Q
	 kKUEnJP0KVDD+pRDghd27aK32CTcrUmYjRptBN5ZIksRbn8SA9c38AowEIc+a7SxKneNE
	 K3qeqD+niNRr7fvYgh20iYptjw1s8HK1mC2drRrHwCjerX2VHz3LafJdEXrjFA/5VgJu2
	 ImcKN43CpDHfwVW16Cig9tAdm/XO6s8MJTe1JFcmknIjNuHie4fGAdy1jbC5jD52GhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QMhjnxWS;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA59E606A31C
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 05:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA59E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QMhjnxWS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792561960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDUKJX/pVSTEJ9If23a5pLa8WWWGr6+rMZL+Jxa8a5Y=;
	b=QMhjnxWSpsv7CbWujUVU5EtxIzAUeJ6+NeSAaZv+6gA20Ia5LNMmPOu3LBuFPUVSMFs/Xq
	Q5QXIZ44DXSmu3JZoX1IUBeiGXPP0DFNmS0V5vMJROwPjbMw8zqoccUlxTW9OwZ5qzuBv5
	hHQZD1OlGGjZKK0ykZL8TT/u5mIWNsg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-r6enKXHsO3yh4Q5mruDBAg-1; Wed,
 21 Oct 2026 01:52:39 -0400
X-MC-Unique: r6enKXHsO3yh4Q5mruDBAg-1
X-Mimecast-MFC-AGG-ID: r6enKXHsO3yh4Q5mruDBAg_1792561958
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D2D219560AD
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 05:52:38 +0000 (UTC)
Received: from desktop (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 987F91956089;
	Wed, 21 Oct 2026 05:52:37 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: linux-block@vger.kernel.org
Cc: Alberto Faria <afaria@redhat.com>
Subject: [PATCH 1/2] virtio_blk: add fua write support
Date: Wed, 21 Oct 2026 06:52:33 +0100
Message-ID: <20261021055235.648957-2-afaria@redhat.com>
In-Reply-To: <20261021055235.648957-1-afaria@redhat.com>
References: <20261021055235.648957-1-afaria@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add the new virtio-blk request FUA flag uapi definitions and
corresponding virtio-blk support.

Signed-off-by: Alberto Faria <afaria@redhat.com>
---
 drivers/block/virtio_blk.c      | 15 +++++++++++++--
 include/uapi/linux/virtio_blk.h | 13 +++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c8bfbf8435ac7..f2ef0fdba181d 100644
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
@@ -258,6 +261,9 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 	case REQ_OP_WRITE:
 		type = VIRTIO_BLK_T_OUT;
 		sector = blk_rq_pos(req);
+		if (req->cmd_flags & REQ_FUA)
+			vbr->out_hdr.flags |= cpu_to_virtio32(vdev,
+				BIT(VIRTIO_BLK_REQ_FLAG_OUT_FUA));
 		break;
 	case REQ_OP_FLUSH:
 		type = VIRTIO_BLK_T_FLUSH;
@@ -1508,6 +1514,10 @@ static int virtblk_probe(struct virtio_device *vdev)
 	if (virtblk_get_cache_mode(vdev))
 		lim.features |= BLK_FEAT_WRITE_CACHE;
 
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS) &&
+	    virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA))
+		lim.features |= BLK_FEAT_FUA;
+
 	vblk->disk = blk_mq_alloc_disk(&vblk->tag_set, &lim, vblk);
 	if (IS_ERR(vblk->disk)) {
 		err = PTR_ERR(vblk->disk);
@@ -1672,7 +1682,8 @@ static unsigned int features[] = {
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
2.56.0

