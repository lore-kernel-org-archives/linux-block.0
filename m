Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5DAC433F5
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 18:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA62961076
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 18:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhKCSfE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 14:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhKCSfD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 14:35:03 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA131C061714
        for <linux-block@vger.kernel.org>; Wed,  3 Nov 2021 11:32:25 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r10-20020a056830448a00b0055ac7767f5eso4766337otv.3
        for <linux-block@vger.kernel.org>; Wed, 03 Nov 2021 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iUVdiKdE3UtLDrSJ4ppTvX/REgJOcEw5TGAopy8ZtZU=;
        b=P64WAdj+AWI6P8K618uYTEwfAIyIyUvOGoUMaRrR3YGPUJbQ0lZH6k9VvlTHm2yUFG
         6K7A4zwaKg7GjamFnl9bN0kwMCPe6kLxkjU4NWIOzGGDCaifbNu/nS0SCeghlpneldQM
         a/QUFylYbVYLHrZo424omwfoV001aSWslv5bhuhz5T5LWUIb+DmeMmBQbgcjx5lWWxo5
         o2ByKu6nk7wLroB9F2wqHhBDu5N6kVxTUT/9TBq1Ncsihh11mgTJmI9fcgcntqH8rW3e
         4GhRD5qf3QoYYqwOP9IkjYujHmeakhrhBRFcUNoNa380mytvvh7n5viJqMEWxCDdYJXw
         BMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iUVdiKdE3UtLDrSJ4ppTvX/REgJOcEw5TGAopy8ZtZU=;
        b=wDkK3UdKw7HRASjDtabfeTJZphuEyfMmuPUfB8sZa97fpp4sX6RiNlOe6WYetVuzkH
         h6hCcpPfARY7/33DW7OFDuOCmf2iC/QcJxeWs2AFj39fQcs5R4QDOUtsajkmiRKQgF99
         igBuzWWkCyKtAM8R99juqS0Nt0TFLNnv6tfR8+pHQ9Wn4r5er4UmY16e6Z5848rWugpp
         dNzisv1Zq6TEdKj/z9XnWZnP+QlN7Vih60us1u+9ea00cKJMkxSPenrD4n1mBWn6f9We
         JegUqDhHXe1+A0jHHWS1wZVDuiJ0XM2tnx9PVcuMTd2r7YUUj/gCeJKBKauWxd3SD0e8
         7bhA==
X-Gm-Message-State: AOAM530OIu5Mb3/wGXXgaetvAHTLaeloqIrE7Hf/oyHMXb9uMYvCLDf5
        ggDZcTFs9vRzrQuhN5/rHHxW3Pl7f19eVg==
X-Google-Smtp-Source: ABdhPJwZxpHYCfWA2tjXGDNLEqB31Xl5XsX8bP7nadr9aBZyJzTWeIwy7B3jBuwmXw4M6coDwh40qQ==
X-Received: by 2002:a9d:1cad:: with SMTP id l45mr1463627ota.343.1635964344990;
        Wed, 03 Nov 2021 11:32:24 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i20sm766056otp.18.2021.11.03.11.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 11:32:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] block: have plug stored requests hold references to the queue
Date:   Wed,  3 Nov 2021 12:32:19 -0600
Message-Id: <20211103183222.180268-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211103183222.180268-1-axboe@kernel.dk>
References: <20211103183222.180268-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Requests that were stored in the cache deliberately didn't hold an enter
reference to the queue, instead we grabbed one every time we pulled a
request out of there. That made for awkward logic on freeing the remainder
of the cached list, if needed, where we had to artificially raise the
queue usage count before each free.

Grab references up front for cached plug requests. That's safer, and also
more efficient.

Fixes: 47c122e35d7e ("block: pre-allocate requests if plug is started and is a batch")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c | 2 +-
 block/blk-mq.c   | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fd389a16013c..c2d267b6f910 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1643,7 +1643,7 @@ void blk_flush_plug(struct blk_plug *plug, bool from_schedule)
 		flush_plug_callbacks(plug, from_schedule);
 	if (!rq_list_empty(plug->mq_list))
 		blk_mq_flush_plug_list(plug, from_schedule);
-	if (unlikely(!from_schedule && plug->cached_rq))
+	if (unlikely(!rq_list_empty(plug->cached_rq)))
 		blk_mq_free_plug_rqs(plug);
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c68aa0a332e1..5498454c2164 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -410,7 +410,10 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
 		tag_mask &= ~(1UL << i);
 		rq = blk_mq_rq_ctx_init(data, tags, tag, alloc_time_ns);
 		rq_list_add(data->cached_rq, rq);
+		nr++;
 	}
+	/* caller already holds a reference, add for remainder */
+	percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
 	data->nr_tags -= nr;
 
 	return rq_list_pop(data->cached_rq);
@@ -630,10 +633,8 @@ void blk_mq_free_plug_rqs(struct blk_plug *plug)
 {
 	struct request *rq;
 
-	while ((rq = rq_list_pop(&plug->cached_rq)) != NULL) {
-		percpu_ref_get(&rq->q->q_usage_counter);
+	while ((rq = rq_list_pop(&plug->cached_rq)) != NULL)
 		blk_mq_free_request(rq);
-	}
 }
 
 static void req_bio_endio(struct request *rq, struct bio *bio,
-- 
2.33.1

