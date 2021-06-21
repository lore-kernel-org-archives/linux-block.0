Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C11C48BC2
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 10:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D84D611CE
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 10:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhFUK0U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 06:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhFUK0T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 06:26:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6301EC061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 03:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IwaY6kI/v3OjEcexd7f9MhRoW5alapc3msr92jaBKD0=; b=hr9VHI8iOA7tdZwEElN+DZ74Bv
        KLkeTpkNeH+ECFhyg12BjgYhkG25vLvnF9StHU4Y1eMaQ7x5v0r33jPN0tA2wkcol1rUz4OGSdles
        6mApBUyJCvWeI2cjwx/bmpaWaEoHhRZgvHXHG1Icm9vl7WTmH/QMIpONP/vC73iZrW/9ScBYiPEy1
        e0himXQQf609vZszoS6ZBJ5kPTCSajoSVZYj7F4XYeXVxkPRfd9ZEUqAIDrGWSBLCeuENtn71v5Wy
        biIhFY+3M+zt1r/DsSeg8QOwcJjjBKcpens1SNSRdke6pvAkl3G5H7ft8yxAuFlkm5WYdr5t8mwBf
        hPXrhJLg==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvH5R-00CyqV-PP; Mon, 21 Jun 2021 10:23:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
Subject: [PATCH 2/9] loop: reduce loop_ctl_mutex coverage in loop_exit
Date:   Mon, 21 Jun 2021 12:15:40 +0200
Message-Id: <20210621101547.3764003-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621101547.3764003-1-hch@lst.de>
References: <20210621101547.3764003-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

loop_ctl_mutex is only needed to iterate the IDR for removing the loop
devices, so reduce the coverage.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 44fa27c54ac2..9df9fb490f87 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2380,13 +2380,14 @@ static int loop_exit_cb(int id, void *ptr, void *data)
 
 static void __exit loop_exit(void)
 {
-	mutex_lock(&loop_ctl_mutex);
 	unregister_blkdev(LOOP_MAJOR, "loop");
 	misc_deregister(&loop_misc);
 
+	mutex_lock(&loop_ctl_mutex);
 	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
-	idr_destroy(&loop_index_idr);
 	mutex_unlock(&loop_ctl_mutex);
+
+	idr_destroy(&loop_index_idr);
 }
 
 module_init(loop_init);
-- 
2.30.2

