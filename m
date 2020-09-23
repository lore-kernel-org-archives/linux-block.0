Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC60C2D0A8
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 20:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 528A72376E
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 20:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSy1srwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIWUG5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 16:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWUG5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 16:06:57 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61948C0613CE
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 13:06:57 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v54so1008612qtj.7
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 13:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HONrzBdI9DpoxCRFwugtgwBfWYcioGP4sYYVCknfP9M=;
        b=cSy1srwJHqdcgGc14NoMdSzlu7sMxVXF5+2cjgrDXOhDCPciKB7gw6XjmG65PXrb1c
         zCLlFWoB08wL//p3BCTkHJw8LFuEmGc9jaPJM5tvKBjQmGqa0wlm3WMtraJo+BraWLYr
         Twi4Ai8YggIdwNzDjhXW4vJnks0+vVCqU++2NsV0v546DjLjzoK7+sl9b/aYee4A7vNS
         /2PE2qj+u+4CJkqOWZOxnJq9uAO8t+owuPNJcRQ0u2sg23JSXyOoUgbcw2Q2CNPe2hj3
         HuI/oXR6O1XTbS6ToQ+Pv1hUQJx+c3Tc0kBxhHyGmE7QGu8tmd7BSf98aobmlaWm4dg1
         o6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=HONrzBdI9DpoxCRFwugtgwBfWYcioGP4sYYVCknfP9M=;
        b=O4+SWvSMxoZIqcPpEY04sOa++gmYXRhHfcsOMYJWcyXejq7A752yDOHsAJyF3ggWTg
         pHON0rNK/NUP7ZCgrlDk5l+nizpGJzrKgDGWzKuyOt/FvniT4uBjAHFa+RCh8rVAv2F7
         iJyqBdxVkeO1GLq5VTUoTe+zLY2BQSDt9f9WZqzVq8b77g4ARQczURlP0sJtRc6IRpsQ
         j7mGJOOu7/pD95SZoR77iwlAtuRLSYR23BELXhEm5H5mMnmWhHJqPk9xL+l3KqqhF4o9
         gvILkAJguwz+m/XbdPc03ls/dDiqjUzWjntqPi/aGHdFL0Y1iEPsTmd0kcdgM9p1el0W
         issA==
X-Gm-Message-State: AOAM532ECUandK2A8zUhfjFkTRjfueOIpKRDcxASrwbfnH5dy+Jrqgh2
        1fynNY6LfiaQ/AUJN5nk6QNqh/oouS9nr4E7
X-Google-Smtp-Source: ABdhPJwpLw9FIyba3sFP5Emu/a5Qy5slUFAK7OpphUveSgDQP2azOPSP+DLQfimaU0DBD9qMPynDgg==
X-Received: by 2002:ac8:44a7:: with SMTP id a7mr1883594qto.173.1600891616592;
        Wed, 23 Sep 2020 13:06:56 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id p20sm623842qtk.21.2020.09.23.13.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:06:55 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, hch@lst.de,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 2/2] dm: add support for REQ_NOWAIT and enable it for linear target
Date:   Wed, 23 Sep 2020 16:06:52 -0400
Message-Id: <20200923200652.11082-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200923200652.11082-1-snitzer@redhat.com>
References: <20200923200652.11082-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Add DM target feature flag DM_TARGET_NOWAIT which advertises that
target works with REQ_NOWAIT bios.

Add dm_table_supports_nowait() and update dm_table_set_restrictions()
to set/clear QUEUE_FLAG_NOWAIT accordingly.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-linear.c        |  5 +++--
 drivers/md/dm-table.c         | 32 ++++++++++++++++++++++++++++++++
 drivers/md/dm.c               |  4 +++-
 include/linux/device-mapper.h |  6 ++++++
 4 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index e1db43446327..00774b5d7668 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -228,10 +228,11 @@ static struct target_type linear_target = {
 	.name   = "linear",
 	.version = {1, 4, 0},
 #ifdef CONFIG_BLK_DEV_ZONED
-	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_ZONED_HM,
+	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_NOWAIT |
+		    DM_TARGET_ZONED_HM,
 	.report_zones = linear_report_zones,
 #else
-	.features = DM_TARGET_PASSES_INTEGRITY,
+	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_NOWAIT,
 #endif
 	.module = THIS_MODULE,
 	.ctr    = linear_ctr,
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index acba92500c12..17fb9b96d18e 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1719,6 +1719,33 @@ static bool dm_table_supports_write_zeroes(struct dm_table *t)
 	return true;
 }
 
+static int device_not_nowait_capable(struct dm_target *ti, struct dm_dev *dev,
+				     sector_t start, sector_t len, void *data)
+{
+	struct request_queue *q = bdev_get_queue(dev->bdev);
+
+	return q && !blk_queue_nowait(q);
+}
+
+static bool dm_table_supports_nowait(struct dm_table *t)
+{
+	struct dm_target *ti;
+	unsigned i = 0;
+
+	while (i < dm_table_get_num_targets(t)) {
+		ti = dm_table_get_target(t, i++);
+
+		if (!dm_target_supports_nowait(ti->type))
+			return false;
+
+		if (!ti->type->iterate_devices ||
+		    ti->type->iterate_devices(ti, device_not_nowait_capable, NULL))
+			return false;
+	}
+
+	return true;
+}
+
 static int device_not_discard_capable(struct dm_target *ti, struct dm_dev *dev,
 				      sector_t start, sector_t len, void *data)
 {
@@ -1821,6 +1848,11 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	 */
 	q->limits = *limits;
 
+	if (dm_table_supports_nowait(t))
+		blk_queue_flag_set(QUEUE_FLAG_NOWAIT, q);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_NOWAIT, q);
+
 	if (!dm_table_supports_discards(t)) {
 		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
 		/* Must also clear discard limits... */
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index b110b5eb99a5..3ad4a8da8b15 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1733,7 +1733,9 @@ static blk_qc_t dm_submit_bio(struct bio *bio)
 	if (unlikely(test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags))) {
 		dm_put_live_table(md, srcu_idx);
 
-		if (!(bio->bi_opf & REQ_RAHEAD))
+		if (bio->bi_opf & REQ_NOWAIT)
+			bio_wouldblock_error(bio);
+		else if (!(bio->bi_opf & REQ_RAHEAD))
 			queue_io(md, bio);
 		else
 			bio_io_error(bio);
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 57610fc3013e..ba3b0979e09f 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -252,6 +252,12 @@ struct target_type {
 #define DM_TARGET_ZONED_HM		0x00000040
 #define dm_target_supports_zoned_hm(type) ((type)->features & DM_TARGET_ZONED_HM)
 
+/*
+ * A target handles REQ_NOWAIT
+ */
+#define DM_TARGET_NOWAIT		0x00000080
+#define dm_target_supports_nowait(type) ((type)->features & DM_TARGET_NOWAIT)
+
 struct dm_target {
 	struct dm_table *table;
 	struct target_type *type;
-- 
2.15.0

