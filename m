Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16FAC433F5
	for <linux-block@archiver.kernel.org>; Fri, 26 Nov 2021 23:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbhKZXMJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Nov 2021 18:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245470AbhKZXKI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Nov 2021 18:10:08 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A8DC061759;
        Fri, 26 Nov 2021 15:06:55 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p18so9292295wmq.5;
        Fri, 26 Nov 2021 15:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fpiGdrzOUvOueMAGHR97ttYfgicr+sSs1c6mjDMywB8=;
        b=CP9wTYpVOcuuFcOJia67RjPX3q4Ls6/fmDl8uxxlpBtt4KdLw06I9BzNB/vSrFbyw6
         O+OIiUGuYSJcwBQ64pu7wLfmOXkAUCMsPZXJvoF4fDukL+Hs/WRqBPZZYoWvFVomLz8w
         nRxp6yEIC2D1q5Kx+zSbQVQCjlOBvx6NVVCOcG4R1cU8HN9CJqG+t9ja/t8gKkE1mc1F
         50TT/yQhMWL+hGE3CYraJTDdXecNZRYg436WN2IgMLXa88UrgnmGkNeHQJSFQ0Px4O7X
         BnMlsggf7EdUKrmFlp4eBcJ/tcfKUHjALHjsqjBel98QFr3/waYugXDdeimPJ6geIPvv
         BYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fpiGdrzOUvOueMAGHR97ttYfgicr+sSs1c6mjDMywB8=;
        b=5nYyXV9gIHqUR5oLn/C9saB/d1vmC68j6xJSJhMa0lOUmeq6Cxal25Lg6n7KgW8ect
         6A2x51iqc4fnUMOwBvVYpxcwhWjy5oAUpoqixnYX5lZOULI3iyK1FIRGxRt1GC4DmGYj
         25xZKR0IA6Uq/R6w77wAcvHwEvMMWOjcU+LZ2R4b8QJ7fTtzRSRNPThVTzNpbgWihn19
         OWtQ4eTF6owXIFkEc/B1qXyNc2vj8UEJTC3Xjwz71hPYU3ZGIbi3/61PvquIUiKFlUg2
         v185faq101VWTl9s/j+pcSxn0FvgOh8IgfI/E/PrE0ews7+xsw0ffYfsUWuYEwTlma7W
         gRGg==
X-Gm-Message-State: AOAM532m3+Dgrj12Pji79ZbipsCOLqMlJmNmI15NZMnAoks/T2AgASkM
        EvXpIo6VILPpnQs5hzTmDw==
X-Google-Smtp-Source: ABdhPJxI8bFqnOhNhjUn+uieFffwFiGxfkKvLjMln4sA+q1Igj3acfmCK0mo27qEdNNLUIMWgYx21g==
X-Received: by 2002:a7b:c763:: with SMTP id x3mr19186121wmk.31.1637968013914;
        Fri, 26 Nov 2021 15:06:53 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id az4sm12279603wmb.20.2021.11.26.15.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 15:06:53 -0800 (PST)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: Remove redundant initialization of variable ret
Date:   Fri, 26 Nov 2021 23:06:52 +0000
Message-Id: <20211126230652.1175636-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The variable ret is being initialized with a value that is never
read, it is being updated later on. The assignment is redundant and
can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 block/bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 886a08a045a6..26eefa5de6ca 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -665,7 +665,7 @@ static void blkdev_flush_mapping(struct block_device *bdev)
 static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
 {
 	struct gendisk *disk = bdev->bd_disk;
-	int ret = 0;
+	int ret;
 
 	if (disk->fops->open) {
 		ret = disk->fops->open(bdev, mode);
-- 
2.33.1

