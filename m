Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BB5C433F5
	for <linux-block@archiver.kernel.org>; Sat,  2 Oct 2021 09:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C80EB6136A
	for <linux-block@archiver.kernel.org>; Sat,  2 Oct 2021 09:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhJBJY5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Oct 2021 05:24:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57615 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbhJBJY5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Oct 2021 05:24:57 -0400
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1929N4Cu034754;
        Sat, 2 Oct 2021 18:23:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Sat, 02 Oct 2021 18:23:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1929N4ed034748
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 2 Oct 2021 18:23:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH v2 (RESEND)] block: genhd: fix double kfree() in
 __alloc_disk_node()
Message-ID: <e6dd13c5-8db0-4392-6e78-a42ee5d2a1c4@i-love.sakura.ne.jp>
Date:   Sat, 2 Oct 2021 18:23:02 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot is reporting use-after-free read at bdev_free_inode() [1], for
kfree() from __alloc_disk_node() is called before bdev_free_inode()
(which is called after RCU grace period) reads bdev->bd_disk and calls
kfree(bdev->bd_disk).

Fix use-after-free read followed by double kfree() problem
by making sure that bdev->bd_disk is NULL when calling iput().

Link: https://syzkaller.appspot.com/bug?extid=8281086e8a6fbfbd952a [1]
Reported-by: syzbot <syzbot+8281086e8a6fbfbd952a@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
Changes in v2:
  Defer bdev->bd_disk assignment instead of resetting to NULL in bdev_alloc().

 block/bdev.c  | 2 +-
 block/genhd.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index cf2780cb44a7..485a258b0ab3 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -490,7 +490,6 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	bdev = I_BDEV(inode);
 	mutex_init(&bdev->bd_fsfreeze_mutex);
 	spin_lock_init(&bdev->bd_size_lock);
-	bdev->bd_disk = disk;
 	bdev->bd_partno = partno;
 	bdev->bd_inode = inode;
 	bdev->bd_stats = alloc_percpu(struct disk_stats);
@@ -498,6 +497,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 		iput(inode);
 		return NULL;
 	}
+	bdev->bd_disk = disk;
 	return bdev;
 }
 
diff --git a/block/genhd.c b/block/genhd.c
index 7b6e5e1cf956..496e8458c357 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1268,6 +1268,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 
 out_destroy_part_tbl:
 	xa_destroy(&disk->part_tbl);
+	disk->part0->bd_disk = NULL;
 	iput(disk->part0->bd_inode);
 out_free_bdi:
 	bdi_put(disk->bdi);
-- 
2.18.4
