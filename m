Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52F0C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECEA60F11
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbhHRGhY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbhHRGhX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 02:37:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F4BC061764
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FXmTMF6Ajh70k0duCWm0jFiKANkPK/mgbhge+anQB8U=; b=AyDStgbo3Wg90sV+CuhwoX0jeQ
        Dj7QnuifN+rI6qt9MLD2vYF/shSBkMYwnE0CATzfq5Vw+9GjFJyYme1gr3zpVMqZtM5MJOQJxtGix
        45s01yGVl1OZ0WnBykc29PWZTInH5hjf5UCHdky/A3UysN2sHcAujxatI62TbsnWUg7zlqJCncWmt
        yrk5MHZyxXXcSQpQwS8zGy7cTJk8LoV2t9Skm00TzgjobOfESB/NeRzYE+afMuZ1t6QpXPMDZnMQU
        4KcePiMj57DKNg/w5dAp7IUFoLf0sY+zBOEji0p5z3m0969E8WdkqolnBBbAKBtTC3CewUMmjUJcO
        VAuLWs0g==;
Received: from 213-225-12-39.nat.highway.a1.net ([213.225.12.39] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGF9p-003Rmb-10; Wed, 18 Aug 2021 06:34:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 7/7] loop: avoid holding loop_ctl_mutex over add_disk
Date:   Wed, 18 Aug 2021 08:24:55 +0200
Message-Id: <20210818062455.211065-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818062455.211065-1-hch@lst.de>
References: <20210818062455.211065-1-hch@lst.de>
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
 drivers/block/loop.c | 16 ++++++++++++----
 drivers/block/loop.h |  1 +
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 043673bda8b3..80f462edc39f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2329,7 +2329,7 @@ static int loop_add(int i)
 	lo = kzalloc(sizeof(*lo), GFP_KERNEL);
 	if (!lo)
 		goto out;
-	lo->lo_state = Lo_unbound;
+	lo->lo_state = Lo_new;
 
 	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
@@ -2343,8 +2343,9 @@ static int loop_add(int i)
 	} else {
 		err = idr_alloc(&loop_index_idr, lo, 0, 0, GFP_KERNEL);
 	}
+	mutex_unlock(&loop_ctl_mutex);
 	if (err < 0)
-		goto out_unlock;
+		goto out_free_dev;
 	i = err;
 
 	err = -ENOMEM;
@@ -2414,15 +2415,22 @@ static int loop_add(int i)
 	disk->event_flags	= DISK_EVENT_FLAG_UEVENT;
 	sprintf(disk->disk_name, "loop%d", i);
 	add_disk(disk);
+
+	err = mutex_lock_killable(&loop_ctl_mutex);
+	if (err)
+		goto out_del_gendisk;
+	lo->lo_state = Lo_unbound;
 	mutex_unlock(&loop_ctl_mutex);
+
 	return i;
 
+out_del_gendisk:
+	del_gendisk(lo->lo_disk);
+	blk_cleanup_disk(lo->lo_disk);
 out_cleanup_tags:
 	blk_mq_free_tag_set(&lo->tag_set);
 out_free_idr:
 	idr_remove(&loop_index_idr, i);
-out_unlock:
-	mutex_unlock(&loop_ctl_mutex);
 out_free_dev:
 	kfree(lo);
 out:
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

