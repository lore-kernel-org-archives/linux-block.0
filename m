Return-Path: <SRS0=T+5Q=ZA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1FFFA372C
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 11:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABA621D6C
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 11:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389905AbfKHLxg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:53:36 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56883 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391394AbfKHLqj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Nov 2019 06:46:39 -0500
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xA8BfQTc062503;
        Fri, 8 Nov 2019 20:41:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Fri, 08 Nov 2019 20:41:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126227191088.bbtec.net [126.227.191.88])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xA8BfKEh062452
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 8 Nov 2019 20:41:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH] block: Bail out iteration functions upon SIGKILL.
To:     Bob Liu <bob.liu@oracle.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <000000000000c52dbf05958f3f3a@google.com>
 <3fbc4bb2-a03b-fbfa-4803-47a6d0075ff2@I-love.SAKURA.ne.jp>
 <24296ff7-4a5f-2bd9-63c7-07831f7b4d8d@oracle.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <8fde32da-d5e5-11b7-9ed7-e3aa5b003647@i-love.sakura.ne.jp>
Date:   Fri, 8 Nov 2019 20:41:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <24296ff7-4a5f-2bd9-63c7-07831f7b4d8d@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot found that a thread can stall for minutes inside fallocate()
after that thread was killed by SIGKILL [1]. While trying to allocate
64TB of disk space using fallocate() is legal, delaying termination of
killed thread for minutes is bad. Thus, allow iteration functions in
block/blk-lib.c to be killable.

[1] https://syzkaller.appspot.com/bug?id=9386d051e11e09973d5a4cf79af5e8cedf79386d

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+b48daca8639150bc5e73@syzkaller.appspotmail.com>
---
 block/blk-lib.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 5f2c429..6ca7cae 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -7,9 +7,22 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/scatterlist.h>
+#include <linux/sched/signal.h>
 
 #include "blk.h"
 
+static int blk_should_abort(struct bio *bio)
+{
+	int ret;
+
+	cond_resched();
+	if (!fatal_signal_pending(current))
+		return 0;
+	ret = submit_bio_wait(bio);
+	bio_put(bio);
+	return ret ? ret : -EINTR;
+}
+
 struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp)
 {
 	struct bio *new = bio_alloc(gfp, nr_pages);
@@ -55,6 +68,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		return -EINVAL;
 
 	while (nr_sects) {
+		int ret;
 		sector_t req_sects = min_t(sector_t, nr_sects,
 				bio_allowed_max_sectors(q));
 
@@ -75,7 +89,11 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		 * us to schedule out to avoid softlocking if preempt
 		 * is disabled.
 		 */
-		cond_resched();
+		ret = blk_should_abort(bio);
+		if (ret) {
+			*biop = NULL;
+			return ret;
+		}
 	}
 
 	*biop = bio;
@@ -154,6 +172,8 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 	max_write_same_sectors = bio_allowed_max_sectors(q);
 
 	while (nr_sects) {
+		int ret;
+
 		bio = blk_next_bio(bio, 1, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
@@ -171,7 +191,11 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 			bio->bi_iter.bi_size = nr_sects << 9;
 			nr_sects = 0;
 		}
-		cond_resched();
+		ret = blk_should_abort(bio);
+		if (ret) {
+			*biop = NULL;
+			return ret;
+		}
 	}
 
 	*biop = bio;
@@ -230,6 +254,8 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		return -EOPNOTSUPP;
 
 	while (nr_sects) {
+		int ret;
+
 		bio = blk_next_bio(bio, 0, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
@@ -245,7 +271,11 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 			bio->bi_iter.bi_size = nr_sects << 9;
 			nr_sects = 0;
 		}
-		cond_resched();
+		ret = blk_should_abort(bio);
+		if (ret) {
+			*biop = NULL;
+			return ret;
+		}
 	}
 
 	*biop = bio;
@@ -281,6 +311,8 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 		return -EPERM;
 
 	while (nr_sects != 0) {
+		int ret;
+
 		bio = blk_next_bio(bio, __blkdev_sectors_to_bio_pages(nr_sects),
 				   gfp_mask);
 		bio->bi_iter.bi_sector = sector;
@@ -295,7 +327,11 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 			if (bi_size < sz)
 				break;
 		}
-		cond_resched();
+		ret = blk_should_abort(bio);
+		if (ret) {
+			*biop = NULL;
+			return ret;
+		}
 	}
 
 	*biop = bio;
-- 
1.8.3.1


