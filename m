Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB87C433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 14:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 884F6610CC
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 14:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhJNOG3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 10:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhJNOG2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 10:06:28 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DC2C061755;
        Thu, 14 Oct 2021 07:04:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v17so19828980wrv.9;
        Thu, 14 Oct 2021 07:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xnpzWQz9uOiSJqamWPmVItt84eeZuw9zU3to8Fs7zAE=;
        b=dPPsuMaXAyife1zHD+SjQn16u+5fm+VTtR7m/utqBmX/m80NHI8uv/xTEXqk9PzHrk
         e0nC+lh4g9bakuUsJZZxuRFDpo0v4xdp4h1FE2evc4EiYJRshIEPatjGXm1EVhhRCkLZ
         zRRZb1U7alJNjbvljH7MzidBqmGNxAdh23fFeh6aIBmRYdaX93vpf5OQyR4UZfTxXHty
         1ta6yeHRGvD7QwwfIFxVNdHKy1qKhaoI1u2jmNll/dlBDTP9VNA+podgDsPXiS0tnCMH
         iF8n6Q4cZr5zs8jfbnAySCp1SW1OmFHMI1LnllD9mahl372WHjDb3r+dZA8s2sdQ6nXx
         RGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xnpzWQz9uOiSJqamWPmVItt84eeZuw9zU3to8Fs7zAE=;
        b=Jkm6PXO6OVGpu4QWWfual48vyfj2MXYJV//oRalTUpaqlFk/Y5kZisk2rz/EziF2Zs
         XdQ1wDRbZcX5fVfoFoiMqxS7Kca7k/v0qc4sYNW3aEyv0H8V8Uc6K/t+uyOMnHSDkSHh
         F4eBiFx3GelxrTwmCyKS+0iUHJBBOQtaw2LZ+mt1RI3WpwEnHa9Awy9s+lSpqg8B8iV2
         3mPFtHNMkPCxpGG8DOkDrhM/U2vhMQ/yMxD00DFJfLTjRi7DssKUZkn8kIn9pdBDIpjF
         yfAkVoGmq2NNMbJf8AGmN+zz+nx+eixpRpAeofVEhycqJUfgDQq6G2W+UgRzaOxIOTJ7
         l6Pg==
X-Gm-Message-State: AOAM532mDzv+v1A7t8xRNcwz9arXIcZXcLuruxHOAdGVemCzmBO7wxrR
        gXg38G1zh0vnTD+mlX4mrbA=
X-Google-Smtp-Source: ABdhPJzz3FvzU2fjQHWajbXSjOOMSPi99ea/Go43sBCjdu3/04plkt2lKsaJb7dIbaBPhz7TUePriw==
X-Received: by 2002:a5d:4248:: with SMTP id s8mr6706803wrr.195.1634220260051;
        Thu, 14 Oct 2021 07:04:20 -0700 (PDT)
Received: from localhost.localdomain ([185.69.145.214])
        by smtp.gmail.com with ESMTPSA id p8sm2273461wmg.15.2021.10.14.07.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:04:19 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>, asml.silence@gmail.com
Subject: [PATCH 4/5] block: use bdev_get_queue() in blk-core.c
Date:   Thu, 14 Oct 2021 15:03:29 +0100
Message-Id: <efc41f880262517c8dc32f932f1b23112f21b255.1634219547.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1634219547.git.asml.silence@gmail.com>
References: <cover.1634219547.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Convert bdev->bd_disk->queue to bdev_get_queue(), it's uses a cached
queue pointer and so is fater.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1ad2528680ea..f928990a1341 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -472,7 +472,7 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 
 static inline int bio_queue_enter(struct bio *bio)
 {
-	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	bool nowait = bio->bi_opf & REQ_NOWAIT;
 	int ret;
 
@@ -782,7 +782,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 {
 	struct block_device *bdev = bio->bi_bdev;
-	struct request_queue *q = bdev->bd_disk->queue;
+	struct request_queue *q = bdev_get_queue(bdev);
 	blk_status_t status = BLK_STS_IOERR;
 	struct blk_plug *plug;
 
@@ -940,7 +940,7 @@ static void __submit_bio_noacct(struct bio *bio)
 	current->bio_list = bio_list_on_stack;
 
 	do {
-		struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 		struct bio_list lower, same;
 
 		if (unlikely(bio_queue_enter(bio) != 0))
@@ -961,7 +961,7 @@ static void __submit_bio_noacct(struct bio *bio)
 		bio_list_init(&lower);
 		bio_list_init(&same);
 		while ((bio = bio_list_pop(&bio_list_on_stack[0])) != NULL)
-			if (q == bio->bi_bdev->bd_disk->queue)
+			if (q == bdev_get_queue(bio->bi_bdev))
 				bio_list_add(&same, bio);
 			else
 				bio_list_add(&lower, bio);
@@ -1056,7 +1056,7 @@ void submit_bio(struct bio *bio)
 
 		if (unlikely(bio_op(bio) == REQ_OP_WRITE_SAME))
 			count = queue_logical_block_size(
-					bio->bi_bdev->bd_disk->queue) >> 9;
+					bdev_get_queue(bio->bi_bdev)) >> 9;
 		else
 			count = bio_sectors(bio);
 
-- 
2.33.0

