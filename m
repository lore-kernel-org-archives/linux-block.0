Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8932C4743C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 15:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE13B608FE
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 15:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhFWPDG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWPDG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 11:03:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D28C061574
        for <linux-block@vger.kernel.org>; Wed, 23 Jun 2021 08:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VvZg4PxfaiU69t4gVmY3F0mZQB37mtA+JzKjV1OmVl0=; b=P75Fu46Zv9ZX51BSTENaVj7TcQ
        oM5RT1a4q7x7v2kIFDWVqkjfG0OXZcpZiKWAiwzBuzmip9m1rDPhXaHUz8rqBl4SJARLWxX+0pAQU
        cHAwHaYJyZIRWaQIoeSdKp+FuegrOrYXdlWHq7WzRvHNeiDJBSDrwlA/GJ40c2DXZdkAi4wvl+Di/
        BFoCpIP4JxqsPj7Wu/+hrQjTi858xjNOKDhr6zwcigdC+KOWGiOv/xQTvPaXYiEjdC7UmZh8Zmv3o
        HerXXKtlKKVwmSHxcDA8KPAHR24FlimQ884d9+XmKaSh/weveXuoGYFE1kiNvacQzHzzIPW4SD4Xl
        kHfZ8oMw==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw4Lx-00FXrQ-O1; Wed, 23 Jun 2021 14:59:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/9] loop: reorder loop_exit
Date:   Wed, 23 Jun 2021 16:59:00 +0200
Message-Id: <20210623145908.92973-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623145908.92973-1-hch@lst.de>
References: <20210623145908.92973-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Unregister the misc and blockdevice first to prevent further access,
and only then iterate to remove the devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 081eb9aaeba8..44fa27c54ac2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2381,14 +2381,11 @@ static int loop_exit_cb(int id, void *ptr, void *data)
 static void __exit loop_exit(void)
 {
 	mutex_lock(&loop_ctl_mutex);
-
-	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
-	idr_destroy(&loop_index_idr);
-
 	unregister_blkdev(LOOP_MAJOR, "loop");
-
 	misc_deregister(&loop_misc);
 
+	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
+	idr_destroy(&loop_index_idr);
 	mutex_unlock(&loop_ctl_mutex);
 }
 
-- 
2.30.2

