Return-Path: <jack@suse.cz>
Date: Fri, 10 Feb 2017 14:20:07 +0100
From: Jan Kara <jack@suse.cz>
To: NeilBrown <neilb@suse.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 07/10] writeback: Implement reliable switching to default
 writeback structure
Message-ID: <20170210132007.GA5491@quack2.suse.cz>
References: <20170209124433.2626-1-jack@suse.cz>
 <20170209124433.2626-8-jack@suse.cz>
 <87zihuu6rj.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87zihuu6rj.fsf@notabene.neil.brown.name>
List-ID: <linux-block@vger.kernel.org>

On Fri 10-02-17 13:19:44, NeilBrown wrote:
> On Thu, Feb 09 2017, Jan Kara wrote:
> 
> > Currently switching of inode between different writeback structures is
> > asynchronous and not guaranteed to succeed. Add a variant of switching
> > that is synchronous and reliable so that it can reliably move inode to
> > the default writeback structure (bdi->wb) when writeback on bdi is going
> > to be shutdown.
> >
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/fs-writeback.c         | 60 ++++++++++++++++++++++++++++++++++++++++-------
> >  include/linux/fs.h        |  3 ++-
> >  include/linux/writeback.h |  6 +++++
> >  3 files changed, 60 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 23dc97cf2a50..52992a1036b1 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -332,14 +332,11 @@ struct inode_switch_wbs_context {
> >  	struct work_struct	work;
> >  };
> >  
> > -static void inode_switch_wbs_work_fn(struct work_struct *work)
> > +static void do_inode_switch_wbs(struct inode *inode,
> > +				struct bdi_writeback *new_wb)
> >  {
> > -	struct inode_switch_wbs_context *isw =
> > -		container_of(work, struct inode_switch_wbs_context, work);
> > -	struct inode *inode = isw->inode;
> >  	struct address_space *mapping = inode->i_mapping;
> >  	struct bdi_writeback *old_wb = inode->i_wb;
> > -	struct bdi_writeback *new_wb = isw->new_wb;
> >  	struct radix_tree_iter iter;
> >  	bool switched = false;
> >  	void **slot;
> > @@ -436,15 +433,29 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
> >  	spin_unlock(&new_wb->list_lock);
> >  	spin_unlock(&old_wb->list_lock);
> >  
> > +	/*
> > +	 * Make sure waitqueue_active() check in wake_up_bit() cannot happen
> > +	 * before I_WB_SWITCH is cleared. Pairs with the barrier in
> > +	 * set_task_state() after wait_on_bit() added waiter to the wait queue.
> 
> I think you mean "set_current_state()" ??

Yes, I'll fix that.

> It's rather a trap for the unwary, this need for a smp_mb().
> Greping for wake_up_bit(), I find quite a few places with barriers -
> sometimes clear_bit_unlock() or spin_unlock() - but
> 
> fs/block_dev.c-         whole->bd_claiming = NULL;
> fs/block_dev.c:         wake_up_bit(&whole->bd_claiming, 0);
> 
> fs/cifs/connect.c-      clear_bit(TCON_LINK_PENDING, &tlink->tl_flags);
> fs/cifs/connect.c:      wake_up_bit(&tlink->tl_flags, TCON_LINK_PENDING);
> 
> fs/cifs/misc.c-                 clear_bit(CIFS_INODE_PENDING_WRITERS, &cinode->flags);
> fs/cifs/misc.c:                 wake_up_bit(&cinode->flags, CIFS_INODE_PENDING_WRITERS);
> 
> (several more in cifs)
> 
> net/sunrpc/xprt.c-      clear_bit(XPRT_CLOSE_WAIT, &xprt->state);
> net/sunrpc/xprt.c-      xprt->ops->close(xprt);
> net/sunrpc/xprt.c-      xprt_release_write(xprt, NULL);
> net/sunrpc/xprt.c:      wake_up_bit(&xprt->state, XPRT_LOCKED);
> (there might be a barrier in ->close or xprt_release_write() I guess)
> 
> security/keys/gc.c-             clear_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_flags);
> security/keys/gc.c:             wake_up_bit(&key_gc_flags, KEY_GC_REAPING_KEYTYPE);

Yup, the above look like bugs.

> I wonder if there is a good way to make this less error-prone.
> I would suggest that wake_up_bit() should always have a barrier, and
> __wake_up_bit() is needed to avoid it, but there is already a
> __wake_up_bit() with a slightly different interface.

Yeah, it is error-prone as all waitqueue_active() optimizations...
 
> In this case, you have a spin_unlock() just before the wake_up_bit().
> It is my understand that it would provide enough of a barrier (all
> writes before are globally visible after), so do you really need
> the barrier here?

I believe I do. spin_unlock() is a semi-permeable barrier - i.e., any read
or write from "outside" can be moved inside. So CPU is free to prefetch
values for waitqueue active checks before the spinlock is unlocked or even
before clearing I_WB_SWITCH bit.

> > +	 */
> > +	smp_mb();
> > +	wake_up_bit(&inode->i_state, __I_WB_SWITCH);
> > +
> >  	if (switched) {
> >  		wb_wakeup(new_wb);
> >  		wb_put(old_wb);
> >  	}
> > -	wb_put(new_wb);
> > +}
> >  
> > -	iput(inode);
> > -	kfree(isw);
> > +static void inode_switch_wbs_work_fn(struct work_struct *work)
> > +{
> > +	struct inode_switch_wbs_context *isw =
> > +		container_of(work, struct inode_switch_wbs_context, work);
> >  
> > +	do_inode_switch_wbs(isw->inode, isw->new_wb);
> > +	wb_put(isw->new_wb);
> > +	iput(isw->inode);
> > +	kfree(isw);
> >  	atomic_dec(&isw_nr_in_flight);
> >  }
> >  
> > @@ -521,6 +532,39 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
> >  }
> >  
> >  /**
> > + * inode_switch_to_default_wb_sync - change the wb association of an inode to
> > + *	the default writeback structure synchronously
> > + * @inode: target inode
> > + *
> > + * Switch @inode's wb association to the default writeback structure (bdi->wb).
> > + * Unlike inode_switch_wbs() the switching is performed synchronously and we
> > + * guarantee the inode is switched to the default writeback structure when this
> > + * function returns. Nothing prevents from someone else switching inode to
> > + * another writeback structure just when we are done though. Preventing that is
> > + * upto the caller if needed.
> > + */
> > +void inode_switch_to_default_wb_sync(struct inode *inode)
> > +{
> > +	struct backing_dev_info *bdi = inode_to_bdi(inode);
> > +
> > +	/* while holding I_WB_SWITCH, no one else can update the association */
> > +	spin_lock(&inode->i_lock);
> > +	if (WARN_ON_ONCE(inode->i_state & I_FREEING) ||
> > +	    !inode_to_wb_is_valid(inode) || inode_to_wb(inode) == &bdi->wb) {
> > +		spin_unlock(&inode->i_lock);
> > +		return;
> > +	}
> > +	__inode_wait_for_state_bit(inode, __I_WB_SWITCH);
> 
> I note that __inode_wait_for_state_bit() can drop and reclaim ->i_lock.
> is it possible that:
>   !inode_to_wb_is_valid(inode) || inode_to_wb(inode) == &bdi->wb)
> 
> could change while ->i_lock is unlocked?
> It would be particular unfortunate if inode_to_wb(inode) became &bdi->wb
> due to some thing thread, as do_inode_switch_wbs() will deadlock if
>   inode_to_wb(inode) == &bdi->wb
> 
> i.e. do you need to repeat the test?

That's a very good question and I think you are right that I need to repeat
the checks for inode->i_wb. Will fix. Thanks for review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
