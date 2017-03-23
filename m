Return-Path: <jack@suse.cz>
Date: Thu, 23 Mar 2017 01:21:05 +0100
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Tahsin Erdogan <tahsin@google.com>,
	Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 02/11] block: Fix race of bdev open with gendisk shutdown
Message-ID: <20170323002105.GB18402@quack2.suse.cz>
References: <20170313151410.5586-1-jack@suse.cz>
 <20170313151410.5586-3-jack@suse.cz>
 <20170321161907.GB30919@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170321161907.GB30919@htj.duckdns.org>
List-ID: <linux-block@vger.kernel.org>

Hello Tejun,

> On Mon, Mar 13, 2017 at 04:14:01PM +0100, Jan Kara wrote:
> > blkdev_open() may race with gendisk shutdown in two different ways.
> > Either del_gendisk() has already unhashed block device inode (and thus
> > bd_acquire() will end up creating new block device inode) however
> > gen_gendisk() will still return the gendisk that is being destroyed.
> > Or bdev returned by bd_acquire() will get unhashed and gendisk destroyed
> > before we get to get_gendisk() and get_gendisk() will return new gendisk
> > that got allocated for device that reused the device number.
> > 
> > In both cases this will result in possible inconsistencies between
> > bdev->bd_disk and bdev->bd_bdi (in the first case after gendisk gets
> > destroyed and device number reused, in the second case immediately).
> > 
> > Fix the problem by checking whether the gendisk is still alive and inode
> > hashed when associating bdev inode with it and its bdi. That way we are
> > sure that we will not associate bdev inode with disk that got past
> > blk_unregister_region() in del_gendisk() (and thus device number can get
> > reused). Similarly, we will not associate bdev that was once associated
> > with gendisk that is going away (and thus the corresponding bdev inode
> > will get unhashed in del_gendisk()) with a new gendisk that is just
> > reusing the device number.
> > 
> > Also add a warning that will tell us about unexpected inconsistencies
> > between bdi associated with the bdev inode and bdi associated with the
> > disk.
> 
> Hmm... let's see if I got this straight.
> 
> It used to be that blockdevs are essentially stateless while nobody
> has it open.  It acquires all its actual associations during the
> initial open and loses them on the last release.  The immediate
> release semantics got us into trouble because upper layers had nothing
> to serve as the proper sever point when the underlying qblock device
> goes away.
> 
> So, we decided that bdi should serve that purpose, which makes perfect
> sense as it's what upper layers talk to when they wanna reach to the
> block device, so we decoupled its lifetime from the request_queue and
> implements sever there.
> 
> Now that bdis are persistent, we can solve bdev-access-while-not-open
> problem by making bdi point to the respective bdi from the beginning
> until it's released, which means that bdevs are now stateful objects
> which are associated with specific bdis and thus request_queues.

Yes, perfect summary.

> Because there are multiple ways that these objects are looked up and
> handled, now we can get into situations where the request_queue
> (gendisk) we look up during open may not match the bdi that a bdev is
> associated with, and this patch solves that problem by detecting the
> conditions where these mismatches would take place.  More
> specifically, we don't want to be using a dead bdev during open.

Yes.

> > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > index 53e2389ae4d4..5ec8750f5332 100644
> > --- a/fs/block_dev.c
> > +++ b/fs/block_dev.c
> > @@ -1560,7 +1560,8 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
> >  		if (!partno) {
> >  			ret = -ENXIO;
> >  			bdev->bd_part = disk_get_part(disk, partno);
> > -			if (!bdev->bd_part)
> > +			if (!(disk->flags & GENHD_FL_UP) || !bdev->bd_part ||
> > +			    inode_unhashed(bdev->bd_inode))
> >  				goto out_clear;
> 
> This adds both GENHD_FL_UP and unhashed testing; however, I'm not sure
> whether the former is meaningful here.  GENHD flag updates are not
> synchronized when seen from outside the party which is updating it.
> The actual synchronization against dead device should happen inside
> disk->fops->open().

Hum, now that I look at the code again it seems my patch is still racy if
we get fresh inode (lookup_bdev() already allocated new inode and returned
it to us) but get_gendisk() returned gendisk that is shutting down but
we'll still see GENHD_FL_UP set and thus associate new inode with gendisk
that is being destroyed.

> >  			ret = 0;
> > @@ -1614,7 +1615,8 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
> >  			bdev->bd_contains = whole;
> >  			bdev->bd_part = disk_get_part(disk, partno);
> >  			if (!(disk->flags & GENHD_FL_UP) ||
> > -			    !bdev->bd_part || !bdev->bd_part->nr_sects) {
> > +			    !bdev->bd_part || !bdev->bd_part->nr_sects ||
> > +			    inode_unhashed(bdev->bd_inode)) {
> >  				ret = -ENXIO;
> >  				goto out_clear;
> >  			}
> 
> Which is different from here.  As the device is already open, we're
> just incrementing the ref before granting another open without
> consulting the driver.  As the device is open already, whether
> granting a new ref or not can't break anything.  Block layer is just
> doing a best effort thing to not give out new ref on a dead one with
> the UP test, which is completely fine.

Yeah.

> > @@ -1623,6 +1625,9 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
> >  
> >  		if (bdev->bd_bdi == &noop_backing_dev_info)
> >  			bdev->bd_bdi = bdi_get(disk->queue->backing_dev_info);
> > +		else
> > +			WARN_ON_ONCE(bdev->bd_bdi !=
> > +				     disk->queue->backing_dev_info);
> 
> While I can't think of cases where this wouldn't work, it seems a bit
> roundabout to me.
> 
> * A bdi is the object which knows which request_queue it's associated
>   and when that association dies.

So bdi is associated with a request_queue but it does not have any
direct pointer or reference to it. It is the request_queue that points to
bdi. However you are right that bdi_unregister() call is telling bdi that
the device is going away.

> * bdev is permanently associated with a bdi.

Yes.

> So, it's kinda weird to look up the request_queue again on each open
> and then verify that the bd_bdi and request_queue match.  I think it
> would make more sense to skip disk look up and just go through bdi to
> determine the associated request_queue as that's the primary nexus
> object tying everything up now.

So I was thinking about this as well. The problem is that you cannot really
keep a reference to request_queue (or gendisk) from block device inode or
bdi as that could unexpectedly pin the driver in memory after user thinks
everything should be cleaned up. So I think we really do have to establish
the connection between block device inode and request_queue / gendisk on
opening of the block device and drop the reference when the block device is
closed.

> That said, it's totally possible that that would take too much
> restructuring to implement right now with everything else, but if we
> think that that's the right long term direction, I think it would make
> more sense to just test whether bdev->bd_bdi matches the disk right
> after looking up the disk and fail the open if not.  That's the
> ultimate condition we wanna avoid after all and it also would ease
> replacing it with going through bdi instead of looking up again.

The problem with this is that you could still associate fresh block device
inode with a bdi corresponding to gendisk that is going away (and that has
already went through bdev_unhash_inode()). Such block device inode may than
stay in case associated with that bdi even after the device number gets
reused and that will cause false the check for matching bdi to fail ever
after that moment.

So since I'm not actually able to trigger any of these races in my testing,
I guess I'll just drop this patch (it isn't needed by anything else in the
series) and let the reset of the series be merged. When I come up with some
better solution to this problem, I'll send a fix separately. Thanks for
review!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
