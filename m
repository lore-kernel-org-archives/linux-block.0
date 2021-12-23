Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30433C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Dec 2021 11:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbhLWLZ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 06:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347899AbhLWLZW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 06:25:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A620CC061756
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 03:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nD1wv9dIeAsaJyaqKTced0zhh4F2oweeRb9LPnmZIdg=; b=hXKKQp1Qw/hkKL7MGNC+n2ZM6o
        wB194/xFzjFeKA2n7w1Kqj533nEhdXNtYUhjIlSKh/kp+oxVRPJN5tXewzRxMGw2mJ8LGg2ypci/w
        lTcT+w42J1Yvgt2S0033QPseGqIv2TmcPdIJgVgIpBv5y3N1FFuJH2Obb4GYxoZJNnliHwTS5J7kd
        0AaAYJxsuZAf/VZt8AkBNkErximGlItpOnN13nw6TOdh5x+AdNnqfPFpVRlNsJ7ZRXZJlYHmUgqrn
        UhLRgyaLerC3b5f6gBn728hlxppLFUc5dwoJo3sG8ZlM3AEAthiEQz4SZ2/tCTVWdyhbrMgP4iw2O
        Gr8ysXaQ==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0MDm-00CZu4-BW; Thu, 23 Dec 2021 11:25:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 2/2] loop: make autoclear operation synchronous again
Date:   Thu, 23 Dec 2021 12:25:09 +0100
Message-Id: <20211223112509.1116461-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211223112509.1116461-1-hch@lst.de>
References: <20211223112509.1116461-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>

The kernel test robot is reporting that xfstest can fail at

  umount ext2 on xfs
  umount xfs

sequence, for commit 322c4293ecc58110 ("loop: make autoclear operation
asynchronous") broke what commit ("loop: Make explicit loop device
destruction lazy") wanted to achieve.

Although we cannot guarantee that nobody is holding a reference when
"umount xfs" is called, we should try to close a race window opened
by asynchronous autoclear operation.

Make the autoclear operation upon close() synchronous, by performing
__loop_clr_fd() directly from the release callback.

Reported-by: kernel test robot <oliver.sang@intel.com>
Fixes: 322c4293ecc58110 ("loop: make autoclear operation asynchronous")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
[hch: rebased]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 31 +------------------------------
 drivers/block/loop.h |  1 -
 2 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 573f0d83fe80a..7faacefc4ede9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1156,40 +1156,12 @@ static void __loop_clr_fd(struct loop_device *lo)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART;
 
 	fput(filp);
-}
-
-static void loop_rundown_completed(struct loop_device *lo)
-{
 	mutex_lock(&lo->lo_mutex);
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&lo->lo_mutex);
 	module_put(THIS_MODULE);
 }
 
-static void loop_rundown_workfn(struct work_struct *work)
-{
-	struct loop_device *lo = container_of(work, struct loop_device,
-					      rundown_work);
-	struct block_device *bdev = lo->lo_device;
-	struct gendisk *disk = lo->lo_disk;
-
-	__loop_clr_fd(lo);
-	kobject_put(&bdev->bd_device.kobj);
-	module_put(disk->fops->owner);
-	loop_rundown_completed(lo);
-}
-
-static void loop_schedule_rundown(struct loop_device *lo)
-{
-	struct block_device *bdev = lo->lo_device;
-	struct gendisk *disk = lo->lo_disk;
-
-	__module_get(disk->fops->owner);
-	kobject_get(&bdev->bd_device.kobj);
-	INIT_WORK(&lo->rundown_work, loop_rundown_workfn);
-	queue_work(system_long_wq, &lo->rundown_work);
-}
-
 static int loop_clr_fd(struct loop_device *lo)
 {
 	int err;
@@ -1220,7 +1192,6 @@ static int loop_clr_fd(struct loop_device *lo)
 	mutex_unlock(&lo->lo_mutex);
 
 	__loop_clr_fd(lo);
-	loop_rundown_completed(lo);
 	return 0;
 }
 
@@ -1745,7 +1716,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
 		 */
-		loop_schedule_rundown(lo);
+		__loop_clr_fd(lo);
 		return;
 	} else if (lo->lo_state == Lo_bound) {
 		/*
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 885c83b4417e1..0400cbfed6308 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -55,7 +55,6 @@ struct loop_device {
 	struct gendisk		*lo_disk;
 	struct mutex		lo_mutex;
 	bool			idr_visible;
-	struct work_struct      rundown_work;
 };
 
 struct loop_cmd {
-- 
2.30.2

