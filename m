Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E6CC04AAF
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 14:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DBE20675
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 14:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfEPOBc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 10:01:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:37154 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726742AbfEPOBb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 10:01:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB05DAE9D;
        Thu, 16 May 2019 14:01:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4695B1E3ED6; Thu, 16 May 2019 16:01:30 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        <linux-block@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] loop: Don't change loop device under exclusive opener
Date:   Thu, 16 May 2019 16:01:27 +0200
Message-Id: <20190516140127.23272-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Loop module allows calling LOOP_SET_FD while there are other openers of
the loop device. Even exclusive ones. This can lead to weird
consequences such as kernel deadlocks like:

mount_bdev()				lo_ioctl()
  udf_fill_super()
    udf_load_vrs()
      sb_set_blocksize() - sets desired block size B
      udf_tread()
        sb_bread()
          __bread_gfp(bdev, block, B)
					  loop_set_fd()
					    set_blocksize()
            - now __getblk_slow() indefinitely loops because B != bdev
              block size

Fix the problem by disallowing LOOP_SET_FD ioctl when there are
exclusive openers of a loop device.

[Deliberately chosen not to CC stable as a user with priviledges to
trigger this race has other means of taking the system down and this
has a potential of breaking some weird userspace setup]

Reported-and-tested-by: syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

Hi Jens!

What do you think about this patch? It fixes the problem but it also changes
user visible behavior so there are chances it breaks some existing setup
(although I have hard time coming up with a realistic scenario where it would
matter).

Alternatively we could change getblk() code handle changing block size. That
would fix the particular issue syzkaller found as well but I'm not sure what
else is broken when block device changes while fs driver is working with it.

Honza

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 102d79575895..f11b7dc16e9d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -945,9 +945,20 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (!file)
 		goto out;
 
+	/*
+	 * If we don't hold exclusive handle for the device, upgrade to it
+	 * here to avoid changing device under exclusive owner.
+	 */
+	if (!(mode & FMODE_EXCL)) {
+		bdgrab(bdev);
+		error = blkdev_get(bdev, mode | FMODE_EXCL, loop_set_fd);
+		if (error)
+			goto out_putf;
+	}
+
 	error = mutex_lock_killable(&loop_ctl_mutex);
 	if (error)
-		goto out_putf;
+		goto out_bdev;
 
 	error = -EBUSY;
 	if (lo->lo_state != Lo_unbound)
@@ -1012,10 +1023,15 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	mutex_unlock(&loop_ctl_mutex);
 	if (partscan)
 		loop_reread_partitions(lo, bdev);
+	if (!(mode & FMODE_EXCL))
+		blkdev_put(bdev, mode | FMODE_EXCL);
 	return 0;
 
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
+out_bdev:
+	if (!(mode & FMODE_EXCL))
+		blkdev_put(bdev, mode | FMODE_EXCL);
 out_putf:
 	fput(file);
 out:
-- 
2.16.4

