Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35655 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752617AbdDFPtb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2017 11:49:31 -0400
Received: by mail-pg0-f51.google.com with SMTP id 81so40132081pgh.2
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2017 08:49:31 -0700 (PDT)
Date: Thu, 6 Apr 2017 08:48:34 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, Ming Lei <minlei@redhat.com>,
        kernel-team@fb.com
Subject: Re: [RFC PATCH] loop: set queue logical block size
Message-ID: <20170406154834.GA405@vader>
References: <07d6b9266284b98aa3a4706062bd135275220d38.1491466688.git.osandov@fb.com>
 <ba593363-672f-9d8b-986f-4eb9a11ab135@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ba593363-672f-9d8b-986f-4eb9a11ab135@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Apr 06, 2017 at 10:52:01AM +0200, Hannes Reinecke wrote:
> On 04/06/2017 10:19 AM, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > The request queue created when we create a loop device has the default
> > logical block size of 512. When we associate the device with an fd, we
> > set the block size on the block_device but don't update the logical
> > block size of the request_queue. This makes it impossibe to use direct
> > I/O with a backing file on a device with a block size >512, as the
> > following check in __loop_update_dio() fails:
> > 
> > 	sb_bsize = bdev_logical_block_size(inode->i_sb->s_bdev);
> > 	if (queue_logical_block_size(lo->lo_queue) >= sb_bsize &&
> > 	    ...
> > 
> > Fix it by updating the logical block size when we set the fd.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  drivers/block/loop.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index cc981f34e017..1bb22903ad1a 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -941,6 +941,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
> >  	/* let user-space know about the new size */
> >  	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
> >  
> > +	blk_queue_logical_block_size(lo->lo_queue, lo_blocksize);
> >  	set_blocksize(bdev, lo_blocksize);
> >  
> >  	lo->lo_state = Lo_bound;
> > 
> Gnaa.
> 
> I've tried so change exactly this by my patchset titled 'loop: enable
> different logical blocksizes'.
> And I even got agreement from Jens to merge it once it got another
> review. Which, of course, no-one did.

Yours looks like a more complete solution, sorry that I missed it. I'll
take a look when you repost the patches.
