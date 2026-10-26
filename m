Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015728;
	b=ME6Rk/Aekw97j7LM4gpOLNTftMgH9Z40nQ7BVKTTNkHspqWes9BJtJgOBkqYv9KoP0ww
	 1xm2vESecoAko8VGf5rOgjRdtuFZEguSMDIhjm0z2C7tcDVAWqkuKrX/vQrF7BQR1fCVz
	 rh3oMoDgDWPj7RWWZOzyH0fBvhdARTNFyFKybvRws6bjE95KtPJQYm8AS4gVo88+evysL
	 5bGv9N7pfZeMUo2v8NlxO3syqRGtmtjY+/PTP+1mhFENJEea1Xjssa65NRKxwBcwmUWuK
	 vs+Ws+y9a9jjS2Fzw5Qy29fcB+iJTPclVKP7QxIeiLN5/F5LHdgzNdy4rM9LjjZSjKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015728;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=znfRRGXnuU67jSNnNEjHXyFS0kfdf0VT6Pe2OYJ+5HE=;
	b=XiRKG7XtpLazEiSiliSujbULNRAmp71D0YSwkzy/hAVff56t22r0uEQ7dYst6NE7nKQK
	 7YjjD374is3EgoA8BItpRWefidSftTLWt+xUpk6gvqGqcp7A1XV4vt60mhybrT00n7v5w
	 6BoXwu7U+3NjCPk+LeU+SyPjl7fL53lZI6djxCL++bGQSd4gZZtNe0ZMzKlJvhzLMIeJr
	 KlMLyx6RfoJylsh6SencJvDQF0hI/OyOozxui8k4vwOKt/oI26HVnL4CJiXEoBbuduwv6
	 nrdojZv2j9lAI391qvEfGViy2Z98rT9ktW6xv9A14U62P7HDddZyUb6hE+02LxEFIEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBD2606A31D;
	Mon, 26 Oct 2026 11:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BBD2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jCsWc6fTwz5BNRf;
	Mon, 26 Oct 2026 19:55:24 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 69QBtGls092273;
	Mon, 26 Oct 2026 19:55:16 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 26 Oct 2026 19:55:19 +0800 (CST)
X-Zmail-TransId: 2afb6adf3fa72e5-beab5
X-Mailer: Zmail v1.0
Message-ID: <202610261955196384aSLGuy3_0MiTvlYXVdiC@zte.com.cn>
Date: Mon, 26 Oct 2026 19:55:19 +0800 (CST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <mst@redhat.com>, <jasowangio@gmail.com>, <virtualization@lists.linux.dev>
Cc: <pbonzini@redhat.com>, <stefanha@redhat.com>, <eperezma@redhat.com>,
        <hch@lst.de>, <dlemoal@kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB2aXJ0aW8tYmxrOiBGaXggem9uZSBhcHBlbmQgc2VjdG9yIHJlcG9ydGluZyBpbiBiYXRjaGVkIGNvbXBsZXRpb24=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 69QBtGls092273
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 26 Oct 2026 19:55:24 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ADF3FAC.000/4jCsWc6fTwz5BNRf

From: Shao Mingyin <shao.mingyin@zte.com.cn>

For zone append, the block layer copies req->__sector back into the
bio in blk_zone_append_update_request_bio(), so the driver must update
req->__sector with the sector reported by the device.
virtblk_request_done() does that, but the batched completion path used
by virtblk_poll() only unmaps and cleans up the requests before calling
blk_mq_end_request_batch().

A zone append completed through polling therefore keeps the sector that
was assigned at submission time, and the file system or application sees
the wrong LBA for the written data.

Move the sector update into a helper and call it from both completion
paths.

Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c8bfbf8435ac..cc29b8238a4d 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -331,18 +331,25 @@ static inline u8 virtblk_vbr_status(struct virtblk_req *vbr)
 	return *((u8 *)&vbr->in_hdr + vbr->in_hdr_len - 1);
 }

+static inline void virtblk_update_zone_append_sector(struct request *req,
+						     struct virtblk_req *vbr)
+{
+	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
+
+	if (req_op(req) == REQ_OP_ZONE_APPEND)
+		req->__sector = virtio64_to_cpu(vblk->vdev,
+						vbr->in_hdr.zone_append.sector);
+}
+
 static inline void virtblk_request_done(struct request *req)
 {
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
 	blk_status_t status = virtblk_result(virtblk_vbr_status(vbr));
-	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;

 	virtblk_unmap_data(req, vbr);
 	virtblk_cleanup_cmd(req);

-	if (req_op(req) == REQ_OP_ZONE_APPEND)
-		req->__sector = virtio64_to_cpu(vblk->vdev,
-						vbr->in_hdr.zone_append.sector);
+	virtblk_update_zone_append_sector(req, vbr);

 	blk_mq_end_request(req, status);
 }
@@ -1196,8 +1203,11 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
 	struct request *req;

 	rq_list_for_each(&iob->req_list, req) {
-		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
+		struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
+
+		virtblk_unmap_data(req, vbr);
 		virtblk_cleanup_cmd(req);
+		virtblk_update_zone_append_sector(req, vbr);
 	}
 	blk_mq_end_request_batch(iob);
 }
