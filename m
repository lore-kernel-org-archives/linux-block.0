Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33561 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbcEKIFo (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 11 May 2016 04:05:44 -0400
Date: Wed, 11 May 2016 10:05:37 +0200
From: Jan Kara <jack@suse.cz>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: dan.j.williams@intel.com, jack@suse.cz, david@fromorbit.com,
	viro@zeniv.linux.org.uk, axboe@fb.com, hch@infradead.org,
	boaz@plexistor.com, tytso@mit.edu, adilger.kernel@dilger.ca,
	ross.zwisler@linux.intel.com, micah.parrish@hpe.com,
	linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] block: Update blkdev_dax_capable() for consistency
Message-ID: <20160511080537.GA14744@quack2.suse.cz>
References: <1462897437-16626-1-git-send-email-toshi.kani@hpe.com>
 <1462897437-16626-7-git-send-email-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462897437-16626-7-git-send-email-toshi.kani@hpe.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue 10-05-16 10:23:57, Toshi Kani wrote:
> blkdev_dax_capable() is similar to bdev_dax_supported(), but needs
> to remain as a separate interface for checking dax capability of
> a raw block device.
> 
> Rename and relocate blkdev_dax_capable() to keep them maintained
> consistently, and call bdev_direct_access() for the dax capability
> check.
...
> +bool bdev_dax_capable(struct block_device *bdev)
> +{
> +	struct gendisk *disk = bdev->bd_disk;
> +	struct blk_dax_ctl dax = {
> +		.size = PAGE_SIZE,
> +	};
> +
> +	if (!IS_ENABLED(CONFIG_FS_DAX))
> +		return false;

Frankly, I prefer the #ifdef CONFIG_FS_DAX and just compile the code out
when DAX is not enabled (like it was with blkdev_dax_capable()). That way we
don't grow the kernel for people who don't care about DAX.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
