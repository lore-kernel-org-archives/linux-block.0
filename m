Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2951BC433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 12:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07EF760F9D
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 12:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhIVMj2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 08:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235871AbhIVMjZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 08:39:25 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1519FC061756
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 05:37:56 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s11so2467958pgr.11
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 05:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XXo90rCwKov3n8RI+9L+aOvAMX+z/2zpjog89bF1/nY=;
        b=JwrJmAECNV2t7VRi9uoLEnD/JVjKT4PR28LoO/bRruVMwlOHxUbTfbHj1YZ66qO8vK
         NGYwVqivM2etFriuk0ET8xVcVNONczJO2K6N8S+cGvamhW9UNAqK9ORaNxNx+wze7QAM
         5XOYWu9/f+8UmBUMGPWSzXx7fwPr1qF1GbFSGSx7b1dRqkJ/UJ8Z46hzxSMTX1/KnuZV
         GHyR9vIHtJNxfpUB8Xo+j0Gidj1xnaOYsfwjvJKkWDdEifOA58DjkTvxs1LP+znRLKbC
         5EN/z5cW6w/DIDEH9/NUfuWuW8OW7FH+i7zIPuolWTPEZ4oWBbclAERBYOJWRwd7oU+I
         4amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XXo90rCwKov3n8RI+9L+aOvAMX+z/2zpjog89bF1/nY=;
        b=k7CtlkKq3ibQvp6T18TW2B/d7MgFdwm0WPqLwtDOz0M7y1i4wWNjyPJLr0t9Kz2PtJ
         Uasa+nU9W/2ePrI14yILAtQkgkVqHz5C4szzHxXJuIys4pwMuMSN+9AwGVuzckW6DeXI
         SiWU3/H2I7K3j1wkbnfSJr5lpxoj0eVsGhxY32jHH54lf/hPFY2cNklPFEbzRTZCzTis
         8ha5sYNPHKmg+D97RmhwgOtU4NQLLhVgHCda0vZOcmBiAOm9SFo/EEbtU6JP4+7yUohO
         tv5cqFAal7Ap1xsMYCpsU9YNdIcpY2Ej8qL+n/hMvFNEgs+QvoAo/75nZFDy84YZ+vgW
         Isxw==
X-Gm-Message-State: AOAM531WF/dX+iQ+ajnF9vj9z5/qiCBDnUAk1945oNE+bRqcR1jF3yoZ
        /5o2VVxYzatGqO0HVgZiNoq/ILxs+JeLVWY=
X-Google-Smtp-Source: ABdhPJyF/Cz6OiRZv3oI6P/rXSCH87qxUj4jr8nv+HKYRy0Lhyf1ZC8DmOQFf+VbzXM2zx/BVwKTOw==
X-Received: by 2002:a62:7b16:0:b0:443:56c4:33dc with SMTP id w22-20020a627b16000000b0044356c433dcmr31836416pfc.47.1632314275647;
        Wed, 22 Sep 2021 05:37:55 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id a27sm2397688pfk.192.2021.09.22.05.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 05:37:55 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Subject: [PATCH v2 2/4] loop: Use invalidate_disk() helper to invalidate gendisk
Date:   Wed, 22 Sep 2021 20:37:09 +0800
Message-Id: <20210922123711.187-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922123711.187-1-xieyongji@bytedance.com>
References: <20210922123711.187-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use invalidate_disk() helper to simplify the code for gendisk
invalidation.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7bf4686af774..eab6906326cc 100644
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
+	invalidate_disk(lo->lo_disk);
 	loop_sysfs_exit(lo);
 	if (bdev) {
 		/* let user-space know about this change */
-- 
2.11.0

