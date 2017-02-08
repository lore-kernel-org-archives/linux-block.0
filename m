Return-Path: <jack@suse.cz>
Date: Wed, 8 Feb 2017 11:23:49 +0100
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/4 v2] BDI lifetime fix
Message-ID: <20170208102349.GA27541@quack2.suse.cz>
References: <20170131125429.14303-1-jack@suse.cz>
 <2851869.q2N89k4IqL@morokweng>
 <1790906.I1Z25HtRf4@morokweng>
 <20170207123331.GD13524@quack2.suse.cz>
 <20170207172101.GC6164@htj.duckdns.org>
 <20170208075142.GA26317@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170208075142.GA26317@quack2.suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Wed 08-02-17 08:51:42, Jan Kara wrote:
> On Tue 07-02-17 12:21:01, Tejun Heo wrote:
> > Hello,
> > 
> > On Tue, Feb 07, 2017 at 01:33:31PM +0100, Jan Kara wrote:
> > > > We can see above that inode->i_wb is in r31, and the machine crashed at 
> > > > 0xc0000000003799a0 so it was trying to dereference wb and crashed.
> > > > r31 is NULL in the crash information.
> > > 
> > > Thanks for report and the analysis. After some looking into the code I see
> > > where the problem is. Writeback code assumes inode->i_wb can never become
> > > invalid once it is set however we still call inode_detach_wb() from
> > > __blkdev_put(). So in a way this is a different problem but closely
> > > related.
> > 
> > Heh, it feels like we're chasing our own tails.
> 
> Pretty much. I went through the history of bdi registration and
> unregistration to understand various constraints and various different
> reasons keep pushing that around and always something breaks...
> 
> > > It seems to me that instead of calling inode_detach_wb() in __blkdev_put()
> > > we may just switch blkdev inode to bdi->wb (it is now guaranteed to stay
> > > around). That way bdi_unregister() can complete (destroying all writeback
> > > structures except for bdi->wb) while block device inode can still live with
> > > a valid i_wb structure.
> > 
> > So, the problem there would be synchronizing get_wb against the
> > transition.  We can do that and inode_switch_wbs_work_fn() already
> > does it but it is a bit nasty.
> 
> Yeah, I have prototyped that and it is relatively simple although we have
> to use synchronize_rcu() to be sure unlocked users of i_wb are done before
> switching and that is somewhat ugly. So I'm looking for ways to avoid the
> switching as well. Especially since from high-level POV the switching
> should not be necessary. Everything is going away and there is no real work
> to be done. Just we may be unlucky enough that e.g. flusher is looking
> whether there's some work to do and we remove stuff under its hands. So
> switching seems like a bit of an overkill.
> 
> > I'm getting a bit confused here, so the reason we added
> > inode_detach_wb() in __blkdev_put() was because the root wb might go
> > away because it's embedded in the bdi which is embedded in the
> > request_queue which is put and may be released by put_disk().
> > 
> > Are you saying that we changed the behavior so that bdi->wb stays
> > around?  If so, we can just remove the inode_detach_wb() call, no?
> 
> Yes, my patches (currently in linux-block) make bdi->wb stay around as long
> as the block device inode. However things are complicated by the fact that
> these days bdev_inode->i_wb may be pointing even to non-root wb_writeback
> structure. If that happens and we don't call inode_detach_wb(),
> bdi_unregister() will block waiting for reference count on wb_writeback to
> drop to zero which happens only once bdev inode is evicted from inode cache
> which may be far far in the future.
> 
> Now I think we can move bdi_unregister() into del_gendisk() (where it IMHO
> belongs anyway as a counterpart to device_add_disk() in which we call
> bdi_register()) and shutdown the block device inode there before calling
> bdi_unregister(). But I'm still figuring out whether it will not break
> something else because the code has lots of interactions...

More news from device shutdown world ;): I was looking more into how device
shutdown works. I was wondering what happens when device gets hot-removed
and how do we shutdown stuff. If I tracked the callback maze correctly, when
we remove scsi disk, we do __scsi_remove_device() -> device_del() ->
bus_remove_device() -> device_release_driver() -> sd_remove() ->
del_gendisk(). We also have __scsi_remove_device() -> blk_cleanup_queue()
-> bdi_unregister() shortly after the previous happening
<DETOUR BEGIN>
This ordering seems to be the real culprit of the bdi name reuse problems
Omar has reported? Same as described in commit 6cd18e711dd8 for MD BTW and
Dan's patch could be IMHO replaced by a move of bdi_unregister() from
blk_cleanup_queue() to del_gendisk() where it logically belongs as a
counterpart of device_add_disk(). I'll test that.
<DETOUR END>

__scsi_remove_device() is also called when the device was hot-removed. At
that point the bdev can still be open and in active use and its i_wb can
point to some non-root wb_writeback struct. Thus bdi_unregister() will
block waiting for that wb_writeback to get released and thus SCSI device
removal will block basically intefinitely (at least until fs on top of bdev
gets unmounted). I believe this is a bug and __scsi_remove_device() is
expected to finish regardless of upper layers still using the bdev. So to
fix this I don't think we can really avoid the switching of bdev inode from
non-root wb_writeback structure to bdi->wb.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
