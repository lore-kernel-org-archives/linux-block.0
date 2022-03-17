Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD63BC433EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Mar 2022 14:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbiCQOKA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Mar 2022 10:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCQOJ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Mar 2022 10:09:59 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCFA147AD9
        for <linux-block@vger.kernel.org>; Thu, 17 Mar 2022 07:08:37 -0700 (PDT)
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22HE87Wl019444;
        Thu, 17 Mar 2022 23:08:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Thu, 17 Mar 2022 23:08:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22HE86Vh019435
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 17 Mar 2022 23:08:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e0a0bc94-e6de-b0e5-ee46-a76cd1570ea6@I-love.SAKURA.ne.jp>
Date:   Thu, 17 Mar 2022 23:08:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block <linux-block@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] loop: add WQ_MEM_RECLAIM flag to per device workqueue
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit b5dd2f6047ca1080 ("block: loop: improve performance via blk-mq")
started using a global WQ_MEM_RECLAIM workqueue.

+       loop_wq = alloc_workqueue("kloopd",
+                       WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND, 0);

Commit f4aa4c7bbac6c4af ("block: loop: convert to per-device workqueue")
started using per device WQ_MEM_RECLAIM workqueue.

-       loop_wq = alloc_workqueue("kloopd",
-                       WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND, 0);
+       lo->wq = alloc_workqueue("kloopd%d",
+                       WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND, 0,
+                       lo->lo_number);

Commit 4d4e41aef9429872 ("block: loop: avoiding too many pending per work
I/O") adjusted max_active parameter.

-                       WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND, 0,
+                       WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND, 16,

Commit e03a3d7a94e2485b ("block: loop: use kthread_work") started using
per device kthread.

-       lo->wq = alloc_workqueue("kloopd%d",
-                       WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND, 16,
-                       lo->lo_number);
+       lo->worker_task = kthread_run(kthread_worker_fn,
+                       &lo->worker, "loop%d", lo->lo_number);

Commit 87579e9b7d8dc36e ("loop: use worker per cgroup instead of kworker")
again started using per device workqueue

-       lo->worker_task = kthread_run(loop_kthread_worker_fn,
-                       &lo->worker, "loop%d", lo->lo_number);
+       lo->workqueue = alloc_workqueue("loop%d",
+                                       WQ_UNBOUND | WQ_FREEZABLE,
+                                       0,
+                                       lo->lo_number);

but forgot to restore WQ_MEM_RECLAIM flag.

We should reserve one "struct task_struct" to each loop device in order
to guarantee that I/O request for writeback operation can make forward
progress even under memory pressure. I don't know why WQ_FREEZABLE flag
was added, but let's add WQ_MEM_RECLAIM flag like commit f4aa4c7bbac6c4af
("block: loop: convert to per-device workqueue") describes.

Fixes: 87579e9b7d8dc36e ("loop: use worker per cgroup instead of kworker")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 19fe19eaa50e..60dfebcedd95 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1013,7 +1013,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 		lo->lo_flags |= LO_FLAGS_READ_ONLY;
 
 	lo->workqueue = alloc_workqueue("loop%d",
-					WQ_UNBOUND | WQ_FREEZABLE,
+					WQ_MEM_RECLAIM | WQ_UNBOUND | WQ_FREEZABLE,
 					0,
 					lo->lo_number);
 	if (!lo->workqueue) {
-- 
2.32.0

