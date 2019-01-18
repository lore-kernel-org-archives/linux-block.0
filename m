Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888EAC07EBF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 17:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BED820823
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 17:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="n6yTvmKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfARReT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:34:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45746 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfARReT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 12:34:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so6624277plm.12
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 09:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=iv/8tGr2QG8tvDKiAW6NKCoBq5ytclf3WOxCL3sDLtM=;
        b=n6yTvmKl5CbACq7QWT0zEWdNhNqeMxKCZyDCV4JGIiz2n7jIHj8kMBkdXSDO/wCObe
         y3CM5iglj8rEgzWZ6FzZ0Toj3IFvhE8YV0uVPy7cxPZrZFGbtzvuGM/uur/cEDbh9yHu
         VtX6++71kjON1nW6yQJlaUW8/wBTzhp8uNEpvIAsseL1wgRPL561kK3rM8Y0+3jdAJuw
         lUpaZcrrWp98LqZoYfZ19JMGrGzw35qG5NaSmy8kRkwXHNGi8M6CcQ6m/60n5WRfHgjz
         li6NztSMSejsIuTaodwZdt61NA2Mxf74GbDjAHC67mWl9chy9YeYDiKS3/ETzKiPPnhK
         GNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=iv/8tGr2QG8tvDKiAW6NKCoBq5ytclf3WOxCL3sDLtM=;
        b=J8fqddTy6Y4yUDxJ14C56vQDeDRLO3evd/cy9C4r4BbcCtkIk0MQtv99I+eTC86DeY
         4OBxMCLPQCY8ZyaTij0s951F7waZ+BRKxX42My+JAEI3uj7bBhETEixxLKmw5MKpLGar
         lfIV7dY3zk5W4d2wc0E1jIyAnWK0iPvga7ZVJf7Z0CMEW/MscYTbvz3Y6JIjs3elRd0R
         H05jSqBUuIfw8AKcekQTYnDwEBODCmCrUEM2qkpAy7COGMHyABKl9J3pRiYybXwm4RNa
         S/JSJEBFMRW2z0QukIFNpesCtC/EOoqXCFrUKZlcu7k1hXdoER70/QhILb/ZmJYywqFa
         +OGw==
X-Gm-Message-State: AJcUukc9Oz2XVb5JCDCyXn4qsPH3AoXKugzJ3NO0E7qxEWytvMw9gFWt
        sZtEV2c0kOcQYit+yOrobe+wSdRUL1lOgw==
X-Google-Smtp-Source: ALg8bN4TvKRZ1qL6s1QKv0TJ2DPTsztvslWOVH5Sbwq4Xx4M9i0YsAzmKgu1gOQP1WkPgiTZkh/fLA==
X-Received: by 2002:a17:902:722:: with SMTP id 31mr20119562pli.271.1547832859047;
        Fri, 18 Jan 2019 09:34:19 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c7sm7839400pfh.18.2019.01.18.09.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 09:34:18 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        hurikhan77+bko@gmail.com
From:   Jens Axboe <axboe@kernel.dk>
Subject: bfq: update internal depth state when queue depth changes
Message-ID: <013ca038-559d-0a56-4d49-366c7ec79ac3@kernel.dk>
Date:   Fri, 18 Jan 2019 10:34:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A previous commit moved the shallow depth and BFQ depth map calculations
to be done at init time, moving it outside of the hotter IO path. This
potentially causes hangs if the users changes the depth of the scheduler
map, by writing to the 'nr_requests' sysfs file for that device.

Add a blk-mq-sched hook that allows blk-mq to inform the scheduler if
the depth changes, so that the scheduler can update its internal state.

Reported-by: Paolo Valente <paolo.valente@linaro.org>
Fixes: f0635b8a416e ("bfq: calculate shallow depths at init time")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index cd307767a134..b09589915667 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5342,7 +5342,7 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
 	return min_shallow;
 }
 
-static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
+static void bfq_depth_updated(struct blk_mq_hw_ctx *hctx)
 {
 	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
 	struct blk_mq_tags *tags = hctx->sched_tags;
@@ -5350,6 +5350,11 @@ static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
 
 	min_shallow = bfq_update_depths(bfqd, &tags->bitmap_tags);
 	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, min_shallow);
+}
+
+static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
+{
+	bfq_depth_updated(hctx);
 	return 0;
 }
 
@@ -5772,6 +5777,7 @@ static struct elevator_type iosched_bfq_mq = {
 		.requests_merged	= bfq_requests_merged,
 		.request_merged		= bfq_request_merged,
 		.has_work		= bfq_has_work,
+		.depth_updated		= bfq_depth_updated,
 		.init_hctx		= bfq_init_hctx,
 		.init_sched		= bfq_init_queue,
 		.exit_sched		= bfq_exit_queue,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ba37b9e15e9..a047b297ade5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3101,6 +3101,8 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 		}
 		if (ret)
 			break;
+		if (q->elevator && q->elevator->type->ops.depth_updated)
+			q->elevator->type->ops.depth_updated(hctx);
 	}
 
 	if (!ret)
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 2e9e2763bf47..6e8bc53740f0 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -31,6 +31,7 @@ struct elevator_mq_ops {
 	void (*exit_sched)(struct elevator_queue *);
 	int (*init_hctx)(struct blk_mq_hw_ctx *, unsigned int);
 	void (*exit_hctx)(struct blk_mq_hw_ctx *, unsigned int);
+	void (*depth_updated)(struct blk_mq_hw_ctx *);
 
 	bool (*allow_merge)(struct request_queue *, struct request *, struct bio *);
 	bool (*bio_merge)(struct blk_mq_hw_ctx *, struct bio *);

-- 
Jens Axboe

