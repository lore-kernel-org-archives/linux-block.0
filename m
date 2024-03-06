Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5A3132C38
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733862; cv=none; b=SyUIH+T0kKn2m5StFRPju5jUf1Nx8osRbDDCwDkKOsZJOFNLJDt8Xog1BbVwTt6IB/4/dMp+6DPyCUmQbv+gAEyP2WZyW4XeI5tOCcwJssN4+o1oxDdtoUazIImcQHyzUofT5bKzIk+Ku66T0GBY4qO9uLiQpMrz/jSXvi2tqFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733862; c=relaxed/simple;
	bh=lRyB6SaCRVrP9h3xCOSo+6kATl9J6hb5jIWTE9oR8uY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uF3GuKg5Y2I3xeuXCT0GSVuwy3eaNL3n/DeAroM3rga7fGCbUEdinj0FIqjogFPX6lu5exMwLwA4usdr5pHlru36MiAu/Rx70uI/A+4lif/3LeXwwmM1Qw7697rwxzRSW3V943Uwn6QHKaXp+jdiixZFXtd539ujGVQh7DWIX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=dZiFqB4D; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="dZiFqB4D"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56647babfe6so10030772a12.3
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 06:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1709733859; x=1710338659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JJxAYhfXHCDUu1ylelsVJri+kbSlwIsVmiuUFYkgAo=;
        b=dZiFqB4DkLiKuFsjv+lUg6EBOact73n9FaCRuzenDxdSsJIJcX3yvuEW8dYbXWjzZP
         dYHg1r/Z94PPHc9nK+MH6PY8yM1IQcfWr60SpHM8fOJ3jTUZ2bgePiJzniCpLyXWVsRV
         L8G6eY9JQX6mPRLAs8sTCbhlpPKewbrtfv1TA5DnEy6yu2p9z1g935+2Adut2fL6Jrv5
         L67PgBkeTEGGjdAE2cPuF5X1swAFnWzQajkQK6zwqafGRLotZBP5iuCl+W5rxX3Yxy4h
         PqMJBgqa2GUKku97o+/WutQF4RFX8abjKUvx2bPMMPZcs9vG7LT7AO0xrVcjdWLc3cw5
         kanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709733859; x=1710338659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JJxAYhfXHCDUu1ylelsVJri+kbSlwIsVmiuUFYkgAo=;
        b=eNre3EYRQoOfcJYfxJHFRB2BzurcC0fRbpmUS8yoAd4CKGpdCivj/L2NMnR9DO47b4
         iJbeblZ3Le1O66zqwb2ExU+d5c+Y7qVvZR9AtGXJYrHvhorWWJp2m/HT3lJkA09GMNhI
         cTvpzKzAREB2/hUfhZotVLY9hgRJQ2YcsnjMWkuUq9FYBpQBYVJAkDXSU7MQFngIdnzM
         MCdvP6zYDrHYVGRr9O4Bd60/9hfR5N//akHzKWNNC0p2XFZ5+zha65dqDSUgkmt037CI
         rlIGIgzTC+00Ia0oAEE2W5fHy1EEO7jWpfCe/KQwo9lJGIgyyM9gXjYBUxkGEN12sGx1
         0m5A==
X-Forwarded-Encrypted: i=1; AJvYcCUCZD89SoXFyK3TGdcdoysgCOJsFGGPQqWsDTQ6TfyWqHXMpuJB7Ev95QVA+hDCLKit8vbCETn1V8OqApauvKCA7ZbCJFcNAZjbzdI=
X-Gm-Message-State: AOJu0YybiaULF8ZZzxDW/HCb8jS4dbTBOStVm5BzOYuYYS6aYcVfEy8V
	yMjPGJirUFS15M3bfcjsoVRr3ZzV4U0akwVbxluTgKjRfOw8+BArjE5OTafqAsY=
X-Google-Smtp-Source: AGHT+IHGC0WBmCNO2PZhBdCdtnITFxhmuCY+bn8CEkV5EMiAMwNXGZkbmk3uHno6H5goyo9CEM8ovw==
X-Received: by 2002:a05:6402:17c4:b0:567:e812:e44e with SMTP id s4-20020a05640217c400b00567e812e44emr1155277edy.18.1709733858793;
        Wed, 06 Mar 2024 06:04:18 -0800 (PST)
Received: from ryzen9.home (62-47-18-60.adsl.highway.telekom.at. [62.47.18.60])
        by smtp.gmail.com with ESMTPSA id m18-20020aa7c492000000b005662d3418dfsm6924991edq.74.2024.03.06.06.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:04:18 -0800 (PST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 4/7] drbd: merge drbd_setup_queue_param into drbd_reconsider_queue_parameters
Date: Wed,  6 Mar 2024 15:03:29 +0100
Message-Id: <20240306140332.623759-5-philipp.reisner@linbit.com>
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

drbd_setup_queue_param is only called by drbd_reconsider_queue_parameters
and there is no really clear boundary of responsibilities between the
two.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Philipp Reisner <philipp.reisner@linbit.com>
Reviewed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Tested-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 56 ++++++++++++++----------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 0326b7322ceb..0f40fdee0899 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1309,45 +1309,16 @@ static unsigned int drbd_backing_dev_max_segments(struct drbd_device *device)
 	return max_segments;
 }
 
-static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backing_dev *bdev,
-				   unsigned int max_bio_size, struct o_qlim *o)
-{
-	struct request_queue * const q = device->rq_queue;
-	unsigned int max_hw_sectors = max_bio_size >> 9;
-	unsigned int max_segments = BLK_MAX_SEGMENTS;
-	struct request_queue *b = NULL;
-
-	if (bdev) {
-		b = bdev->backing_bdev->bd_disk->queue;
-
-		max_hw_sectors = min(queue_max_hw_sectors(b), max_bio_size >> 9);
-		max_segments = drbd_backing_dev_max_segments(device);
-
-		blk_set_stacking_limits(&q->limits);
-	}
-
-	blk_queue_max_hw_sectors(q, max_hw_sectors);
-	blk_queue_max_segments(q, max_segments);
-	blk_queue_segment_boundary(q, PAGE_SIZE-1);
-	decide_on_discard_support(device, bdev);
-
-	if (b) {
-		blk_stack_limits(&q->limits, &b->limits, 0);
-		disk_update_readahead(device->vdisk);
-	}
-	fixup_write_zeroes(device, q);
-	fixup_discard_support(device, q);
-}
-
 void drbd_reconsider_queue_parameters(struct drbd_device *device,
 		struct drbd_backing_dev *bdev, struct o_qlim *o)
 {
-	unsigned int now = queue_max_hw_sectors(device->rq_queue) <<
-			SECTOR_SHIFT;
+	struct request_queue * const q = device->rq_queue;
+	unsigned int now = queue_max_hw_sectors(q) << 9;
+	struct request_queue *b = NULL;
 	unsigned int new;
 
 	if (bdev) {
-		struct request_queue *b = bdev->backing_bdev->bd_disk->queue;
+		b = bdev->backing_bdev->bd_disk->queue;
 
 		device->local_max_bio_size =
 			queue_max_hw_sectors(b) << SECTOR_SHIFT;
@@ -1369,7 +1340,24 @@ void drbd_reconsider_queue_parameters(struct drbd_device *device,
 		drbd_info(device, "max BIO size = %u\n", new);
 	}
 
-	drbd_setup_queue_param(device, bdev, new, o);
+	if (bdev) {
+		blk_set_stacking_limits(&q->limits);
+		blk_queue_max_segments(q,
+			drbd_backing_dev_max_segments(device));
+	} else {
+		blk_queue_max_segments(q, BLK_MAX_SEGMENTS);
+	}
+
+	blk_queue_max_hw_sectors(q, new >> SECTOR_SHIFT);
+	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
+	decide_on_discard_support(device, bdev);
+
+	if (bdev) {
+		blk_stack_limits(&q->limits, &b->limits, 0);
+		disk_update_readahead(device->vdisk);
+	}
+	fixup_write_zeroes(device, q);
+	fixup_discard_support(device, q);
 }
 
 /* Starts the worker thread */
-- 
2.40.1

