Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 18 Jun 2018 10:40:14 -0700
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
Message-ID: <20180618174014.GY1351649@devbig577.frc2.facebook.com>
References: <20180618134658.32302-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180618134658.32302-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 18, 2018 at 03:46:58PM +0200, Jan Kara wrote:
> syzbot is reporting NULL pointer dereference at wb_workfn() [1] due to
> wb->bdi->dev being NULL. And Dmitry confirmed that wb->state was
> WB_shutting_down after wb->bdi->dev became NULL. This indicates that
> unregister_bdi() failed to call wb_shutdown() on one of wb objects.
> 
> The problem is in cgwb_bdi_unregister() which does cgwb_kill() and thus
> drops bdi's reference to wb structures before going through the list of
> wbs again and calling wb_shutdown() on each of them. This way the loop
> iterating through all wbs can easily miss a wb if that wb has already
> passed through cgwb_remove_from_bdi_list() called from wb_shutdown()
> from cgwb_release_workfn() and as a result fully shutdown bdi although
> wb_workfn() for this wb structure is still running. In fact there are
> also other ways cgwb_bdi_unregister() can race with
> cgwb_release_workfn() leading e.g. to use-after-free issues:
> 
> CPU1                            CPU2
>                                 cgwb_bdi_unregister()
>                                   cgwb_kill(*slot);
> 
> cgwb_release()
>   queue_work(cgwb_release_wq, &wb->release_work);
> cgwb_release_workfn()
>                                   wb = list_first_entry(&bdi->wb_list, ...)
>                                   spin_unlock_irq(&cgwb_lock);
>   wb_shutdown(wb);
>   ...
>   kfree_rcu(wb, rcu);
>                                   wb_shutdown(wb); -> oops use-after-free
> 
> We solve these issues by synchronizing writeback structure shutdown from
> cgwb_bdi_unregister() with cgwb_release_workfn() using a new mutex. That
> way we also no longer need synchronization using WB_shutting_down as the
> mutex provides it for CONFIG_CGROUP_WRITEBACK case and without
> CONFIG_CGROUP_WRITEBACK wb_shutdown() can be called only once from
> bdi_unregister().
> 
> Reported-by: syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
