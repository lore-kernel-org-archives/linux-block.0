Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795156472;
	b=SOXgXSns35HLNIswUT/oToRKRUqy4BgQEJDF63K9VRnAZjF8N562QHhJRDZqPwXlmNvZ
	 P3I9yXfHgExWduZHc/9ITW+Ex2yqhMQyhDxJrZGHedon2AH29iXWL+BsiVCe4vprgYin/
	 3XfKHGWGuuVdiIFU4Jkypyt9A3OQnfk4eosqfTUJmzkysJNwiX5i9V3ouXVYZ0d51MERa
	 x3Qq66FSqWQAGY4FDfMzVzF8TDOWOV0XJjvpK16DfaIduAuKL633V3GOS1EWVuvKiILDJ
	 8183p8rWetrs45TkMBkoub41KR/F7TVKbIe0Oofy/d8qp+D44pQeywNsI1tPyQeyytQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795156472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l2nH2XTb5frL3IcF+3+XVhqdfkR4kPSpm/fGUJr6SFY=;
	b=MpNuIcRxCaRC6X5Jj9TlHJyxATYU9R49EtQ3ryw2iv4jsB98IGG+9T55CD7R4k6VibJT
	 ERDBwmgkIZpQdVtwsIfSuSw3EM9YwWm4h0yO6Rbv8zeUja8eJJ29FHx77x+q6WF0Vz1wb
	 RvNKxi1Qk5MmswsPBzRS8LPYJo6AkIeQ5ZeJyEwzr0qIPCOrYZ7GTKYgr4Mi2mDB05q8K
	 1TB0bTvelnETtBkIDhwjvbWl7mqthFzJhOXebTllEPdokH1Mkct5+V2reYFRY1ehHa/+E
	 GGD10ThBNZNnelIu0OqGc1KUHK+qjK8dU4TR6HHYSTGUOwO7eAoWCqvSrPpSY9dq9Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0qrljRq;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D503E606A32A
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 06:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D503E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0qrljRq
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso778683c88.1
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 22:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795156471; x=1795761271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l2nH2XTb5frL3IcF+3+XVhqdfkR4kPSpm/fGUJr6SFY=;
        b=C0qrljRqr6WB5mcG2FJbWz0ZpX9xYi9k13zz9r6fJw7gy4F+Ayk/9gAIFz9swn8N9A
         qDjZXXGtcj0FZFKkzL+1NzcNDsO5LoPqkgJ0oW7b1Bhgqc1wZKyOaIiQVvkFz+MCqQNJ
         vH4a6+2RxDKcRA9eM2kHGdplYeHgqCM4yXDrnSCaCTnV78oGu5Srgcp1amxaui2zAXdl
         r01hCXvD/Fl0Kja049jzB1A6rIlgG03lKD/dsY31annm+LRUDzeKvTburg+a15/l28+p
         oQv0XBoiQBQUv9GAeSAzesTFbCvR9lMwEhZI7UgVlpGkTPHz0SaBWUw7NdzHOQKRM1+S
         UHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795156471; x=1795761271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l2nH2XTb5frL3IcF+3+XVhqdfkR4kPSpm/fGUJr6SFY=;
        b=IlSoHR2ePzKeKmIguTXqRM3l6d2hOvX8cSn11RyIjaBCp/s5V5S4gOX2lhoteMaUAM
         sT2px8C26tsXIrjWjgTElcEEJaCWlOh+k1TnoGXjJxUYrtLerbxKNkHrCind8PcWVr3G
         4B9Zi7mQgqA4C67w1mKRYZhY9w5YxWWB9LRxS/1CrHuEsST1pn+8UicFxZeJFj0m0QSE
         0Xy2xE+OhR+HvFkpYLP1w0Yw7bknolLKhv0mDUjYnt3zezyjvjNc9Lg0UyMlCgqUHcMj
         iVLCkwmESPs9FjjiziURsgmrbnbGBZ12IvnCsLBUWhVvWOdoZxao+BtPcMQ22GWLAg1t
         TJHw==
X-Forwarded-Encrypted: i=1; AL+hErHTA1l3vAptVHoTk6I7/3Ywr9zmlp90WefRCPd0NiQcpMwcvzLjuX3yCPxob5foX+nIrToXIi1HLBNznw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Nx9TlGiaZKgAropEPSsNj4Z7ryIKwt9/jNIj+uCWGjGftlUHO
	TvvMsO6hMrwyd07qyhnHZpR6T4lION/jn0YGbmncDkVmVrloktbcpcT3
X-Gm-Gg: AZFdTZccsKclOkQNPEWFrwLwFQ+WVBv/fJDKAL/wBp7mxhx55ciE3qfBEtw9CDF+AgO
	+rc0aLU8ylJE6t5tyqBFO5q1M7Zhr/LW60uLNuYQE9bbUj0MPUYQ8v+TefB29QKd5Gk3f/nmaR/
	uyYNqezD9JfXFLcZ91A7+Z0SRdtJmEe5n3EkYa9HnNfkjxfX19is4a7eJ/2RRSmt299mf+AWGDw
	7RWIbha1cTxZlPIJbpNtUOjqat/6otWdei0naBzwYZM1VFiUeVginWWx/yKHUjCb2dD1Y//Kw/a
	gkbVrcK1rfpgpUCS1WsFM7GYpTXxO0LDLhUYqqwKDbTNUSSCcB/26sYsu9WSfwUGq/Tb5xW9w7j
	74UpjqAMW1TSHyiQk9xalHxwR67n9wC6V6n0b6p5g386TB1SC4Wko+NmTmgFaXoh3m+sCuAQdCH
	vX+ALw5mA00L32tI8HP+RCnubiGkDij96gIDnEzvFLvbjsXJlKVXpa7O45x3oWr6HlZUWcREz9w
	DyRKvjk50bXNyhukTEaZlEv+TDc+c8Z2l2lAhPQtpl5VJIT6UlqKbHzZbhnWi8mCiDhdbBeYXWC
	B0bhuRxXyJBPqG0vycxO9tL51jGrlQhINalqfIZ5798JPFSPQDA=
X-Received: by 2002:a05:7300:c01b:20b0:385:4b9:18ea with SMTP id 5a478bee46e88-38571027a68mr2036926eec.35.1795156470715;
        Thu, 19 Nov 2026 22:34:30 -0800 (PST)
Received: from annie-ProLiant-DL380-Gen11.. ([119.204.109.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm4821319eec.14.2026.11.19.22.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:34:30 -0800 (PST)
From: Annie Kim <pulpannie@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyokyung Kim <pulpannie@gmail.com>
Subject: [PATCH] virtio_blk: validate zone append sector from device
Date: Fri, 20 Nov 2026 15:30:39 +0900
Message-ID: <20261120063039.4155597-1-pulpannie@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyokyung Kim <pulpannie@gmail.com>

The device reports the starting sector for REQ_OP_ZONE_APPEND completions,
and virtio_blk copies it into req->__sector without checking that it
still refers to the requested zone. A buggy or malicious device can
therefore make upper layers believe the append landed at an arbitrary
location.

Validate successful zone append completions before updating
req->__sector. The returned sector must not precede the request start
and the entire request must fit within the zone writable capacity.
Reject invalid completions with BLK_STS_IOERR.

The polling path may batch successful completions, so perform the same
validation before admitting a request to the batch. Invalid append
completions then fall back to the normal completion path and are
completed with an error instead of being reported as successful.

Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
Assisted-by: Codex:GPT-5
Signed-off-by: Hyokyung Kim <pulpannie@gmail.com>
---
Tested on v7.4-rc3+ using modified QEMU backend that returned incorrect
zone-append sectors on a memory-backed null_blk zoned device.

 drivers/block/virtio_blk.c | 50 +++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2b462005c..8f88570b4 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -331,15 +331,45 @@ static inline u8 virtblk_vbr_status(struct virtblk_req *vbr)
 	return *((u8 *)&vbr->in_hdr + vbr->in_hdr_len - 1);
 }
 
-static inline void virtblk_update_zone_append_sector(struct request *req,
-						     struct virtblk_req *vbr)
+#ifdef CONFIG_BLK_DEV_ZONED
+static inline blk_status_t
+virtblk_update_zone_append_sector(struct request *req,
+				  struct virtblk_req *vbr,
+				  blk_status_t status)
 {
 	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
+	sector_t req_start, sector, zone_end;
+	unsigned int nr_sectors;
+
+	if (req_op(req) != REQ_OP_ZONE_APPEND || status != BLK_STS_OK)
+		return status;
+
+	req_start = blk_rq_pos(req);
+	sector = virtio64_to_cpu(vblk->vdev, vbr->in_hdr.zone_append.sector);
+	nr_sectors = blk_rq_sectors(req);
+	zone_end = req_start + disk_zone_capacity(vblk->disk, req_start);
+
+	if (zone_end < req_start || sector < req_start || sector >= zone_end ||
+	    nr_sectors > zone_end - sector) {
+		dev_err_ratelimited(&vblk->vdev->dev,
+				    "zone append sector %llu + %u outside valid range [%llu, %llu)\n",
+				    (u64)sector, nr_sectors,
+				    (u64)req_start, (u64)zone_end);
+		return BLK_STS_IOERR;
+	}
 
-	if (req_op(req) == REQ_OP_ZONE_APPEND)
-		req->__sector = virtio64_to_cpu(vblk->vdev,
-						vbr->in_hdr.zone_append.sector);
+	req->__sector = sector;
+	return status;
 }
+#else
+static inline blk_status_t
+virtblk_update_zone_append_sector(struct request *req,
+				  struct virtblk_req *vbr,
+				  blk_status_t status)
+{
+	return status;
+}
+#endif
 
 static inline void virtblk_request_done(struct request *req)
 {
@@ -349,7 +379,7 @@ static inline void virtblk_request_done(struct request *req)
 	virtblk_unmap_data(req, vbr);
 	virtblk_cleanup_cmd(req);
 
-	virtblk_update_zone_append_sector(req, vbr);
+	status = virtblk_update_zone_append_sector(req, vbr, status);
 
 	blk_mq_end_request(req, status);
 }
@@ -1242,7 +1272,6 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
 
 		virtblk_unmap_data(req, vbr);
 		virtblk_cleanup_cmd(req);
-		virtblk_update_zone_append_sector(req, vbr);
 	}
 	blk_mq_end_request_batch(iob);
 }
@@ -1260,11 +1289,14 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 
 	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
 		struct request *req = blk_mq_rq_from_pdu(vbr);
-		u8 status = virtblk_vbr_status(vbr);
+		blk_status_t status;
+
+		status = virtblk_result(virtblk_vbr_status(vbr));
+		status = virtblk_update_zone_append_sector(req, vbr, status);
 
 		found++;
 		if (!blk_mq_complete_request_remote(req) &&
-		    !blk_mq_add_to_batch(req, iob, status != VIRTIO_BLK_S_OK,
+		    !blk_mq_add_to_batch(req, iob, status != BLK_STS_OK,
 					 virtblk_complete_batch))
 			virtblk_request_done(req);
 	}
-- 
2.53.0

