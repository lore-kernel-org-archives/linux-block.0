Return-Path: <jack@suse.cz>
Date: Tue, 16 May 2017 12:48:31 +0200
From: Jan Kara <jack@suse.cz>
To: Rakesh Pandit <rakesh@tuxera.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 16/25] fuse: Convert to separately allocated bdi
Message-ID: <20170516104831.GA26782@quack2.suse.cz>
References: <20170412102449.16901-1-jack@suse.cz>
 <20170412102449.16901-17-jack@suse.cz>
 <20170515203400.GA8068@hercules.tuxera.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
In-Reply-To: <20170515203400.GA8068@hercules.tuxera.com>
List-ID: <linux-block@vger.kernel.org>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon 15-05-17 23:34:00, Rakesh Pandit wrote:
> Hi Jan, Miklos,
> 
> On Wed, Apr 12, 2017 at 12:24:40PM +0200, Jan Kara wrote:
> > Allocate struct backing_dev_info separately instead of embedding it
> > inside the superblock. This unifies handling of bdi among users.
> >
> > CC: Miklos Szeredi <miklos@szeredi.hu>
> > CC: linux-fsdevel@vger.kernel.org
> > Acked-by: Miklos Szeredi <mszeredi@redhat.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> ...
> 
> >  static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
> >  {
> >  	int err;
> > +	char *suffix = "";
> >  
> > -	fc->bdi.name = "fuse";
> > -	fc->bdi.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_SIZE;
> > -	/* fuse does it's own writeback accounting */
> > -	fc->bdi.capabilities = BDI_CAP_NO_ACCT_WB | BDI_CAP_STRICTLIMIT;
> > -
> > -	err = bdi_init(&fc->bdi);
> > +	if (sb->s_bdev)
> > +		suffix = "-fuseblk";
> > +	err = super_setup_bdi_name(sb, "%u:%u%s", MAJOR(fc->dev),
> > +				   MINOR(fc->dev), suffix);
> >  	if (err)
> >  		return err;
> >
> 
> This call to super_setup_bdi_name would only work with "fuse" but not
> with "fuseblk" as mounting a block device in userspace triggers
> mount_bdev call which results in set_bdev_super taking a reference
> from block device's BDI.  But super_setup_bdi_name allocates a new bdi
> and ignores the already existing reference which triggers:
> 
> WARN_ON(sb->s_bdi != &noop_backing_dev_info);
> 
> as sb->s_bdi already has a reference from set_bdev_super.  This works
> for "fuse" (without a blocking device) for obvious reasons.  I can
> reproduce this on -rc1 and also found a report on lkml:
> https://lkml.org/lkml/2017/5/2/445
> 
> Only sane solution seems to be maintaining a private bdi instace just
> for fuseblk and let fuse use the common new infrastructure.

Thanks for analysis! Does the attached patch fix the warning for you?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--EVF5PPMfhYS0aIcm
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-fuseblk-Fix-warning-in-super_setup_bdi_name.patch"

>From 5b0cfc37b45670a35228c96cbaee2b99cd3d447c Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Tue, 16 May 2017 12:22:22 +0200
Subject: [PATCH] fuseblk: Fix warning in super_setup_bdi_name()

Commit 5f7f7543f52e "fuse: Convert to separately allocated bdi" didn't
properly handle fuseblk filesystem. When fuse_bdi_init() is called for
that filesystem type, sb->s_bdi is already initialized (by
set_bdev_super()) to point to block device's bdi and consequently
super_setup_bdi_name() complains about this fact when reseting bdi to
the private one.

Fix the problem by properly dropping bdi reference in fuse_bdi_init()
before creating a private bdi in super_setup_bdi_name().

Fixes: 5f7f7543f52eee03ed35c9d671fbb1cdbd4bc9b5
Reported-by: Rakesh Pandit <rakesh@tuxera.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fuse/inode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 5a1b58f8fef4..65c88379a3a1 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -975,8 +975,15 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
 	int err;
 	char *suffix = "";
 
-	if (sb->s_bdev)
+	if (sb->s_bdev) {
 		suffix = "-fuseblk";
+		/*
+		 * sb->s_bdi points to blkdev's bdi however we want to redirect
+		 * it to our private bdi...
+		 */
+		bdi_put(sb->s_bdi);
+		sb->s_bdi = &noop_backing_dev_info;
+	}
 	err = super_setup_bdi_name(sb, "%u:%u%s", MAJOR(fc->dev),
 				   MINOR(fc->dev), suffix);
 	if (err)
-- 
2.12.0


--EVF5PPMfhYS0aIcm--
