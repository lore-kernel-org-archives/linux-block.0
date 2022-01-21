Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45A9C433EF
	for <linux-block@archiver.kernel.org>; Fri, 21 Jan 2022 11:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380209AbiAULmT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jan 2022 06:42:19 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56980 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380202AbiAULmQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jan 2022 06:42:16 -0500
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20LBeFff048221;
        Fri, 21 Jan 2022 20:40:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Fri, 21 Jan 2022 20:40:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20LBe9Hd048197
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 21 Jan 2022 20:40:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v3 3/5] loop: don't hold lo->lo_mutex from lo_open()
Date:   Fri, 21 Jan 2022 20:40:04 +0900
Message-Id: <20220121114006.3633-3-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220121114006.3633-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20220121114006.3633-1-penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Waiting for I/O completion with disk->open_mutex held has possibility of
deadlock. Since disk->open_mutex => lo->lo_mutex dependency is recorded by
lo_open(), and blk_mq_freeze_queue() by e.g. loop_set_status() waits for
I/O completion with lo->lo_mutex held, from locking dependency chain
perspective waiting for I/O completion with disk->open_mutex held still
remains.

Introduce loop_delete_spinlock dedicated for protecting lo->lo_state
versus lo->lo_refcnt race in lo_open() and loop_remove_control().

Cc: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e52a8a5e8cbc..5ce8ac2dfa4c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -89,6 +89,7 @@
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
 static DEFINE_MUTEX(loop_validate_mutex);
+static DEFINE_SPINLOCK(loop_delete_spinlock);
 
 /**
  * loop_global_lock_killable() - take locks for safe loop_validate_file() test
@@ -1717,16 +1718,15 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 static int lo_open(struct block_device *bdev, fmode_t mode)
 {
 	struct loop_device *lo = bdev->bd_disk->private_data;
-	int err;
+	int err = 0;
 
-	err = mutex_lock_killable(&lo->lo_mutex);
-	if (err)
-		return err;
-	if (lo->lo_state == Lo_deleting)
+	spin_lock(&loop_delete_spinlock);
+	/* lo->lo_state may be changed to any Lo_* but Lo_deleting. */
+	if (data_race(lo->lo_state) == Lo_deleting)
 		err = -ENXIO;
 	else
 		atomic_inc(&lo->lo_refcnt);
-	mutex_unlock(&lo->lo_mutex);
+	spin_unlock(&loop_delete_spinlock);
 	return err;
 }
 
@@ -2112,19 +2112,18 @@ static int loop_control_remove(int idx)
 	ret = mutex_lock_killable(&lo->lo_mutex);
 	if (ret)
 		goto mark_visible;
-	if (lo->lo_state != Lo_unbound ||
-	    atomic_read(&lo->lo_refcnt) > 0) {
-		mutex_unlock(&lo->lo_mutex);
+	spin_lock(&loop_delete_spinlock);
+	/* Mark this loop device no longer open()-able if nobody is using. */
+	if (lo->lo_state != Lo_unbound || atomic_read(&lo->lo_refcnt) > 0)
 		ret = -EBUSY;
-		goto mark_visible;
-	}
-	/* Mark this loop device no longer open()-able. */
-	lo->lo_state = Lo_deleting;
+	else
+		lo->lo_state = Lo_deleting;
+	spin_unlock(&loop_delete_spinlock);
 	mutex_unlock(&lo->lo_mutex);
-
-	loop_remove(lo);
-	return 0;
-
+	if (!ret) {
+		loop_remove(lo);
+		return 0;
+	}
 mark_visible:
 	/* Show this loop device again. */
 	mutex_lock(&loop_ctl_mutex);
-- 
2.32.0

