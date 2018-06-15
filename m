Return-Path: <jack@suse.cz>
Date: Fri, 15 Jun 2018 14:06:20 +0200
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Dmitry Vyukov <dvyukov@google.com>, Jens Axboe <axboe@kernel.dk>,
	syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dave Chinner <david@fromorbit.com>, linux-block@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
Message-ID: <20180615120620.uyc7h6sudbpsecnm@quack2.suse.cz>
References: <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz>
 <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
 <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz>
 <20180611172053.GR1351649@devbig577.frc2.facebook.com>
 <20180612155754.x5k2yndh5t6wlmpy@quack2.suse.cz>
 <20180613143315.GS1351649@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="scbfshupznc5roe3"
In-Reply-To: <20180613143315.GS1351649@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>


--scbfshupznc5roe3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed 13-06-18 07:33:15, Tejun Heo wrote:
> Hello, Jan.
> 
> On Tue, Jun 12, 2018 at 05:57:54PM +0200, Jan Kara wrote:
> > > Yeah, right, so the root cause is that we're walking the wb_list while
> > > holding lock and expecting the object to stay there even after lock is
> > > released.  Hmm... we can use a mutex to synchronize the two
> > > destruction paths.  It's not like they're hot paths anyway.
> > 
> > Hmm, do you mean like having a per-bdi or even a global mutex that would
> > protect whole wb_shutdown()? Yes, that should work and we could get rid of
> > WB_shutting_down bit as well with that. Just it seems a bit strange to
> 
> Yeap.
> 
> > introduce a mutex only to synchronize these two shutdown paths - usually
> > locks protect data structures and in this case we have cgwb_lock for
> > that so it looks like a duplication from a first look.
> 
> Yeah, I feel a bit reluctant too but I think that's the right thing to
> do here.  This is an inherently weird case where there are two ways
> that an object can go away with the immediate drain requirement from
> one side.  It's not a hot path and the dumber the synchronization the
> better, right?

Yeah, fair enough. Something like attached patch? It is indeed considerably
simpler than fixing synchronization using WB_shutting_down. This one even
got some testing using scsi_debug, I want to do more testing next week with
more cgroup writeback included.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--scbfshupznc5roe3
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-bdi-Fix-another-oops-in-wb_workfn.patch"

>From 95fa7fe8ebc7dcf4d09a2e097c06abdf24ba81b5 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 14 Jun 2018 14:30:03 +0200
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

We solve these issues by synchronizing writeback structure shutdown from
cgwb_bdi_unregister() with cgwb_release_workfn() using a new mutex.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/backing-dev-defs.h | 1 +
 mm/backing-dev.c                 | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 0bd432a4d7bd..661e3121e580 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -189,6 +189,7 @@ struct backing_dev_info {
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct radix_tree_root cgwb_tree; /* radix tree of active cgroup wbs */
 	struct rb_root cgwb_congested_tree; /* their congested states */
+	struct mutex cgwb_release_mutex;  /* protect shutdown of wb structs */
 #else
 	struct bdi_writeback_congested *wb_congested;
 #endif
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 347cc834c04a..078cb4e0fb62 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -508,10 +508,12 @@ static void cgwb_release_workfn(struct work_struct *work)
 	struct bdi_writeback *wb = container_of(work, struct bdi_writeback,
 						release_work);
 
+	mutex_lock(&wb->bdi->cgwb_release_mutex);
 	wb_shutdown(wb);
 
 	css_put(wb->memcg_css);
 	css_put(wb->blkcg_css);
+	mutex_unlock(&wb->bdi->cgwb_release_mutex);
 
 	fprop_local_destroy_percpu(&wb->memcg_completions);
 	percpu_ref_exit(&wb->refcnt);
@@ -697,6 +699,7 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 
 	INIT_RADIX_TREE(&bdi->cgwb_tree, GFP_ATOMIC);
 	bdi->cgwb_congested_tree = RB_ROOT;
+	mutex_init(&bdi->cgwb_release_mutex);
 
 	ret = wb_init(&bdi->wb, bdi, 1, GFP_KERNEL);
 	if (!ret) {
@@ -717,7 +720,10 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
 	spin_lock_irq(&cgwb_lock);
 	radix_tree_for_each_slot(slot, &bdi->cgwb_tree, &iter, 0)
 		cgwb_kill(*slot);
+	spin_unlock_irq(&cgwb_lock);
 
+	mutex_lock(&bdi->cgwb_release_mutex);
+	spin_lock_irq(&cgwb_lock);
 	while (!list_empty(&bdi->wb_list)) {
 		wb = list_first_entry(&bdi->wb_list, struct bdi_writeback,
 				      bdi_node);
@@ -726,6 +732,7 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
 		spin_lock_irq(&cgwb_lock);
 	}
 	spin_unlock_irq(&cgwb_lock);
+	mutex_unlock(&bdi->cgwb_release_mutex);
 }
 
 /**
-- 
2.16.4


--scbfshupznc5roe3--
