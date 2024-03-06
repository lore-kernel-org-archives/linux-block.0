Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45057132C38
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733865; cv=none; b=LOGn45NXQ67pch/WGrwHKHEFhywzUWN+imVfoKskiPvbGP7rgf5VDORUlAsgPuAEAcy0RTMRtX4gtE4fRZ8PAiKTeaxnTu1slF1P+iCYQYX9at0IvKzgu4Cvw3Sn6dGWHShMyQYxYuAmgMaxNKveRmEcL6JNVb6b4QHnn3dX0RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733865; c=relaxed/simple;
	bh=Xkg2NzJRzT7r6gFh0oaVGRxWlZcaFFGtb/MDW6upix4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUFfzhDujn6ZSUfsL9ayP1ot+WiYcHIjnnFYyLCXRS8QDoyeUjxyxVSW8NV7nu7IYZXOjuov8rRzOQP84dRlKMzxT9CiP2RfrGdOVqiwinpff9IBGPdaFaX9ov/mbe+5JLw+8yTKuJKU5koTSSbnpttYpQ+/8Ch7ARkCXPUx8Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=aHRH7wNQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="aHRH7wNQ"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so8724556a12.3
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 06:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1709733862; x=1710338662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GmncMjG1GIDrKttEG+31/JHanom7hp+TnPpiKXoBMI=;
        b=aHRH7wNQiqjKuG53APsW5B19r+wK8cMoe7YTOmpCmUoV3QVKqxAAX702VJ3vtr3/W1
         60dm+/TR/m9pq38YA6Ovb1zuC/DRU3x9TNPJlESFwPqbw1SuQllj+QkBveMPNrqpzALs
         GUlGO97V4uo2ehzLiWZESKowe8926objI8yJB2iSNdFH2X1zR/oipuUUlrMbyqcxcOpv
         HX6MR5Sp9bzGMGVCPIf3AQqQACe5S9/CQ5H6mSNIELl0i6LchSIAnsUiPP8ed8cB1jEI
         Z9UAIvrEXc+W9uLEWwuPALB018aJPLbIMEv44UFi833wVmZt4FHABbPZRDp0RMWTQ+qN
         z/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709733862; x=1710338662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GmncMjG1GIDrKttEG+31/JHanom7hp+TnPpiKXoBMI=;
        b=g8IGM3zl4BVf8DGx8qpMeRCnbwc/tZJlYRSNAccDJz2FbnDxoadErY6HSL+TTQdGMC
         6ETXGvYJQ8PkjDwMtdLkVLUFUCl94MQ0mhMOrlDxT58n3EameNuCR/nLd9m13s2oHkB6
         SwgN5VtmEJTNiv4P/oxwNY8DleYIQS3NN7s6KFJhA/D7xptY1z/ITrf1opv2LoWy8Lv2
         AB+cU6tAcOyHx56njJeJK5ekO5Wim53dNofmSriDjzC4bJ5OUK8Cn+FJ1TwFnjXTR5yP
         9Y+bLPx1Tr2SyTW3pxLVwZAJjBjJEFwrf+DcMu5kLIh3Zzo+UUUd22E+6P8+4eISN+3j
         eqiA==
X-Forwarded-Encrypted: i=1; AJvYcCVCYmmbWOPpNqEKXQF8W/82wO6eVScB4aPx9kb2xoZ5Y0JGX7bCz6sLoJ3dX3C0beQ2MJcIPAQuI1DfzMkMd8dbhybHn447C4r/Z0A=
X-Gm-Message-State: AOJu0YzOL2rVHLW/45esiUAgSED4KfpyAoKnfanm3wtaJ9aDdukBNG1m
	bKBntf+4n2mQFl/13X25llJzylGQUQYGiN2jtxuxtuLUquSUb70gPrK6Kk5r6mY=
X-Google-Smtp-Source: AGHT+IE4Sgd2O5n0KeOZDMftBV4LfJrVCZIXfrzoDY2ETcKylWMmBMwZuuLmnebrOsGkxfNyK/He3A==
X-Received: by 2002:a05:6402:5bc4:b0:566:6e4e:cb8c with SMTP id gy4-20020a0564025bc400b005666e4ecb8cmr9727452edb.38.1709733861928;
        Wed, 06 Mar 2024 06:04:21 -0800 (PST)
Received: from ryzen9.home (62-47-18-60.adsl.highway.telekom.at. [62.47.18.60])
        by smtp.gmail.com with ESMTPSA id m18-20020aa7c492000000b005662d3418dfsm6924991edq.74.2024.03.06.06.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:04:21 -0800 (PST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 7/7] drbd: atomically update queue limits in drbd_reconsider_queue_parameters
Date: Wed,  6 Mar 2024 15:03:32 +0100
Message-Id: <20240306140332.623759-8-philipp.reisner@linbit.com>
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

Switch drbd_reconsider_queue_parameters to set up the queue parameters
in an on-stack queue_limits structure and apply the atomically.  Remove
various helpers that have become so trivial that they can be folded into
drbd_reconsider_queue_parameters.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Philipp Reisner <philipp.reisner@linbit.com>
Reviewed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Tested-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 119 ++++++++++++++---------------------
 1 file changed, 46 insertions(+), 73 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 94ed2b3ea636..fbd92803dc1d 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1216,11 +1216,6 @@ static unsigned int drbd_max_peer_bio_size(struct drbd_device *device)
 	return DRBD_MAX_BIO_SIZE;
 }
 
-static void blk_queue_discard_granularity(struct request_queue *q, unsigned int granularity)
-{
-	q->limits.discard_granularity = granularity;
-}
-
 static unsigned int drbd_max_discard_sectors(struct drbd_connection *connection)
 {
 	/* when we introduced REQ_WRITE_SAME support, we also bumped
@@ -1247,62 +1242,6 @@ static bool drbd_discard_supported(struct drbd_connection *connection,
 	return true;
 }
 
-static void decide_on_discard_support(struct drbd_device *device,
-		struct drbd_backing_dev *bdev)
-{
-	struct drbd_connection *connection =
-		first_peer_device(device)->connection;
-	struct request_queue *q = device->rq_queue;
-	unsigned int max_discard_sectors;
-
-	if (!drbd_discard_supported(connection, bdev))
-		goto not_supported;
-
-	/*
-	 * We don't care for the granularity, really.
-	 *
-	 * Stacking limits below should fix it for the local device.  Whether or
-	 * not it is a suitable granularity on the remote device is not our
-	 * problem, really. If you care, you need to use devices with similar
-	 * topology on all peers.
-	 */
-	blk_queue_discard_granularity(q, 512);
-	max_discard_sectors = drbd_max_discard_sectors(connection);
-	blk_queue_max_discard_sectors(q, max_discard_sectors);
-	return;
-
-not_supported:
-	blk_queue_discard_granularity(q, 0);
-	blk_queue_max_discard_sectors(q, 0);
-}
-
-static void fixup_write_zeroes(struct drbd_device *device, struct request_queue *q)
-{
-	/* Fixup max_write_zeroes_sectors after blk_stack_limits():
-	 * if we can handle "zeroes" efficiently on the protocol,
-	 * we want to do that, even if our backend does not announce
-	 * max_write_zeroes_sectors itself. */
-	struct drbd_connection *connection = first_peer_device(device)->connection;
-	/* If the peer announces WZEROES support, use it.  Otherwise, rather
-	 * send explicit zeroes than rely on some discard-zeroes-data magic. */
-	if (connection->agreed_features & DRBD_FF_WZEROES)
-		q->limits.max_write_zeroes_sectors = DRBD_MAX_BBIO_SECTORS;
-	else
-		q->limits.max_write_zeroes_sectors = 0;
-}
-
-static void fixup_discard_support(struct drbd_device *device, struct request_queue *q)
-{
-	unsigned int max_discard = device->rq_queue->limits.max_discard_sectors;
-	unsigned int discard_granularity =
-		device->rq_queue->limits.discard_granularity >> SECTOR_SHIFT;
-
-	if (discard_granularity > max_discard) {
-		blk_queue_discard_granularity(q, 0);
-		blk_queue_max_discard_sectors(q, 0);
-	}
-}
-
 /* This is the workaround for "bio would need to, but cannot, be split" */
 static unsigned int drbd_backing_dev_max_segments(struct drbd_device *device)
 {
@@ -1320,8 +1259,11 @@ static unsigned int drbd_backing_dev_max_segments(struct drbd_device *device)
 void drbd_reconsider_queue_parameters(struct drbd_device *device,
 		struct drbd_backing_dev *bdev, struct o_qlim *o)
 {
+	struct drbd_connection *connection =
+		first_peer_device(device)->connection;
 	struct request_queue * const q = device->rq_queue;
 	unsigned int now = queue_max_hw_sectors(q) << 9;
+	struct queue_limits lim;
 	struct request_queue *b = NULL;
 	unsigned int new;
 
@@ -1348,24 +1290,55 @@ void drbd_reconsider_queue_parameters(struct drbd_device *device,
 		drbd_info(device, "max BIO size = %u\n", new);
 	}
 
+	lim = queue_limits_start_update(q);
 	if (bdev) {
-		blk_set_stacking_limits(&q->limits);
-		blk_queue_max_segments(q,
-			drbd_backing_dev_max_segments(device));
+		blk_set_stacking_limits(&lim);
+		lim.max_segments = drbd_backing_dev_max_segments(device);
 	} else {
-		blk_queue_max_segments(q, BLK_MAX_SEGMENTS);
+		lim.max_segments = BLK_MAX_SEGMENTS;
 	}
 
-	blk_queue_max_hw_sectors(q, new >> SECTOR_SHIFT);
-	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
-	decide_on_discard_support(device, bdev);
+	lim.max_hw_sectors = new >> SECTOR_SHIFT;
+	lim.seg_boundary_mask = PAGE_SIZE - 1;
 
-	if (bdev) {
-		blk_stack_limits(&q->limits, &b->limits, 0);
-		disk_update_readahead(device->vdisk);
+	/*
+	 * We don't care for the granularity, really.
+	 *
+	 * Stacking limits below should fix it for the local device.  Whether or
+	 * not it is a suitable granularity on the remote device is not our
+	 * problem, really. If you care, you need to use devices with similar
+	 * topology on all peers.
+	 */
+	if (drbd_discard_supported(connection, bdev)) {
+		lim.discard_granularity = 512;
+		lim.max_hw_discard_sectors =
+			drbd_max_discard_sectors(connection);
+	} else {
+		lim.discard_granularity = 0;
+		lim.max_hw_discard_sectors = 0;
 	}
-	fixup_write_zeroes(device, q);
-	fixup_discard_support(device, q);
+
+	if (bdev)
+		blk_stack_limits(&lim, &b->limits, 0);
+
+	/*
+	 * If we can handle "zeroes" efficiently on the protocol, we want to do
+	 * that, even if our backend does not announce max_write_zeroes_sectors
+	 * itself.
+	 */
+	if (connection->agreed_features & DRBD_FF_WZEROES)
+		lim.max_write_zeroes_sectors = DRBD_MAX_BBIO_SECTORS;
+	else
+		lim.max_write_zeroes_sectors = 0;
+
+	if ((lim.discard_granularity >> SECTOR_SHIFT) >
+	    lim.max_hw_discard_sectors) {
+		lim.discard_granularity = 0;
+		lim.max_hw_discard_sectors = 0;
+	}
+
+	if (queue_limits_commit_update(q, &lim))
+		drbd_err(device, "setting new queue limits failed\n");
 }
 
 /* Starts the worker thread */
-- 
2.40.1

