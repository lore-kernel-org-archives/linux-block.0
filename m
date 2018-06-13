Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
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
 <b210e55c-b06a-41ff-8592-0dbe21875779@i-love.sakura.ne.jp>
Message-ID: <6d3dc916-94fd-3684-7861-6b120e5616ee@i-love.sakura.ne.jp>
Date: Wed, 13 Jun 2018 20:51:13 +0900
MIME-Version: 1.0
In-Reply-To: <b210e55c-b06a-41ff-8592-0dbe21875779@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Tetsuo Handa wrote:
> Or, toggling a dedicated flag using test_and_change_bit():
> 
> 
>  include/linux/backing-dev-defs.h | 1 +
>  mm/backing-dev.c                 | 8 +++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 0bd432a..93ff83c 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -26,6 +26,7 @@ enum wb_state {
>  	WB_writeback_running,	/* Writeback is in progress */
>  	WB_has_dirty_io,	/* Dirty inodes on ->b_{dirty|io|more_io} */
>  	WB_start_all,		/* nr_pages == 0 (all) work pending */
> +	WB_postpone_kfree,      /* cgwb_bdi_unregister() will access later */
>  };
>  
>  enum wb_congested_state {
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 347cc83..422d7a7 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -516,7 +516,10 @@ static void cgwb_release_workfn(struct work_struct *work)
>  	fprop_local_destroy_percpu(&wb->memcg_completions);
>  	percpu_ref_exit(&wb->refcnt);
>  	wb_exit(wb);
> -	kfree_rcu(wb, rcu);
> +	spin_lock_irq(&cgwb_lock);
> +	if (!test_and_change_bit(WB_postpone_kfree, &wb->state))
> +		kfree_rcu(wb, rcu);
> +	spin_unlock_irq(&cgwb_lock);
>  }
>  
>  static void cgwb_release(struct percpu_ref *refcnt)
> @@ -721,9 +724,12 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
>  	while (!list_empty(&bdi->wb_list)) {
>  		wb = list_first_entry(&bdi->wb_list, struct bdi_writeback,
>  				      bdi_node);
> +		set_bit(WB_postpone_kfree, &wb->state);
>  		spin_unlock_irq(&cgwb_lock);
>  		wb_shutdown(wb);
>  		spin_lock_irq(&cgwb_lock);
> +		if (!test_and_change_bit(WB_postpone_kfree, &wb->state))
> +			kfree_rcu(wb, rcu);
>  	}
>  	spin_unlock_irq(&cgwb_lock);
>  }

Forgot to include below change, but isn't this approach the simplest?

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
