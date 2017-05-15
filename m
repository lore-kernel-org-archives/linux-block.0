Return-Path: <rakesh@tuxera.com>
Date: Mon, 15 May 2017 23:34:00 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>
CC: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 16/25] fuse: Convert to separately allocated bdi
Message-ID: <20170515203400.GA8068@hercules.tuxera.com>
References: <20170412102449.16901-1-jack@suse.cz>
 <20170412102449.16901-17-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170412102449.16901-17-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hi Jan, Miklos,

On Wed, Apr 12, 2017 at 12:24:40PM +0200, Jan Kara wrote:
> Allocate struct backing_dev_info separately instead of embedding it
> inside the superblock. This unifies handling of bdi among users.
>
> CC: Miklos Szeredi <miklos@szeredi.hu>
> CC: linux-fsdevel@vger.kernel.org
> Acked-by: Miklos Szeredi <mszeredi@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>

...

>  static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
>  {
>  	int err;
> +	char *suffix = "";
>  
> -	fc->bdi.name = "fuse";
> -	fc->bdi.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_SIZE;
> -	/* fuse does it's own writeback accounting */
> -	fc->bdi.capabilities = BDI_CAP_NO_ACCT_WB | BDI_CAP_STRICTLIMIT;
> -
> -	err = bdi_init(&fc->bdi);
> +	if (sb->s_bdev)
> +		suffix = "-fuseblk";
> +	err = super_setup_bdi_name(sb, "%u:%u%s", MAJOR(fc->dev),
> +				   MINOR(fc->dev), suffix);
>  	if (err)
>  		return err;
>

This call to super_setup_bdi_name would only work with "fuse" but not
with "fuseblk" as mounting a block device in userspace triggers
mount_bdev call which results in set_bdev_super taking a reference
from block device's BDI.  But super_setup_bdi_name allocates a new bdi
and ignores the already existing reference which triggers:

WARN_ON(sb->s_bdi != &noop_backing_dev_info);

as sb->s_bdi already has a reference from set_bdev_super.  This works
for "fuse" (without a blocking device) for obvious reasons.  I can
reproduce this on -rc1 and also found a report on lkml:
https://lkml.org/lkml/2017/5/2/445

Only sane solution seems to be maintaining a private bdi instace just
for fuseblk and let fuse use the common new infrastructure.

Best regards,
Rakesh
