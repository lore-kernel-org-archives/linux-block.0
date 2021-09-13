Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A0FC433FE
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 11:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B8060F44
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 11:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbhIML2E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 07:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbhIML2B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 07:28:01 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3A6C061762
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 04:26:45 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 18so8480853pfh.9
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 04:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1/kYiCngMmxbFqJfXYoBIgm/p1vV2D8hrclHTCgo/m8=;
        b=QuBFqYGy7IEUmyoFMQ1sO0EakRIH0Y2lHGy18G80MfBSvOYS4cSa7EexTgD2dfm6F2
         FeHzg0Za52o6hULCGLQERMg5NTTpt1qtRjcMUM1DOX8KwoHhV34OqzfO1/hNVuf3mg/+
         ejCj3Ce4VhMQ86TfD04rG5yTmzUFIP9LeIeQBYmw+EiTxOZEXLGp2Ic+ShIt23Nejd6H
         fowKACDl2JsZ0F+WZV5WvnqeDDpQQ0CY3U0x/b72j70h1pVLhAXIhCrx5QvQ06Su/269
         we7Nj08kTZTw3ALd8j01pBOF1bQos7M5LdkzFfW3Y9iDSwl+d/K2J6wwqpGYKA6evnG5
         IW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1/kYiCngMmxbFqJfXYoBIgm/p1vV2D8hrclHTCgo/m8=;
        b=v+0jTQH3IS855u03WMvseXlxDkOYCsuf/UraBu38QEaGKs+X/P6WJ5kebiBJuAcF/l
         AgILyeP+OjN4Wh4gTanyN0mDTAD484Ahj032tdHbg5duYzENqjOXW43NBdqvAS9IMJ/Y
         ewGEhXWodLgoanlP67J6whMLLqMQenJMTdnjHln+usZhdvyDEnJ/quaOcWTV9UHTPuj/
         JLxkda5gvvfl2jJi9NTxosvyPlO3mnbx6DkIJj5r7oEsFQ8jirs2sGQQV+izzR0vxY/I
         tTfkg2I/JQ8++T/L+gLIsuVdGYGsoBrW5lMdCGmtPU3NnNHdm+sykZbLOGGRmCxaNw8A
         H3VA==
X-Gm-Message-State: AOAM531/nY5iZnmrTELLHpVIIk7JTWMh5dWhrEH/ApSiw8kUHnGzPCVu
        YKPLEhsQQVO9g0PGgjoWWGu6
X-Google-Smtp-Source: ABdhPJxBmRuoWPM0P6hXnnjYsJBWQk+F5kUG8mCFzn5NPFkr1v2Gtzitpmo8UW1caPBq+6sPyFozjw==
X-Received: by 2002:a63:4464:: with SMTP id t36mr10819238pgk.4.1631532404899;
        Mon, 13 Sep 2021 04:26:44 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id p13sm6575373pjo.9.2021.09.13.04.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 04:26:44 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Subject: [PATCH 2/3] loop: Use invalidate_gendisk() helper to invalidate gendisk
Date:   Mon, 13 Sep 2021 19:25:56 +0800
Message-Id: <20210913112557.191-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913112557.191-1-xieyongji@bytedance.com>
References: <20210913112557.191-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use invalidate_gendisk() helper to simplify the code for gendisk
invalidation.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/loop.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7bf4686af774..ddcf0428cdf9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1395,11 +1395,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	blk_queue_logical_block_size(lo->lo_queue, 512);
 	blk_queue_physical_block_size(lo->lo_queue, 512);
 	blk_queue_io_min(lo->lo_queue, 512);
-	if (bdev) {
-		invalidate_bdev(bdev);
-		bdev->bd_inode->i_mapping->wb_err = 0;
-	}
-	set_capacity(lo->lo_disk, 0);
+	invalidate_gendisk(lo->lo_disk);
 	loop_sysfs_exit(lo);
 	if (bdev) {
 		/* let user-space know about this change */
-- 
2.11.0

