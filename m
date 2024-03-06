Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46461132494
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733861; cv=none; b=VIlXK1IEfMXXfWHP2XlC7TWUXd+bVwGIlgrJSQnusiiG4VOHyEH54UZqyamSLP8vxs3WCUX0M89ZsjnVAyuehTnvYWfZ6v0tsNWN6U6QIVkY1vzidIw2RQOYz/Wryd9vhzshdOByWmSL/4/ndBDFK0VSmizpEsakmLRezyZwvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733861; c=relaxed/simple;
	bh=MyDNIpOORM9lD+WBOdvGdBQ/6JwC0i2R+mlQ59Hp/1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lO7M+4WyAqQVeConwZsKc2VVedt8Mk+9RuqTb3X1Sqd2o14/603wW0CWBOfBj9lxg/I8y6gXXtRog7Glo3m6F+NLqFNrwFP+Wy139t3tjan7+q/+mW1F/SRwuzAoggeiZF3pKxLZZ87GEQHDR6DnJQOpca02WimuKwBtsfTX4sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=ufThjcrW; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="ufThjcrW"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563d56ee65cso10292775a12.2
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 06:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1709733857; x=1710338657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRYEa+8c0RD7c9mVDBDAz1QMFvgl81NHS3vUxcRXkOo=;
        b=ufThjcrWQddiaf/hLKd8nX0pWndjnqLz0UbJVDerB2S6SvnkL7DkpR6GQ833HgHKh4
         0Z+6thnXEf37+oGpPhhF7U3RqBjNWh7dLmeGUBMwDCOjSlj+DsZ7WOiCFIdIvVKkIi+N
         Ct3FfTEYst2ZFbk2OTt+IhE9DqauyhVZga5oW7D1bxtYFiX99eQ2rZtiFI6YunlZBqgr
         q/UiXwnPFzZgo/7skSHgwHqDw5ewHebEi7L6orQeUxihSADATi+u26jcREcmNBduaXVU
         4kx9gvLifg+zv4a9b9/ORB5TQ0E6oJS1kLWlY/LixRUFF8J+sxXr9pe2euue4MGqR3wR
         /N0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709733857; x=1710338657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRYEa+8c0RD7c9mVDBDAz1QMFvgl81NHS3vUxcRXkOo=;
        b=qJLzZgnjQCGj3AhZcvIhiO8e+V7DX6xN/xPacT8AP5lfPvYfqxvnwcw8PriQsxUZM2
         EL4WPRFz+/ajcnJ8kUUzky/u/N5wJsXdVXRQzWhiWEZK+tQqQ0/xzMKwqj7Ia/L7GeZV
         NZIYMiMYpBwC8aUuheKzoQk9JPRGQSgMMSXaiVea6KxVXhATRBCaUBmYARVy7dMA4TWo
         Mj7SC2MairmEonYJdAyKLC8NHPQBYX1K2ofswSi3WEj/mjBvVRRHIEDv5xbS1YuQYlA0
         sPeHjVYNvtoYUSjM875MCLSoARC+trUy9p6M8ePJm2FzxYuAeYZosfpghyNrULQeDyvG
         zzmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHjwUVk6ymaltH/yCqUl0UfRyqYOuxPbD4X11Lgrfz6Z0K9yC17pp58k47qlMhmikRNrHQ6Pqrx9RaZSboqNPWC1OfuxVjkDjTBiM=
X-Gm-Message-State: AOJu0YwMM9hWpI4knlEqmIdzR8Yjmn2Npc3OOZpF2a5DnFM1oOq2bKm3
	ElIBxyzscYI0rVRernLOQkYZtwCfHs04743jE6QQCE9MCEaLy6UjXVeqN/LXDeg=
X-Google-Smtp-Source: AGHT+IFh2HrB/L8s25lhOCmfk34YmGw/xKNWWDg9bAIeSf0LfGcvX4QC61LytQQJ3YYt5/ygtdP2yw==
X-Received: by 2002:aa7:ce05:0:b0:567:702d:ccb1 with SMTP id d5-20020aa7ce05000000b00567702dccb1mr5392625edv.20.1709733857680;
        Wed, 06 Mar 2024 06:04:17 -0800 (PST)
Received: from ryzen9.home (62-47-18-60.adsl.highway.telekom.at. [62.47.18.60])
        by smtp.gmail.com with ESMTPSA id m18-20020aa7c492000000b005662d3418dfsm6924991edq.74.2024.03.06.06.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:04:17 -0800 (PST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 3/7] drbd: refactor the backing dev max_segments calculation
Date: Wed,  6 Mar 2024 15:03:28 +0100
Message-Id: <20240306140332.623759-4-philipp.reisner@linbit.com>
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

Factor out a drbd_backing_dev_max_segments helper that checks the
backing device limitation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Philipp Reisner <philipp.reisner@linbit.com>
Reviewed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Tested-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 9135001a8e57..0326b7322ceb 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1295,30 +1295,39 @@ static void fixup_discard_support(struct drbd_device *device, struct request_que
 	}
 }
 
+/* This is the workaround for "bio would need to, but cannot, be split" */
+static unsigned int drbd_backing_dev_max_segments(struct drbd_device *device)
+{
+	unsigned int max_segments;
+
+	rcu_read_lock();
+	max_segments = rcu_dereference(device->ldev->disk_conf)->max_bio_bvecs;
+	rcu_read_unlock();
+
+	if (!max_segments)
+		return BLK_MAX_SEGMENTS;
+	return max_segments;
+}
+
 static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backing_dev *bdev,
 				   unsigned int max_bio_size, struct o_qlim *o)
 {
 	struct request_queue * const q = device->rq_queue;
 	unsigned int max_hw_sectors = max_bio_size >> 9;
-	unsigned int max_segments = 0;
+	unsigned int max_segments = BLK_MAX_SEGMENTS;
 	struct request_queue *b = NULL;
-	struct disk_conf *dc;
 
 	if (bdev) {
 		b = bdev->backing_bdev->bd_disk->queue;
 
 		max_hw_sectors = min(queue_max_hw_sectors(b), max_bio_size >> 9);
-		rcu_read_lock();
-		dc = rcu_dereference(device->ldev->disk_conf);
-		max_segments = dc->max_bio_bvecs;
-		rcu_read_unlock();
+		max_segments = drbd_backing_dev_max_segments(device);
 
 		blk_set_stacking_limits(&q->limits);
 	}
 
 	blk_queue_max_hw_sectors(q, max_hw_sectors);
-	/* This is the workaround for "bio would need to, but cannot, be split" */
-	blk_queue_max_segments(q, max_segments ? max_segments : BLK_MAX_SEGMENTS);
+	blk_queue_max_segments(q, max_segments);
 	blk_queue_segment_boundary(q, PAGE_SIZE-1);
 	decide_on_discard_support(device, bdev);
 
-- 
2.40.1

