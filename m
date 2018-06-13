Return-Path: <jack@suse.cz>
Date: Wed, 13 Jun 2018 16:46:06 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>, Jens Axboe <axboe@kernel.dk>,
	syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dave Chinner <david@fromorbit.com>, linux-block@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
Message-ID: <20180613144606.nvbcyg2rdjpxhf7s@quack2.suse.cz>
References: <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz>
 <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
 <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz>
 <20180611172053.GR1351649@devbig577.frc2.facebook.com>
 <20180612155754.x5k2yndh5t6wlmpy@quack2.suse.cz>
 <b210e55c-b06a-41ff-8592-0dbe21875779@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6rjndak2jmeoyd4q"
In-Reply-To: <b210e55c-b06a-41ff-8592-0dbe21875779@i-love.sakura.ne.jp>
List-ID: <linux-block@vger.kernel.org>


--6rjndak2jmeoyd4q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed 13-06-18 19:43:47, Tetsuo Handa wrote:
> Can't we utilize RCU grace period (like shown below) ?

Honestly, the variant 1 looks too ugly to me. However variant 2 looks
mostly OK. We can also avoid the schedule_timeout_uninterruptible(HZ / 10)
from your patch by careful handling of the bit waitqueues. Also I'd avoid
the addition argument to wb_writeback() and split the function instead. The
patch resulting from your and mine ideas is attached. Thoughts?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--6rjndak2jmeoyd4q
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-bdi-Fix-another-oops-in-wb_workfn.patch"

>From d0fbfad964ae5b0a331f0d814d527150bd0c305c Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Wed, 13 Jun 2018 16:39:00 +0200
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

We solve these issues by making wb_shutdown() remove the writeback
structure from the bdi_list only after all the shutdown is done and by
making sure cgwb_bdi_unregister() properly synchronizes with concurrent
shutdowns using WB_shutting_down bit.

Signed-off-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/backing-dev.c | 69 ++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 347cc834c04a..433807ae364e 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -350,27 +350,21 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 
 static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb);
 
-/*
- * Remove bdi from the global list and shutdown any threads we have running
- */
-static void wb_shutdown(struct bdi_writeback *wb)
+static bool wb_start_shutdown(struct bdi_writeback *wb)
 {
 	/* Make sure nobody queues further work */
 	spin_lock_bh(&wb->work_lock);
 	if (!test_and_clear_bit(WB_registered, &wb->state)) {
 		spin_unlock_bh(&wb->work_lock);
-		/*
-		 * Wait for wb shutdown to finish if someone else is just
-		 * running wb_shutdown(). Otherwise we could proceed to wb /
-		 * bdi destruction before wb_shutdown() is finished.
-		 */
-		wait_on_bit(&wb->state, WB_shutting_down, TASK_UNINTERRUPTIBLE);
-		return;
+		return false;
 	}
 	set_bit(WB_shutting_down, &wb->state);
 	spin_unlock_bh(&wb->work_lock);
+	return true;
+}
 
-	cgwb_remove_from_bdi_list(wb);
+static void __wb_shutdown(struct bdi_writeback *wb)
+{
 	/*
 	 * Drain work list and shutdown the delayed_work.  !WB_registered
 	 * tells wb_workfn() that @wb is dying and its work_list needs to
@@ -379,6 +373,7 @@ static void wb_shutdown(struct bdi_writeback *wb)
 	mod_delayed_work(bdi_wq, &wb->dwork, 0);
 	flush_delayed_work(&wb->dwork);
 	WARN_ON(!list_empty(&wb->work_list));
+	cgwb_remove_from_bdi_list(wb);
 	/*
 	 * Make sure bit gets cleared after shutdown is finished. Matches with
 	 * the barrier provided by test_and_clear_bit() above.
@@ -387,6 +382,23 @@ static void wb_shutdown(struct bdi_writeback *wb)
 	clear_and_wake_up_bit(WB_shutting_down, &wb->state);
 }
 
+/*
+ * Remove bdi from the global list and shutdown any threads we have running
+ */
+static void wb_shutdown(struct bdi_writeback *wb)
+{
+	if (!wb_start_shutdown(wb)) {
+		/*
+		 * Wait for wb shutdown to finish if someone else is just
+		 * running wb_shutdown(). Otherwise we could proceed to wb /
+		 * bdi destruction before wb_shutdown() is finished.
+		 */
+		wait_on_bit(&wb->state, WB_shutting_down, TASK_UNINTERRUPTIBLE);
+		return;
+	}
+	__wb_shutdown(wb);
+}
+
 static void wb_exit(struct bdi_writeback *wb)
 {
 	int i;
@@ -706,6 +718,35 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 	return ret;
 }
 
+/*
+ * Mark writeback structure as shutting down. The function returns true if
+ * we successfully marked the structure, false if shutdown was already in
+ * progress (in which case we also wait for it to finish).
+ *
+ * The function requires cgwb_lock to be held and releases it. Note that the
+ * caller need not hold reference to the writeback structure and thus once
+ * cgwb_lock is released, the writeback structure can be freed.
+ */
+static bool cgwb_start_shutdown(struct bdi_writeback *wb)
+	__releases(cgwb_lock)
+{
+	if (!wb_start_shutdown(wb)) {
+		DEFINE_WAIT(wait);
+		wait_queue_head_t *wqh = bit_waitqueue(&wb->state,
+						       WB_shutting_down);
+		bool sleep;
+
+		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+		sleep = test_bit(WB_shutting_down, &wb->state);
+		spin_unlock_irq(&cgwb_lock);
+		if (sleep)
+			schedule();
+		return false;
+	}
+	spin_unlock_irq(&cgwb_lock);
+	return true;
+}
+
 static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
 {
 	struct radix_tree_iter iter;
@@ -721,8 +762,8 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
 	while (!list_empty(&bdi->wb_list)) {
 		wb = list_first_entry(&bdi->wb_list, struct bdi_writeback,
 				      bdi_node);
-		spin_unlock_irq(&cgwb_lock);
-		wb_shutdown(wb);
+		if (cgwb_start_shutdown(wb))
+			__wb_shutdown(wb);
 		spin_lock_irq(&cgwb_lock);
 	}
 	spin_unlock_irq(&cgwb_lock);
-- 
2.13.7


--6rjndak2jmeoyd4q--
