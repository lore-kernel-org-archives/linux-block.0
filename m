Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B8BC4338F
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 07:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35EE961AAD
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 07:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbhHPHds (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 03:33:48 -0400
Received: from verein.lst.de ([213.95.11.211]:53322 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233725AbhHPHdr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 03:33:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1F10167373; Mon, 16 Aug 2021 09:33:14 +0200 (CEST)
Date:   Mon, 16 Aug 2021 09:33:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hillf Danton <hdanton@sina.com>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH v3] block: genhd: don't call probe function with
 major_names_lock held
Message-ID: <20210816073313.GA27275@lst.de>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp> <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is the wrong way to approach it.  Instead of making things ever
more complex try to make it simpler.  In this case, ensure that the
destroy_workqueue is not held with pointless locks.  Given that the
loop device already is known to not have a reference and marked as in
the rundown state there shouldn't be anything that is required to
be protected by lo_mutex.  So something like this untested patch
should probably do the work:

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index fa1c298a8cfb..c734dc768316 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1347,16 +1347,15 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	 * became visible.
 	 */
 
-	mutex_lock(&lo->lo_mutex);
 	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
 		err = -ENXIO;
-		goto out_unlock;
+		goto out;
 	}
 
 	filp = lo->lo_backing_file;
 	if (filp == NULL) {
 		err = -EINVAL;
-		goto out_unlock;
+		goto out;
 	}
 
 	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
@@ -1366,6 +1365,8 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	blk_mq_freeze_queue(lo->lo_queue);
 
 	destroy_workqueue(lo->workqueue);
+
+	mutex_lock(&lo->lo_mutex);
 	spin_lock_irq(&lo->lo_work_lock);
 	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
 				idle_list) {
@@ -1413,8 +1414,8 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN && bdev;
 	lo_number = lo->lo_number;
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
-out_unlock:
 	mutex_unlock(&lo->lo_mutex);
+
 	if (partscan) {
 		/*
 		 * open_mutex has been held already in release path, so don't
@@ -1435,7 +1436,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 		/* Device is gone, no point in returning error */
 		err = 0;
 	}
-
+out:
 	/*
 	 * lo->lo_state is set to Lo_unbound here after above partscan has
 	 * finished.
