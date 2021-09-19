Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D02C433EF
	for <linux-block@archiver.kernel.org>; Sun, 19 Sep 2021 14:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B07F361242
	for <linux-block@archiver.kernel.org>; Sun, 19 Sep 2021 14:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhISOqP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Sep 2021 10:46:15 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64487 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbhISOqH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Sep 2021 10:46:07 -0400
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 18JEiXaH043914;
        Sun, 19 Sep 2021 23:44:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Sun, 19 Sep 2021 23:44:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 18JEiTKq043904
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 19 Sep 2021 23:44:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH] block: genhd: fix double kfree() in __alloc_disk_node()
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     axboe@kernel.dk, Christoph Hellwig <hch@lst.de>
References: <0000000000004a5adf05cc593ca9@google.com>
 <41766564-08cb-e7f2-4cb2-9ad102f21324@I-love.SAKURA.ne.jp>
Cc:     linux-block@vger.kernel.org
Message-ID: <3999c511-cd27-1554-d3a6-4288c3eca298@i-love.sakura.ne.jp>
Date:   Sun, 19 Sep 2021 23:44:29 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <41766564-08cb-e7f2-4cb2-9ad102f21324@I-love.SAKURA.ne.jp>
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
by explicitly resetting bdev->bd_disk to NULL before calling iput().

Link: https://syzkaller.appspot.com/bug?extid=8281086e8a6fbfbd952a [1]
Reported-by: syzbot <syzbot+8281086e8a6fbfbd952a@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
This patch is not tested due to lack of reproducer. Is this fix correct?

 block/bdev.c  | 1 +
 block/genhd.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index cf2780cb44a7..f6b8bac83bd8 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -495,6 +495,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	bdev->bd_inode = inode;
 	bdev->bd_stats = alloc_percpu(struct disk_stats);
 	if (!bdev->bd_stats) {
+		bdev->bd_disk = NULL;
 		iput(inode);
 		return NULL;
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


