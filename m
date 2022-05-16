Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF9EC433F5
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 10:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiEPKT1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 06:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiEPKTX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 06:19:23 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDB3DEBF
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 03:19:20 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 202so13641378pgc.9
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 03:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bW4la66s2/2Qkl9P/hRh2ka24n+8uceXtWH8mz/xliY=;
        b=DlU+GBh2MfUhs6P6NuaPTzAk6CnKaIU25rlLqVbf9TmS7k560BONygkGBXfcGN1PWU
         kiWPLIo6SQsYDD9On2cXonZktr/+RT+wBt2rKAprhyW7b7JO0f9jLHo8Y35iiL75zySQ
         31HspQ7f9eOwvYMS1wd6418OCzJQpRKB3vJ72yz3UtDzYQBxdCBKlEQ0khnRe4FG++HD
         HzOGGsKQlLaNL2OKEXI0D7D9rOJywmDc+GcsAtJFxyjnOSe407rX9Vl7B/qbaWWEabVZ
         JI7sAX2aZN6LE7qPplxJztRNY87BGCg+GRukXatvKdLUfrl+II7xje4xZdHa6WFcWtK3
         QZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bW4la66s2/2Qkl9P/hRh2ka24n+8uceXtWH8mz/xliY=;
        b=MdSd8ehseSkDHTZ4QtNXa/tuwWHOtuOxYFo9mzxkk0uEiSAFpmkEYtppP5RBA6HWFX
         rCJDXtrbejiaQiX3By0PUePA5xnU8/VD3fD3TcJCPX7MmXWP6yyGxLpsEzecAjcRz5Eg
         iuq5HWuQ+tG3DDyHK4wxcNiqdvARqz6tUHhzvSvzrL8tOqD7TMfz+qo9J4tE1Qf+JAOK
         Cd34Ou9iFWSEWJO1yV1Kc5Demrw2qWHHxwVQHfXDAYMB8CcF9zNavHHmbr+Yf8F5uJ+r
         YXGhbU12uPNu0Vaza77sEmm017tIFWGL9WQmpgKAofZH2NTte9tXEYWpYhUITPgvlOMh
         hWHQ==
X-Gm-Message-State: AOAM533/wlVmgtZsHzK5Rn0R7rI7sq2kqWfyuNOW6VpFG8R3B/SYNVz4
        qovXiG4V8yE7FgOAU9XAYC+KSQ==
X-Google-Smtp-Source: ABdhPJwIkvqG1MyMUXgY2WtuJDubBjCrD5lZ9usKKsCWanfaWY6veeD8QGmqb1vDcZJoENug8S59rg==
X-Received: by 2002:a63:2b05:0:b0:3c2:3ed1:5fa9 with SMTP id r5-20020a632b05000000b003c23ed15fa9mr14676453pgr.220.1652696359590;
        Mon, 16 May 2022 03:19:19 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902820e00b0015e8d4eb1efsm2509699pln.57.2022.05.16.03.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 03:19:19 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] blk-iocos: fix inuse clamp when iocg deactivate or free
Date:   Mon, 16 May 2022 18:19:09 +0800
Message-Id: <20220516101909.99768-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For an active leaf node, its inuse shouldn't be zero or exceed
its active, but it's not true when deactivate idle iocg or delete
iocg in ioc_pd_free().

Although inuse of 1 is very small, it could cause noticeable hwi
decrease in the long running server. So we'd better fix it.

And check iocg->child_active_sum is enough for inner iocg, remove
the needless list_empty check by the way.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-iocost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 2570732b92d1..84374ebcc402 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1073,11 +1073,11 @@ static void __propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse,
 	 * @active. An active internal node's inuse is solely determined by the
 	 * inuse to active ratio of its children regardless of @inuse.
 	 */
-	if (list_empty(&iocg->active_list) && iocg->child_active_sum) {
+	if (iocg->child_active_sum) {
 		inuse = DIV64_U64_ROUND_UP(active * iocg->child_inuse_sum,
 					   iocg->child_active_sum);
 	} else {
-		inuse = clamp_t(u32, inuse, 1, active);
+		inuse = clamp_t(u32, inuse, 0, active);
 	}
 
 	iocg->last_inuse = iocg->inuse;
-- 
2.36.1

