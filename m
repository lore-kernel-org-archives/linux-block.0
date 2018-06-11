Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 11 Jun 2018 09:01:31 -0700
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Dmitry Vyukov <dvyukov@google.com>, Jens Axboe <axboe@kernel.dk>,
	syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dave Chinner <david@fromorbit.com>, linux-block@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
Message-ID: <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
References: <95865cab-e12f-d45b-b6e3-465b624862ba@i-love.sakura.ne.jp>
 <CACT4Y+byRRtCA9B9bPG9mjrf3UY3OsGeBsoh8dZ0T+V6tKpTHg@mail.gmail.com>
 <201806080231.w582VIRn021009@www262.sakura.ne.jp>
 <CACT4Y+Y7Mj1JngLst1aRHDhURXQMn-eTjyPFjDdGAT0ZV-dHrw@mail.gmail.com>
 <CACT4Y+bBfwpcP2h0URpqwiNMQ5SFJdPDHThUu2xetmrxgC+3BQ@mail.gmail.com>
 <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Mon, Jun 11, 2018 at 11:12:48AM +0200, Jan Kara wrote:
> However this is wrong and so is the patch. The problem is in
> cgwb_bdi_unregister() which does cgwb_kill() and thus drops bdi's
> reference to wb structures before going through the list of wbs again and
> calling wb_shutdown() on each of them. The writeback structures we are
> accessing at this point can be already freed in principle like:
> 
> CPU1				CPU2
> 				cgwb_bdi_unregister()
> 				  cgwb_kill(*slot);
> 
> cgwb_release()
>   queue_work(cgwb_release_wq, &wb->release_work);
> cgwb_release_workfn()
> 				  wb = list_first_entry(&bdi->wb_list, ...)
> 				  spin_unlock_irq(&cgwb_lock);
>   wb_shutdown(wb);
>   ...				
>   kfree_rcu(wb, rcu);
> 				  wb_shutdown(wb); -> oops use-after-free
> 
> I'm not 100% sure how to fix this. wb structures can be at various phases of
> shutdown (or there may be other external references still existing) when we
> enter cgwb_bdi_unregister() so I think adding a way for cgwb_bdi_unregister()
> to wait for standard wb shutdown path to finish is the most robust way.
> What do you think about attached patch Tejun? So far only compile tested...
> 
> Possible problem with it is that now cgwb_bdi_unregister() will wait for
> all wb references to be dropped so it adds some implicit dependencies to
> bdi shutdown path. 

Would something like the following work or am I missing the point
entirely?

Thanks.

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 347cc83..359cacd 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -715,14 +715,19 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
 	WARN_ON(test_bit(WB_registered, &bdi->wb.state));
 
 	spin_lock_irq(&cgwb_lock);
-	radix_tree_for_each_slot(slot, &bdi->cgwb_tree, &iter, 0)
-		cgwb_kill(*slot);
+	radix_tree_for_each_slot(slot, &bdi->cgwb_tree, &iter, 0) {
+		struct bdi_writeback *wb = *slot;
+
+		wb_get(wb);
+		cgwb_kill(wb);
+	}
 
 	while (!list_empty(&bdi->wb_list)) {
 		wb = list_first_entry(&bdi->wb_list, struct bdi_writeback,
 				      bdi_node);
 		spin_unlock_irq(&cgwb_lock);
 		wb_shutdown(wb);
+		wb_put(wb);
 		spin_lock_irq(&cgwb_lock);
 	}
 	spin_unlock_irq(&cgwb_lock);


-- 
tejun
