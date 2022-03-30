Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD78C433FE
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 05:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242996AbiC3Fbz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243010AbiC3Fbq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 01:31:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BEA1C7F0D
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 22:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7FMB8k2k//bismCMyEKOPHTN0G4yEkkiK6b/Aojd8lY=; b=1x518Zu9MMo9qTASG3eeGTyJ3G
        ji1h6K6DrXppypS7KapdceMS82t0BXu/qYkq1Jf9RNJLekYcbD2cxitFhYj/k69rQJv8PZ206qGmZ
        ZrxqcVetALCCQd+k/D8KPw4gBP5K4tSR/lSxCOOvLICkQGkwnTMqMqs8Lq81783EP5e0a4ufF480A
        qdQIXAxXR08FHsnIyoWUNIhmTVXw55bMfyD/XMnRGNrwN7wJJO8UvMbn+16dkn+CZfCRDUjHTh0zC
        p0/L6SJK8JwESwSljD8Bfcy24TnQJvClJ0woCkPyKpquE0PEopARPUr0AK9UIiSNZfAQI1D85l4jL
        oi9yPZ8g==;
Received: from 213-225-15-62.nat.highway.a1.net ([213.225.15.62] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZQtw-00ELKw-9H; Wed, 30 Mar 2022 05:29:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 07/15] loop: initialize the worker tracking fields once
Date:   Wed, 30 Mar 2022 07:29:09 +0200
Message-Id: <20220330052917.2566582-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330052917.2566582-1-hch@lst.de>
References: <20220330052917.2566582-1-hch@lst.de>
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
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by: Darrick J. Wong <djwong@kernel.org>
---
 drivers/block/loop.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 762f0a18295d7..d1c1086beedce 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1057,10 +1057,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 
 	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
 	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
-	INIT_LIST_HEAD(&lo->idle_worker_list);
-	lo->worker_tree = RB_ROOT;
-	timer_setup(&lo->timer, loop_free_idle_workers_timer,
-		TIMER_DEFERRABLE);
 	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 	lo->lo_device = bdev;
 	lo->lo_backing_file = file;
@@ -1973,6 +1969,9 @@ static int loop_add(int i)
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

