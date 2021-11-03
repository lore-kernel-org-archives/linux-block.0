Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80553C43217
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 18:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A70661076
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 18:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhKCSfF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 14:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhKCSfF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 14:35:05 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C561C061714
        for <linux-block@vger.kernel.org>; Wed,  3 Nov 2021 11:32:28 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id y11so5057617oih.7
        for <linux-block@vger.kernel.org>; Wed, 03 Nov 2021 11:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nx4YNyDIu1laRmWmTqB2WvSefHm+x/QcfSPBrmlNO+I=;
        b=Le/mfW/wLjpuLrGyo/O58PZCIPoV/sSGJqqGmpEaCZSMhJxGlJyfhyw/+rPdLXMpAJ
         ezjuWA9Dg5AIhHss61ysnG9O61eCHXhCeF8iM4RZugpDTyFfbICs9rnjPNeU5yd0RgZJ
         q7siGBlAUK2MvAS0tm3q6Jee4IYBzZCf1R4kjsl9kXyz2c2c7zBot2CJ0ai0EBBb4Jny
         0m9t7NBuj1ZIkjAQisz/Fv/7qOpDkMdTyHTs5U7pbUua735KAV31yL2ONkF3EMZCYpKq
         vIMdYUB1TG5tueBmeOlTZb3hE+k7yl4luD6svgEkWSY0g7rfLIENxvOmn9srww/IFK9o
         gxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nx4YNyDIu1laRmWmTqB2WvSefHm+x/QcfSPBrmlNO+I=;
        b=6aaRYlKq2AwbZeoH3O9K2FHE+fOkL6cXjsmSMdSoH6UD038L5U+XvjXwWaIiZ0QiNJ
         cO1aZS+yR67HdeXK5NrYl/oj1MzBaHUBQA/kFpJbrceDXNPVyhEfdMNynSUWuGSNqQcw
         iSwwklQZ6m/QJ2LQOnXO+8D3eP6qKT9M6voFcNuV8tBTcbqjjdPjP73PaxHNe2gzj+vt
         PuBGgJ3W3eqxWuwW51rCSi1YlGfLVTs7VKGOJAtZLwVp80llCIcftKs6GkSHpxRqhb/r
         +qV7kzkmITtTLBtQ/UhUN9sCyFp1X0NhFPA9R5evF/EXnuLaRCuDJesJeWZzEGkBV3Hz
         5I5g==
X-Gm-Message-State: AOAM5339mM9rSlfTliaySln6w7xrjP5crK1lDatpEhIXRXQ0MeyWkBKS
        p138pJtxeqkuiP4hzSzb0hLtQxfBtAeNgg==
X-Google-Smtp-Source: ABdhPJzwDxkdLwltU8R8tjTKIyJuWHmBJhHULNIyMZpF9fBjF+p5+aWdeWaKyX37rpUFkdjEJ8T+/w==
X-Received: by 2002:a05:6808:18a7:: with SMTP id bi39mr12090676oib.136.1635964347483;
        Wed, 03 Nov 2021 11:32:27 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i20sm766056otp.18.2021.11.03.11.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 11:32:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] block: move plug rq alloc into helper and ensure queue match
Date:   Wed,  3 Nov 2021 12:32:22 -0600
Message-Id: <20211103183222.180268-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211103183222.180268-1-axboe@kernel.dk>
References: <20211103183222.180268-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We need to improve the logic here a bit, most importantly ensuring that
the request matches the current queue. If it doesn't, we cannot use it
and must fallback to normal request alloc.

Fixes: 47c122e35d7e ("block: pre-allocate requests if plug is started and is a batch")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4bc98c7264fa..e92c36f2326a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2485,6 +2485,24 @@ static inline bool blk_mq_queue_enter(struct request_queue *q, struct bio *bio)
 	return true;
 }
 
+static inline struct request *blk_get_plug_request(struct request_queue *q,
+						   struct blk_plug *plug,
+						   struct bio *bio)
+{
+	struct request *rq;
+
+	if (plug && !rq_list_empty(plug->cached_rq)) {
+		rq = rq_list_peek(&plug->cached_rq);
+		if (rq->q == q) {
+			rq_qos_throttle(q, bio);
+			plug->cached_rq = rq_list_next(rq);
+			INIT_LIST_HEAD(&rq->queuelist);
+			return rq;
+		}
+	}
+	return NULL;
+}
+
 /**
  * blk_mq_submit_bio - Create and send a request to block device.
  * @bio: Bio pointer.
@@ -2523,11 +2541,8 @@ void blk_mq_submit_bio(struct bio *bio)
 	}
 
 	plug = blk_mq_plug(q, bio);
-	if (plug && plug->cached_rq) {
-		rq = rq_list_pop(&plug->cached_rq);
-		INIT_LIST_HEAD(&rq->queuelist);
-		rq_qos_throttle(q, bio);
-	} else {
+	rq = blk_get_plug_request(q, plug, bio);
+	if (!rq) {
 		struct blk_mq_alloc_data data = {
 			.q		= q,
 			.nr_tags	= 1,
-- 
2.33.1

