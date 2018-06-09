Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH] bdi: Fix another oops in wb_workfn()
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <95865cab-e12f-d45b-b6e3-465b624862ba@i-love.sakura.ne.jp>
 <CACT4Y+byRRtCA9B9bPG9mjrf3UY3OsGeBsoh8dZ0T+V6tKpTHg@mail.gmail.com>
 <201806080231.w582VIRn021009@www262.sakura.ne.jp>
 <CACT4Y+Y7Mj1JngLst1aRHDhURXQMn-eTjyPFjDdGAT0ZV-dHrw@mail.gmail.com>
 <CACT4Y+bBfwpcP2h0URpqwiNMQ5SFJdPDHThUu2xetmrxgC+3BQ@mail.gmail.com>
 <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
Message-ID: <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
Date: Sat, 9 Jun 2018 23:00:05 +0900
MIME-Version: 1.0
In-Reply-To: <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

>From 014c4149f2e24cd26b278b32d5dfda056eecf093 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 9 Jun 2018 22:47:52 +0900
Subject: [PATCH] bdi: Fix another oops in wb_workfn()

syzbot is reporting NULL pointer dereference at wb_workfn() [1] due to
wb->bdi->dev being NULL. And Dmitry confirmed that wb->state was
WB_shutting_down after wb->bdi->dev became NULL. This indicates that
unregister_bdi() failed to call wb_shutdown() on one of wb objects.

Since cgwb_bdi_unregister() from bdi_unregister() cannot call wb_shutdown()
on wb objects which have already passed list_del_rcu() in wb_shutdown(),
cgwb_bdi_unregister() from bdi_unregister() can return and set wb->bdi->dev
to NULL before such wb objects enter final round of wb_workfn() via
mod_delayed_work()/flush_delayed_work().

Since WB_registered is already cleared by wb_shutdown(), only wb_shutdown()
can schedule for final round of wb_workfn(). Since concurrent calls to
wb_shutdown() on the same wb object is safe because of WB_shutting_down
state, I think that wb_shutdown() can safely keep a wb object in the
bdi->wb_list until that wb object leaves final round of wb_workfn().
Thus, make wb_shutdown() call list_del_rcu() after flush_delayed_work().

[1] https://syzkaller.appspot.com/bug?id=e0818ccb7e46190b3f1038b0c794299208ed4206

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@fb.com>
---
 mm/backing-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 347cc83..bef4b25 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -370,7 +370,6 @@ static void wb_shutdown(struct bdi_writeback *wb)
 	set_bit(WB_shutting_down, &wb->state);
 	spin_unlock_bh(&wb->work_lock);
 
-	cgwb_remove_from_bdi_list(wb);
 	/*
 	 * Drain work list and shutdown the delayed_work.  !WB_registered
 	 * tells wb_workfn() that @wb is dying and its work_list needs to
@@ -379,6 +378,7 @@ static void wb_shutdown(struct bdi_writeback *wb)
 	mod_delayed_work(bdi_wq, &wb->dwork, 0);
 	flush_delayed_work(&wb->dwork);
 	WARN_ON(!list_empty(&wb->work_list));
+	cgwb_remove_from_bdi_list(wb);
 	/*
 	 * Make sure bit gets cleared after shutdown is finished. Matches with
 	 * the barrier provided by test_and_clear_bit() above.
-- 
1.8.3.1
