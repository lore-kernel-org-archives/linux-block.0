Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40E6C433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 22:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A4420823
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 22:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="defEXQ49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgESWQu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 18:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESWQt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 18:16:49 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5427AC061A0F
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 15:16:48 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w19so441583ply.11
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 15:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GRjxYibzlS4o3avg6p2vVkLA1+T3i5/MjrM9DLMxH+Q=;
        b=defEXQ49DqQO/7rYBm1mDgtJKGAlVzIFgD+4JsjyVSBd+pA46CbrTVkQNIJvkc7ysH
         w9buPS6isXFvPOa7FEWFO+yJBZbqmUPDBrLMVkmafSdoAhjvfn59RbRdRyKGV/kOoRjG
         d2TeH/4uGgplUMCIKDnoUmxW5fVrdi1k0fxViQyZT++xDMFvkdMugzvsQibsFYii407Y
         8E2Yt51ZtKw1sfnfpQVWrHj1H9305cATQ9rPcWCS//XzVfNRWXaCWP+aPbSbHiEeEOR7
         EVOu6cFAqwjF3LJWzJM4ju4be1CSpB0uJCUAEnhQJAFbspZtRqJ1kJeL3a3sK8XZIgBs
         zQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GRjxYibzlS4o3avg6p2vVkLA1+T3i5/MjrM9DLMxH+Q=;
        b=G+JPc+QSdX2jzXEWialXYnt2NQ26fdov/F8s3dKOcKWwHUOYBb7sC/QcdcuygA7Gou
         vEpml0D/qZn2sA+66CC5VReiQmVFf9Q/7p43fsKjf5DLaU0j1q9BnRpqlRjf/sACRNR0
         A0y2ndPE1+OjGSc2oOc//vBITx8Ppu0wa0xtw7qNzYzd0KhWH1UMD0lccMXnG67a10Sp
         Q2NCaiSUUkFtkHykjGqjjdUZQnUmoTkl4RGNN0myh10c5q99fFnbouhTPQLVa9lQlNuj
         I7tnfYbaYgtwF4fly/LG+mxmJl3AAabJXKBvgYIwpr65WQsOwbwCuUs6owkuqoyS/nZu
         6hRw==
X-Gm-Message-State: AOAM533dCPnny+p59U855mTbsx1fZun82V7STABoQsRHKnOENKGas750
        7vXxEOI0dL065ziHEUmldFS895lBXLU=
X-Google-Smtp-Source: ABdhPJxivJPwG+4s/YAmp27bWpjl0r+6h5JqOzFIEAgbsP6S4C3ZHaLnLhH5Rub6QYZlS/4dGiOHxg==
X-Received: by 2002:a17:902:c213:: with SMTP id 19mr1543735pll.190.1589926607367;
        Tue, 19 May 2020 15:16:47 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:14f4:acbd:a5d0:25ca? ([2605:e000:100e:8c61:14f4:acbd:a5d0:25ca])
        by smtp.gmail.com with ESMTPSA id v75sm412112pjb.35.2020.05.19.15.16.46
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 15:16:46 -0700 (PDT)
Subject: Fwd: [RFC 2/2] io_uring: mark REQ_NOWAIT for a non-mq queue as
 unspported
References: <1589925170-48687-3-git-send-email-bijan.mottahedeh@oracle.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
X-Forwarded-Message-Id: <1589925170-48687-3-git-send-email-bijan.mottahedeh@oracle.com>
Message-ID: <3503f837-0958-0a55-ab7b-d4f1c7131179@kernel.dk>
Date:   Tue, 19 May 2020 16:16:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589925170-48687-3-git-send-email-bijan.mottahedeh@oracle.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org




-------- Forwarded Message --------
Subject: [RFC 2/2] io_uring: mark REQ_NOWAIT for a non-mq queue as unspported
Date: Tue, 19 May 2020 14:52:50 -0700
From: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
To: axboe@kernel.dk
CC: io-uring@vger.kernel.org

Mark a REQ_NOWAIT request for a non-mq queue as unspported instead of
retryable since otherwise the io_uring layer will keep resubmitting
the request.

Signed-off-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
---
 block/blk-core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5847993..3807140 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -962,14 +962,10 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 	}
 
 	/*
-	 * Non-mq queues do not honor REQ_NOWAIT, so complete a bio
-	 * with BLK_STS_AGAIN status in order to catch -EAGAIN and
-	 * to give a chance to the caller to repeat request gracefully.
+	 * Non-mq queues do not honor REQ_NOWAIT, return -EOPNOTSUPP.
 	 */
-	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_mq(q)) {
-		status = BLK_STS_AGAIN;
-		goto end_io;
-	}
+	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_mq(q))
+		goto not_supported;
 
 	if (should_fail_bio(bio))
 		goto end_io;
-- 
1.8.3.1

