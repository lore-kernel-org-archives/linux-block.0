Return-Path: <SRS0=5EYj=43=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F26C10F27
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 13:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA0F2467D
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 13:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="lzqQa7kx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgCJNQx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:16:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35121 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731291AbgCJNMg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 09:12:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id m3so1294818wmi.0
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2020 06:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L42pOiV3jLGMDXgIEOo6/CJMt+4vo0NwEJd2XSpLcUA=;
        b=lzqQa7kxFDW37mdZURAt89yck5+OARsY2LdJSCdEsu5+xXa2Xbg17kXA5EGl5kb6wm
         PoFYlOQwGj3O2Ri+uO7PsFU99oR0jJVyijlGShvxiXmgpyHzoGFJ73ZHmSiNiU+MPjbC
         gEru521iogeffswdTziIksfdFbyi0mWY/Qh2Hy54Y9u2rlNhcczLUQifXm6G/EThoTDK
         Dv2AgEUBTIbKOvZ5lgGh1IjYuUYLh/8rROg0jxiBHq0ZTXpF9CMd5EDPUVc7mA5oZrG0
         zMo2h48yZBvk0RnqcQHIbFGx+fU/HH2LjJNugadXuSchjJRKGFa3FBlKx8Vo9Rd8Pcgw
         XA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L42pOiV3jLGMDXgIEOo6/CJMt+4vo0NwEJd2XSpLcUA=;
        b=ENmeToVtr2wehWqDjmVwJqKGp3xU2hEl89o/35y6w5zg/CEwkD0DBGCVuV1TJJsNNV
         UqS414VQOmmcvkAKdMM9BVEjEkS8eFCZ3C0kNbh5Bd5NxgR+FznKOI7bvtUbMwUWSBIV
         oz6FWWme9szT6dxPpeyqZEcnOdW8WGudTWzJi07tEpZHl49Dk7t+l67gzI23GXAHaYqg
         PTSaj0fMRWlB68UO7cvHOoXJ2Z/6q7k25uw+fy0+ftwVDR8N7zIM+a4UNolDV2YECzl6
         xQvGZp7PTvEPXu3HufnUCpRBZZiBCO17ax28q4okXGL4GIX/rRcI6GGYciT43DEC+h6C
         kqfA==
X-Gm-Message-State: ANhLgQ2LZ4t+cku/CjivPEco2ulNeCEUMBrTUOgzb3hzm+Rh3Ew7kVYA
        vrcKJ0TmFvJvEjGy0VmEJai7iQ==
X-Google-Smtp-Source: ADFU+vsBo54LPFGNDNUeazMCLtEa+s5E4VYML9WS+QK+OJ1rbrRdVOCr6u1NDOhMUhn0duW7MuNqmw==
X-Received: by 2002:a7b:c7cd:: with SMTP id z13mr2034890wmk.97.1583845954319;
        Tue, 10 Mar 2020 06:12:34 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id x5sm3658447wrv.67.2020.03.10.06.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:12:33 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de
Cc:     bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Martijn Coenen <maco@android.com>
Subject: [PATCH] loop: Only change blocksize when needed.
Date:   Tue, 10 Mar 2020 14:12:30 +0100
Message-Id: <20200310131230.106427-1-maco@android.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Return early in loop_set_block_size() if the requested block size is
identical to the one we already have; this avoids expensive calls to
freeze the block queue.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c1c844ad6b1a..a42c49e04954 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1541,16 +1541,16 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	if (arg < 512 || arg > PAGE_SIZE || !is_power_of_2(arg))
 		return -EINVAL;
 
-	if (lo->lo_queue->limits.logical_block_size != arg) {
-		sync_blockdev(lo->lo_device);
-		kill_bdev(lo->lo_device);
-	}
+	if (lo->lo_queue->limits.logical_block_size == arg)
+		return 0;
+
+	sync_blockdev(lo->lo_device);
+	kill_bdev(lo->lo_device);
 
 	blk_mq_freeze_queue(lo->lo_queue);
 
 	/* kill_bdev should have truncated all the pages */
-	if (lo->lo_queue->limits.logical_block_size != arg &&
-			lo->lo_device->bd_inode->i_mapping->nrpages) {
+	if (lo->lo_device->bd_inode->i_mapping->nrpages) {
 		err = -EAGAIN;
 		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
 			__func__, lo->lo_number, lo->lo_file_name,
-- 
2.25.1.481.gfbce0eb801-goog

