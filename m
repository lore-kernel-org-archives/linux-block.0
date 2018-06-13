Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
To: Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>, linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CACT4Y+Y7Mj1JngLst1aRHDhURXQMn-eTjyPFjDdGAT0ZV-dHrw@mail.gmail.com>
 <CACT4Y+bBfwpcP2h0URpqwiNMQ5SFJdPDHThUu2xetmrxgC+3BQ@mail.gmail.com>
 <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz>
 <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
 <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz>
 <20180611172053.GR1351649@devbig577.frc2.facebook.com>
 <20180612155754.x5k2yndh5t6wlmpy@quack2.suse.cz>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b210e55c-b06a-41ff-8592-0dbe21875779@i-love.sakura.ne.jp>
Date: Wed, 13 Jun 2018 19:43:47 +0900
MIME-Version: 1.0
In-Reply-To: <20180612155754.x5k2yndh5t6wlmpy@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2018/06/13 0:57, Jan Kara wrote:
> On Mon 11-06-18 10:20:53, Tejun Heo wrote:
>> Hello,
>>
>> On Mon, Jun 11, 2018 at 06:29:20PM +0200, Jan Kara wrote:
>>>> Would something like the following work or am I missing the point
>>>> entirely?
>>>
>>> I was pondering the same solution for a while but I think it won't work.
>>> The problem is that e.g. wb_memcg_offline() could have already removed
>>> wb from the radix tree but it is still pending in bdi->wb_list
>>> (wb_shutdown() has not run yet) and so we'd drop reference we didn't get.
>>
>> Yeah, right, so the root cause is that we're walking the wb_list while
>> holding lock and expecting the object to stay there even after lock is
>> released.  Hmm... we can use a mutex to synchronize the two
>> destruction paths.  It's not like they're hot paths anyway.
> 
> Hmm, do you mean like having a per-bdi or even a global mutex that would
> protect whole wb_shutdown()? Yes, that should work and we could get rid of
> WB_shutting_down bit as well with that. Just it seems a bit strange to
> introduce a mutex only to synchronize these two shutdown paths - usually
> locks protect data structures and in this case we have cgwb_lock for
> that so it looks like a duplication from a first look.
> 

Can't we utilize RCU grace period (like shown below) ?



If wb_shutdown(wb) by cgwb_release_workfn() was faster than wb_shutdown(wb) by cgwb_bdi_unregister():

  cgwb_bdi_unregister(bdi)                     cgwb_release_workfn(work)

                                                 wb = container_of(work, struct bdi_writeback, release_work);
    spin_lock_irq(&cgwb_lock);
    wb = list_first_entry(&bdi->wb_list, struct bdi_writeback, bdi_node); /* Same wb here */
    rcu_read_lock(); /* Prevent kfree_rcu() from invoking kfree() */
    spin_unlock_irq(&cgwb_lock);
                                                 wb_shutdown(wb);
                                                   spin_lock_bh(&wb->work_lock);
                                                   !test_and_clear_bit(WB_registered, &wb->state) is "false".
                                                   set_bit(WB_shutting_down, &wb->state);
                                                   spin_unlock_bh(&wb->work_lock);
                                                   mod_delayed_work(bdi_wq, &wb->dwork, 0);
                                                   flush_delayed_work(&wb->dwork);
                                                   cgwb_remove_from_bdi_list(wb);
                                                     spin_lock_irq(&cgwb_lock);
                                                     list_del_rcu(&wb->bdi_node);
                                                     spin_unlock_irq(&cgwb_lock);
                                                 wb_exit(wb);
                                                 kfree_rcu(wb, rcu); /* Won't call kfree() because of rcu_read_lock() */
    wb_shutdown(wb);
      spin_lock_bh(&wb->work_lock); /* Safe to access because kfree() cannot be called */
      !test_and_clear_bit(WB_registered, &wb->state) is "true".
      spin_unlock_bh(&wb->work_lock);
      rcu_read_unlock();
                                                   kfree(wb);
      schedule_timeout_uninterruptible(HZ / 10); /* Try to wait in case list_del_rcu() is not yet called */
    spin_lock_irq(&cgwb_lock);
    wb = list_first_entry(&bdi->wb_list, struct bdi_writeback, bdi_node); /* Different wb if list_del_rcu() was already called, same wb otherwise */
    rcu_read_lock(); /* Prevent kfree_rcu() from invoking kfree() if still same wb here */
    spin_unlock_irq(&cgwb_lock);

If wb_shutdown(wb) by cgwb_bdi_unregister() was faster than wb_shutdown(wb) by cgwb_release_workfn():

  cgwb_bdi_unregister(bdi)                     cgwb_release_workfn(work)

                                                 wb = container_of(work, struct bdi_writeback, release_work);
    spin_lock_irq(&cgwb_lock);
    wb = list_first_entry(&bdi->wb_list, struct bdi_writeback, bdi_node); /* Same wb here */
    rcu_read_lock();
    spin_unlock_irq(&cgwb_lock);
    wb_shutdown(wb);
      spin_lock_bh(&wb->work_lock);
      !test_and_clear_bit(WB_registered, &wb->state) is "false".
      set_bit(WB_shutting_down, &wb->state);
      spin_unlock_bh(&wb->work_lock);
      rcu_read_unlock();
      mod_delayed_work(bdi_wq, &wb->dwork, 0);
      flush_delayed_work(&wb->dwork);
      cgwb_remove_from_bdi_list(wb);
        spin_lock_irq(&cgwb_lock);
        list_del_rcu(&wb->bdi_node);
        spin_unlock_irq(&cgwb_lock);
    spin_lock_irq(&cgwb_lock);
    wb = list_first_entry(&bdi->wb_list, struct bdi_writeback, bdi_node); /* Different wb here */
    rcu_read_lock();
    spin_unlock_irq(&cgwb_lock);
                                                 wb_shutdown(wb);
                                                   spin_lock_bh(&wb->work_lock); /* Safe to access because kfree() cannot be called */
                                                   !test_and_clear_bit(WB_registered, &wb->state) is "true".
                                                   spin_unlock_bh(&wb->work_lock);
                                                 wb_exit(wb);
                                                 kfree_rcu(wb, rcu);



 mm/backing-dev.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 347cc83..6886cea 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -353,13 +353,24 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 /*
  * Remove bdi from the global list and shutdown any threads we have running
  */
-static void wb_shutdown(struct bdi_writeback *wb)
+static void wb_shutdown(struct bdi_writeback *wb, const bool in_rcu)
 {
 	/* Make sure nobody queues further work */
 	spin_lock_bh(&wb->work_lock);
 	if (!test_and_clear_bit(WB_registered, &wb->state)) {
 		spin_unlock_bh(&wb->work_lock);
 		/*
+		 * Try to wait for cgwb_remove_from_bdi_list() without
+		 * using wait_on_bit(), for kfree_rcu(wb, rcu) from
+		 * cgwb_release_workfn() might invoke kfree() before we
+		 * recheck WB_shutting_down bit.
+		 */
+		if (in_rcu) {
+			rcu_read_unlock();
+			schedule_timeout_uninterruptible(HZ / 10);
+			return;
+		}
+		/*
 		 * Wait for wb shutdown to finish if someone else is just
 		 * running wb_shutdown(). Otherwise we could proceed to wb /
 		 * bdi destruction before wb_shutdown() is finished.
@@ -369,8 +380,9 @@ static void wb_shutdown(struct bdi_writeback *wb)
 	}
 	set_bit(WB_shutting_down, &wb->state);
 	spin_unlock_bh(&wb->work_lock);
+	if (in_rcu)
+		rcu_read_unlock();
 
-	cgwb_remove_from_bdi_list(wb);
 	/*
 	 * Drain work list and shutdown the delayed_work.  !WB_registered
 	 * tells wb_workfn() that @wb is dying and its work_list needs to
@@ -379,6 +391,7 @@ static void wb_shutdown(struct bdi_writeback *wb)
 	mod_delayed_work(bdi_wq, &wb->dwork, 0);
 	flush_delayed_work(&wb->dwork);
 	WARN_ON(!list_empty(&wb->work_list));
+	cgwb_remove_from_bdi_list(wb);
 	/*
 	 * Make sure bit gets cleared after shutdown is finished. Matches with
 	 * the barrier provided by test_and_clear_bit() above.
@@ -508,7 +521,7 @@ static void cgwb_release_workfn(struct work_struct *work)
 	struct bdi_writeback *wb = container_of(work, struct bdi_writeback,
 						release_work);
 
-	wb_shutdown(wb);
+	wb_shutdown(wb, false);
 
 	css_put(wb->memcg_css);
 	css_put(wb->blkcg_css);
@@ -721,8 +734,9 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
 	while (!list_empty(&bdi->wb_list)) {
 		wb = list_first_entry(&bdi->wb_list, struct bdi_writeback,
 				      bdi_node);
+		rcu_read_lock();
 		spin_unlock_irq(&cgwb_lock);
-		wb_shutdown(wb);
+		wb_shutdown(wb, true);
 		spin_lock_irq(&cgwb_lock);
 	}
 	spin_unlock_irq(&cgwb_lock);
@@ -944,7 +958,7 @@ void bdi_unregister(struct backing_dev_info *bdi)
 {
 	/* make sure nobody finds us on the bdi_list anymore */
 	bdi_remove_from_list(bdi);
-	wb_shutdown(&bdi->wb);
+	wb_shutdown(&bdi->wb, false);
 	cgwb_bdi_unregister(bdi);
 
 	if (bdi->dev) {
-- 



Or, equivalent one but easier to read:



 mm/backing-dev.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 347cc83..77088a3 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -350,15 +350,25 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 
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
+		return false;
+	}
+	set_bit(WB_shutting_down, &wb->state);
+	spin_unlock_bh(&wb->work_lock);
+	return true;
+}
+
+/*
+ * Remove bdi from the global list and shutdown any threads we have running
+ */
+static void wb_shutdown(struct bdi_writeback *wb, const bool started)
+{
+	if (!started && !wb_start_shutdown(wb)) {
 		/*
 		 * Wait for wb shutdown to finish if someone else is just
 		 * running wb_shutdown(). Otherwise we could proceed to wb /
@@ -367,10 +377,6 @@ static void wb_shutdown(struct bdi_writeback *wb)
 		wait_on_bit(&wb->state, WB_shutting_down, TASK_UNINTERRUPTIBLE);
 		return;
 	}
-	set_bit(WB_shutting_down, &wb->state);
-	spin_unlock_bh(&wb->work_lock);
-
-	cgwb_remove_from_bdi_list(wb);
 	/*
 	 * Drain work list and shutdown the delayed_work.  !WB_registered
 	 * tells wb_workfn() that @wb is dying and its work_list needs to
@@ -379,6 +385,7 @@ static void wb_shutdown(struct bdi_writeback *wb)
 	mod_delayed_work(bdi_wq, &wb->dwork, 0);
 	flush_delayed_work(&wb->dwork);
 	WARN_ON(!list_empty(&wb->work_list));
+	cgwb_remove_from_bdi_list(wb);
 	/*
 	 * Make sure bit gets cleared after shutdown is finished. Matches with
 	 * the barrier provided by test_and_clear_bit() above.
@@ -508,7 +515,7 @@ static void cgwb_release_workfn(struct work_struct *work)
 	struct bdi_writeback *wb = container_of(work, struct bdi_writeback,
 						release_work);
 
-	wb_shutdown(wb);
+	wb_shutdown(wb, false);
 
 	css_put(wb->memcg_css);
 	css_put(wb->blkcg_css);
@@ -711,6 +718,7 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
 	struct radix_tree_iter iter;
 	void **slot;
 	struct bdi_writeback *wb;
+	bool started;
 
 	WARN_ON(test_bit(WB_registered, &bdi->wb.state));
 
@@ -721,8 +729,20 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
 	while (!list_empty(&bdi->wb_list)) {
 		wb = list_first_entry(&bdi->wb_list, struct bdi_writeback,
 				      bdi_node);
+		rcu_read_lock();
 		spin_unlock_irq(&cgwb_lock);
-		wb_shutdown(wb);
+		started = wb_start_shutdown(wb);
+		rcu_read_unlock();
+		if (started)
+			wb_shutdown(wb, true);
+		else
+			/*
+			 * Try to wait for cgwb_remove_from_bdi_list() without
+			 * using wait_on_bit(), for kfree_rcu(wb, rcu) from
+			 * cgwb_release_workfn() might invoke kfree() before we
+			 * recheck WB_shutting_down bit.
+			 */
+			schedule_timeout_uninterruptible(HZ / 10);
 		spin_lock_irq(&cgwb_lock);
 	}
 	spin_unlock_irq(&cgwb_lock);
@@ -944,7 +964,7 @@ void bdi_unregister(struct backing_dev_info *bdi)
 {
 	/* make sure nobody finds us on the bdi_list anymore */
 	bdi_remove_from_list(bdi);
-	wb_shutdown(&bdi->wb);
+	wb_shutdown(&bdi->wb, false);
 	cgwb_bdi_unregister(bdi);
 
 	if (bdi->dev) {
-- 



Or, toggling a dedicated flag using test_and_change_bit():



 include/linux/backing-dev-defs.h | 1 +
 mm/backing-dev.c                 | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 0bd432a..93ff83c 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -26,6 +26,7 @@ enum wb_state {
 	WB_writeback_running,	/* Writeback is in progress */
 	WB_has_dirty_io,	/* Dirty inodes on ->b_{dirty|io|more_io} */
 	WB_start_all,		/* nr_pages == 0 (all) work pending */
+	WB_postpone_kfree,      /* cgwb_bdi_unregister() will access later */
 };
 
 enum wb_congested_state {
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 347cc83..422d7a7 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -516,7 +516,10 @@ static void cgwb_release_workfn(struct work_struct *work)
 	fprop_local_destroy_percpu(&wb->memcg_completions);
 	percpu_ref_exit(&wb->refcnt);
 	wb_exit(wb);
-	kfree_rcu(wb, rcu);
+	spin_lock_irq(&cgwb_lock);
+	if (!test_and_change_bit(WB_postpone_kfree, &wb->state))
+		kfree_rcu(wb, rcu);
+	spin_unlock_irq(&cgwb_lock);
 }
 
 static void cgwb_release(struct percpu_ref *refcnt)
@@ -721,9 +724,12 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
 	while (!list_empty(&bdi->wb_list)) {
 		wb = list_first_entry(&bdi->wb_list, struct bdi_writeback,
 				      bdi_node);
+		set_bit(WB_postpone_kfree, &wb->state);
 		spin_unlock_irq(&cgwb_lock);
 		wb_shutdown(wb);
 		spin_lock_irq(&cgwb_lock);
+		if (!test_and_change_bit(WB_postpone_kfree, &wb->state))
+			kfree_rcu(wb, rcu);
 	}
 	spin_unlock_irq(&cgwb_lock);
 }
-- 
