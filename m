Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25D7C433FE
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D046120F
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhKDSYv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbhKDSYu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 14:24:50 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E41C061203
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 11:22:11 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id t21-20020a9d7295000000b0055bf1807972so1358716otj.8
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 11:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oJ3n0rjsJvhWnuw+0JLUeNScZ7C6Wkhj6J3VNVvA4C4=;
        b=oAqWIoF3rKeKCB6HwjXUYSP9DgVG2Fd37it9G0gybglTJIZsngMuvuTU2kSKhpDj8E
         8BvzG2eiIKYjnREN5IZjqfc0i5UsOxNtI8FwKb1zvKrPSSAF9bourQnta/oVHRCdZQg3
         4ISc2yrqMnt8SKbFEneYHvad0uHzESGJqIbbtQAAXtKKkE/6ZNAqDFbAomjbh3a6q9nQ
         nb8tA/3gCKkpRyYCZllGcj2qlRgRBsc96Xcw1CeYHbjzrTmm0aSuZ4jzd3qe7RVAM/MT
         9P4ueXmLzju4FMixXzuFPz9+lGYc0+QzX2td2Oaz7JGPN3Qlyz/JYx0GvMuDzpkITbtN
         /leQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oJ3n0rjsJvhWnuw+0JLUeNScZ7C6Wkhj6J3VNVvA4C4=;
        b=gslpJBVHN9ICTZ9z3bu1ko1u/ifPieoRmTXB40qPw2+CJVq0GJ9GJeA0+4xIK5tVV1
         ECGqqh+Bn3fjqvs69j66aBLVXYRaeS0Hr0AWTtgtcA1YYnlijgNP6dXRBVSrQqyrrlqj
         4zkvYxVuaWPI4iYid64EMdstGO4LFfpbN9pirIr6S4k63dkKhvqkhgzQfkRDTlf6Cx5P
         1Bvd4BJtkEjV3gHwTSdx0eaG1C7Fo0fFcSQe+KRK9deghINUTisW8SZO8FZyy8qVBfR8
         6xRLZZmapJBIQobdN2dbfz1iAo/r07wNlIFrsFbaopgs4aUiCLyNCnGWjYKqH9MW3LBQ
         g0JA==
X-Gm-Message-State: AOAM530qNsjaVncgkRTw3xs9NxtJe66I/EO2R69b+Tm6VhjbCFX5yYMr
        WsuomdRCZaBUjxmPMk6K7ZZ1X0Iyqnx+lA==
X-Google-Smtp-Source: ABdhPJxdKVQYLrczSFjMIJ8nO7qToxTsdJy191UhBHDEwSVvPVAVYBYNkNURZdB8Qth+iSjOkPK/AA==
X-Received: by 2002:a05:6830:2690:: with SMTP id l16mr21601988otu.184.1636050131048;
        Thu, 04 Nov 2021 11:22:11 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s206sm1595445oia.33.2021.11.04.11.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 11:22:10 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@infradead.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/5] block: ensure cached plug request matches the current queue
Date:   Thu,  4 Nov 2021 12:22:01 -0600
Message-Id: <20211104182201.83906-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211104182201.83906-1-axboe@kernel.dk>
References: <20211104182201.83906-1-axboe@kernel.dk>
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
index 875bd0c04409..6c8d02bd1b06 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2529,7 +2529,7 @@ static inline struct request *blk_mq_get_request(struct request_queue *q,
 		struct request *rq;
 
 		rq = rq_list_peek(&plug->cached_rq);
-		if (rq) {
+		if (rq && rq->q == q) {
 			if (unlikely(!submit_bio_checks(bio)))
 				return NULL;
 			plug->cached_rq = rq_list_next(rq);
-- 
2.33.1

