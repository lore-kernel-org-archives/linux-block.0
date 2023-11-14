Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20D12FC3F
	for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E169D;
	Tue, 14 Nov 2023 13:18:13 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1cc4f777ab9so47031725ad.0;
        Tue, 14 Nov 2023 13:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699996693; x=1700601493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iDgtijbfSr5IQPF1PJVs/YOTy8FP7gUZQnGFONo3vA=;
        b=LHgN7hvwDdY4f66Vl7LAfUK6etOj7kRpmzREYoETp2L6X7Gltai6HDoRtHyEg2FeC7
         I4cl94Z2FPzWlQSjS/Pxy0bdDfaRsP+XDqgROGcyhB3LeTOubH61bSoaNtJcGtYlmeqY
         tWmHboXJEINA6XMsGc7u/RVbhBgC5VYBA8TEvG0bjm80n1x09fJssG4xgjS64mmxIY4a
         HyYjqMmNQFeB09z/ccu8ORa25puecQ7GgetQTUerQPPRbvpxepqeSC4N8tjzk84WjdbI
         eTF3wnPrdN9OBi/7psTjs1rn/G3uzh2opuAa7hIhjv5B6Xgsx8Rd1MpQzvyfcR+e/odL
         9BzA==
X-Gm-Message-State: AOJu0YxbGSaqXXv4lXERgSlpdbi+7NScbw9Z/9v06RzF6w2gLZasiY8/
	6VHy0jri3SchbSRfoczNJ5U=
X-Google-Smtp-Source: AGHT+IE7kkAMSflj5vy7ZLuFnrflrpiNamM6Gh7Lvi/UwSi/Ydp/VgaE+M6hmurKlkWCE3oz8JtenA==
X-Received: by 2002:a17:902:c411:b0:1cc:59a1:79ae with SMTP id k17-20020a170902c41100b001cc59a179aemr366922plk.39.1699996693078;
        Tue, 14 Nov 2023 13:18:13 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:2278:ad72:cefb:4d49])
        by smtp.gmail.com with ESMTPSA id ix7-20020a170902f80700b001c71ec1866fsm6169288plb.258.2023.11.14.13.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:18:12 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v15 01/19] block: Introduce more member variables related to zone write locking
Date: Tue, 14 Nov 2023 13:16:09 -0800
Message-ID: <20231114211804.1449162-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231114211804.1449162-1-bvanassche@acm.org>
References: <20231114211804.1449162-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many but not all storage controllers require serialization of zoned writes.
Introduce two new request queue limit member variables related to write
serialization. 'driver_preserves_write_order' allows block drivers to
indicate that the order of write commands is preserved and hence that
serialization of writes per zone is not required. 'use_zone_write_lock' is
set by disk_set_zoned() if and only if the block device has zones and if
the block driver does not preserve the order of write requests.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-settings.c   | 15 +++++++++++++++
 block/blk-zoned.c      |  1 +
 include/linux/blkdev.h | 10 ++++++++++
 3 files changed, 26 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 0046b447268f..4c776c08f190 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -56,6 +56,8 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->alignment_offset = 0;
 	lim->io_opt = 0;
 	lim->misaligned = 0;
+	lim->driver_preserves_write_order = false;
+	lim->use_zone_write_lock = false;
 	lim->zoned = BLK_ZONED_NONE;
 	lim->zone_write_granularity = 0;
 	lim->dma_alignment = 511;
@@ -82,6 +84,8 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
 	lim->max_zone_append_sectors = UINT_MAX;
+	/* Request-based stacking drivers do not reorder requests. */
+	lim->driver_preserves_write_order = true;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
 
@@ -685,6 +689,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 						   b->max_secure_erase_sectors);
 	t->zone_write_granularity = max(t->zone_write_granularity,
 					b->zone_write_granularity);
+	t->driver_preserves_write_order = t->driver_preserves_write_order &&
+		b->driver_preserves_write_order;
+	t->use_zone_write_lock = t->use_zone_write_lock ||
+		b->use_zone_write_lock;
 	t->zoned = max(t->zoned, b->zoned);
 	return ret;
 }
@@ -949,6 +957,13 @@ void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 	}
 
 	q->limits.zoned = model;
+	/*
+	 * Use the zone write lock only for zoned block devices and only if
+	 * the block driver does not preserve the order of write commands.
+	 */
+	q->limits.use_zone_write_lock = model != BLK_ZONED_NONE &&
+		!q->limits.driver_preserves_write_order;
+
 	if (model != BLK_ZONED_NONE) {
 		/*
 		 * Set the zone write granularity to the device logical block
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 619ee41a51cc..112620985bff 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -631,6 +631,7 @@ void disk_clear_zone_settings(struct gendisk *disk)
 	q->limits.chunk_sectors = 0;
 	q->limits.zone_write_granularity = 0;
 	q->limits.max_zone_append_sectors = 0;
+	q->limits.use_zone_write_lock = false;
 
 	blk_mq_unfreeze_queue(q);
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 51fa7ffdee83..2d452f5a36c8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -316,6 +316,16 @@ struct queue_limits {
 	unsigned char		misaligned;
 	unsigned char		discard_misaligned;
 	unsigned char		raid_partial_stripes_expensive;
+	/*
+	 * Whether or not the block driver preserves the order of write
+	 * requests. Set by the block driver.
+	 */
+	bool			driver_preserves_write_order;
+	/*
+	 * Whether or not zone write locking should be used. Set by
+	 * disk_set_zoned().
+	 */
+	bool			use_zone_write_lock;
 	enum blk_zoned_model	zoned;
 
 	/*
