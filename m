Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7E6C4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 10:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2516115A
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 10:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhFUKoP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 06:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFUKoL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 06:44:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793A8C061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 03:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0ZQxbSlLRJ8eoWqF9Y19Cxux5KQvbaAL/Q9Z8WFXbaY=; b=GDDbaEHdE6+NzRnSwbDEmoXXtV
        3FygHPc3/5518LU0jLQOQKYaMQQmhv7g4F5M+Yt4XiT35gDppqqbT5DfRHizv0U1nEWrCWB31IHTu
        tAV+lqLKCzWgCse+LusbBkLuJzFV9Qb26scmNRw0S2HRFgotV2IMdwcL34kVs80jtQKZXYroo26be
        YWjWmtqd2OrmmXWy/FqZUuLfCIgFwyyqoGN+fUBURlkRXKaRJ7zL73IqZ9c+NSJKxUw6kA2+XR9Xh
        6dGM67gBQUehP3hHZqQkoq/zmMRZVJ3lN0C9mX6LSpGGdHp5WBdiHHCJkZ+4wPQeVitIfckYVVEaD
        mga4Be7Q==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvHMg-00Czob-O0; Mon, 21 Jun 2021 10:41:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
Subject: [PATCH 9/9] loop: rewrite loop_exit using idr_for_each_entry
Date:   Mon, 21 Jun 2021 12:15:47 +0200
Message-Id: <20210621101547.3764003-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621101547.3764003-1-hch@lst.de>
References: <20210621101547.3764003-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use idr_for_each_entry to simplify removing all devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 2ff5162bd28b..a9fd1f0d0ded 100644
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

