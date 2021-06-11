Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D51C48BE0
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 15:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A02B8613BC
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 15:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFKPQ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jun 2021 11:16:27 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60909 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhFKPQY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jun 2021 11:16:24 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 15BFEPbF009254;
        Sat, 12 Jun 2021 00:14:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Sat, 12 Jun 2021 00:14:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 15BFEPCB009250
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 12 Jun 2021 00:14:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH] loop: drop loop_ctl_mutex around del_gendisk() in
 loop_remove()
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Petr Vorel <pvorel@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>
References: <000000000000ae236f05bfde0678@google.com>
 <1435f266-9f6d-22ef-ba7d-f031c616aede@I-love.SAKURA.ne.jp>
 <7b8c9eeb-789d-e5e6-04d6-130ee8be7305@i-love.sakura.ne.jp>
 <20210609164639.GM4910@sequoia>
 <718b44b5-a230-1907-e1e1-9f609cb67322@i-love.sakura.ne.jp>
 <4e315cc1-cbb9-b00e-c4cd-ca4f6f60f202@i-love.sakura.ne.jp>
Message-ID: <d15e9392-44d0-f42c-cbac-859459a99395@i-love.sakura.ne.jp>
Date:   Sat, 12 Jun 2021 00:14:20 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4e315cc1-cbb9-b00e-c4cd-ca4f6f60f202@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot is reporting circular locking dependency between loop_ctl_mutex and
bdev->bd_mutex [1] due to commit c76f48eb5c084b1e ("block: take bd_mutex
around delete_partitions in del_gendisk").

But calling del_gendisk() from loop_remove() without loop_ctl_mutex held
triggers a different race problem regarding sysfs entry management. We
somehow need to serialize "add_disk() from loop_add()" and "del_gendisk()
 from loop_remove()". Fortunately, since loop_control_ioctl() is called
with no locks held, we can use "sleep and retry" approach without risking
deadlock.

Since "struct loop_device"->lo_disk->private_data is set to non-NULL at
loop_add() and is reset to NULL before calling loop_remove(), we can use
it as a flag for taking appropriate action ("sleep and retry" or "skip")
when loop_remove() is in progress.

Link: https://syzkaller.appspot.com/bug?extid=61e04e51b7ac86930589 [1]
Reported-by: syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>
Fixes: c76f48eb5c084b1e ("block: take bd_mutex around delete_partitions in del_gendisk")
---
 drivers/block/loop.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d58d68f3c7cd..d4c9567b2904 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2188,7 +2188,9 @@ static int loop_add(struct loop_device **l, int i)
 
 static void loop_remove(struct loop_device *lo)
 {
+	mutex_unlock(&loop_ctl_mutex);
 	del_gendisk(lo->lo_disk);
+	mutex_lock(&loop_ctl_mutex);
 	blk_cleanup_queue(lo->lo_queue);
 	blk_mq_free_tag_set(&lo->tag_set);
 	put_disk(lo->lo_disk);
@@ -2201,7 +2203,7 @@ static int find_free_cb(int id, void *ptr, void *data)
 	struct loop_device *lo = ptr;
 	struct loop_device **l = data;
 
-	if (lo->lo_state == Lo_unbound) {
+	if (lo->lo_state == Lo_unbound && lo->lo_disk->private_data) {
 		*l = lo;
 		return 1;
 	}
@@ -2254,6 +2256,13 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 	struct loop_device *lo;
 	int ret;
 
+	if (0) {
+unlock_and_retry:
+		mutex_unlock(&loop_ctl_mutex);
+		if (schedule_timeout_killable(HZ / 10))
+			return -EINTR;
+	}
+	debug_check_no_locks_held();
 	ret = mutex_lock_killable(&loop_ctl_mutex);
 	if (ret)
 		return ret;
@@ -2263,6 +2272,8 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 	case LOOP_CTL_ADD:
 		ret = loop_lookup(&lo, parm);
 		if (ret >= 0) {
+			if (!lo->lo_disk->private_data)
+				goto unlock_and_retry;
 			ret = -EEXIST;
 			break;
 		}
@@ -2272,6 +2283,8 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 		ret = loop_lookup(&lo, parm);
 		if (ret < 0)
 			break;
+		if (!lo->lo_disk->private_data)
+			goto unlock_and_retry;
 		ret = mutex_lock_killable(&lo->lo_mutex);
 		if (ret)
 			break;
@@ -2286,9 +2299,10 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 			break;
 		}
 		lo->lo_disk->private_data = NULL;
+		parm = lo->lo_number;
 		mutex_unlock(&lo->lo_mutex);
-		idr_remove(&loop_index_idr, lo->lo_number);
 		loop_remove(lo);
+		idr_remove(&loop_index_idr, parm);
 		break;
 	case LOOP_CTL_GET_FREE:
 		ret = loop_lookup(&lo, -1);
-- 
2.25.1


