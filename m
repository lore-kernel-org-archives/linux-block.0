Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
To: Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
References: <20180618134658.32302-1-jack@suse.cz>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e32deee5-97d4-9cc8-3eac-84e5ad9cc520@i-love.sakura.ne.jp>
Date: Mon, 18 Jun 2018 23:38:12 +0900
MIME-Version: 1.0
In-Reply-To: <20180618134658.32302-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2018/06/18 22:46, Jan Kara wrote:
> syzbot is reporting NULL pointer dereference at wb_workfn() [1] due to

[1] https://syzkaller.appspot.com/bug?id=e0818ccb7e46190b3f1038b0c794299208ed4206

line is missing.

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

Wow, this patch removes WB_shutting_down.

A bit of worry for me is how long will this mutex_lock() sleep, for
if there are a lot of wb objects to shutdown, sequentially doing
wb_shutdown() might block someone's mutex_lock() for longer than
khungtaskd's timeout period (typically 120 seconds) ?

> 
> Reported-by: syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  include/linux/backing-dev-defs.h |  2 +-
>  mm/backing-dev.c                 | 20 +++++++-------------
>  2 files changed, 8 insertions(+), 14 deletions(-)
