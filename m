Return-Path: <jack@suse.cz>
Date: Mon, 20 Nov 2017 17:43:00 +0100
From: Jan Kara <jack@suse.cz>
To: Hou Tao <houtao1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Tejun Heo <tj@kernel.org>, Tahsin Erdogan <tahsin@google.com>,
	Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 02/11] block: Fix race of bdev open with gendisk shutdown
Message-ID: <20171120164300.GE12826@quack2.suse.cz>
References: <20170313151410.5586-1-jack@suse.cz>
 <20170313151410.5586-3-jack@suse.cz>
 <c95bb137-8b91-815d-f0bf-c491889c2615@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c95bb137-8b91-815d-f0bf-c491889c2615@huawei.com>
List-ID: <linux-block@vger.kernel.org>

Hi Tao!

On Fri 17-11-17 14:51:18, Hou Tao wrote:
> On 2017/3/13 23:14, Jan Kara wrote:
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
> 
> > Fix the problem by checking whether the gendisk is still alive and inode
> > hashed when associating bdev inode with it and its bdi. That way we are
> > sure that we will not associate bdev inode with disk that got past
> > blk_unregister_region() in del_gendisk() (and thus device number can get
> > reused). Similarly, we will not associate bdev that was once associated
> > with gendisk that is going away (and thus the corresponding bdev inode
> > will get unhashed in del_gendisk()) with a new gendisk that is just
> > reusing the device number.
> 
> I have run some extended tests based on Omar Sandoval's script [1] these days,
> and found two new problems related with the race between bdev open and gendisk
> shutdown.
> 
> The first problem lies in __blkdev_get(), and will cause use-after-free, or
> worse oops. It happens because there may be two instances of gendisk related
> with one bdev. When the process which owns the newer gendisk completes the
> invocation of __blkdev_get() firstly, the other process which owns the older
> gendisk will put the last reference of the older gendisk and cause use-after-free.
> 
> The following call sequences illustrate the problem:
> 
> unhash the bdev_inode of /dev/sda
> 
> process A (blkdev_open()):
> 	bd_acquire() returns new bdev_inode of /dev/sda
> 	get_gendisk() returns gendisk (v1 gendisk)
> 
> remove gendisk from bdev_map
> device number is reused

^^ this is through blk_unregister_region() in del_gendisk(), isn't it?

> process B (blkdev_open()):
> 	bd_acquire() returns new bdev_inode of /dev/sda
> 	get_gendisk() returns a new gendisk (v2 gendisk)
> 	increase bdev->bd_openers

So this needs to be a bit more complex - bd_acquire() must happen before
bdev_unhash_inode() in del_gendisk() above happened. And get_gendisk() must
happen after blk_unregister_region() from del_gendisk() happened. But yes,
this seems possible.

> process A (blkdev_open()):
> 	find bdev->bd_openers != 0
> 	put_disk(disk) // this is the last reference to v1 gendisk
> 	disk_unblock_events(disk) // use-after-free occurs
> 
> The problem can be fixed by an extra check showed in the following snippet:
> 
> static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
> {
> 	if (!bdev->bd_openers) {
> 	} else {
> 		if (bdev->bd_disk != disk) {
> 			ret = -ENXIO;
> 			goto out_unlock_bdev;
> 		}
> 	}
> }
>
> And we also can simplify the check in your patch by moving
> blk_unregister_region() before bdev_unhash_inode(), so whenever we get a
> new bdev_inode, the gendisk returned by get_gendisk() will either be NULL
> or a new gendisk.

I don't think we can do that. If we call blk_unregister_region() before
bdev_unhash_inode(), the device number can get reused while bdev inode is
still visible. So you can get that bdev inode v1 associated with gendisk
v2. And open following unhashing of bdev inode v1 will get bdev inode v2
associated with gendisk v2. So you have two different bdev inodes
associated with the same gendisk and that will cause data integrity issues.

But what you suggest above is probably a reasonable fix. Will you submit a
proper patch please?

> And the only check we need to do in __blkdev_get() is
> checking the hash status of the bdev_inode after we get a gendisk from
> get_gendisk(). The check can be done like the following snippet:
> 
> static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
> {
> 	/* ...... */
> 	ret = -ENXIO;
> 	disk = get_gendisk(bdev->bd_dev, &partno);
> 	if (!disk)
> 		goto out;
> 	owner = disk->fops->owner;
> 
> 	if (inode_unhashed(bdev->bd_inode))
> 		goto out_unmatched;
> }
> 
> The second problem lies in bd_start_claiming(), and will trigger the
> BUG_ON assert in blkdev_get: BUG_ON(!bd_may_claim(bdev, whole, holder)).
> It occurs when testing the exclusive open and close of the disk and its
> partitions.
> 
> The cause of the problem is that a bdev_inode of a disk partition
> corresponds with two instances of bdev_inode of the whole disk
> simultaneously. When one pair of the partition inode and disk inode
> completes the claiming, the other pair will be stumbled by the BUG_ON
> assert in blkdev_get() because bdev->bd_holder is no longer NULL.
> 
> The following sequences illustrate the problem:
> 
> unhash the bdev_inode of /dev/sda2
> 
> process A (blkdev_open()):
> 	bd_acquire() returns a new bdev_inode for /dev/sda2
> 	bd_start_claiming() returns bdev_inode of /dev/sda
> 
> process B (blkdev_open()):
> 	bd_acquire() returns the new bdev_inode for /dev/sda2
> 
> unhash the bdev_inode of /dev/sda
> remove gendisk from bdev_map
> device number is reused
> 
> process B (blkdev_open()):
> 	bd_start_claming() returns a new bdev_inode for /dev/sda
> 
> process A (blkdev_open()):
> 	__blkdev_get() returns successfully
> 	finish claiming  // bdev->bd_holder = holder
> 
> process B (blkdev_open()):
> 	__blkdev_get() returns successfully
> 	trigger BUG_ON(!bd_may_claim(bdev, whole, holder))

Ah, good spotting. Essentially the whole->bd_claiming protection for
partition bdev does not work because we've got two different 'whole' bdev
pointers.

> And the problem can be fixed by adding more checks in bd_start_claiming():
> 
> static struct block_device *bd_start_claiming(struct block_device *bdev,
>                                               void *holder)
> {
> 	/* ...... */
>         disk = get_gendisk(bdev->bd_dev, &partno);
>         if (!disk)
>                 return ERR_PTR(-ENXIO);
> 
>         if (inode_unhashed(bdev->bd_inode)) {
>                 module_put(disk->fops->owner);
>                 put_disk(disk);
>                 return ERR_PTR(-ENXIO);
>         }
> 
> 	/* ...... */
>         if (!whole)
>                 return ERR_PTR(-ENOMEM);
> 
>         if (inode_unhashed(bdev->bd_inode) ||
>                 inode_unhashed(whole->bd_inode)) {
>                 bdput(whole);
>                 return ERR_PTR(-ENXIO);
>         }
> }
> 
> Except adding more and more checks, are there better solutions to the
> race problem ?  I have thought about managing the device number by
> ref-counter, so the device number will not be reused until the last
> reference of bdev_inode and gendisk are released, and i am trying to
> figure out a way to get/put a reference of the device number when get/put
> the block_device.
> 
> So any suggests and thoughts ?

Yeah, these races are nasty. I will think whether there's some reasonably
easy way to fixing them or whether we'll have to go via some other route
like blocking the device number as you suggest. In either case thanks for
the report and the analysis!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
