Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41509 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932118AbcEKP0y (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 11 May 2016 11:26:54 -0400
Date: Wed, 11 May 2016 17:26:46 +0200
From: Jan Kara <jack@suse.cz>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: Jan Kara <jack@suse.cz>, dan.j.williams@intel.com,
	david@fromorbit.com, viro@zeniv.linux.org.uk, axboe@fb.com,
	hch@infradead.org, boaz@plexistor.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, ross.zwisler@linux.intel.com,
	micah.parrish@hpe.com, linux-nvdimm@lists.01.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] block: Update blkdev_dax_capable() for consistency
Message-ID: <20160511152646.GF14744@quack2.suse.cz>
References: <1462897437-16626-1-git-send-email-toshi.kani@hpe.com>
 <1462897437-16626-7-git-send-email-toshi.kani@hpe.com>
 <20160511080537.GA14744@quack2.suse.cz>
 <1462976710.27137.140.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1462976710.27137.140.camel@hpe.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed 11-05-16 08:25:10, Toshi Kani wrote:
> On Wed, 2016-05-11 at 10:05 +0200, Jan Kara wrote:
> > On Tue 10-05-16 10:23:57, Toshi Kani wrote:
> > > 
> > > blkdev_dax_capable() is similar to bdev_dax_supported(), but needs
> > > to remain as a separate interface for checking dax capability of
> > > a raw block device.
> > > 
> > > Rename and relocate blkdev_dax_capable() to keep them maintained
> > > consistently, and call bdev_direct_access() for the dax capability
> > > check.
> > ...
> > > 
> > > +bool bdev_dax_capable(struct block_device *bdev)
> > > +{
> > > +	struct gendisk *disk = bdev->bd_disk;
> > > +	struct blk_dax_ctl dax = {
> > > +		.size = PAGE_SIZE,
> > > +	};
> > > +
> > > +	if (!IS_ENABLED(CONFIG_FS_DAX))
> > > +		return false;
> >
> > Frankly, I prefer the #ifdef CONFIG_FS_DAX and just compile the code out
> > when DAX is not enabled (like it was with blkdev_dax_capable()). That way
> > we don't grow the kernel for people who don't care about DAX.
> 
> When CONFIG_FS_DAX is not set, the rest of the code is optimized out. �So,
> I think the code size is the same.
> 
> (gdb) disas bdev_dax_capable
> Dump of assembler code for function bdev_dax_capable:
> ���0xffffffff81260d20 <+0>:�����callq��0xffffffff81813c30 <__fentry__>
> ���0xffffffff81260d25 <+5>:�����push���%rbp
> ���0xffffffff81260d26 <+6>:�����xor����%eax,%eax
> ���0xffffffff81260d28 <+8>:�����mov����%rsp,%rbp
> ���0xffffffff81260d2b <+11>:����pop����%rbp
> ���0xffffffff81260d2c <+12>:����retq���
> End of assembler dump.

Ah, good. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
