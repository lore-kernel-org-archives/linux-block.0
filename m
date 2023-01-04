Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E587C54EBE
	for <linux-block@archiver.kernel.org>; Wed,  4 Jan 2023 16:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239791AbjADQKW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Jan 2023 11:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239927AbjADQJ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Jan 2023 11:09:59 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769783C3BF
        for <linux-block@vger.kernel.org>; Wed,  4 Jan 2023 08:09:43 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id e129so9689435iof.3
        for <linux-block@vger.kernel.org>; Wed, 04 Jan 2023 08:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv+Luh619pd+KwOuWP6nLDdbUDoffJZW2uGn/UWH76Y=;
        b=Szdo/PkoXrKgCVuqiA7XdG2nMOjlqk7Wz2EhKFgf/cKwvRZWbFohillEHBjCjvbO/y
         VdKU0Ct6O+f6UFLxov3r8jpSCEnZJ3rS+MjMiuGGz8nMmuFRASRZ9hU9XVvI0GHbYama
         oTBHZ0csR/OKDkM464tmJ5GwiwOFDSENTQA37sChumnQvDm7uzOJ3gZc8TBVkxUP59k4
         IcErwFDR1qJmw0GCYiB/4Z52sOnI/OJnn8DluBzL1Oqt0z9Gys0EUeKzSJQy9aNFGQrs
         F2Jst3lFbBnMFJSW6fVi18a+SQmV/yNHePQnV5/bUjSY2dYALo2HGp6eDIiSkumSVAiT
         NNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jv+Luh619pd+KwOuWP6nLDdbUDoffJZW2uGn/UWH76Y=;
        b=c2YsUlWxkGlSlsLeCRLx8p17omOrZudiPWcnpH8AvVsNpvK99mo1kVk9KXcxeRytyG
         XLR8KoHaq85bsFE1/zfuw6PSQ/NhpSAVSY0Bq0nuftm+fo6CSqI50EhXwtmtiHdC1I8R
         CnIhOj16kPxd9+N2slLbKchml6GXuGoPSx5CUgE9whJACHM3uJQlnfUorwRExAWXDnGS
         pFkesItACyJBzJItzYRr4Lgvyz/iqaoUGYgnxy22U+TOAFADSsVdTvOCCO8sNjCRzFVF
         EpLIhqE+yxNJMc0RmEjgvsxJyRXmmPfGbWKz2in4FewDoRrGnbFuewtouLtsCUgZy/ke
         ZgYg==
X-Gm-Message-State: AFqh2kp6QYreAze7URi3KBFNur+JIQ9r+oUCFUov/A2o6n6X0NQ+GEL9
        cLS8L6dRM9vXW25eXzfe02Az9gDMBMmBrxNq
X-Google-Smtp-Source: AMrXdXviSe2p+3nFQmZ0mQbDLJEf8l8wbpNO7oiKq7n8eswCHOYY0Wf9pmElW0dCaVP8OyhaANdtOg==
X-Received: by 2002:a5d:990e:0:b0:6df:128f:ca12 with SMTP id x14-20020a5d990e000000b006df128fca12mr5841017iol.1.1672848582530;
        Wed, 04 Jan 2023 08:09:42 -0800 (PST)
Received: from m1max.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t24-20020a02b198000000b0038a41eb1ba3sm10955243jah.177.2023.01.04.08.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 08:09:42 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     mikelley@microsoft.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] block: handle bio_split_to_limits() NULL return
Date:   Wed,  4 Jan 2023 09:09:37 -0700
Message-Id: <20230104160938.62636-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230104160938.62636-1-axboe@kernel.dk>
References: <20230104160938.62636-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This can't happen right now, but in preparation for allowing
bio_split_to_limits() returning NULL if it ended the bio, check for it
in all the callers.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-merge.c             | 4 +++-
 block/blk-mq.c                | 5 ++++-
 drivers/block/drbd/drbd_req.c | 2 ++
 drivers/block/ps3vram.c       | 2 ++
 drivers/md/dm.c               | 2 ++
 drivers/md/md.c               | 2 ++
 drivers/nvme/host/multipath.c | 2 ++
 drivers/s390/block/dcssblk.c  | 2 ++
 8 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 35a8f75cc45d..071c5f8cf0cf 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -358,11 +358,13 @@ struct bio *__bio_split_to_limits(struct bio *bio,
 	default:
 		split = bio_split_rw(bio, lim, nr_segs, bs,
 				get_max_io_size(bio, lim) << SECTOR_SHIFT);
+		if (IS_ERR(split))
+			return NULL;
 		break;
 	}
 
 	if (split) {
-		/* there isn't chance to merge the splitted bio */
+		/* there isn't chance to merge the split bio */
 		split->bi_opf |= REQ_NOMERGE;
 
 		blkcg_bio_issue_init(split);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c5cf0dbca1db..2c49b4151da1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2951,8 +2951,11 @@ void blk_mq_submit_bio(struct bio *bio)
 	blk_status_t ret;
 
 	bio = blk_queue_bounce(bio, q);
-	if (bio_may_exceed_limits(bio, &q->limits))
+	if (bio_may_exceed_limits(bio, &q->limits)) {
 		bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
+		if (!bio)
+			return;
+	}
 
 	if (!bio_integrity_prep(bio))
 		return;
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index eb14ec8ec04c..e36216d50753 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1607,6 +1607,8 @@ void drbd_submit_bio(struct bio *bio)
 	struct drbd_device *device = bio->bi_bdev->bd_disk->private_data;
 
 	bio = bio_split_to_limits(bio);
+	if (!bio)
+		return;
 
 	/*
 	 * what we "blindly" assume:
diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index c76e0148eada..574e470b220b 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -587,6 +587,8 @@ static void ps3vram_submit_bio(struct bio *bio)
 	dev_dbg(&dev->core, "%s\n", __func__);
 
 	bio = bio_split_to_limits(bio);
+	if (!bio)
+		return;
 
 	spin_lock_irq(&priv->lock);
 	busy = !bio_list_empty(&priv->list);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index e1ea3a7bd9d9..b424a6ee27ba 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1742,6 +1742,8 @@ static void dm_split_and_process_bio(struct mapped_device *md,
 		 * otherwise associated queue_limits won't be imposed.
 		 */
 		bio = bio_split_to_limits(bio);
+		if (!bio)
+			return;
 	}
 
 	init_clone_info(&ci, md, map, bio, is_abnormal);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 775f1dde190a..8af639296b3c 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -455,6 +455,8 @@ static void md_submit_bio(struct bio *bio)
 	}
 
 	bio = bio_split_to_limits(bio);
+	if (!bio)
+		return;
 
 	if (mddev->ro == MD_RDONLY && unlikely(rw == WRITE)) {
 		if (bio_sectors(bio) != 0)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c03093b6813c..fc39d01e7b63 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -376,6 +376,8 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 	 * pool from the original queue to allocate the bvecs from.
 	 */
 	bio = bio_split_to_limits(bio);
+	if (!bio)
+		return;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
 	ns = nvme_find_path(head);
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index b392b9f5482e..c0f85ffb2b62 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -865,6 +865,8 @@ dcssblk_submit_bio(struct bio *bio)
 	unsigned long bytes_done;
 
 	bio = bio_split_to_limits(bio);
+	if (!bio)
+		return;
 
 	bytes_done = 0;
 	dev_info = bio->bi_bdev->bd_disk->private_data;
-- 
2.39.0

