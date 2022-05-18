Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF957C433F5
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 22:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiERWfK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 18:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiERWfK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 18:35:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0EA222402
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 15:35:09 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id u15so3407843pfi.3
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 15:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:cc:content-transfer-encoding;
        bh=k9cQgQ/4PPxdgUX3m8X5yYRNvrvQyApnNUSKZ4xFRTY=;
        b=i5ccwAc3oJONdArQLxuN71Db/IdWKOKW1ECIMOIkCDRL6v4omMw/UHUSWKMVUTbTyR
         SI0GppHbTr8bjJNlDaiYjh5fWW+URRTDMwaUmYRA4GonR30F+H/XgJWIYFdfxcaMAZVt
         h97r7EpFy9Ysj7X0vjm6Z8uTqOI3/AE+jf7tHLwftx90IuQQfKkL4/aQ6IWdDEM2SilO
         LSpQ8Huxk0Wkq6UZ3G1ZwB9KW92y/xyFLnhRWK4bBGacqXgZTq8yyGlsArYiBRw0nrOd
         3UW7GPc0FQhZYkwtJeJI5dWO44uWJwBEaIGqGdwyskKiXWwyrDp0nmoxuxAhORvT08E8
         LDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:cc:content-transfer-encoding;
        bh=k9cQgQ/4PPxdgUX3m8X5yYRNvrvQyApnNUSKZ4xFRTY=;
        b=cOWBebej8xUeAElrQmlJ83f2L5GLBszHkwGQEm01yEEq3TBLd/GoGUhpOVt4iGGeAp
         AwaWFZKSy7QtxrPEEgs47xtQx0yBrdwU3zF0QFFC0nP9oyetrKfeq3zPIsmizZ7KhSlf
         XWTfw7GOU5rMFJyiNH9yxhw4KOMLKPj6d9TINflAx/K+k1we/Xg0reOjmZTMJ7GyVdp+
         z9gtdDc4SjBtN8nKJV5Tm4OYTGw4YXoOIJLDRxLVq9/YPZXky87Q2+bIZmihqpN3xgoO
         9ZIqV143CauO+VY1zRqwZcoZ1hVneltrzGKN3eecRg1ak8YxDVyGh63vBpBV519NbO5G
         XDpA==
X-Gm-Message-State: AOAM531dDuNtK5juxSUiSqVCRliToBz0KNj71vKVtgC2pkcs0o+RixJL
        NjaA4qG8GPZNZuwRoCLR8PtU26su/wP45g==
X-Google-Smtp-Source: ABdhPJxLWywGdFxNglKdJPEoC+UMjkaNHYWAaUcuQUdlmeRUabPIBeZ97i1hIOOdllgaaXfGIeLPfg==
X-Received: by 2002:a63:5824:0:b0:3db:65eb:8e2f with SMTP id m36-20020a635824000000b003db65eb8e2fmr1337672pgb.349.1652913308730;
        Wed, 18 May 2022 15:35:08 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h20-20020aa786d4000000b0050dc762814fsm2491429pfo.41.2022.05.18.15.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 15:35:08 -0700 (PDT)
Message-ID: <52f2c742-9e64-63b0-25c3-8052f7e85883@kernel.dk>
Date:   Wed, 18 May 2022 16:35:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blk-cgroup: delete rcu_read_lock_held() WARN_ON_ONCE()
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A previous commit got rid of unnecessary rcu_read_lock() inside the
IRQ disabling queue_lock, but this debug statement was left. It's now
firing since we are indeed not inside a RCU read lock, but we don't
need to be as we're still preempt safe.

Get rid of the check, as we have a lockdep assert for holding the
queue lock right after it anyway.

Link: https://lore.kernel.org/linux-block/46253c48-81cb-0787-20ad-9133afdd9e21@samsung.com/
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 77c570a1ea85 ("blk-cgroup: Remove unnecessary rcu_read_lock/unlock()")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0676cf7a41b5..40161a3f68d0 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -298,7 +298,6 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 	struct blkcg_gq *blkg;
 	int i, ret;
 
-	WARN_ON_ONCE(!rcu_read_lock_held());
 	lockdep_assert_held(&q->queue_lock);
 
 	/* request_queue is dying, do not create/recreate a blkg */

-- 
Jens Axboe

