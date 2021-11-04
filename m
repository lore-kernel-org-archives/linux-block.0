Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C68EC433EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 15:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC8161212
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 15:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhKDPYr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 11:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhKDPYq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 11:24:46 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B892C06127A
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 08:22:08 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id g25-20020a9d5f99000000b0055af3d227e8so4307770oti.11
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 08:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iUVdiKdE3UtLDrSJ4ppTvX/REgJOcEw5TGAopy8ZtZU=;
        b=kccblwzg65rRL04Ugsk+1EjsGLiLpBdM8SLVWBMIzUFRoJhrCot9E/TaXCFudQIwvN
         rY2PHdk0TrUm6EH1xuoZDlLUorAUGriZmcRd/eML5/7pBkjdNNvAT2+b5IOilcIWXkrB
         hiN9WdivxGuP1JE1t0Sky90i051BoCFU9GJrYLrjnBeMZvxTd4dNLRCdk0dK8qYmNfsb
         bNQ3jnq99QKtJmwWkytFXpc6JkP5WmEEXVKJbSwbp4ghi9ITfAWo+bobg7FtaDO4Plqy
         ib7nmHJ/yIQ3hz259R4rOvsrjoGpXOO6+dz0lx4/VjH4KIpESffU2HplAwAX8r27kd/6
         kYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iUVdiKdE3UtLDrSJ4ppTvX/REgJOcEw5TGAopy8ZtZU=;
        b=aYH/F6NFHpVvI4Lnc30mMZ/GA/NjANdHjXBEtjG2c0mvAgES3P7T4g8pVQj3OmjRiP
         8okK4E3zhGJRJqJbv1oXLDuk3MaQZEulSmo8J0/ey+os3SKjnbqlW8mEmPK+KLRd70m3
         nU2MU9dhAzvWyiKstmcAh50ul3ESdY/JBRkVsqf9VjzOyAwZWZwPR/6Gap2YioYWhILS
         NKS+rOCBTfZwz0Duf9MiFmIGWQYqFX3pKCcSu6fO4dVkZdyJEPVjAodajo9dCdppoOEw
         ZOFJXm8FGl9EANKeQ3yZmxQRyS9leqD8CaDT/PaUDaVYyPXTBLkU2QUdkQqg/Bsg3lV5
         UMfQ==
X-Gm-Message-State: AOAM533zEkCrUafTqtDwWBoCZYgQon4y7K1h4ZiVppCW9KqlUJAU0EXP
        lxhvi/fM4l4Pf5NxXSVl/RPsROLXV7RFlw==
X-Google-Smtp-Source: ABdhPJz9m2wnuF66QbIctGaR9q/02l3m2ULa7FUDUlJQ3O+mP89JzpA5mK9fUsruUhRK/sZMZTU+fQ==
X-Received: by 2002:a05:6830:2:: with SMTP id c2mr1939536otp.76.1636039327501;
        Thu, 04 Nov 2021 08:22:07 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k2sm1023925oiw.7.2021.11.04.08.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 08:22:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] block: have plug stored requests hold references to the queue
Date:   Thu,  4 Nov 2021 09:22:00 -0600
Message-Id: <20211104152204.57360-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211104152204.57360-1-axboe@kernel.dk>
References: <20211104152204.57360-1-axboe@kernel.dk>
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

