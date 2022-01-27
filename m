Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85B0C433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 01:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiA0BGH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 20:06:07 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:59993 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbiA0BGG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 20:06:06 -0500
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20R15lEu045928;
        Thu, 27 Jan 2022 10:05:47 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Thu, 27 Jan 2022 10:05:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20R15lAq045925
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Jan 2022 10:05:47 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7bebf860-2415-7eb6-55a1-47dc4439d9e9@I-love.SAKURA.ne.jp>
Date:   Thu, 27 Jan 2022 10:05:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: yet another approach to fix loop autoclear for xfstets xfs/049
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20220126155040.1190842-1-hch@lst.de>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220126155040.1190842-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/27 0:50, Christoph Hellwig wrote:
> Hi Jens, hi Tetsuo,
> 
> this series uses the approach from Tetsuo to delay the destroy_workueue
> call, extended by a delayed teardown of the workers to fix a potential
> racewindow then the workqueue can be still round after finishing the
> commands.  It then also removed the queue freeing in release that is
> not needed to fix the dependency chain for that (which can't be
> reported by lockdep) as well.

I want to remove disk->open_mutex => lo->lo_mutex => I/O completion chain itself from
/proc/lockdep . Even if real deadlock does not happen due to lo->lo_refcnt exclusion,
I consider that disk->open_mutex => lo->lo_mutex dependency being recorded is a bad sign.
It makes difficult to find real possibility of deadlock when things change in future.
I consider that lo_release() is doing too much things under disk->open_mutex.

I tried to defer lo->lo_mutex in lo_release() as much as possible. But this chain
still remains.

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cf7830a68113..a9abd213b38d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1706,12 +1706,19 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
 	struct loop_device *lo = bdev->bd_disk->private_data;
 	int err;
 
+	/*
+	 * Since lo_open() and lo_release() are serialized by disk->open_mutex,
+	 * we can racelessly increment/decrement lo->lo_refcnt without holding
+	 * lo->lo_mutex.
+	 */
 	if (atomic_inc_return(&lo->lo_refcnt) > 1)
 		return 0;
 
 	err = mutex_lock_killable(&lo->lo_mutex);
-	if (err)
+	if (err) {
+		atomic_dec(&lo->lo_refcnt);
 		return err;
+	}
 	if (lo->lo_state == Lo_deleting) {
 		atomic_dec(&lo->lo_refcnt);
 		err = -ENXIO;
@@ -1727,16 +1734,18 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 	if (!atomic_dec_and_test(&lo->lo_refcnt))
 		return;
 
-	mutex_lock(&lo->lo_mutex);
-	if (lo->lo_state == Lo_bound &&
-	    (lo->lo_flags & LO_FLAGS_AUTOCLEAR)) {
-		lo->lo_state = Lo_rundown;
-		mutex_unlock(&lo->lo_mutex);
-		__loop_clr_fd(lo, true);
+	/*
+	 * Since lo_open() and lo_release() are serialized by disk->open_mutex,
+	 * and lo->refcnt == 0 means nobody is using this device, we can read
+	 * lo->lo_state and lo->lo_flags without holding lo->lo_mutex.
+	 */
+	if (lo->lo_state != Lo_bound || !(lo->lo_flags & LO_FLAGS_AUTOCLEAR))
 		return;
-	}
-
+	mutex_lock(&lo->lo_mutex);
+	lo->lo_state = Lo_rundown;
 	mutex_unlock(&lo->lo_mutex);
+	__loop_clr_fd(lo, true);
+	return;
 }
 
 static const struct block_device_operations lo_fops = {

In __loop_clr_fd(), it waits for loop_validate_mutex. loop_validate_mutex can be
held when loop_change_fd() calls blk_mq_freeze_queue(). Loop recursion interacts
with other loop devices.

While each loop device takes care of only single backing file, we can use multiple
loop devices for multiple backing files within the same mount point (e.g. /dev/loop0
is attached on /mnt/file0 and /dev/loop1 is attached on /mnt/file1), can't we?
But fsfreeze is per a mount point (e.g. /mnt/). That is, fsfreeze also interacts
with other loop devices, doesn't it?

disk->open_mutex is a per a loop device serialization, but loop_validate_mutex and
fsfreeze are global serialization. It is anxious to involve global serialization under
individual serialization, when we already know that involvement of sysfs + fsfreeze
causes possibility of deadlock. I expect that lo_open()/lo_release() are done without
holding disk->open_mutex.

