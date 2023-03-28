Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B88DC76196
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 14:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjC1O6l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjC1O6a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 10:58:30 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F601E1A1
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 07:58:06 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id kq3so11893928plb.13
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 07:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680015486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bq/FNHJyM6VL3GySeYH7whuNpSDOXfegBXORfrv0Wd0=;
        b=gjeUX9N/SZSVreSCgBBOw1Qw3SvaO9BulRKZFa9FyzIBnTyw04c02sekVQEgIM9rIX
         GBYeifm4ppvE4m2nrikaPAj3YSUKwne5xcZwXa1x08/SUo8pKH0jL/9uaE0YzjjJKWH5
         +IQ6UpCaQ0skcosDMsJ6DB9E/8AOPxqejhYko3LGCE/xwRl9jjGZFBWSzf7CHMnJW7Sn
         5ZvdrLMWzlSBrb1U6z1yXAtrL6G20+j5YfRsafiry3WpHRYLRKQnP/LZ1oBdlo9O0Xhm
         +eJLgX+JpPVZA045FloYbVpJecxawrYj1IP83C+8SMNjRfLs8X67VdNeK+gbWJkd6eu3
         qngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680015486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bq/FNHJyM6VL3GySeYH7whuNpSDOXfegBXORfrv0Wd0=;
        b=E3Gn/wXdTGoHjX+Zhs6JwGZ0rwsEi8mXaOZHWTafkEBNxw5D2j20m76EN5mWBiXyOD
         rFzlrHcV4MAr765aU+TqoKyls2wiMC3GR9elfE/BQwLI63EEK88xWS6mWW2RFT6xZWdH
         N48b6KrUb3OKir9Y3u2scD4HmASq36isghYBK6tgna+E2HYhmB2slgQcknEOp0FDb05y
         ZXTWK131SVs7UVhOucUwZdHeJaTWpeMVJXntBvbvMVA4Ed3HjfunNnnwQbz1dSbK6Qeb
         ceERoO26vAi1B4a4QF/74EfVLhfE/YGjkAh6kJP9g952pGGOPbU40ckD1IxyjhYrcJNW
         BlEQ==
X-Gm-Message-State: AAQBX9eOVtuW1e3/0Tn+Rrjua5due8AoeylmXiydiuywGQRMu0nQc1s3
        I5i3948fmqcdiDBPMPi4eP7ovA==
X-Google-Smtp-Source: AKy350bsOMKykidZMTfGdRua7QdjJGu0JUcqyIYnK51VJ3/7o6PSqWLvzcEq7eErON9tTEHI22gg3Q==
X-Received: by 2002:a17:90a:10d7:b0:234:f77:d6d2 with SMTP id b23-20020a17090a10d700b002340f77d6d2mr17046206pje.45.1680015485946;
        Tue, 28 Mar 2023 07:58:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e6d:5da0:f469:aa9c:494f:b32f])
        by smtp.gmail.com with ESMTPSA id nk13-20020a17090b194d00b0023b3179f0fcsm6382250pjb.6.2023.03.28.07.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:58:05 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org,
        josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 4/4] blk-cgroup: change BLKCG_MAX_POLS back to 5
Date:   Tue, 28 Mar 2023 22:57:01 +0800
Message-Id: <20230328145701.33699-4-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230328145701.33699-1-zhouchengming@bytedance.com>
References: <20230328145701.33699-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

BLKCG_MAX_POLS is changed from 5 to 6 when mq-deadline-cgroup introduced,
then commit 0f7839955114 ("Revert "block/mq-deadline: Add cgroup support"")
reverted it. So change BLKCG_MAX_POLS back to 5.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 941304f17492..398f288bcf30 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -54,7 +54,7 @@ extern struct class block_class;
  * Maximum number of blkcg policies allowed to be registered concurrently.
  * Defined here to simplify include dependency.
  */
-#define BLKCG_MAX_POLS		6
+#define BLKCG_MAX_POLS		5
 
 #define DISK_MAX_PARTS			256
 #define DISK_NAME_LEN			32
-- 
2.39.2

