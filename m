Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1D9C433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Dec 2021 15:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbhLVP2F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Dec 2021 10:28:05 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:53677 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbhLVP2E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Dec 2021 10:28:04 -0500
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BMFRr6C003199;
        Thu, 23 Dec 2021 00:27:53 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Thu, 23 Dec 2021 00:27:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BMFRrDj003196
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Dec 2021 00:27:53 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <9eff2034-2f32-54a3-e476-d0f609ab49c0@i-love.sakura.ne.jp>
Date:   Thu, 23 Dec 2021 00:27:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: [PATCH 2/2] loop: use task_work for autoclear operation
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
References: <e9f59c70-5dc9-45ce-be93-9f149028f922@i-love.sakura.ne.jp>
In-Reply-To: <e9f59c70-5dc9-45ce-be93-9f149028f922@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The kernel test robot is reporting that xfstest can fail at

  umount ext2 on xfs
  umount xfs

sequence, for commit 322c4293ecc58110 ("loop: make autoclear operation
asynchronous") broke what commit ("loop: Make explicit loop device
destruction lazy") wanted to achieve.

Although we cannot guarantee that nobody is holding a reference when
"umount xfs" is called, we should try to close a race window opened
by asynchronous autoclear operation.

Try to make the autoclear operation upon close() synchronous, by calling
__loop_clr_fd() from current thread's task work rather than a WQ thread.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 25 ++++++++++++++++++++-----
 drivers/block/loop.h |  5 ++++-
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b1b05c45c07c..814605e2cbef 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1175,10 +1175,8 @@ static void loop_rundown_completed(struct loop_device *lo)
 	module_put(THIS_MODULE);
 }
 
-static void loop_rundown_workfn(struct work_struct *work)
+static void loop_rundown_start(struct loop_device *lo)
 {
-	struct loop_device *lo = container_of(work, struct loop_device,
-					      rundown_work);
 	struct block_device *bdev = lo->lo_device;
 	struct gendisk *disk = lo->lo_disk;
 
@@ -1188,6 +1186,18 @@ static void loop_rundown_workfn(struct work_struct *work)
 	loop_rundown_completed(lo);
 }
 
+static void loop_rundown_callbackfn(struct callback_head *callback)
+{
+	loop_rundown_start(container_of(callback, struct loop_device,
+					rundown.callback));
+}
+
+static void loop_rundown_workfn(struct work_struct *work)
+{
+	loop_rundown_start(container_of(work, struct loop_device,
+					rundown.work));
+}
+
 static void loop_schedule_rundown(struct loop_device *lo)
 {
 	struct block_device *bdev = lo->lo_device;
@@ -1195,8 +1205,13 @@ static void loop_schedule_rundown(struct loop_device *lo)
 
 	__module_get(disk->fops->owner);
 	kobject_get(&bdev->bd_device.kobj);
-	INIT_WORK(&lo->rundown_work, loop_rundown_workfn);
-	queue_work(system_long_wq, &lo->rundown_work);
+	if (!(current->flags & PF_KTHREAD)) {
+		init_task_work(&lo->rundown.callback, loop_rundown_callbackfn);
+		if (!task_work_add(current, &lo->rundown.callback, TWA_RESUME))
+			return;
+	}
+	INIT_WORK(&lo->rundown.work, loop_rundown_workfn);
+	queue_work(system_long_wq, &lo->rundown.work);
 }
 
 static int loop_clr_fd(struct loop_device *lo)
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 918a7a2dc025..596472f9cde3 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -56,7 +56,10 @@ struct loop_device {
 	struct gendisk		*lo_disk;
 	struct mutex		lo_mutex;
 	bool			idr_visible;
-	struct work_struct      rundown_work;
+	union {
+		struct work_struct   work;
+		struct callback_head callback;
+	} rundown;
 };
 
 struct loop_cmd {
-- 
2.32.0

