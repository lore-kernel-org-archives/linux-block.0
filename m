Return-Path: <jack@suse.cz>
Date: Wed, 9 May 2018 11:48:08 +0200
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] bdi: Fix oops in wb_workfn()
Message-ID: <20180509094808.pvkahp6h2xqbzbvi@quack2.suse.cz>
References: <20180503162626.27753-1-jack@suse.cz>
 <20180503215558.GB10363@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180503215558.GB10363@dastard>
List-ID: <linux-block@vger.kernel.org>

On Fri 04-05-18 07:55:58, Dave Chinner wrote:
> On Thu, May 03, 2018 at 06:26:26PM +0200, Jan Kara wrote:
> > Syzbot has reported that it can hit a NULL pointer dereference in
> > wb_workfn() due to wb->bdi->dev being NULL. This indicates that
> > wb_workfn() was called for an already unregistered bdi which should not
> > happen as wb_shutdown() called from bdi_unregister() should make sure
> > all pending writeback works are completed before bdi is unregistered.
> > Except that wb_workfn() itself can requeue the work with:
> > 
> > 	mod_delayed_work(bdi_wq, &wb->dwork, 0);
> > 
> > and if this happens while wb_shutdown() is waiting in:
> > 
> > 	flush_delayed_work(&wb->dwork);
> > 
> > the dwork can get executed after wb_shutdown() has finished and
> > bdi_unregister() has cleared wb->bdi->dev.
> > 
> > Make wb_workfn() use wakeup_wb() for requeueing the work which takes all
> > the necessary precautions against racing with bdi unregistration.
> > 
> > CC: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > CC: Tejun Heo <tj@kernel.org>
> > Fixes: 839a8e8660b6777e7fe4e80af1a048aebe2b5977
> > Reported-by: syzbot <syzbot+9873874c735f2892e7e9@syzkaller.appspotmail.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/fs-writeback.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 47d7c151fcba..471d863958bc 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -1961,7 +1961,7 @@ void wb_workfn(struct work_struct *work)
> >  	}
> >  
> >  	if (!list_empty(&wb->work_list))
> > -		mod_delayed_work(bdi_wq, &wb->dwork, 0);
> > +		wb_wakeup(wb);
> >  	else if (wb_has_dirty_io(wb) && dirty_writeback_interval)
> >  		wb_wakeup_delayed(wb);
> 
> Yup, looks fine - I can't see any more of these open coded wakeup,
> either, so we should be good here.
> 
> Reviewed-by: Dave Chinner <dchinner@redhat.com>

Thanks!

> As an aside, why is half the wb infrastructure in fs/fs-writeback.c
> and the other half in mm/backing-dev.c? it seems pretty random as to
> what is where e.g. wb_wakeup() and wb_wakeup_delayed() are almost
> identical, but are in completely different files...

Yeah, it deserves a cleanup.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
