Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109F9C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 08:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3CB061077
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 08:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbhITIdN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 04:33:13 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55699 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbhITIdM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 04:33:12 -0400
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 18K8Vc0Q047504;
        Mon, 20 Sep 2021 17:31:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Mon, 20 Sep 2021 17:31:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 18K8VbLl047499
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 20 Sep 2021 17:31:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH v2] block: genhd: fix double kfree() in __alloc_disk_node()
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
References: <0000000000004a5adf05cc593ca9@google.com>
 <41766564-08cb-e7f2-4cb2-9ad102f21324@I-love.SAKURA.ne.jp>
 <3999c511-cd27-1554-d3a6-4288c3eca298@i-love.sakura.ne.jp>
 <20210920064028.GB26999@lst.de>
 <c5b78df8-1ab7-04fa-d6e8-c7270c3bc373@i-love.sakura.ne.jp>
 <20210920080547.GA30362@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <692fdc1a-6396-dcf4-c700-2d822f161053@i-love.sakura.ne.jp>
Date:   Mon, 20 Sep 2021 17:31:38 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210920080547.GA30362@lst.de>
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

