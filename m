Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E786DC433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Dec 2021 12:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244765AbhLVMCp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Dec 2021 07:02:45 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:53541 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbhLVMCm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Dec 2021 07:02:42 -0500
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BMC2UaM013651;
        Wed, 22 Dec 2021 21:02:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Wed, 22 Dec 2021 21:02:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BMC2T7A013446
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 22 Dec 2021 21:02:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <08d703d1-8b32-ec9b-2b50-54b8376d3d40@i-love.sakura.ne.jp>
Date:   Wed, 22 Dec 2021 21:02:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH 1/2] block: Add post_release() operation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add post_release() block device callback which allows release() block
device callback to schedule an extra cleanup operation while holding
disk->open_mutex and let post_release() callback synchronously perform
that operation without holding disk->open_mutex.

The loop driver needs this callback for synchronously performing autoclear
operation, for some userspace programs (e.g. xfstest) depend on that the
autoclear operation already completes by the moment lo_release() from
close() returns to userspace and immediately call umount() of a partition
containing a backing file which the autoclear operation will close(), but
temporarily dropping disk->open_mutex inside lo_release() in order to avoid
circular locking dependency is considered as a bad approach.

Note that unlike release() callback, post_release() callback is called
every time blkdev_put() is called. That is, the release() callback is
responsible for making it possible for post_release() callback to tell
whether post_release() callback has something to do.

Reported-by: kernel test robot <oliver.sang@intel.com>
Fixes: 322c4293ecc58110 ("loop: make autoclear operation asynchronous")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 block/bdev.c           | 2 ++
 include/linux/blkdev.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index 8bf93a19041b..0cb638d81a27 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -948,6 +948,8 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 	else
 		blkdev_put_whole(bdev, mode);
 	mutex_unlock(&disk->open_mutex);
+	if (bdev->bd_disk->fops->post_release)
+		bdev->bd_disk->fops->post_release(bdev->bd_disk);
 
 	module_put(disk->fops->owner);
 	blkdev_put_no_open(bdev);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c80cfaefc0a8..b252b1d87471 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1227,6 +1227,11 @@ struct block_device_operations {
 	 * driver.
 	 */
 	int (*alternative_gpt_sector)(struct gendisk *disk, sector_t *sector);
+	/*
+	 * Special callback for doing post-release callback without
+	 * disk->open_mutex held. Used by loop driver.
+	 */
+	void (*post_release)(struct gendisk *disk);
 };
 
 #ifdef CONFIG_COMPAT
-- 
2.32.0

