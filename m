Return-Path: <SRS0=LW4I=4O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE4FC4BA0A
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 08:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE80821556
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 08:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3S1VY0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgBZIce (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:32:34 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38050 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgBZIce (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Feb 2020 03:32:34 -0500
Received: by mail-pj1-f68.google.com with SMTP id j17so973665pjz.3;
        Wed, 26 Feb 2020 00:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HKTxLuQ5nhjrOrx+Thx+BTX7TOSnSPBtMS3eSGVhkfc=;
        b=d3S1VY0cTXS2OKbI9CvTey2rVo473E0hs5wSs/r1y02/t+fCWs7V3EsfN26mbmQahv
         36Qy3jmj4YAAqUO44HPvYwaMGb8EuChtKQXY2RuG76odOZMssHtE7+u2WPNujMXyo0I+
         /vXVEThOBTyCXeYVIpgkAkc88R9AmluILKFbb1kuTlC3YnsFm01qmGTDsYkyG99rb7lT
         cbk1PoL0AfD2/kSyW8SwxcoQOx7TJ5KMxrHAE9yZDPRFSOz1p5nX6Kpf7I1pQP/qF1Yf
         N8pU/DEnAQXVyLLID2Sq2vrysUVAiqKMFnk24iZOAb/ZcD+ATXADs0FdTbOcqpQRw3GB
         XC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HKTxLuQ5nhjrOrx+Thx+BTX7TOSnSPBtMS3eSGVhkfc=;
        b=On/S6zNLZ93HxhJHuZnAmw1lY9KZMOWZdHPZuu9PD3Q1LVO8csxVhREbTkEU242b9U
         JSIOukLmkLgX8EjlsRqWxzT1pQK0zQVfxrUqgBQwn+aR9Dm3xG8DlMLracg8QUJNWHoq
         cHNHCi8KzlffLQPhHsOVZSuQqsuXfE8Fr88Nqyg5qai9+X1MMwc9K+gFjt0tnN/CDbA2
         UhhF4WDYbLvVAUVpN8e4qbH0MHkraRP0nkin/agCRvV11IvnN4sAOIE4zc/zVVfY22Kt
         u4olpj6FdZn6GPfYpfuoxqEg88mVa5C2cyO4+66j3IXkj+EjrYVcEy/IO0IeFokSPLS6
         034A==
X-Gm-Message-State: APjAAAX+CzzJyH95zhwMGG/wwpcjAL4AO+V/t2NKno+D2gATV7fthjVN
        nwjm06avSUB9oIw4xDECQG8=
X-Google-Smtp-Source: APXvYqygpuTaPFxu1B1czsjQ7Sq15hOZyc1nKhJ4FyNSYTbL7NwBkX7D374bnrLlaIiSbkRGXfYPFw==
X-Received: by 2002:a17:90a:9284:: with SMTP id n4mr3756979pjo.69.1582705952985;
        Wed, 26 Feb 2020 00:32:32 -0800 (PST)
Received: from huyue2.ccdomain.com ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id m18sm1649278pgd.39.2020.02.26.00.32.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 00:32:32 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] drivers/block/zram/zram_drv.c: remove WARN_ON_ONCE() in free_block_bdev()
Date:   Wed, 26 Feb 2020 16:32:17 +0800
Message-Id: <20200226083217.5720-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Currently, free_block_bdev() only happens after calling alloc_block_bdev()
which will ensure blk_idx bit to be set using test_and_set_bit(). So no
need to do WARN_ON_ONCE(!was_set) again when freeing.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/block/zram/zram_drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1bdb579..61b10ab 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -570,10 +570,7 @@ static unsigned long alloc_block_bdev(struct zram *zram)
 
 static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
 {
-	int was_set;
-
-	was_set = test_and_clear_bit(blk_idx, zram->bitmap);
-	WARN_ON_ONCE(!was_set);
+	clear_bit(blk_idx, zram->bitmap);
 	atomic64_dec(&zram->stats.bd_count);
 }
 
-- 
1.9.1

