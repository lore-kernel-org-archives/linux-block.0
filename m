Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF1CC4743D
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 06:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB4961285
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 06:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFKGsr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jun 2021 02:48:47 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63846 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKGsr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jun 2021 02:48:47 -0400
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 15B6kmKC064515;
        Fri, 11 Jun 2021 15:46:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Fri, 11 Jun 2021 15:46:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 15B6kmvl064511
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 11 Jun 2021 15:46:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [syzbot] possible deadlock in del_gendisk
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Petr Vorel <pvorel@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>,
        Tejun Heo <tj@kernel.org>
References: <000000000000ae236f05bfde0678@google.com>
 <1435f266-9f6d-22ef-ba7d-f031c616aede@I-love.SAKURA.ne.jp>
 <7b8c9eeb-789d-e5e6-04d6-130ee8be7305@i-love.sakura.ne.jp>
 <20210609164639.GM4910@sequoia>
 <718b44b5-a230-1907-e1e1-9f609cb67322@i-love.sakura.ne.jp>
Message-ID: <4e315cc1-cbb9-b00e-c4cd-ca4f6f60f202@i-love.sakura.ne.jp>
Date:   Fri, 11 Jun 2021 15:46:48 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <718b44b5-a230-1907-e1e1-9f609cb67322@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I hoped that below patch fixes the problem, but it did not ( https://syzkaller.appspot.com/text?tag=CrashReport&x=111bc8f7d00000 ).
I guess we need to somehow serialize loop_add() and loop_remove() if we can't use loop_ctl_mutex...

From 2dfbd8e4a10c7883a85a2d4c32d83c93b2c3d485 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Fri, 11 Jun 2021 05:54:25 +0000
Subject: [not-yet-a-PATCH] loop: drop loop_ctl_mutex before calling del_gendisk()

syzbot is reporting circular locking dependency between loop_ctl_mutex and
bdev->bd_mutex [1] due to commit c76f48eb5c084b1e ("block: take bd_mutex
around delete_partitions in del_gendisk").

Since the lo becomes unreachable before del_gendisk() is called by
loop_remove(lo) from loop_control_ioctl(LOOP_CTL_REMOVE), we can drop
loop_ctl_mutex before calling loop_remove().

Holding loop_ctl_mutex in loop_exit() is pointless, for module's refcount
being 0 (unless forced module unload is requested) guarantees that nobody
is using /dev/loop* interface.

Link: https://syzkaller.appspot.com/bug?extid=61e04e51b7ac86930589 [1]
Reported-by: syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>
Fixes: c76f48eb5c084b1e ("block: take bd_mutex around delete_partitions in del_gendisk")
---
 drivers/block/loop.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d58d68f3c7cd..3045bcb9f7ed 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2079,6 +2079,7 @@ static const struct blk_mq_ops loop_mq_ops = {
 	.complete	= lo_complete_rq,
 };
 
+/* Must be called with loop_ctl_mutex held. */
 static int loop_add(struct loop_device **l, int i)
 {
 	struct loop_device *lo;
@@ -2186,6 +2187,7 @@ static int loop_add(struct loop_device **l, int i)
 	return err;
 }
 
+/* Must not be called with loop_ctl_mutex or lo->lo_mutex held. */
 static void loop_remove(struct loop_device *lo)
 {
 	del_gendisk(lo->lo_disk);
@@ -2288,8 +2290,9 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 		lo->lo_disk->private_data = NULL;
 		mutex_unlock(&lo->lo_mutex);
 		idr_remove(&loop_index_idr, lo->lo_number);
+		mutex_unlock(&loop_ctl_mutex);
 		loop_remove(lo);
-		break;
+		return 0;
 	case LOOP_CTL_GET_FREE:
 		ret = loop_lookup(&lo, -1);
 		if (ret >= 0)
@@ -2397,16 +2400,12 @@ static int loop_exit_cb(int id, void *ptr, void *data)
 
 static void __exit loop_exit(void)
 {
-	mutex_lock(&loop_ctl_mutex);
-
 	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
 	idr_destroy(&loop_index_idr);
 
 	unregister_blkdev(LOOP_MAJOR, "loop");
 
 	misc_deregister(&loop_misc);
-
-	mutex_unlock(&loop_ctl_mutex);
 }
 
 module_init(loop_init);
-- 
2.25.1


