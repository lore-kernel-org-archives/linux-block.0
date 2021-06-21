Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C487BC4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 10:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1B71611C1
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 10:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhFUKXn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 06:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhFUKXm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 06:23:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B5FC061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 03:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pO90m1jmfKViNxEnJJUoHunLBOwPwglVtuT7o6rGPkI=; b=D/BPOkhVIsDqDXzzo/Wel5nAT7
        K2WQQKQfF8Cq2bx1UBBzdFL8gaTCkNR4AqikflM1GIZDVo7s6ev9BUCgHpWEnejBriD6A8MIRuad2
        YuE9XcmWBVELdKkcN+jsWxdf3JW+9KC1GRFr9SUwXSbR6Qq6KmeKFLVTgGpDkhfkXsd1krul0hqzQ
        dMDRYOV0pC98rFuBydjzOfAnl5qu9+OUZbKXH2C3NPqIB2T8ZUarQoihoAF+zMf12SHhRpfnXi1t7
        yzlNR3TJ2xTH1nzZBx7+rryT7mmqCtB5H1Xte3rOPm89H7i6ELcjoNcto7SN16LpiXbKBtVmG8gBe
        4Xvxxgiw==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvH2s-00Cyho-1o; Mon, 21 Jun 2021 10:20:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
Subject: [PATCH 1/9] loop: reorder loop_exit
Date:   Mon, 21 Jun 2021 12:15:39 +0200
Message-Id: <20210621101547.3764003-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621101547.3764003-1-hch@lst.de>
References: <20210621101547.3764003-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Unregister the misc and blockdevice first to prevent further access,
and only then iterate to remove the devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

