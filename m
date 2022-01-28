Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92436C433FE
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 13:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbiA1NAd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 08:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237628AbiA1NAd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 08:00:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0970DC061714
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 05:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=L+JJfK2NHPJv5MHoM3InDvOXTWR2sZz0iNRY4R8iog4=; b=w/L14eTsQz63k3T+GS7vz2uC3M
        O/d67FY2rgTgiEYLEs/9uaCIzdjzGpEW2G+JriZvLTgmJpQE90nrOL0wSkHwFY6erKd6iTq06H2bU
        FkCmya3KMEkM6BRqQbUP+KT1qLjQRyAIoQ4PbBA/GZTJ/j1O4Wl4Geui5HqI0gCKz3pZmOLJS/4fn
        V6+GIjbeDohBNpyi5egn4sV+0Mw/YpSkvezofnvfjnMPM2tmACvWiVKC3cX8UfAgweoX+0LudbulH
        Rr+ksxhxTnD72n94kEyFyct3XALawvHbrVlGwTMbXkfhMYW7XpzmjdOivpct8iAy4x/NZ7H/AFZ1a
        2K+6p5VA==;
Received: from [2001:4bb8:180:4c4c:73e:e8c7:4199:32d7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDQre-0028rb-7p; Fri, 28 Jan 2022 13:00:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 2/8] loop: initialize the worker tracking fields once
Date:   Fri, 28 Jan 2022 14:00:16 +0100
Message-Id: <20220128130022.1750906-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128130022.1750906-1-hch@lst.de>
References: <20220128130022.1750906-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no need to reinitialize idle_worker_list, worker_tree and timer
every time a loop device is configured.  Just initialize them once at
allocation time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: Darrick J. Wong <djwong@kernel.org>
---
 drivers/block/loop.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b268bca6e4fb7..6ec55a5d9dfc4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1052,10 +1052,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 
 	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
 	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
-	INIT_LIST_HEAD(&lo->idle_worker_list);
-	lo->worker_tree = RB_ROOT;
-	timer_setup(&lo->timer, loop_free_idle_workers_timer,
-		TIMER_DEFERRABLE);
 	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 	lo->lo_device = bdev;
 	lo->lo_backing_file = file;
@@ -1957,6 +1953,9 @@ static int loop_add(int i)
 	lo = kzalloc(sizeof(*lo), GFP_KERNEL);
 	if (!lo)
 		goto out;
+	lo->worker_tree = RB_ROOT;
+	INIT_LIST_HEAD(&lo->idle_worker_list);
+	timer_setup(&lo->timer, loop_free_idle_workers_timer, TIMER_DEFERRABLE);
 	lo->lo_state = Lo_unbound;
 
 	err = mutex_lock_killable(&loop_ctl_mutex);
-- 
2.30.2

