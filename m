Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54805 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097AbcERI3h (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 18 May 2016 04:29:37 -0400
Date: Wed, 18 May 2016 10:29:33 +0200
From: Jan Kara <jack@suse.cz>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Jeff Moyer <jmoyer@redhat.com>,
	Stephen Bates <stephen.bates@microsemi.com>,
	Keith Busch <keith.busch@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH] block: Fix S_DAX inode flag locking
Message-ID: <20160518082933.GC26315@quack2.suse.cz>
References: <1463509797-10324-1-git-send-email-jonathan.derrick@intel.com>
 <1463509797-10324-2-git-send-email-jonathan.derrick@intel.com>
 <CAPcyv4hX2prAxpk9npM2mUGsSQ7Myjig-JfUfeXUANAzrcgTEQ@mail.gmail.com>
 <20160517203805.GA2231@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160517203805.GA2231@localhost.localdomain>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue 17-05-16 14:38:05, Jon Derrick wrote:
> On Tue, May 17, 2016 at 12:34:57PM -0700, Dan Williams wrote:
> > On Tue, May 17, 2016 at 11:29 AM, Jon Derrick
> > <jonathan.derrick@intel.com> wrote:
> > > This patch fixes S_DAX bd_inode i_flag locking to conform to suggested
> > 
> > A "fix" implies that its currently broken.  I don't see how it is, not
> > until we add an ioctl method or other path that also tries to update
> > the flags outside of blkdev_get() context.  So, I don't think this
> > patch stands on its own if you were intending it to be merged
> > separately.
> Are there no other paths that can set/clear a bd_inode->i_flags?
> If not, that's fine and I'll pack this into the next HIPRI set

So for block device inodes I don't think anybody else is currently messing
with i_flags but using some lock (and inode_lock() looks fine to me) for
that seems like a reasonable future-proofing. But I think it is enough to
send these patches together with your patch set if it introduces another
user of i_flags in block device inodes. It is always better to see a
concrete reason for the change.

> > > +       inode_lock(inode);
> > > +       if (inode->i_flags & S_DAX)
> > > +               inode->i_flags = S_DAX;
> > > +       inode_unlock(inode);
> > > +
> > 
> > Clear all other flags if S_DAX is set? Why?
>
> Code today sets i_flags = S_DAX, clearing all other flags, so I figured
> that's how it's supposed to be. Though I can't see any reason it has to
> be that way.

IMO that's just over-cautious code and there's no good reason for that.
Inodes are initialized with i_flags == 0. Some i_flags may be set by
previous openers of the block device inode but then these are presumably
consistent. So I'd just remove this zeroing.

> > > @@ -1309,6 +1329,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
> > >         bdev->bd_disk = NULL;
> > >         bdev->bd_part = NULL;
> > >         bdev->bd_queue = NULL;
> > > +       bd_clear_dax(inode);
> > 
> > Why?
> As far as I can tell, this path is only for cleanup when a whole block
> device or partition block device fails to get. Your question makes me
> think I don't understand this part of the code correctly, and admittedly
> I don't understand it all that well.
> 
> All callers of out_clear set an error code on ret, so I assumed all
> instances of out_clear are errors. There's no reason to keep the S_DAX
> flag on the bdev this time around. If it resolves itself (for example,
> GENHD_FL_UP gets set), it can be set again on the next __blkdev_get pass. 

Yeah, I agree. When we fail to properly set up the block device inode, it
probably makes sense to clear S_DAX just to be sure...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
