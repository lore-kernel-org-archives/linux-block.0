Return-Path: <famz@redhat.com>
Date: Wed, 17 Aug 2016 16:48:23 +0800
From: Fam Zheng <famz@redhat.com>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        virtualization@lists.linux-foundation.org,
        linux-nvme@lists.infradead.org, "Ed L. Cashin" <ed.cashin@acm.org>,
        Keith Busch <keith.busch@intel.com>, Minchan Kim <minchan@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-mtd@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
        Nitin Gupta <ngupta@vflare.org>
Subject: Re: [PATCH 06/15] genhd: Add return code to device_add_disk
Message-ID: <20160817084823.GB19326@al.usersys.redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
 <1471418115-3654-7-git-send-email-famz@redhat.com>
 <20160817104914.37087cb3.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160817104914.37087cb3.cornelia.huck@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, 08/17 10:49, Cornelia Huck wrote:
> On Wed, 17 Aug 2016 15:15:06 +0800
> Fam Zheng <famz@redhat.com> wrote:
> 
> > @@ -613,10 +614,8 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
> >  	disk->flags |= GENHD_FL_UP;
> > 
> >  	retval = blk_alloc_devt(&disk->part0, &devt);
> > -	if (retval) {
> > -		WARN_ON(1);
> > -		return;
> > -	}
> > +	if (retval)
> > +		goto fail;
> >  	disk_to_dev(disk)->devt = devt;
> > 
> >  	/* ->major and ->first_minor aren't supposed to be
> > @@ -625,16 +624,26 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
> >  	disk->major = MAJOR(devt);
> >  	disk->first_minor = MINOR(devt);
> > 
> > -	disk_alloc_events(disk);
> > +	retval = disk_alloc_events(disk);
> > +	if (retval)
> > +		goto fail;
> > 
> >  	/* Register BDI before referencing it from bdev */
> >  	bdi = &disk->queue->backing_dev_info;
> > -	bdi_register_owner(bdi, disk_to_dev(disk));
> > +	retval = bdi_register_owner(bdi, disk_to_dev(disk));
> > +	if (retval)
> > +		goto fail;
> > 
> > -	blk_register_region(disk_devt(disk), disk->minors, NULL,
> > -			    exact_match, exact_lock, disk);
> > -	register_disk(parent, disk);
> > -	blk_register_queue(disk);
> > +	retval = blk_register_region(disk_devt(disk), disk->minors, NULL,
> > +				     exact_match, exact_lock, disk);
> > +	if (retval)
> > +		goto fail;
> > +	retval = register_disk(parent, disk);
> > +	if (retval)
> > +		goto fail;
> > +	retval = blk_register_queue(disk);
> > +	if (retval)
> > +		goto fail;
> > 
> >  	/*
> >  	 * Take an extra ref on queue which will be put on disk_release()
> > @@ -644,10 +653,20 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
> > 
> >  	retval = sysfs_create_link(&disk_to_dev(disk)->kobj, &bdi->dev->kobj,
> >  				   "bdi");
> > +	if (retval)
> > +		goto fail;
> > +
> > +	retval = disk_add_events(disk);
> > +	if (retval)
> > +		goto fail;
> > +
> > +	retval = blk_integrity_add(disk);
> > +	if (retval)
> > +		goto fail;
> > +	return 0;
> > +fail:
> >  	WARN_ON(retval);
> > -
> > -	disk_add_events(disk);
> > -	blk_integrity_add(disk);
> > +	return retval;
> >  }
> 
> Noticed this when trying to figure out whether the error handling in
> virtio_blk was correct:
> 
> Shouldn't you try to cleanup/rewind so that any structures are in a
> sane state after failure? The caller doesn't know where device_add_disk
> failed, and calling del_gendisk unconditionally like virtio_blk does is
> probably not the right thing to do (at the very least, I don't think
> unregistering a device that has not been registered is likely to work).
> 

Yes, I think all callers need to be reviewed before device_add_disk do the
clean up on error. For this patchset I wanted to keep the change small.

Fam
