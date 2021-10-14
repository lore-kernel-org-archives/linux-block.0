Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F80C433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 14:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184A1611B0
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 14:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhJNOGY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 10:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhJNOGX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 10:06:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991C7C061570;
        Thu, 14 Oct 2021 07:04:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i12so19859043wrb.7;
        Thu, 14 Oct 2021 07:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RELB8TbEOZyrfIMN/HydYmqwGJs+ezWzETNaP5mv0f0=;
        b=Yc3JqziCBJ2sSIU2fcOdZJAIZyh4m6yQrdveft0Ajq97tL2j0mDh43NR4j36vuRkK2
         giRn4LL+v36Hrv78VvZh81FiqynDIhALbioZVOr0qSRBHH5fys5vIQpU94QIuGOXFZGY
         Z/kZnps0Zzsz3SaE4xpYOP98UI7rXsdFcpyHvMgnWDQi5ajtlkpmXrIB63FhEDItENdL
         pcJBZJgUcqeA2xG0wlWy0PiznjxVmjLjheJ7Et3wyxgsoBg8dwrVCuMnoW3icaoOXyw9
         Th/PHe6F8wxmlPs0+rj05T8lqHmaWuK/RgBDDN3WCMbCf5jmiHqaZI5YgLC3oezZset6
         wFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RELB8TbEOZyrfIMN/HydYmqwGJs+ezWzETNaP5mv0f0=;
        b=adojHoA/UM+8OMlIjHZ+2QMiy893oQKG1LP/dgskCkesjHMoQwhWGAF/gPeV0u8kK+
         MkvdRNhUizsgDyLlnsLlmh2TDbBRTVD6IhEqJQ749oFeurlN3yEFN8TqU83D3b+03Ied
         lMIaeXoUVotf5M8HXEcCZy6LflNVhXWhFnjntZnTNzmUqEHVPNK8qEgwoNaUegnm3HC4
         tRyU4voH35hMxsexcSS2j7J9audvoQewLcCSjdWArOy/El7XMYEK4efDrbbs8CmzaGLw
         xQEoB7+iLhLKGIwL3k4knRySfxiCUUqbXrjVKTsKyuazqCrqyGj9Wj/7kN7qcraMM6Ca
         ZEnQ==
X-Gm-Message-State: AOAM532tg/JPSHd86qKZGhYN3x/UYkIB0nn8j8XxMbKkmOLxQ3/Bkqae
        UJqXLjk/339Bp/svWvf2iAE=
X-Google-Smtp-Source: ABdhPJxbqShtNDOyBGiy0do8LoPUwVk18iZAJPKk/FGhny5uE4sb8+CDz1A8Q9a9rpGj2zIYSLSzGA==
X-Received: by 2002:adf:a4ca:: with SMTP id h10mr6929979wrb.28.1634220257217;
        Thu, 14 Oct 2021 07:04:17 -0700 (PDT)
Received: from localhost.localdomain ([185.69.145.214])
        by smtp.gmail.com with ESMTPSA id p8sm2273461wmg.15.2021.10.14.07.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:04:16 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>, asml.silence@gmail.com
Subject: [PATCH 1/5] block: cache request queue in bdev
Date:   Thu, 14 Oct 2021 15:03:26 +0100
Message-Id: <a3bfaecdd28956f03629d0ca5c63ebc096e1c809.1634219547.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1634219547.git.asml.silence@gmail.com>
References: <cover.1634219547.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are tons of places where we need to get a request_queue only
having bdev, which turns into bdev->bd_disk->queue. There are probably a
hundred of such places considering inline helpers, and enough of them
are in hot paths.

Cache queue pointer in struct block_device and make use of it in
bdev_get_queue().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bdev.c              | 1 +
 block/genhd.c             | 4 +++-
 include/linux/blk_types.h | 1 +
 include/linux/blkdev.h    | 2 +-
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 567534c63f3d..30ae5b5d5f91 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -494,6 +494,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	bdev->bd_disk = disk;
 	bdev->bd_partno = partno;
 	bdev->bd_inode = inode;
+	bdev->bd_queue = disk->queue;
 	bdev->bd_stats = alloc_percpu(struct disk_stats);
 	if (!bdev->bd_stats) {
 		iput(inode);
diff --git a/block/genhd.c b/block/genhd.c
index 5e8aa0ab66c2..e11ee23a4401 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1244,6 +1244,9 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 	if (!disk->bdi)
 		goto out_free_disk;
 
+	/* bdev_alloc() might need the queue, set before the first call */
+	disk->queue = q;
+
 	disk->part0 = bdev_alloc(disk, 0);
 	if (!disk->part0)
 		goto out_free_bdi;
@@ -1259,7 +1262,6 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 	disk_to_dev(disk)->type = &disk_type;
 	device_initialize(disk_to_dev(disk));
 	inc_diskseq(disk);
-	disk->queue = q;
 	q->disk = disk;
 	lockdep_init_map(&disk->lockdep_map, "(bio completion)", lkclass, 0);
 #ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 72736b4c057c..1e370929c89e 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -38,6 +38,7 @@ struct block_device {
 	u8			bd_partno;
 	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
 	struct gendisk *	bd_disk;
+	struct request_queue *	bd_queue;
 
 	/* The counter of freeze processes */
 	int			bd_fsfreeze_count;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2a8689e949b4..d5b21fc8f49e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -574,7 +574,7 @@ int iocb_bio_iopoll(struct kiocb *kiocb, unsigned int flags);
 
 static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 {
-	return bdev->bd_disk->queue;	/* this is never NULL */
+	return bdev->bd_queue;	/* this is never NULL */
 }
 
 /*
-- 
2.33.0

