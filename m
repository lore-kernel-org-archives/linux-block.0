Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AB4C433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 15:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D428D60524
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 15:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhKDPYu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 11:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbhKDPYu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 11:24:50 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E86DC061203
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 08:22:12 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id q33-20020a056830442100b0055abeab1e9aso8736914otv.7
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 08:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DI5RGovHvXsvejaQeBjVs1yIv5LWjweBXdeDbGeQoXs=;
        b=YtHStLiZIXA+aSQqJwEyN7s8T6iQF8j1dnoU3chJIb3sCcrhSf3C5BCIm30JNTx0IJ
         TOb9IbbW7brRLk8rrZlRYdqCQF8ZA/y0UcTJzOHbGyorK44U/HXTD+BiQxLxART7OYVN
         KZcBvbft6NSA6MMmHuAyb3i/4arqFclZPIVJC8qHKan9qrNqbzvuIZ+bwAYKBwKnnOjU
         FczyYQ7Ukf3gCTqvPkPrqKn7wuUi8BlvEI1RgxTZvg0KyIPBHfZGt8MMcWfNOkDTaMC5
         NVw2os3q7TaRpsi7vnN+ueY7cKQaWZhK3XtUGEpOpuiFh0DxmdewXuxxCkxNKlE6vxzJ
         F4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DI5RGovHvXsvejaQeBjVs1yIv5LWjweBXdeDbGeQoXs=;
        b=tDv2X4cvXTat9MwQaSPPInLsjpkxH8rNX8BWwBbCHLJl7zTTNyOvu728CKmSjooQKf
         mn1Jq4EEGKD1NS54B1Rxlw8MVvTrLpGjWyK0d9MK6qwbrEcmm+poyf6iEH58QIm7Y9wr
         14x4f2GXJJwOm8yDjVZb426erHZkdxvFy7+0Hl7BwS6571cqP3e97gntaKwmoDDIF4Gy
         tcyDYCCtBFZOyOkyOcSxjhkiGjhvOkx19tY8QsbIE7l8J8VD0BYQ+mytJTUpipyK9u8s
         Kn1u0DEn9pXeG3H+s8RMJi1xl9/X1d0ZnX1etLdbBDTOs4DCtgvRZSnVpEhs0rRLLJck
         4k7Q==
X-Gm-Message-State: AOAM531uFoaNMiqiHyR7QGQUqtAZ6nYlymcR/9u/gLO3Sqj/AmQV5eye
        cEcqzKzk0/oZmdigXiOQJj6zCklrxGWuuQ==
X-Google-Smtp-Source: ABdhPJxR0AkLx5UQ7ZbcbRiqZIpnnlqzt9+BrJugq+bikXEqVPonPxo8xy67FdlAs5McDR1uoUksUg==
X-Received: by 2002:a05:6830:3484:: with SMTP id c4mr22282628otu.254.1636039331343;
        Thu, 04 Nov 2021 08:22:11 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k2sm1023925oiw.7.2021.11.04.08.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 08:22:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/5] block: ensure cached plug request matches the current queue
Date:   Thu,  4 Nov 2021 09:22:04 -0600
Message-Id: <20211104152204.57360-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211104152204.57360-1-axboe@kernel.dk>
References: <20211104152204.57360-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we're driving multiple devices, we could have pre-populated the cache
for a different device. Ensure that the empty request matches the current
queue.

Fixes: 47c122e35d7e ("block: pre-allocate requests if plug is started and is a batch")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b0c0eac43eef..e9397bcdd90c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2487,7 +2487,7 @@ static inline struct request *blk_get_plug_request(struct request_queue *q,
 	if (!plug)
 		return NULL;
 	rq = rq_list_peek(&plug->cached_rq);
-	if (!rq)
+	if (!rq || rq->q != q)
 		return NULL;
 	if (unlikely(!submit_bio_checks(bio)))
 		return ERR_PTR(-EIO);
-- 
2.33.1

