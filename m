Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D72DC432BE
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 13:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5217560F21
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 13:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242737AbhHZNsq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 09:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242723AbhHZNsq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 09:48:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17BFC0613C1
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 06:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rFdxAVsC8/GgQNM9r6twqFYr6Goqt150UykXg8mfD0I=; b=JJ6e8gbdJ6ys21uWGepCgjzlSv
        2DR9lxqqbNAS4LvSQg3OEPQud1tL1+CUAnEXmyLN+iQLOWw1FZwwkBbRUX5vcBbDOHCdWNF4kmsIc
        +vuihugEI2y6o6vZE3V3qf/C56m2jUtdy1qzXBag9gy7yaxdC7oPHgh+6d5Gis3c6d7ar7cvyadC2
        Qyke04PiNV8ZqeJ4Zoh27RrwTrjySfKNhE0CHckCe3/b58BY+qp+kaKZ6d3fEGzb5z9hlM2uSgojZ
        EeZT2arkJuKLw9Mwi0Qe17jGvSh5kLY3B1TNuOLxEm7w9SJM6vNitMCrSyr8f+K0jwimbhU4oWUVZ
        0V5kgaDg==;
Received: from [2001:4bb8:193:fd10:d9d9:6c15:481b:99c4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJFhw-00DLZf-UE; Thu, 26 Aug 2021 13:46:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 7/8] loop: move loop device deletion out of loop_ctl_mutex
Date:   Thu, 26 Aug 2021 15:38:09 +0200
Message-Id: <20210826133810.3700-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826133810.3700-1-hch@lst.de>
References: <20210826133810.3700-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To avoid complex lock ordering issues always delete loop devices outside
of loop_ctl_mutex.  In loop_control_remove the Lo_deleting state can
be used to prevent further lookups, and given that module unload is
synchronized vs new opens of the control device and thus ioctls there
is no need for locks there at all.

Based on patches from Hillf Danton <hdanton@sina.com> and
Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>.

Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6ee4b046bdcc..cb857d5e8313 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2478,7 +2478,11 @@ static int loop_control_remove(int idx)
 	mutex_unlock(&lo->lo_mutex);
 
 	idr_remove(&loop_index_idr, lo->lo_number);
+	mutex_unlock(&loop_ctl_mutex);
+
 	loop_remove(lo);
+	return 0;
+
 out_unlock_ctrl:
 	mutex_unlock(&loop_ctl_mutex);
 	return ret;
@@ -2609,11 +2613,12 @@ static void __exit loop_exit(void)
 	unregister_blkdev(LOOP_MAJOR, "loop");
 	misc_deregister(&loop_misc);
 
-	mutex_lock(&loop_ctl_mutex);
+	/*
+	 * No need for loop_ctl_mutex given that no new ioctls and thus
+	 * additions and removals can happen in parallel to module unloading.
+	 */
 	idr_for_each_entry(&loop_index_idr, lo, id)
 		loop_remove(lo);
-	mutex_unlock(&loop_ctl_mutex);
-
 	idr_destroy(&loop_index_idr);
 }
 
-- 
2.30.2

