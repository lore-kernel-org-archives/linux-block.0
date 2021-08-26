Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8438C4320E
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 13:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8C4060F4C
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 13:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhHZNuE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 09:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhHZNuD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 09:50:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0715FC0613C1
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 06:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tMeEb8qSxY5BfBBpYEzAA1n1R0tjz35LswrWeBRieIY=; b=L7gmKYSe1q0OxoLwhpU2YWKI+B
        VDj7m7qVXv5NYsPhG2ZAQ2Nv9OAVn8psqTrMRMr1JP/yfJ1GOktztZ0/j7b07P0bsuV93c64odVlw
        IJKBiDNrX7DU5XSOMp7IuL2+sjuxSWLPaFQx0ULGyCemF19/Q+Hd2mbW6wVuykIi7RdQECHEEEBXn
        hSPJuLxcf3w/9DxsY7B7piyABoNiG6YJ0C8lELm++oRrozap/bAKhYq8WeQZhp9m+aVw8geuhu8bG
        79Vmzd4TSgoEkQEy0qd8L7w8gTYGqBwLSRUtWzCJtu6XIXB9cD5Vt4NeOv29AA6sqyvAN+IfxMgF/
        PHaG3ptQ==;
Received: from [2001:4bb8:193:fd10:d9d9:6c15:481b:99c4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJFj2-00DLeP-Sv; Thu, 26 Aug 2021 13:47:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 8/8] loop: avoid holding loop_ctl_mutex over add_disk
Date:   Thu, 26 Aug 2021 15:38:10 +0200
Message-Id: <20210826133810.3700-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826133810.3700-1-hch@lst.de>
References: <20210826133810.3700-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To avoid complex lock ordering issues loop_ctl_mutex should not
be held over add_disk.  Add a new Lo_new state for a loop device
that has just been created but which is not live yet.

Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 25 +++++++++++++++----------
 drivers/block/loop.h |  1 +
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cb857d5e8313..c8a24e06c259 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2327,7 +2327,11 @@ static int loop_add(int i)
 	lo = kzalloc(sizeof(*lo), GFP_KERNEL);
 	if (!lo)
 		goto out;
-	lo->lo_state = Lo_unbound;
+	lo->lo_state = Lo_new;
+	atomic_set(&lo->lo_refcnt, 0);
+	mutex_init(&lo->lo_mutex);
+	spin_lock_init(&lo->lo_lock);
+	spin_lock_init(&lo->lo_work_lock);
 
 	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
@@ -2341,9 +2345,11 @@ static int loop_add(int i)
 	} else {
 		err = idr_alloc(&loop_index_idr, lo, 0, 0, GFP_KERNEL);
 	}
-	if (err < 0)
-		goto out_unlock;
 	i = err;
+	lo->lo_number = i;
+	mutex_unlock(&loop_ctl_mutex);
+	if (err < 0)
+		goto out_free_dev;
 
 	err = -ENOMEM;
 	lo->tag_set.ops = &loop_mq_ops;
@@ -2397,11 +2403,6 @@ static int loop_add(int i)
 	if (!part_shift)
 		disk->flags |= GENHD_FL_NO_PART_SCAN;
 	disk->flags |= GENHD_FL_EXT_DEVT;
-	atomic_set(&lo->lo_refcnt, 0);
-	mutex_init(&lo->lo_mutex);
-	lo->lo_number		= i;
-	spin_lock_init(&lo->lo_lock);
-	spin_lock_init(&lo->lo_work_lock);
 	disk->major		= LOOP_MAJOR;
 	disk->first_minor	= i << part_shift;
 	disk->minors		= 1 << part_shift;
@@ -2412,14 +2413,18 @@ static int loop_add(int i)
 	disk->event_flags	= DISK_EVENT_FLAG_UEVENT;
 	sprintf(disk->disk_name, "loop%d", i);
 	add_disk(disk);
-	mutex_unlock(&loop_ctl_mutex);
+
+	mutex_lock(&lo->lo_mutex);
+	lo->lo_state = Lo_unbound;
+	mutex_unlock(&lo->lo_mutex);
+
 	return i;
 
 out_cleanup_tags:
 	blk_mq_free_tag_set(&lo->tag_set);
 out_free_idr:
+	mutex_lock(&loop_ctl_mutex);
 	idr_remove(&loop_index_idr, i);
-out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
 out_free_dev:
 	kfree(lo);
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index d14ce6bdc014..608a20c23c64 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -24,6 +24,7 @@ enum {
 	Lo_bound,
 	Lo_rundown,
 	Lo_deleting,
+	Lo_new,
 };
 
 struct loop_func_table;
-- 
2.30.2

