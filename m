Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED20132C0C
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733860; cv=none; b=lCjzMKLAbg6N3JwB8p57SrE3tIn9WQrh8mCj71/nkNubZq4AMKZTa9GIlPY2VKFkWSVwOLk9a1KknSnmH6zwofAvOXnbq3zFPJlEZLHZzUAZFtDmd3H8WgoxFJszz4MyK3L7wqD44ASwlE+HHuKxS4aX0hSKcUTGsci5BSZkj8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733860; c=relaxed/simple;
	bh=4y2ZTzrj4+6oIlKAXdYZ+1BebDKtHBK9+KxAAbbXM+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tClKSZ3SzAISGloGLe9yRCqsyktpcLTAnpzXzc3Tkt0L7aqEQWTXeqL0lqudyCeL1KfwU8eY+ZFnPaJFJm8Uj8FAN1u/rHWouVMDHriw++Htcplm1JHvFlg+9T9DaQW7XRy1q9XG8015qSgdFkh7hCOb7o4alTEyLOYQ6GOPPco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=Oh/lOWeP; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="Oh/lOWeP"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so10148303a12.0
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 06:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1709733857; x=1710338657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBW7AqjFjzB5v7jqorFXCgskxDjZ85ZOVHMqFlQBVwE=;
        b=Oh/lOWePURq3V21CY5oqgOMoJnid2S6bXuUFPS6h2DwCZEPOdDKvUnKoHLwiJoAkMX
         EVcwxs1lOwqeEs4kb29LRFfgqIevn9tXEASkCyerqAop6mW9QBsZ4DRVrGx6DSnjIGve
         0w1WxgKAx3DMHrwjrLRXYNQtSLsNGSPvHWLfVRtAUZH6nOqFc/2iwLUnE5PrgQBOwg+d
         NZxZzUVV6TWDwOIWvxXF6GrSkbpqY9+40pKy/Y4U4myfn+Fg6cVtnEZXqRcnOyoQltIp
         R5ITwIXfy/1A5aLlROIphdRlh2YvQ/RdM9kzQtv3Ktontp4eGSrUVs/wf0QNolvfPCtY
         hLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709733857; x=1710338657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBW7AqjFjzB5v7jqorFXCgskxDjZ85ZOVHMqFlQBVwE=;
        b=W0DZEWMEXpGUFUa7Up+IH6QuToiYj4A9EQoKE4mIRuarhlw7xZHa+nEL/jdVEd/SRE
         5t+OKOjOLEnsXRVl9BakjMZ0L2pAiCN9tAGHGepQoOx/UpMaMu3zkDenhH6OACNXlkOj
         XiDeN2omf6/CQ5mMq1cXM9ftM754v/29CyrL+qDDHTgOZoYlQLksAR/J/ff78M00cHiT
         QalxBuyarLqYLxgkc8xRJj8aVy/Tqv76baywHpyfpepyv5SnY9z2gMJdjeTd1zjm/ZOU
         qCKEwCh+AbQcwm8HHN4/vTe9H0Mas4qPiDu74ZGh1SooKiVnABObTc6TEC5bw+QhLbCe
         6Xsg==
X-Forwarded-Encrypted: i=1; AJvYcCVARgVsMzo0fUraWL+KcBbbesRpBalqv/CcPRi1tPELPcgmO3vQcNOtdi1VPwypIM9yrlBH7vOljJscitQYTSVQvg/bA6zfbgkdNKY=
X-Gm-Message-State: AOJu0YyYNZG6wUsItw8YtJxJHC1dHWoASnIKP+9TlYJ0MqYIIvaULUo5
	8m789LWUToACVaHeq/HUYQ7L9217PKyjKqg/5fxtN7MuxK7Js56weGeA5Mom0Aw=
X-Google-Smtp-Source: AGHT+IH8X5qutVwkgZpmXE85MQxRZM9rY+xR4zYBka/877T9qsUtMwr0urERTQjGPy27Z81odoUEyw==
X-Received: by 2002:a50:cac7:0:b0:566:d28c:e627 with SMTP id f7-20020a50cac7000000b00566d28ce627mr10761897edi.36.1709733856582;
        Wed, 06 Mar 2024 06:04:16 -0800 (PST)
Received: from ryzen9.home (62-47-18-60.adsl.highway.telekom.at. [62.47.18.60])
        by smtp.gmail.com with ESMTPSA id m18-20020aa7c492000000b005662d3418dfsm6924991edq.74.2024.03.06.06.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:04:16 -0800 (PST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 2/7] drbd: refactor drbd_reconsider_queue_parameters
Date: Wed,  6 Mar 2024 15:03:27 +0100
Message-Id: <20240306140332.623759-3-philipp.reisner@linbit.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240305134041.137006-1-hch@lst.de>
References: <20240305134041.137006-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

Split out a drbd_max_peer_bio_size helper for the peer I/O size,
and condense the various checks to a nested min3(..., max())) instead
of using a lot of local variables.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Philipp Reisner <philipp.reisner@linbit.com>
Reviewed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Tested-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 84 +++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 35 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 43747a1aae43..9135001a8e57 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1189,6 +1189,33 @@ static int drbd_check_al_size(struct drbd_device *device, struct disk_conf *dc)
 	return 0;
 }
 
+static unsigned int drbd_max_peer_bio_size(struct drbd_device *device)
+{
+	/*
+	 * We may ignore peer limits if the peer is modern enough.  From 8.3.8
+	 * onwards the peer can use multiple BIOs for a single peer_request.
+	 */
+	if (device->state.conn < C_WF_REPORT_PARAMS)
+		return device->peer_max_bio_size;
+
+	if (first_peer_device(device)->connection->agreed_pro_version < 94)
+		return min(device->peer_max_bio_size, DRBD_MAX_SIZE_H80_PACKET);
+
+	/*
+	 * Correct old drbd (up to 8.3.7) if it believes it can do more than
+	 * 32KiB.
+	 */
+	if (first_peer_device(device)->connection->agreed_pro_version == 94)
+		return DRBD_MAX_SIZE_H80_PACKET;
+
+	/*
+	 * drbd 8.3.8 onwards, before 8.4.0
+	 */
+	if (first_peer_device(device)->connection->agreed_pro_version < 100)
+		return DRBD_MAX_BIO_SIZE_P95;
+	return DRBD_MAX_BIO_SIZE;
+}
+
 static void blk_queue_discard_granularity(struct request_queue *q, unsigned int granularity)
 {
 	q->limits.discard_granularity = granularity;
@@ -1303,48 +1330,35 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 	fixup_discard_support(device, q);
 }
 
-void drbd_reconsider_queue_parameters(struct drbd_device *device, struct drbd_backing_dev *bdev, struct o_qlim *o)
+void drbd_reconsider_queue_parameters(struct drbd_device *device,
+		struct drbd_backing_dev *bdev, struct o_qlim *o)
 {
-	unsigned int now, new, local, peer;
-
-	now = queue_max_hw_sectors(device->rq_queue) << 9;
-	local = device->local_max_bio_size; /* Eventually last known value, from volatile memory */
-	peer = device->peer_max_bio_size; /* Eventually last known value, from meta data */
+	unsigned int now = queue_max_hw_sectors(device->rq_queue) <<
+			SECTOR_SHIFT;
+	unsigned int new;
 
 	if (bdev) {
-		local = queue_max_hw_sectors(bdev->backing_bdev->bd_disk->queue) << 9;
-		device->local_max_bio_size = local;
-	}
-	local = min(local, DRBD_MAX_BIO_SIZE);
-
-	/* We may ignore peer limits if the peer is modern enough.
-	   Because new from 8.3.8 onwards the peer can use multiple
-	   BIOs for a single peer_request */
-	if (device->state.conn >= C_WF_REPORT_PARAMS) {
-		if (first_peer_device(device)->connection->agreed_pro_version < 94)
-			peer = min(device->peer_max_bio_size, DRBD_MAX_SIZE_H80_PACKET);
-			/* Correct old drbd (up to 8.3.7) if it believes it can do more than 32KiB */
-		else if (first_peer_device(device)->connection->agreed_pro_version == 94)
-			peer = DRBD_MAX_SIZE_H80_PACKET;
-		else if (first_peer_device(device)->connection->agreed_pro_version < 100)
-			peer = DRBD_MAX_BIO_SIZE_P95;  /* drbd 8.3.8 onwards, before 8.4.0 */
-		else
-			peer = DRBD_MAX_BIO_SIZE;
+		struct request_queue *b = bdev->backing_bdev->bd_disk->queue;
 
-		/* We may later detach and re-attach on a disconnected Primary.
-		 * Avoid this setting to jump back in that case.
-		 * We want to store what we know the peer DRBD can handle,
-		 * not what the peer IO backend can handle. */
-		if (peer > device->peer_max_bio_size)
-			device->peer_max_bio_size = peer;
+		device->local_max_bio_size =
+			queue_max_hw_sectors(b) << SECTOR_SHIFT;
 	}
-	new = min(local, peer);
 
-	if (device->state.role == R_PRIMARY && new < now)
-		drbd_err(device, "ASSERT FAILED new < now; (%u < %u)\n", new, now);
-
-	if (new != now)
+	/*
+	 * We may later detach and re-attach on a disconnected Primary.  Avoid
+	 * decreasing the value in this case.
+	 *
+	 * We want to store what we know the peer DRBD can handle, not what the
+	 * peer IO backend can handle.
+	 */
+	new = min3(DRBD_MAX_BIO_SIZE, device->local_max_bio_size,
+		max(drbd_max_peer_bio_size(device), device->peer_max_bio_size));
+	if (new != now) {
+		if (device->state.role == R_PRIMARY && new < now)
+			drbd_err(device, "ASSERT FAILED new < now; (%u < %u)\n",
+					new, now);
 		drbd_info(device, "max BIO size = %u\n", new);
+	}
 
 	drbd_setup_queue_param(device, bdev, new, o);
 }
-- 
2.40.1

