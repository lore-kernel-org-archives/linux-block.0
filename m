Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:42979 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753485AbcEPRbJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Mon, 16 May 2016 13:31:09 -0400
Date: Mon, 16 May 2016 11:31:06 -0600
From: Jon Derrick <jonathan.derrick@intel.com>
To: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jeff Moyer <jmoyer@redhat.com>,
	Stephen Bates <stephen.bates@microsemi.com>,
	Keith Busch <keith.busch@intel.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFCv2 2/3] block: add helper for setting and clearing S_DAX on
 inode
Message-ID: <20160516173106.GA1769@localhost.localdomain>
References: <1463184168-3381-1-git-send-email-jonathan.derrick@intel.com>
 <1463184168-3381-3-git-send-email-jonathan.derrick@intel.com>
 <94D0CD8314A33A4D9D801C0FE68B4029639701CA@G4W3202.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <94D0CD8314A33A4D9D801C0FE68B4029639701CA@G4W3202.americas.hpqcorp.net>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, May 14, 2016 at 05:05:59AM +0000, Elliott, Robert (Persistent Memory) wrote:
> 
> 
> > -----Original Message-----
> > From: linux-block-owner@vger.kernel.org [mailto:linux-block-
> > owner@vger.kernel.org] On Behalf Of Jon Derrick
> > Sent: Friday, May 13, 2016 7:03 PM
> ...
> > Subject: [RFCv2 2/3] block: add helper for setting and clearing S_DAX on
> > inode
> > 
> > inode->i_flags locking rules suggest using the i_mutex lock. This patch
> > adds a helper to do the locking and setting of S_DAX on the block device
> > inode.
> ...
> > +static void bd_set_dax(struct block_device *bdev, bool enabled)
> > +{
> > +	struct inode *inode = bdev->bd_inode;
> > +
> > +	inode_lock(inode);
> > +	if (enabled)
> > +		inode->i_flags = S_DAX;
> > +	else
> > +		inode->i_flags &= ~S_DAX;
> > +	inode_unlock(inode);
> > +}
> 
> This is not symmetric - setting wipes out any other bits, but
> clearing only clears the S_DAX bit. That seems confusing for
> a helper function.
> 
> Using |= would be symmetric, but wouldn't replace what 
> __blkdev_get does (if what it does is appropriate).
> 
I'm under the impression that S_DAX is the only inode flag appropriate for a block device inode with direct-access, even though it does break the 'flag' semantic.

It does bring up an interesting question about the fate of the block device inode when S_DAX is set and then cleared later due to the two other conditions that can clear S_DAX.

I think the appropriate fix is to save the inode flags when setting DAX and restore them when we need to clear S_DAX.

> > @@ -1206,9 +1218,9 @@ static int __blkdev_get(struct block_device *bdev,
> > fmode_t mode, int for_part)
> >  		bdev->bd_queue = disk->queue;
> >  		bdev->bd_contains = bdev;
> >  		if (IS_ENABLED(CONFIG_BLK_DEV_DAX) && disk->fops-
> > >direct_access)
> > -			bdev->bd_inode->i_flags = S_DAX;
> > +			bd_set_dax(bdev, 1);
> >  		else
> > -			bdev->bd_inode->i_flags &= ~S_DAX;
> > +			bd_set_dax(bdev, 0);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
