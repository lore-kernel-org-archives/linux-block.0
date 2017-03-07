Return-Path: <jack@suse.cz>
Date: Tue, 7 Mar 2017 12:14:20 +0100
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	NeilBrown <neilb@suse.de>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 02/11] block: Fix race of bdev open with gendisk shutdown
Message-ID: <20170307111420.GF2578@quack2.suse.cz>
References: <20170306163404.1238-1-jack@suse.cz>
 <20170306163404.1238-3-jack@suse.cz>
 <20170306220459.GJ26127@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170306220459.GJ26127@htj.duckdns.org>
List-ID: <linux-block@vger.kernel.org>

On Mon 06-03-17 17:04:59, Tejun Heo wrote:
> Hello,
> 
> On Mon, Mar 06, 2017 at 05:33:55PM +0100, Jan Kara wrote:
> > +	disk->flags &= ~GENHD_FL_UP;
> > +	/*
> > +	 * Make sure __blkdev_open() sees the disk is going away before
> > +	 * starting to unhash bdev inodes.
> > +	 */
> > +	smp_wmb();
> 
> But which rmb is this paired with?  Without paring memory barriers
> don't do anything.

It is paired with the fact that the test (disk->flags & GENHD_FL_UP) in
__blkdev_get() cannot be reordered before the bd_acquire() call in
blkdev_open() (or however the bdev is looked up). I was thinking so long
about how and where to sanely comment on that that I did not write anything
in the end.

I was also thinking about adding an explicit barrier before that test just
to make things explicit since as you say below the first blkdev open is not
that hot path. Maybe that would be a better option?

> Given that this isn't a super hot path, I think it'd be far better to
> stick to a simpler synchronization mechanism.

I'd be happy to do so however struct gendisk does not have any lock in it
and introducing a special lock just for that seems awkward.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
