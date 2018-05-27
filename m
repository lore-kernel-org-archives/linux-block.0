Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH] bdi: Fix another oops in wb_workfn()
To: syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, tj@kernel.org,
        david@fromorbit.com, linux-block@vger.kernel.org
References: <000000000000cbd959056d1851ca@google.com>
 <0c7c5dea-7312-8a59-9d1b-5467f69719bf@I-love.SAKURA.ne.jp>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <314ae2e0-c873-04ce-9cd5-fe2acadaee26@I-love.SAKURA.ne.jp>
Date: Sun, 27 May 2018 11:21:25 +0900
MIME-Version: 1.0
In-Reply-To: <0c7c5dea-7312-8a59-9d1b-5467f69719bf@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

>From 8a8222698163d1fe180258566e9a3ff43f54fcd9 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sun, 27 May 2018 11:08:20 +0900
Subject: [PATCH] bdi: Fix another oops in wb_workfn()

syzbot is still hitting NULL pointer dereference at wb_workfn() [1].
This might be because we overlooked that delayed_work_timer_fn() does not
check WB_registered before calling __queue_work() while mod_delayed_work()
does not wait for already started delayed_work_timer_fn() because it uses
del_timer() rather than del_timer_sync().

Make wb_shutdown() be careful about wb_wakeup_delayed() path.

[1] https://syzkaller.appspot.com/bug?id=e0818ccb7e46190b3f1038b0c794299208ed4206

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>
---
 mm/backing-dev.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 7441bd9..31e1d7e 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -372,11 +372,24 @@ static void wb_shutdown(struct bdi_writeback *wb)
 
 	cgwb_remove_from_bdi_list(wb);
 	/*
+	 * mod_delayed_work() is not appropriate here, for
+	 * delayed_work_timer_fn() from wb_wakeup_delayed() does not check
+	 * WB_registered before calling __queue_work().
+	 */
+	del_timer_sync(&wb->dwork.timer);
+	/*
+	 * Clear WORK_STRUCT_PENDING_BIT in order to make sure that next
+	 * queue_delayed_work() actually enqueues this work to the tail, for
+	 * wb_wakeup_delayed() already set WORK_STRUCT_PENDING_BIT before
+	 * scheduling delayed_work_timer_fn().
+	 */
+	cancel_delayed_work_sync(&wb->dwork);
+	/*
 	 * Drain work list and shutdown the delayed_work.  !WB_registered
 	 * tells wb_workfn() that @wb is dying and its work_list needs to
 	 * be drained no matter what.
 	 */
-	mod_delayed_work(bdi_wq, &wb->dwork, 0);
+	queue_delayed_work(bdi_wq, &wb->dwork, 0);
 	flush_delayed_work(&wb->dwork);
 	WARN_ON(!list_empty(&wb->work_list));
 	/*
-- 
1.8.3.1
