Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751056AbeEUMiB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 May 2018 08:38:01 -0400
From: Jeff Layton <jlayton@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc: willy@infradead.org, darrick.wong@oracle.com, tytso@mit.edu,
        bfoster@redhat.com
Subject: [PATCH] loop: clear wb_err in bd_inode when detaching backing file
Date: Mon, 21 May 2018 08:37:58 -0400
Message-Id: <20180521123758.9537-1-jlayton@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

When a loop block device encounters a writeback error, that error will
get propagated to the bd_inode's wb_err field. If we then detach the
backing file from it, attach another and fsync it, we'll get back the
writeback error that we had from the previous backing file.

This is a bit of a grey area as POSIX doesn't cover loop devices, but it
is somewhat counterintuitive.

If we detach a backing file from the loopdev while there are still
unreported errors, take it as a sign that we're no longer interested in
the previous file, and clear out the wb_err in the loop blockdev.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 drivers/block/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 5d4e31655d96..55cf554bc914 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1068,6 +1068,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	if (bdev) {
 		bdput(bdev);
 		invalidate_bdev(bdev);
+		bdev->bd_inode->i_mapping->wb_err = 0;
 	}
 	set_capacity(lo->lo_disk, 0);
 	loop_sysfs_exit(lo);
-- 
2.17.0
