Return-Path: <jack@suse.cz>
Date: Wed, 22 Feb 2017 09:51:07 +0100
From: Jan Kara <jack@suse.cz>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	Tejun Heo <tj@kernel.org>, NeilBrown <neilb@suse.de>,
	Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 04/13] block: Move bdi_unregister() to del_gendisk()
Message-ID: <20170222085107.GA23312@quack2.suse.cz>
References: <20170221170958.21845-1-jack@suse.cz>
 <20170221170958.21845-5-jack@suse.cz>
 <1D08B61A9CF0974AA09887BE32D889DA0AC71A@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1D08B61A9CF0974AA09887BE32D889DA0AC71A@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Tue 21-02-17 19:53:29, Bart Van Assche wrote:
> On 02/21/2017 09:55 AM, Jan Kara wrote:
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 47104f6a398b..9a901dcfdd5c 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -580,8 +580,6 @@ void blk_cleanup_queue(struct request_queue *q)
> >  		q->queue_lock = &q->__queue_lock;
> >  	spin_unlock_irq(lock);
> >  
> > -	bdi_unregister(q->backing_dev_info);
> > -
> >  	/* @q is and will stay empty, shutdown and put */
> >  	blk_put_queue(q);
> >  }
> > diff --git a/block/genhd.c b/block/genhd.c
> > index f6c4d4400759..68c613edb93a 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -660,6 +660,13 @@ void del_gendisk(struct gendisk *disk)
> >  	disk->flags &= ~GENHD_FL_UP;
> >  
> >  	sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
> > +	/*
> > +	 * Unregister bdi before releasing device numbers (as they can get
> > +	 * reused and we'd get clashes in sysfs) but after bdev inodes are
> > +	 * unhashed and thus will be soon destroyed as bdev inode's reference
> > +	 * to wb_writeback can block bdi_unregister().
> > +	 */
> > +	bdi_unregister(disk->queue->backing_dev_info);
> >  	blk_unregister_queue(disk);
> >  	blk_unregister_region(disk_devt(disk), disk->minors);
> 
> This change looks suspicious to me. There are drivers that create a
> block layer queue but neither call device_add_disk() nor del_gendisk(),
> e.g. drivers/scsi/st.c. Although bdi_init() will be called for the
> queues created by these drivers, this patch will cause the
> bdi_unregister() call to be skipped for these drivers.

Well, the thing is that bdi_unregister() is the counterpart to
bdi_register(). Unless you call bdi_register(), which happens only in
device_add_disk() (and some filesystems which create their private bdis),
there's no point in calling bdi_unregister(). Counterpart to bdi_init() is
bdi_exit() and that gets called always once bdi reference count drops to 0.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
