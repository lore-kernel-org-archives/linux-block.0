Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF31C77B76
	for <linux-block@archiver.kernel.org>; Fri, 14 Apr 2023 13:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjDNNtK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Apr 2023 09:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjDNNtH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Apr 2023 09:49:07 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B55CB769
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2023 06:48:53 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-517ca8972c5so145077a12.0
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2023 06:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681480132; x=1684072132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ay/yqTRFl1MCbf/8Li/8YkgX3Ugfpqa4A6skVroSMS8=;
        b=5HtYI13ssEUtVwYeSuFkN3S8N/iGh0N/+dJ15Z1+cqTCD0wBGgtQ2Aco7EBL15bHwN
         mvjIuAHqGSKDH4gheP9RWfhz4J1FYw++0gA0LXz/IaxvAOqxJVTbYMl0rT9H3/fCRr5f
         cfg3OuGJjxrqxNfCC17TyC5WevV7v3OvMQ9AqlkZur9XucYzZn/D/xsjv59jeINDX/Yb
         uvFwfN2fkocMSdvsp0J6yLYtwbQ5GQ6XR22HrjOwv5Pzzr9u9aANwgljmIVbBHJfV+61
         NGujx1FTW0h9/1BAsKdG1mRkkbASjftbo8gMqtcYw/FED6uuLVIhvKmO7/tb2k64GKTG
         dKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681480132; x=1684072132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ay/yqTRFl1MCbf/8Li/8YkgX3Ugfpqa4A6skVroSMS8=;
        b=WdV7wBH3Oev5vfFNKiWlxuOqbNvv0FJXCNwCwuUCjJ38dtCGeAdkE94P2Zsiq0K+us
         OsdrM12Vv3aTMaTXU6UIz5tGklTS5SHCWEzkpESm0jD+y5KFIWcQqy0/7gYyfxQjca3S
         oCYKgup9AwUiwRqa9/lGzm19NMWef5BzxzR88WbkTQMnrfD9+pi13yCMK0c2Ps8f+t1E
         37HXTbfAYgGhBmBgFSkHqNKqgS5V63d2J8iUbGY69GPcH+f/Tm0GLOPID+2mZTbyL93e
         4FbwcfDbmO37fD58QKd/sUgipF30+P8NelbNC1soKS2645dEFjREFz4nNlj5GSDdFi3J
         symA==
X-Gm-Message-State: AAQBX9dX5yMSKRGBorI+XIpNazedIWk14mTefnKFxwrcjnyHLq/9IYzO
        jiKvO0gbyomCF3pIAGZYZg98XEklPim7O+hRzS8=
X-Google-Smtp-Source: AKy350bwv03dCHUtNrLfnLfQtobPCr8WNHR/RkXME/xetrA1GlzU578gh6F6Nz62OMYpReQVakJoLQ==
X-Received: by 2002:a17:902:e547:b0:196:8d96:dc6b with SMTP id n7-20020a170902e54700b001968d96dc6bmr3025940plf.2.1681480132545;
        Fri, 14 Apr 2023 06:48:52 -0700 (PDT)
Received: from localhost.localdomain (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902ee5400b001a19bac463fsm3098980plo.42.2023.04.14.06.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 06:48:51 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] block: store bdev->bd_disk->fops->submit_bio state in bdev
Date:   Fri, 14 Apr 2023 07:48:48 -0600
Message-Id: <20230414134848.91563-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414134848.91563-1-axboe@kernel.dk>
References: <20230414134848.91563-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have a long chain of memory dereferencing just to whether or not
this disk has a special submit_bio helper. As that's not necessarily
the common case, add a bd_submit_bio state in the bdev to avoid
traversing this memory dependency chain if we don't need to.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bdev.c              | 1 +
 block/blk-core.c          | 8 ++++----
 block/genhd.c             | 4 ++++
 include/linux/blk_types.h | 1 +
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 1795c7d4b99e..31a5d25b2b44 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -419,6 +419,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	bdev->bd_inode = inode;
 	bdev->bd_queue = disk->queue;
 	bdev->bd_stats = alloc_percpu(struct disk_stats);
+	bdev->bd_submit_bio = 0;
 	if (!bdev->bd_stats) {
 		iput(inode);
 		return NULL;
diff --git a/block/blk-core.c b/block/blk-core.c
index 269765d16cfd..ae7953539dc0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -587,14 +587,14 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 
 static void __submit_bio(struct bio *bio)
 {
-	struct gendisk *disk = bio->bi_bdev->bd_disk;
-
 	if (unlikely(!blk_crypto_bio_prep(&bio)))
 		return;
 
-	if (!disk->fops->submit_bio) {
+	if (!bio->bi_bdev->bd_submit_bio) {
 		blk_mq_submit_bio(bio);
 	} else if (likely(bio_queue_enter(bio) == 0)) {
+		struct gendisk *disk = bio->bi_bdev->bd_disk;
+
 		disk->fops->submit_bio(bio);
 		blk_queue_exit(disk->queue);
 	}
@@ -698,7 +698,7 @@ void submit_bio_noacct_nocheck(struct bio *bio)
 	 */
 	if (current->bio_list)
 		bio_list_add(&current->bio_list[0], bio);
-	else if (!bio->bi_bdev->bd_disk->fops->submit_bio)
+	else if (!bio->bi_bdev->bd_submit_bio)
 		__submit_bio_noacct_mq(bio);
 	else
 		__submit_bio_noacct(bio);
diff --git a/block/genhd.c b/block/genhd.c
index 02d9cfb9e077..07736c5db988 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -420,6 +420,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	 */
 	elevator_init_mq(disk->queue);
 
+	/* Mark bdev as having a submit_bio, if needed */
+	if (disk->fops->submit_bio)
+		disk->part0->bd_submit_bio = 1;
+
 	/*
 	 * If the driver provides an explicit major number it also must provide
 	 * the number of minors numbers supported, and those will be used to
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d68d6e951fad..c08e1c08b7ba 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -47,6 +47,7 @@ struct block_device {
 	bool			bd_read_only;	/* read-only policy */
 	u8			bd_partno;
 	bool			bd_write_holder;
+	bool			bd_submit_bio;
 	dev_t			bd_dev;
 	atomic_t		bd_openers;
 	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
-- 
2.39.2

