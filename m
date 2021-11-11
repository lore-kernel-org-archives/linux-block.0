Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB6CC433EF
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 15:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E70CC61252
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 15:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhKKPRb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 10:17:31 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:64501 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbhKKPRb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 10:17:31 -0500
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1ABFEQGY024589;
        Fri, 12 Nov 2021 00:14:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Fri, 12 Nov 2021 00:14:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1ABFEQ3w024582
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 Nov 2021 00:14:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <9e583550-7cc8-e8a9-59bf-69d415fffe16@i-love.sakura.ne.jp>
Date:   Fri, 12 Nov 2021 00:14:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [syzbot] possible deadlock in __loop_clr_fd (3)
Content-Language: en-US
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <00000000000089436205d07229eb@google.com>
 <0e91a4b0-ef91-0e60-c0fc-e03da3b65d57@I-love.SAKURA.ne.jp>
 <YYxqHhzEwCqhsy1Y@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <YYxqHhzEwCqhsy1Y@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/11/11 9:55, Dan Schatzberg wrote:
>> . Can you somehow call destroy_workqueue() without holding a lock (e.g.
>> breaking &lo->lo_mutex => (wq_completion)loop$M dependency chain by
>> making sure that below change is safe) ?
> 
> It's really not clear to me - the lo_mutex protects a lot of entry
> points (ioctls and others) and it's hard to tell if the observed state
> will be sane if they can race in the middle of __loop_clr_fd.
> 

I'm not familiar with the block layer, but I think it is clear.
We check lo_state with lo_mutex held.
The loop functions fail if lo_state is not what each function expected.

Is blk_mq_freeze_queue() for waiting for "loop_queue_work() from loop_queue_rq()" to
complete and for blocking further loop_queue_rq() until blk_mq_unfreeze_queue() ?
If yes, we need to call blk_mq_freeze_queue() before destroy_workqueue().
But I think lo_state is helping us, like a patch shown below.



From e36f23c081e0b8ed08239f4e3fbc954b4d7d3feb Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Thu, 11 Nov 2021 23:55:43 +0900
Subject: [PATCH] loop: destroy workqueue without holding locks

syzbot is reporting circular locking problem at __loop_clr_fd() [1], for
commit 87579e9b7d8dc36e ("loop: use worker per cgroup instead of kworker")
is calling destroy_workqueue() with lo->lo_mutex held.

Since all functions where lo->lo_state matters are already checking
lo->lo_state with lo->lo_mutex held (in order to avoid racing with e.g.
ioctl(LOOP_CTL_REMOVE)), and __loop_clr_fd() can be called from either
ioctl(LOOP_CLR_FD) or close(), lo->lo_state == Lo_rundown is considered
as an exclusive lock for __loop_clr_fd(). Therefore, it is safe to
temporarily drop lo->lo_mutex when calling destroy_workqueue().

Link: https://syzkaller.appspot.com/bug?extid=63614029dfb79abd4383 [1]
Reported-by: syzbot <syzbot+63614029dfb79abd4383@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a154cab6cd98..b98ec1c2d950 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1104,16 +1104,20 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	 */
 
 	mutex_lock(&lo->lo_mutex);
-	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
-		err = -ENXIO;
-		goto out_unlock;
-	}
+	/*
+	 * Since this function is called upon "ioctl(LOOP_CLR_FD)" xor "close()
+	 * after ioctl(LOOP_CLR_FD)", it is a sign of something going wrong if
+	 * lo->lo_state has changed while waiting for lo->lo_mutex.
+	 */
+	BUG_ON(lo->lo_state != Lo_rundown);
 
+	/*
+	 * Since ioctl(LOOP_CLR_FD) depends on lo->lo_state == Lo_bound, it is
+	 * a sign of something going wrong if lo->lo_backing_file was not
+	 * assigned by ioctl(LOOP_SET_FD) or ioctl(LOOP_CONFIGURE).
+	 */
 	filp = lo->lo_backing_file;
-	if (filp == NULL) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
+	BUG_ON(!filp);
 
 	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
 		blk_queue_write_cache(lo->lo_queue, false, false);
@@ -1121,7 +1125,20 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	/* freeze request queue during the transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
+	/*
+	 * To avoid circular locking dependency, call destroy_workqueue()
+	 * without holding lo->lo_mutex.
+	 */
+	mutex_unlock(&lo->lo_mutex);
 	destroy_workqueue(lo->workqueue);
+	mutex_lock(&lo->lo_mutex);
+
+	/*
+	 * As explained above, lo->lo_state cannot be changed while waiting for
+	 * lo->lo_mutex.
+	 */
+	BUG_ON(lo->lo_state != Lo_rundown);
+
 	spin_lock_irq(&lo->lo_work_lock);
 	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
 				idle_list) {
@@ -1156,7 +1173,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 	lo_number = lo->lo_number;
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
-out_unlock:
 	mutex_unlock(&lo->lo_mutex);
 	if (partscan) {
 		/*
-- 
2.18.4


