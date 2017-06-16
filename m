Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34082 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751815AbdFPFEI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2017 01:04:08 -0400
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@fb.com>
Date: Fri, 16 Jun 2017 15:02:09 +1000
Subject: [PATCH 2/2] loop: Add PF_LESS_THROTTLE to block/loop device thread.
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <149758932925.10006.1411305319375332201.stgit@noble>
In-Reply-To: <149758925866.10006.12779875832895865043.stgit@noble>
References: <149758925866.10006.12779875832895865043.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When a filesystem is mounted from a loop device, writes are
throttled by balance_dirty_pages() twice: once when writing
to the filesystem and once when the loop_handle_cmd() writes
to the backing file.  This double-throttling can trigger
positive feedback loops that create significant delays.  The
throttling at the lower level is seen by the upper level as
a slow device, so it throttles extra hard.

The PF_LESS_THROTTLE flag was created to handle exactly this
circumstance, though with an NFS filesystem mounted from a
local NFS server.  It reduces the throttling on the lower
layer so that it can proceed largely unthrottled.

To demonstrate this, create a filesystem on a loop device
and write (e.g. with dd) several large files which combine
to consume significantly more than the limit set by
/proc/sys/vm/dirty_ratio or dirty_bytes.  Measure the total
time taken.

When I do this directly on a device (no loop device) the
total time for several runs (mkfs, mount, write 200 files,
umount) is fairly stable: 28-35 seconds.
When I do this over a loop device the times are much worse
and less stable.  52-460 seconds.  Half below 100seconds,
half above.
When I apply this patch, the times become stable again,
though not as fast as the no-loop-back case: 53-72 seconds.

There may be room for further improvement as the total overhead still
seems too high, but this is a big improvement.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <tom.leiming@gmail.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/block/loop.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9c457ca6c55e..6ed7c4506951 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -843,10 +843,16 @@ static void loop_unprepare_queue(struct loop_device *lo)
 	kthread_stop(lo->worker_task);
 }
 
+static int loop_kthread_worker_fn(void *worker_ptr)
+{
+	current->flags |= PF_LESS_THROTTLE;
+	return kthread_worker_fn(worker_ptr);
+}
+
 static int loop_prepare_queue(struct loop_device *lo)
 {
 	kthread_init_worker(&lo->worker);
-	lo->worker_task = kthread_run(kthread_worker_fn,
+	lo->worker_task = kthread_run(loop_kthread_worker_fn,
 			&lo->worker, "loop%d", lo->lo_number);
 	if (IS_ERR(lo->worker_task))
 		return -ENOMEM;
