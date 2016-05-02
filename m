Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60893 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589AbcEBPpk (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Mon, 2 May 2016 11:45:40 -0400
Message-ID: <1462203935.11211.15.camel@kernel.org>
Subject: Re: [PATCH v4 5/7] fs: prioritize and separate direct_io from dax_io
From: Vishal Verma <vishal@kernel.org>
To: Christoph Hellwig <hch@infradead.org>,
	Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-nvdimm@ml01.01.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, xfs@oss.sgi.com,
	linux-ext4@vger.kernel.org, linux-mm@kvack.org,
	Matthew Wilcox <matthew@wil.cx>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@fb.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>
Date: Mon, 02 May 2016 09:45:35 -0600
In-Reply-To: <20160502145606.GD20589@infradead.org>
References: <1461878218-3844-1-git-send-email-vishal.l.verma@intel.com>
	 <1461878218-3844-6-git-send-email-vishal.l.verma@intel.com>
	 <20160502145606.GD20589@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2016-05-02 at 07:56 -0700, Christoph Hellwig wrote:
> > 
> > index 79defba..97a1f5f 100644
> > --- a/fs/block_dev.c
> > +++ b/fs/block_dev.c
> > @@ -167,12 +167,21 @@ blkdev_direct_IO(struct kiocb *iocb, struct
> > iov_iter *iter, loff_t offset)
> >  	struct file *file = iocb->ki_filp;
> >  	struct inode *inode = bdev_file_inode(file);
> >  
> > -	if (IS_DAX(inode))
> > +	if (iocb_is_direct(iocb))
> > +		return __blockdev_direct_IO(iocb, inode,
> > I_BDEV(inode), iter,
> > +					    offset,
> > blkdev_get_block, NULL,
> > +					    NULL,
> > DIO_SKIP_DIO_COUNT);
> > +	else if (iocb_is_dax(iocb))
> >  		return dax_do_io(iocb, inode, iter, offset,
> > blkdev_get_block,
> >  				NULL, DIO_SKIP_DIO_COUNT);
> > -	return __blockdev_direct_IO(iocb, inode, I_BDEV(inode),
> > iter, offset,
> > -				    blkdev_get_block, NULL, NULL,
> > -				    DIO_SKIP_DIO_COUNT);
> > +	else {
> > +		/*
> > +		 * If we're in the direct_IO path, either the
> > IOCB_DIRECT or
> > +		 * IOCB_DAX flags must be set.
> > +		 */
> > +		WARN_ONCE(1, "Kernel Bug with iocb flags\n");
> > +		return -ENXIO;
> > +	}
> DAX should not even end up in ->direct_IO.

Do you mean to say remove the last 'else' clause entirely?
I agree that it should never be hit, which is why it is a WARN..
But I'm happy to remove it.

> 
> > 
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -300,7 +300,7 @@ xfs_file_read_iter(
> >  
> >  	XFS_STATS_INC(mp, xs_read_calls);
> >  
> > -	if (unlikely(iocb->ki_flags & IOCB_DIRECT))
> > +	if (unlikely(iocb->ki_flags & (IOCB_DIRECT | IOCB_DAX)))
> >  		ioflags |= XFS_IO_ISDIRECT;
> please also add a XFS_IO_ISDAX flag to propagate the information
> properly and allow tracing to display the actual I/O type.

Will do.

> 
> > 
> > +static inline bool iocb_is_dax(struct kiocb *iocb)
> >  {
> > +	return IS_DAX(file_inode(iocb->ki_filp)) &&
> > +		(iocb->ki_flags & IOCB_DAX);
> > +}
> > +
> > +static inline bool iocb_is_direct(struct kiocb *iocb)
> > +{
> > +	return iocb->ki_flags & IOCB_DIRECT;
> >  }
> No need for these helpers - especially as IOCB_DAX should never be
> set
> if IS_DAX is false.

Ok. So check the flags directly where needed?

> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

