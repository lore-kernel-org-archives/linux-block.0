Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D501AC4743C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 15:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C936115A
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 15:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFWPFT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 11:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhFWPFQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 11:05:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C669DC061574
        for <linux-block@vger.kernel.org>; Wed, 23 Jun 2021 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zwVbBuoYI/AtLYOSj3B/Doj6bcQK/Y9wePlmaXjhV1o=; b=kByS3SwR3w/xqoDbLlBimC0/Il
        1wg+eFtVgEWZf0zWK6VjXU0FWVXpu2MymG7AChEBpdBJNDhbmpFvsP7vUzu0SKGPOi9Wkqe04uU/n
        3u0nueT0vbSJgnZwmsk6l+IXrrfLucmHFuBB73myAxOI34l96ndGuthnCTDqrflDrrJBAVXD5twz5
        SrPBC+evxbfrjwV99iCG0c258mH/WFzKqQ4sAu8ME/Jo1QAEMLWqGehd0eUkqVkgraXp6vUoOluqk
        IUnmCiOCWqWIYl1qiyi1/iTT86lwVQwfD4NxnXZMFW8ZqePkB5LI9R1zQ0OKvr29HAav83Br/vuHk
        XzNV8gAw==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw4OS-00FY09-Gg; Wed, 23 Jun 2021 15:02:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 6/9] loop: move loop_ctl_mutex locking into loop_add
Date:   Wed, 23 Jun 2021 16:59:05 +0200
Message-Id: <20210623145908.92973-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623145908.92973-1-hch@lst.de>
References: <20210623145908.92973-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move acquiring and releasing loop_ctl_mutex from the callers into
loop_add.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d55526c355e1..01d393a60b37 100644
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
-	return lo->lo_number;
+	mutex_unlock(&loop_ctl_mutex);
+	return i;
 
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

