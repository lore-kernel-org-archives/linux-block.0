Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34073 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751727AbdFPFEC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2017 01:04:02 -0400
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@fb.com>
Date: Fri, 16 Jun 2017 15:02:09 +1000
Subject: [PATCH 1/2] loop: use filp_close() rather than fput()
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <149758932908.10006.10765671892098302463.stgit@noble>
In-Reply-To: <149758925866.10006.12779875832895865043.stgit@noble>
References: <149758925866.10006.12779875832895865043.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When a loop device is being shutdown the backing file is
closed with fput().  This is different from how close(2)
closes files - it uses filp_close().

The difference is important for filesystems which provide a ->flush
file operation such as NFS.  NFS assumes a flush will always
be called on last close, and gets confused otherwise.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/block/loop.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ebbd0c3fe0ed..9c457ca6c55e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -682,7 +682,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	if (error)
 		goto out_putf;
 
-	fput(old_file);
+	filp_close(old_file, NULL);
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN)
 		loop_reread_partitions(lo, bdev);
 	return 0;
@@ -1071,12 +1071,12 @@ static int loop_clr_fd(struct loop_device *lo)
 	loop_unprepare_queue(lo);
 	mutex_unlock(&lo->lo_ctl_mutex);
 	/*
-	 * Need not hold lo_ctl_mutex to fput backing file.
+	 * Need not hold lo_ctl_mutex to close backing file.
 	 * Calling fput holding lo_ctl_mutex triggers a circular
 	 * lock dependency possibility warning as fput can take
 	 * bd_mutex which is usually taken before lo_ctl_mutex.
 	 */
-	fput(filp);
+	filp_close(filp, NULL);
 	return 0;
 }
 
