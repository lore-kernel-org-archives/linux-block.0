Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87785C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 13:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C31520896
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 13:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xSVSBBBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfARNfd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:35:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34172 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfARNfd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 08:35:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id j10so6096083pga.1
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 05:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0XfBUH0h6UMegExJfFNoxqar+AsBx1JRamqr0+nxNYQ=;
        b=xSVSBBBZMkxQKk2R2c552R4GY5GXtThhAu3xsEcMscb6Ba9xW00NLul3tHaOcshrR+
         RmkVgoqsf2KhLlhs3S6eOyIa6Z3Vi+iFHiQ/uKhtkTCCblMWpyiNDmdrRQuRobkF/7zc
         dmVudXPhXQ1iSI5UlLUmOVlUK/0Sbe9pTGWsaagZMHQq/837Y8vXg27tWb0lWEeP5zgJ
         KT8KpAJ6TLpnWPdZTrCaxOC7VpN2AP91GwY96g0uhh2xQVOyj97EYnLpVYpsv/KmkFQS
         sqajQDZ4wscBoDY12KMCgJzTKjwoHt7X6d+QPxHp+rG7WkZsBeGiLUxo/oE4kODz/Zzm
         Vl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0XfBUH0h6UMegExJfFNoxqar+AsBx1JRamqr0+nxNYQ=;
        b=susXLsUVsTyS/tS6Tx8PScXpWUOexfZUpL4MyhOqIOWbNytQB6656C13JPkkUVO8rI
         qCSuvEvDEpJloie7YujGdjJ3ToLzBsii9/DJN51HlV5pytLKGZrFosXP252807Hg13aW
         iJQslhCJS1n0U+UCh+tiGYR89ywYkjKF67lxGcJkdU50Ujh1PvyDogDttOlbEuKIsBDE
         z6PRJhAD3HVidooY6aXhd6BAOVHyHXJlwdCZoXv7+e7OFjnvvdf8PsKwdyuC5t5TK3FV
         uSc+xwwLF2AG5vMt5alK8G1mSwyYIikcKQuB5HaDpOFktJDTrh4eeIipDqyUcAYzvCmu
         405g==
X-Gm-Message-State: AJcUuke9i0ggvTrC3k8I/TMoeZaP7kATEO55JwPxL+70zDWEamY37mxC
        wky5DCFP2mR0VI0dD4naQF0J6g==
X-Google-Smtp-Source: ALg8bN657NAG2e9wuKo26Z+vlGdKTIfVboS5bVlKmFVyVfjp/4JQD3cbb2nU+sSA+XsFler5+zjJ4A==
X-Received: by 2002:a63:8e43:: with SMTP id k64mr17551699pge.346.1547818532211;
        Fri, 18 Jan 2019 05:35:32 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m19sm12315464pgn.35.2019.01.18.05.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 05:35:30 -0800 (PST)
Subject: Re: [PATCH BUGFIX RFC 0/2] reverting two commits causing freezes
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, hurikhan77+bko@gmail.com
References: <20190118115219.63576-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c3b182a2-7f82-2860-436b-c1d59d6661ff@kernel.dk>
Date:   Fri, 18 Jan 2019 06:35:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190118115219.63576-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/18/19 4:52 AM, Paolo Valente wrote:
> Hi Jens,
> a user reported a warning, followed by freezes, in case he increases
> nr_requests to more than 64 [1]. After reproducing the issues, I
> reverted the commit f0635b8a416e ("bfq: calculate shallow depths at
> init time"), plus the related commit bd7d4ef6a4c9 ("bfq-iosched:
> remove unused variable"). The problem went away.

For reverts, please put the justification into the actual revert
commit. With this series, if applied as-is, we'd have two patches
in the tree that just says "revert X" without any hint as to why
that was done.

> Maybe the assumption in commit f0635b8a416e ("bfq: calculate shallow
> depths at init time") does not hold true?

It apparently doesn't! But let's try and figure this out instead of
blindly reverting it. OK, I think I see it. For the sched_tags
case, when we grow the requests, we allocate a new set. Hence any
old cache would be stale at that point.

How about something like this? It still keeps the code of having
to update this out of the hot IO path, and only calls it when we
actually change the depths.

Totally untested...


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

