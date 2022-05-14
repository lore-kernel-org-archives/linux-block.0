Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C656FC433F5
	for <linux-block@archiver.kernel.org>; Sat, 14 May 2022 10:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiENKEt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 May 2022 06:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiENKEm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 May 2022 06:04:42 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D25BCA1
        for <linux-block@vger.kernel.org>; Sat, 14 May 2022 03:03:58 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y32so18283656lfa.6
        for <linux-block@vger.kernel.org>; Sat, 14 May 2022 03:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=xfGH7d9M+x2+711lYJq6dNzhfL2xV2ypgN6UlY8zPuQ=;
        b=tVDgUvtEZbtsXq0yASPJBk44tkyY3+TX3n57eSI26CosMagiGXhU+FPPcqQsjOvRUQ
         ztsoDFZnbqnod5BVopH6Q7dBP0zinWsyK4mmoWjlP4y4xaJonfG5MBAD7FvKliHVmY7W
         VFAgt54Yk8KNDKvgH4mUAJYs2koXdnlkZQ2CZhM4Gz4UjuSdSBiXP+qghzozHbcIICke
         MquSG9kOABaHxI/LoWUbzXi0I7O7TTgjyU9c6QRzYvEyQCuvILl7dzyMorL1cWfd3vGV
         L/CtxXXE5R4AFeLQlXbe4Ojv/n8nXkc236It6i8cNyIdYPNxuYI6zmKT6QbE6jwkLIRg
         +TPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=xfGH7d9M+x2+711lYJq6dNzhfL2xV2ypgN6UlY8zPuQ=;
        b=LzIclcehK4gBPC9piG8Attl1nK1UtiSVY7hYz2q8GF2JnU/45eGj+njNIDBJwjmTU3
         FlDQBrqu3UYnjdszW2ZwjHPRbIs9pkB9wy7KsH+cNziuC7ta80kra7DxPKjgJ8mRuuEb
         0ev9IC4s4TQUXoBao1tTeKVENiKVE1Bws2jBjNMF7UJ8JwwkzLbtk1WAN6Z1H0ukxJKN
         OGXamo8XfJiCGQSutZxcmJoYIPVxoz1GV867D68ZbgsOS9JzlH7qL0lS8wLO8G2+ExH0
         W3Yr2db+XV8zUHtbeAO6hekBJGM9fxaf9aCsCOH7Hks0vQUVfxHtukzLx+aJg+ZfsuAi
         zVKw==
X-Gm-Message-State: AOAM530VpmUfOdZ3c+YgbhGAm8beUtOjGpALZZjB8YXTjhrR1I6XkZLI
        3BS5BcsoACSMjcE0OhC1Y+KKBg==
X-Google-Smtp-Source: ABdhPJzcfsV/VSVjA3O7pbqjXkFndQmlTxNXJgNFfOjrmU6QKPUnekYizK14EWFd7jvQSY6P0CUHig==
X-Received: by 2002:a05:6512:33a7:b0:472:481b:9d6c with SMTP id i7-20020a05651233a700b00472481b9d6cmr6344386lfg.451.1652522636409;
        Sat, 14 May 2022 03:03:56 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id d20-20020a2e3314000000b0024f3d1daeacsm789123ljc.52.2022.05.14.03.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 03:03:56 -0700 (PDT)
Message-ID: <e3251f58-fd47-9b94-387b-ab641a773dd7@openvz.org>
Date:   Sat, 14 May 2022 13:03:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH] blk-mq: use force attribute for blk_status_t casts
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fixes sparse warnings:
block/blk-mq.c:1163:36: sparse:
 warning: cast from restricted blk_status_t
block/blk-mq.c:1251:17: sparse:
 warning: cast to restricted blk_status_t

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 84d749511f55..1b887f2d4a19 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1160,7 +1160,7 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
 {
 	struct completion *waiting = rq->end_io_data;
 
-	rq->end_io_data = (void *)(uintptr_t)error;
+	rq->end_io_data = (void *)(__force uintptr_t)error;
 
 	/*
 	 * complete last, if this is a stack request the process (and thus
@@ -1248,7 +1248,7 @@ blk_status_t blk_execute_rq(struct request *rq, bool at_head)
 	else
 		wait_for_completion_io(&wait);
 
-	return (blk_status_t)(uintptr_t)rq->end_io_data;
+	return (__force blk_status_t)(uintptr_t)rq->end_io_data;
 }
 EXPORT_SYMBOL(blk_execute_rq);
 
-- 
2.31.1

