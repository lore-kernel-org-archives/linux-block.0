Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Wed, 18 May 2016 13:30:20 -0600
From: Vishal Verma <vishal.l.verma@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Toshi Kani <toshi.kani@hpe.com>, hch@infradead.org, jack@suse.cz,
	linux-block@vger.kernel.org, linux-nvdimm@lists.01.org,
	david@fromorbit.com, linux-kernel@vger.kernel.org,
	micah.parrish@hpe.com, axboe@fb.com, adilger.kernel@dilger.ca,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, sfr@canb.auug.org.au
Subject: Re: [PATCH] remove unused blkdev_dax_capable() function
Message-ID: <20160518193020.GB20021@omniknight.lm.intel.com>
References: <1462897437-16626-1-git-send-email-toshi.kani@hpe.com>
 <1462897437-16626-7-git-send-email-toshi.kani@hpe.com>
 <3280835.MNk2ItMooy@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3280835.MNk2ItMooy@wuerfel>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Wed, May 18, 2016 at 09:54:08AM +0200, Arnd Bergmann wrote:
> The change from blkdev_dax_capable() to bdev_dax_capable() removed the only user
> of the former, so we now get a build warning:
> 
> fs/block_dev.c:1244:13: error: 'blkdev_dax_capable' defined but not used [-Werror=unused-function]
>  static bool blkdev_dax_capable(struct block_device *bdev)
> 
> This removes the now-unused function.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: a8078b1fc616 ("block: Update blkdev_dax_capable() for consistency")
> ---
> On Tuesday 10 May 2016 10:23:57 Toshi Kani wrote:
> > @@ -1295,7 +1330,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
> >  
> >                         if (!ret) {
> >                                 bd_set_size(bdev,(loff_t)get_capacity(disk)<<9);
> > -                               if (!blkdev_dax_capable(bdev))
> > +                               if (!bdev_dax_capable(bdev))
> >                                         bdev->bd_inode->i_flags &= ~S_DAX;
> > 
> 
> It's not entirely from the patch description what the intention was here
> in keeping two slightly different implementations of the same function
> in one file, my best guess is that it was not intentional and we should
> just remove this.
> 

Good catch - like Toshi said, this was indeed a mis-merge.

Stephen, for reference, I've added a branch with the expected conflict
resolution at:

https://git.kernel.org/cgit/linux/kernel/git/nvdimm/nvdimm.git/ libnvdimm-for-4.7-merge

Thanks,
	-Vishal
