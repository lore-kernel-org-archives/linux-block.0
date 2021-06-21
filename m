Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C05DC4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 10:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB26161108
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 10:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhFUKgV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 06:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUKgU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 06:36:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEADAC061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 03:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eaEnNhzcDhFfHKQPqlqe59jKDMJPiYMuIwzxohvZels=; b=sBmrQivlovledOMrm90IIJRYty
        hSnmwVmvfXZB5ogWmSKJt37tMD0a1TLlVOSY3BrzdorZFh+A3P7SmyEEzSiHnV12cCNQsRwCUlGoY
        Wc1zEzTMHYiJFjPyHxVtS7aLl/sfydSiYo7lUgJhZ/EJKlpFeJmGksSpBmBlaGwos+6mtlQKg1hXt
        4Xgq5eSsimy9Hj7jjhUP+W9JYA9+g4RyMc2dJkrInpLhkRo4w/0PfJpHE6R7fkvt+5n27DeEnNM8q
        47e3DoREe22RwLHrenuj4828MVfvBOXPWg768IfLyRRehn2rXDtTEYwDO/r9/su4tjs2b5tRFEkJ2
        mp28Bkng==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvHFY-00CzQE-F3; Mon, 21 Jun 2021 10:33:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
Subject: [PATCH 6/9] loop: move loop_ctl_mutex locking into loop_add
Date:   Mon, 21 Jun 2021 12:15:44 +0200
Message-Id: <20210621101547.3764003-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621101547.3764003-1-hch@lst.de>
References: <20210621101547.3764003-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move acquiring and releasing loop_ctl_mutex from the callers into
loop_add.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d55526c355e1..3f1e934a7f9e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2079,9 +2079,12 @@ static int loop_add(int i)
 	lo = kzalloc(sizeof(*lo), GFP_KERNEL);
 	if (!lo)
 		goto out;
-
 	lo->lo_state = Lo_unbound;
 
+	err = mutex_lock_killable(&loop_ctl_mutex);
+	if (err)
+		goto out_free_dev;
+
 	/* allocate id, if @id >= 0, we're requesting that specific id */
 	if (i >= 0) {
 		err = idr_alloc(&loop_index_idr, lo, i, i + 1, GFP_KERNEL);
@@ -2091,7 +2094,7 @@ static int loop_add(int i)
 		err = idr_alloc(&loop_index_idr, lo, 0, 0, GFP_KERNEL);
 	}
 	if (err < 0)
-		goto out_free_dev;
+		goto out_unlock;
 	i = err;
 
 	err = -ENOMEM;
@@ -2157,12 +2160,15 @@ static int loop_add(int i)
 	disk->queue		= lo->lo_queue;
 	sprintf(disk->disk_name, "loop%d", i);
 	add_disk(disk);
+	mutex_unlock(&loop_ctl_mutex);
 	return lo->lo_number;
 
 out_cleanup_tags:
 	blk_mq_free_tag_set(&lo->tag_set);
 out_free_idr:
 	idr_remove(&loop_index_idr, i);
+out_unlock:
+	mutex_unlock(&loop_ctl_mutex);
 out_free_dev:
 	kfree(lo);
 out:
@@ -2222,22 +2228,7 @@ static void loop_probe(dev_t dev)
 
 	if (max_loop && idx >= max_loop)
 		return;
-
-	mutex_lock(&loop_ctl_mutex);
 	loop_add(idx);
-	mutex_unlock(&loop_ctl_mutex);
-}
-
-static int loop_control_add(int idx)
-{
-	int ret;
-		
-	ret = mutex_lock_killable(&loop_ctl_mutex);
-	if (ret)
-		return ret;
-	ret = loop_add(idx);
-	mutex_unlock(&loop_ctl_mutex);
-	return ret;
 }
 
 static int loop_control_remove(int idx)
@@ -2281,11 +2272,11 @@ static int loop_control_get_free(int idx)
 	if (ret)
 		return ret;
 	ret = loop_lookup(&lo, -1);
-	if (ret < 0)
-		ret = loop_add(-1);
 	mutex_unlock(&loop_ctl_mutex);
 
-	return ret;
+	if (ret >= 0)
+		return ret;
+	return loop_add(-1);
 }
 
 static long loop_control_ioctl(struct file *file, unsigned int cmd,
@@ -2293,7 +2284,7 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 {
 	switch (cmd) {
 	case LOOP_CTL_ADD:
-		return loop_control_add(parm);
+		return loop_add(parm);
 	case LOOP_CTL_REMOVE:
 		return loop_control_remove(parm);
 	case LOOP_CTL_GET_FREE:
@@ -2374,10 +2365,8 @@ static int __init loop_init(void)
 	}
 
 	/* pre-create number of devices given by config or max_loop */
-	mutex_lock(&loop_ctl_mutex);
 	for (i = 0; i < nr; i++)
 		loop_add(i);
-	mutex_unlock(&loop_ctl_mutex);
 
 	printk(KERN_INFO "loop: module loaded\n");
 	return 0;
-- 
2.30.2

