Return-Path: <linux-block-owner@vger.kernel.org>
Received: from g1t5425.austin.hp.com ([15.216.225.55]:55047 "EHLO
	g1t5425.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbcENFG7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Sat, 14 May 2016 01:06:59 -0400
From: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
To: Jon Derrick <jonathan.derrick@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Jens Axboe <axboe@fb.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jeff Moyer <jmoyer@redhat.com>,
	Stephen Bates <stephen.bates@microsemi.com>,
	Keith Busch <keith.busch@intel.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: RE: [RFCv2 2/3] block: add helper for setting and clearing S_DAX on
 inode
Date: Sat, 14 May 2016 05:05:59 +0000
Message-ID: <94D0CD8314A33A4D9D801C0FE68B4029639701CA@G4W3202.americas.hpqcorp.net>
References: <1463184168-3381-1-git-send-email-jonathan.derrick@intel.com>
 <1463184168-3381-3-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1463184168-3381-3-git-send-email-jonathan.derrick@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



> -----Original Message-----
> From: linux-block-owner@vger.kernel.org [mailto:linux-block-
> owner@vger.kernel.org] On Behalf Of Jon Derrick
> Sent: Friday, May 13, 2016 7:03 PM
...
> Subject: [RFCv2 2/3] block: add helper for setting and clearing S_DAX on
> inode
> 
> inode->i_flags locking rules suggest using the i_mutex lock. This patch
> adds a helper to do the locking and setting of S_DAX on the block device
> inode.
...
> +static void bd_set_dax(struct block_device *bdev, bool enabled)
> +{
> +	struct inode *inode = bdev->bd_inode;
> +
> +	inode_lock(inode);
> +	if (enabled)
> +		inode->i_flags = S_DAX;
> +	else
> +		inode->i_flags &= ~S_DAX;
> +	inode_unlock(inode);
> +}

This is not symmetric - setting wipes out any other bits, but
clearing only clears the S_DAX bit. That seems confusing for
a helper function.

Using |= would be symmetric, but wouldn't replace what 
__blkdev_get does (if what it does is appropriate).

> @@ -1206,9 +1218,9 @@ static int __blkdev_get(struct block_device *bdev,
> fmode_t mode, int for_part)
>  		bdev->bd_queue = disk->queue;
>  		bdev->bd_contains = bdev;
>  		if (IS_ENABLED(CONFIG_BLK_DEV_DAX) && disk->fops-
> >direct_access)
> -			bdev->bd_inode->i_flags = S_DAX;
> +			bd_set_dax(bdev, 1);
>  		else
> -			bdev->bd_inode->i_flags &= ~S_DAX;
> +			bd_set_dax(bdev, 0);

