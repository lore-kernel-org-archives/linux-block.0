Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBECC4167D
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 12:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbiERMr3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 08:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238341AbiERMrG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 08:47:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C251BB995
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 05:45:14 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id d15so3418513lfk.5
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 05:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=D6VKL5ciB5qVlcxfiIdVtP/GTWTB0JXjtarh7eRTsrU=;
        b=aR7mE1q73uoQ1uafhYBOMLD+9L8M15booDjDaYV140/M2J9doR/E8kYLXAR5Ke0fhZ
         ab02ZN9a4tLpuewD/NFrS/CC9xfmfeM6xHeWGW+PUoqUzc19OGuMNQYWdmyu4svaDyaq
         zSch4ZJXyVx3c24lm9Z3hav0OwA1q4/fMjFfib9clgkszQavo1CsgSrfjQQWUxnBQ+1n
         RlcgHcm99aO1b4BupqN9itIHbfV+20M0ycx5ZYWGcavrqHS8EmhjrYvj7XzsZSWn92ma
         gdhQpWCXQ4AK5CMY3p4fgn1IieEvCN2onYqQTg6FA/V7Ouc+Y6YVOP/gY3tIFoLaaBYk
         PN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=D6VKL5ciB5qVlcxfiIdVtP/GTWTB0JXjtarh7eRTsrU=;
        b=b2/GNFaeMQOs6jkB2Ob0gT9Jnesg0zui2daTON+98NslZ6imQVkxeL76nesrWE/z2V
         mX0WXo/b/RLpLMsOjtr3qD8MRNZL6a3w5Of52tVNKHmnnHDNWBwqCHFQZEO7gRDkfrjq
         FZt1BLJByFzshhKZcye5ITjzLfSBL41RMik6FF/c7FL5+S5SkprvMoTHFNmXNhQmXUfk
         BteDjcwbgz+xijGy4vnarYj5Cn2p/KyEbXWftTRZhPrng2ubaeEKcJoFc0+STFh1HpC7
         3FEOWizdCve5ITFe/8NpINj7NayuS4FxHxkN3HmqzLOsJBK+0ByEHLRR3hFrn0vuyL7Z
         NG7w==
X-Gm-Message-State: AOAM533x1vxGf6z6+wAGUFlZwOXB298vtYNwbJo4STtgbpl6YE/eahwv
        4sTwFR+FitoA4vEC8AwPC0xjQg==
X-Google-Smtp-Source: ABdhPJwwYOBAgpRd3PASBWocwl1ypfsAC1FFNAn1yCuNzTy2jNWH6EZ1NCYObMisAE1U6wEDStVZ1g==
X-Received: by 2002:a19:f24e:0:b0:471:c076:bfb9 with SMTP id d14-20020a19f24e000000b00471c076bfb9mr20636965lfk.442.1652877911489;
        Wed, 18 May 2022 05:45:11 -0700 (PDT)
Received: from [192.168.43.196] ([185.174.128.243])
        by smtp.gmail.com with ESMTPSA id v12-20020a2e990c000000b0024f3d1daed0sm205603lji.88.2022.05.18.05.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 05:45:11 -0700 (PDT)
Message-ID: <55475ea9-5f6c-fa19-b52d-93fb89209850@openvz.org>
Date:   Wed, 18 May 2022 15:45:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH v2] blk-mq: fix incorrect blk_status_t casts
To:     Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <YoH0/2FBC2YS9kk5@infradead.org>
Content-Language: en-US
In-Reply-To: <YoH0/2FBC2YS9kk5@infradead.org>
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

blk_status_t type is bitwaise and requires __force for any casts.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
v2: introduced request_blk_status_en/decode helpers
	thanks Christoph Hellwig for the hint
---
 block/blk-mq.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 84d749511f55..8f067b021af3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1151,6 +1151,16 @@ void blk_mq_start_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_start_request);
 
+static void *request_blk_status_encode(blk_status_t status)
+{
+	return (void *)(__force uintptr_t)status;
+}
+
+static blk_status_t request_blk_status_decode(void *ptr)
+{
+	return (__force blk_status_t)(uintptr_t)ptr;
+}
+
 /**
  * blk_end_sync_rq - executes a completion event on a request
  * @rq: request to complete
@@ -1160,7 +1170,7 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
 {
 	struct completion *waiting = rq->end_io_data;
 
-	rq->end_io_data = (void *)(uintptr_t)error;
+	rq->end_io_data = request_blk_status_encode(error);
 
 	/*
 	 * complete last, if this is a stack request the process (and thus
@@ -1228,6 +1238,7 @@ static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
  *    for execution and wait for completion.
  * Return: The blk_status_t result provided to blk_mq_end_request().
  */
+
 blk_status_t blk_execute_rq(struct request *rq, bool at_head)
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
@@ -1248,7 +1259,7 @@ blk_status_t blk_execute_rq(struct request *rq, bool at_head)
 	else
 		wait_for_completion_io(&wait);
 
-	return (blk_status_t)(uintptr_t)rq->end_io_data;
+	return request_blk_status_decode(rq->end_io_data);
 }
 EXPORT_SYMBOL(blk_execute_rq);
 
-- 
2.31.1

