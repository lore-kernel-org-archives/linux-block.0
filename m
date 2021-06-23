Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C3AC4743C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 15:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8176102A
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 15:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhFWPHO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 11:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWPHO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 11:07:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACA0C061574
        for <linux-block@vger.kernel.org>; Wed, 23 Jun 2021 08:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UCYBBM8y+++myQaSPaE2GtTh8JIwBF+yqfSzegrr3d8=; b=qyzoJDZTQNBuiZswQEuIoMiPtz
        yV5ECC6LHiBm6OQ/F4zP9cVsSxYpvUBuaAFbAyb1KOIXoGrRA1vVoy0CFywRt6w1IYKvHu9EBkuD0
        7QyxBVNk3AYWbU3QemL+9sZGXe9ystWK7dhuCIibYl75ThMXfNXIhKvOi800eSuTnEuFW4CaJWPwT
        BXtxt5Z3LWPWGdZnVb/kwIJ0gLvR2zt1rDy9ccfHefBG9rYyaFD52hSjG3bJV3qlGDOpn+xGq1bAi
        OUfAhW9QzpphbR2Rf1utlsgrh1q54dcykbnWsQDfHt1X22XBjhDUmLB3F4wYq5XP/gtm4qulwz/Br
        OH6r2ZOg==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw4QK-00FYA8-GG; Wed, 23 Jun 2021 15:04:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 9/9] loop: rewrite loop_exit using idr_for_each_entry
Date:   Wed, 23 Jun 2021 16:59:08 +0200
Message-Id: <20210623145908.92973-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623145908.92973-1-hch@lst.de>
References: <20210623145908.92973-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use idr_for_each_entry to simplify removing all devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 93abf6d8b88c..40b7c6c470f2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2349,21 +2349,17 @@ static int __init loop_init(void)
 	return err;
 }
 
-static int loop_exit_cb(int id, void *ptr, void *data)
-{
-	struct loop_device *lo = ptr;
-
-	loop_remove(lo);
-	return 0;
-}
-
 static void __exit loop_exit(void)
 {
+	struct loop_device *lo;
+	int id;
+
 	unregister_blkdev(LOOP_MAJOR, "loop");
 	misc_deregister(&loop_misc);
 
 	mutex_lock(&loop_ctl_mutex);
-	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
+	idr_for_each_entry(&loop_index_idr, lo, id)
+		loop_remove(lo);
 	mutex_unlock(&loop_ctl_mutex);
 
 	idr_destroy(&loop_index_idr);
-- 
2.30.2

