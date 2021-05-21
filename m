Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904D3C433ED
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 06:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE5D613BB
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 06:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhEUGKE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 02:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhEUGIw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 02:08:52 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68E5C061574;
        Thu, 20 May 2021 23:07:28 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 27so12122442pgy.3;
        Thu, 20 May 2021 23:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PUAwe7z2INATtYcfD83zTSIPkMgwdGGQMjVc8v5Lil4=;
        b=WIbeOp4S2aqnx4XsSExMR+dhKwalXxtFGvkfdu9TP7GFr7HfpPiOX9mp4ayJsOaC9K
         pbbmAfEqyS5O0HA7iYuAv0TX7t26duCviI5+HoRXt4xv7NXTndzUSZUoRz+hqOSQAQeq
         q2cHFud4EunrkRR6DmcYUGui8T1uUwPauaKvlSviEsBpb+bFQ3OOzoRKFZrFggf6IlVC
         Ucymo/DqssqIac9ss/s6Gwac2FAndz+3NfotVOeld6pI0osV/+rjj0gsjOdOhOJAa7Oh
         bsp0WOPasLsPSXmIyrIaWRxALrAksgp7DkG7m2gLovpHmsXz0L2gwoAyg0PNV45RzAmz
         0+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PUAwe7z2INATtYcfD83zTSIPkMgwdGGQMjVc8v5Lil4=;
        b=JhteJEpE8YDi3pcnDZ8yH71ua1+Zd5y5x6EHqXbv/y9AXcICzzb+buL1uWjhFUo5zv
         cOie0jol++awZfjDMK2A57GBJxJfQjTSeN21KE63YxRclyRE1JmVagHfLGyQFjif0dNB
         uaI85jCnbv27ExljDoQSGqwbn8rzL9YSktk9avGhHGasIVfHMk0K9q+xZnR3ctMJUC4N
         +q/PEKn+8kLc5sE2mbShhQLTynmKJqYx5B+4Db9RYoF7liskfurN7Y6rsGES/WqFJuFH
         jUjh4nwTpvbjVIXWDqHovzQWZwo284Yv9sUBZyXmUnVabGkxy2rU7a2Wmig8LIiG5Y7q
         Rzaw==
X-Gm-Message-State: AOAM533vaOyoLA/O1s4R+sT4KnB1vRVYqiFPOkPs4qy+/3PQRQ6Q1P7c
        3KBNAUI4vDCZR3VaGTtX7+k=
X-Google-Smtp-Source: ABdhPJz+LBV3lvzMoJzg1w1HatzdXU+k4aTYpDNH8M9egmVDm51nbSxFuavyvTtVOx1HL1IaZe8F/Q==
X-Received: by 2002:a63:cd01:: with SMTP id i1mr5347208pgg.294.1621577248395;
        Thu, 20 May 2021 23:07:28 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id n21sm3563793pfu.99.2021.05.20.23.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 23:07:28 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH][RESEND] zram: move backing_dev under macro CONFIG_ZRAM_WRITEBACK
Date:   Fri, 21 May 2021 14:05:44 +0800
Message-Id: <20210521060544.2385-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

backing_dev is never used when not enable CONFIG_ZRAM_WRITEBACK and
it's introduced from writeback feature. So it's needless also affect
readability in that case.

Signed-off-by: Yue Hu <huyue2@yulong.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 419a7e8..6e73dc3 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -113,8 +113,8 @@ struct zram {
 	 * zram is claimed so open request will be failed
 	 */
 	bool claim; /* Protected by bdev->bd_mutex */
-	struct file *backing_dev;
 #ifdef CONFIG_ZRAM_WRITEBACK
+	struct file *backing_dev;
 	spinlock_t wb_limit_lock;
 	bool wb_limit_enable;
 	u64 bd_wb_limit;
-- 
1.9.1

