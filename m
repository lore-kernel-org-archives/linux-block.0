Return-Path: <jack@suse.cz>
Date: Mon, 11 Jun 2018 11:12:48 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Dmitry Vyukov <dvyukov@google.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-block@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
Message-ID: <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz>
References: <95865cab-e12f-d45b-b6e3-465b624862ba@i-love.sakura.ne.jp>
 <CACT4Y+byRRtCA9B9bPG9mjrf3UY3OsGeBsoh8dZ0T+V6tKpTHg@mail.gmail.com>
 <201806080231.w582VIRn021009@www262.sakura.ne.jp>
 <CACT4Y+Y7Mj1JngLst1aRHDhURXQMn-eTjyPFjDdGAT0ZV-dHrw@mail.gmail.com>
 <CACT4Y+bBfwpcP2h0URpqwiNMQ5SFJdPDHThUu2xetmrxgC+3BQ@mail.gmail.com>
 <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="frmuxgldwmreei4c"
In-Reply-To: <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
List-ID: <linux-block@vger.kernel.org>


--frmuxgldwmreei4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat 09-06-18 23:00:05, Tetsuo Handa wrote:
> From 014c4149f2e24cd26b278b32d5dfda056eecf093 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sat, 9 Jun 2018 22:47:52 +0900
> Subject: [PATCH] bdi: Fix another oops in wb_workfn()
> 
> syzbot is reporting NULL pointer dereference at wb_workfn() [1] due to
> wb->bdi->dev being NULL. And Dmitry confirmed that wb->state was
> WB_shutting_down after wb->bdi->dev became NULL. This indicates that
> unregister_bdi() failed to call wb_shutdown() on one of wb objects.
> 
> Since cgwb_bdi_unregister() from bdi_unregister() cannot call wb_shutdown()
> on wb objects which have already passed list_del_rcu() in wb_shutdown(),
> cgwb_bdi_unregister() from bdi_unregister() can return and set wb->bdi->dev
> to NULL before such wb objects enter final round of wb_workfn() via
> mod_delayed_work()/flush_delayed_work().

Thanks a lot for debugging the issue and also thanks a lot to Dmitry for
taking time to reproduce the race by hand with the debug patch! I really
appreciate it!

> Since WB_registered is already cleared by wb_shutdown(), only wb_shutdown()
> can schedule for final round of wb_workfn(). Since concurrent calls to
> wb_shutdown() on the same wb object is safe because of WB_shutting_down
> state, I think that wb_shutdown() can safely keep a wb object in the
> bdi->wb_list until that wb object leaves final round of wb_workfn().
> Thus, make wb_shutdown() call list_del_rcu() after flush_delayed_work().

However this is wrong and so is the patch. The problem is in
cgwb_bdi_unregister() which does cgwb_kill() and thus drops bdi's
reference to wb structures before going through the list of wbs again and
calling wb_shutdown() on each of them. The writeback structures we are
accessing at this point can be already freed in principle like:

CPU1				CPU2
				cgwb_bdi_unregister()
				  cgwb_kill(*slot);

cgwb_release()
  queue_work(cgwb_release_wq, &wb->release_work);
cgwb_release_workfn()
				  wb = list_first_entry(&bdi->wb_list, ...)
				  spin_unlock_irq(&cgwb_lock);
  wb_shutdown(wb);
  ...				
  kfree_rcu(wb, rcu);
				  wb_shutdown(wb); -> oops use-after-free

I'm not 100% sure how to fix this. wb structures can be at various phases of
shutdown (or there may be other external references still existing) when we
enter cgwb_bdi_unregister() so I think adding a way for cgwb_bdi_unregister()
to wait for standard wb shutdown path to finish is the most robust way.
What do you think about attached patch Tejun? So far only compile tested...

Possible problem with it is that now cgwb_bdi_unregister() will wait for
all wb references to be dropped so it adds some implicit dependencies to
bdi shutdown path. 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--frmuxgldwmreei4c
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-bdi-Fix-another-oops-in-wb_workfn.patch"

>From f5038c6e7a3d1a4a91879187b92ede8c868988ac Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 11 Jun 2018 10:56:04 +0200
Subject: [PATCH] bdi: Fix another oops in wb_workfn()

syzbot is reporting NULL pointer dereference at wb_workfn() [1] due to
wb->bdi->dev being NULL. And Dmitry confirmed that wb->state was
WB_shutting_down after wb->bdi->dev became NULL. This indicates that
unregister_bdi() failed to call wb_shutdown() on one of wb objects.

The problem is in cgwb_bdi_unregister() which does cgwb_kill() and thus
drops bdi's reference to wb structures before going through the list of
wbs again and calling wb_shutdown() on each of them. This way the loop
iterating through all wbs can easily miss a wb if that wb has already
passed through cgwb_remove_from_bdi_list() called from wb_shutdown()
from cgwb_release_workfn() and as a result fully shutdown bdi although
wb_workfn() for this wb structure is still running. In fact there are
also other ways cgwb_bdi_unregister() can race with
cgwb_release_workfn() leading e.g. to use-after-free issues:

CPU1                            CPU2
                                cgwb_bdi_unregister()
                                  cgwb_kill(*slot);

cgwb_release()
  queue_work(cgwb_release_wq, &wb->release_work);
cgwb_release_workfn()
                                  wb = list_first_entry(&bdi->wb_list, ...)
                                  spin_unlock_irq(&cgwb_lock);
  wb_shutdown(wb);
  ...
  kfree_rcu(wb, rcu);
                                  wb_shutdown(wb); -> oops use-after-free

We solve all these issues by making cgwb_bdi_unregister() wait for
shutdown of all wb structures instead of going through them and trying
to actively shut them down.

[1] https://syzkaller.appspot.com/bug?id=e0818ccb7e46190b3f1038b0c794299208ed4206

Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Tejun Heo <tj@kernel.org>
Reported-and-analyzed-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/backing-dev.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 347cc834c04a..39fa5f4ddd5c 100644
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
@@ -541,6 +541,9 @@ static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb)
 	spin_lock_irq(&cgwb_lock);
 	list_del_rcu(&wb->bdi_node);
 	spin_unlock_irq(&cgwb_lock);
+	/* Last wb of the bdi? Wake up waiters for shutdown of all wbs. */
+	if (list_empty(&wb->bdi->wb_list))
+		wake_up_all(&wb->bdi->wb_waitq);
 }
 
 static int cgwb_create(struct backing_dev_info *bdi,
@@ -710,22 +713,16 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
 {
 	struct radix_tree_iter iter;
 	void **slot;
-	struct bdi_writeback *wb;
 
 	WARN_ON(test_bit(WB_registered, &bdi->wb.state));
 
 	spin_lock_irq(&cgwb_lock);
 	radix_tree_for_each_slot(slot, &bdi->cgwb_tree, &iter, 0)
 		cgwb_kill(*slot);
-
-	while (!list_empty(&bdi->wb_list)) {
-		wb = list_first_entry(&bdi->wb_list, struct bdi_writeback,
-				      bdi_node);
-		spin_unlock_irq(&cgwb_lock);
-		wb_shutdown(wb);
-		spin_lock_irq(&cgwb_lock);
-	}
 	spin_unlock_irq(&cgwb_lock);
+
+	/* Wait for all writeback structures to shutdown */
+	wait_event(bdi->wb_waitq, list_empty(&bdi->wb_list));
 }
 
 /**
-- 
2.13.7


--frmuxgldwmreei4c--
