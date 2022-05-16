Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C18CC433EF
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 08:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiEPIl3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 04:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241870AbiEPIlG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 04:41:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF5710F2
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 01:41:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id bh5so1980191plb.6
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 01:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M0tCKoDzsPTdc59i5aDsXZipsRf0A5iHp7WUamBhVp0=;
        b=hp6/uhCc1vISll7TeQVh3UtY9N1H5PpJx964CmK3VKM2/cWxxbK9p36HVeUHT61Nc0
         dprPwhpblfcBwOKtiih1xvq5ACP1/nETYJ2IcJTNzWU1R3QaeiIigM9Aa7lpMt0su1SY
         SXNTjwZ8o4nYFEvhIFC6iGnMLKShkjX6dJgUGzYWDetNuoo69vqCGCWLSPqmG3yU/UpC
         ZBecOJb0vRZDna24r7Y2NrVNCINeqZZw7NMAKe1MpHvYv61jQwR9rf4iuNVgp5Zc7bZt
         dt8unfIFP58o5ciDcckvrKJAWmJ6k7hGG7dGcFe8JwyPpHqXPLpK+ns57b4z27tdTuax
         L4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M0tCKoDzsPTdc59i5aDsXZipsRf0A5iHp7WUamBhVp0=;
        b=wvO3MiSYJZ70nGt9Re90LdQAuiNXnu660wDq76TcVEnPr7U05Jj82UwZCzUTOsvSZ9
         S9vhAXN/VDtMxvPqiwt2JYo2b/KlFN1lm6N3IVbGA5c89uNU/MFLNEmQqv3NJcz8aa/S
         UA1zQFDBF2AwXPmvHZlA+VN57uGa3vooITB6vCBizkjJOnqAZ5HJLZgE6a+gy1KwurkZ
         eKlpsRddSLZmEpd0RIp4L5FEMtgZXZJDYW0qPASxr+MPgIcQH9ndq4xA/y/2+GyI65OX
         wHNo5dVgfOsxQyUTm8MLbpWdmOJwxVgHEx0s73DY3KjdjO0qrLeCEp+4lfvELoGeLKHt
         9VwQ==
X-Gm-Message-State: AOAM532IzK6nb/O6XQnLI/xg6mpT7fhMeU3rw/gOCNyGlNiB+U50VCQH
        YrUudnEPJ3EIErmm6yogVGoGDw==
X-Google-Smtp-Source: ABdhPJwsfheq9ax2SfLs9SSyrtzzkZ954A2+1dyAFeSwkGK4ND2OiKKuyQ3hvNB7yKwYvE95gD8+DA==
X-Received: by 2002:a17:90a:ec01:b0:1df:56aa:6b7b with SMTP id l1-20020a17090aec0100b001df56aa6b7bmr3847686pjy.230.1652690462892;
        Mon, 16 May 2022 01:41:02 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902968800b0015e8d4eb26bsm6398763plp.181.2022.05.16.01.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 01:41:02 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] blk-iocost: fix very large vtime when iocg activate
Date:   Mon, 16 May 2022 16:40:45 +0800
Message-Id: <20220516084045.96004-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When the first iocg activate after blk_iocost_init(), now->vnow
maybe smaller than ioc->margins.target, cause very large vtarget
since it's u64.

	vtarget = now->vnow - ioc->margins.target;
	atomic64_add(vtarget - vtime, &iocg->vtime);

Then the iocg's vtime will be very large too, larger than now->vnow.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-iocost.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 5019dff524a4..a2ee12175c49 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1248,7 +1248,7 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 {
 	struct ioc *ioc = iocg->ioc;
 	u64 last_period, cur_period;
-	u64 vtime, vtarget;
+	u64 vtime, vtarget = 0;
 	int i;
 
 	/*
@@ -1290,7 +1290,8 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 	 * Always start with the target budget. On deactivation, we throw away
 	 * anything above it.
 	 */
-	vtarget = now->vnow - ioc->margins.target;
+	if (now->vnow > ioc->margins.target)
+		vtarget = now->vnow - ioc->margins.target;
 	vtime = atomic64_read(&iocg->vtime);
 
 	atomic64_add(vtarget - vtime, &iocg->vtime);
-- 
2.36.1

