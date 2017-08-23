Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33220 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932262AbdHWQQr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2017 12:16:47 -0400
Received: by mail-pf0-f181.google.com with SMTP id k3so1918073pfc.0
        for <linux-block@vger.kernel.org>; Wed, 23 Aug 2017 09:16:47 -0700 (PDT)
Date: Wed, 23 Aug 2017 09:16:44 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Karel Zak <kzak@redhat.com>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH v3 3/4] loop: use queue limit instead of private
 lo_logical_blocksize
Message-ID: <20170823161644.GA15578@vader>
References: <cover.1503422996.git.osandov@fb.com>
 <cda9076854b30eb4c05092b90fae747e7f1f6542.1503422996.git.osandov@fb.com>
 <20170823092355.uvydhxvo4bf6zohr@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170823092355.uvydhxvo4bf6zohr@ws.net.home>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 23, 2017 at 11:23:55AM +0200, Karel Zak wrote:
> On Tue, Aug 22, 2017 at 10:33:00AM -0700, Omar Sandoval wrote:
> > @@ -946,6 +938,9 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
> >  
> >  	if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
> >  		blk_queue_write_cache(lo->lo_queue, true, false);
> > +	blk_queue_logical_block_size(lo->lo_queue, 512);
> > +	blk_queue_physical_block_size(lo->lo_queue, 512);
> > +	blk_queue_io_min(lo->lo_queue, 512);
> 
> ...
> 
> > @@ -1133,14 +1128,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
> ...  
> > +	if (info->lo_flags & LO_FLAGS_BLOCKSIZE) {
> > +		blk_queue_logical_block_size(lo->lo_queue, LO_INFO_BLOCKSIZE(info));
> > +		blk_queue_physical_block_size(lo->lo_queue, LO_INFO_BLOCKSIZE(info));
> > +		blk_queue_io_min(lo->lo_queue, LO_INFO_BLOCKSIZE(info));
> > +	}
> > +
> 
> I don't understand this. 
> 
> * it seems the default is 512, but what about if the backing file 
>   is not a regular file? For example "losetup -f /dev/sda" where 
>   sda sector size is > 512.

I didn't change the legacy behavior here, i.e., it's always 512 by
default.

> * why the attributes in the /sys are affected by LO_FLAGS_BLOCKSIZE?
>   Would be better to have a real sizes there (independently on the flag)?

What do you mean? LO_FLAGS_BLOCKSIZE means I want to change the logical
blocksize of the loop device, so why shouldn't it be reflected in sysfs?

> * I think kernel lies in /sys about I/O size now. The phy sector size
>   has never been 512, but PAGE_SIZE or real phy sector if backing file
>   is a block device.
> 
>   Your patch improves it for LO_FLAGS_BLOCKSIZE, but it's still lies
>   about internally used I/O sizes.
> 
>   Why we cannot use
> 
>     blk_queue_physical_block_size(lo->lo_queue, lo->lo_blocksize);
>     blk_queue_logical_block_size(lo->lo_queue, lo->lo_logical_blocksize);
> 
>   (as suggested by Hannes' original patch), but without 
>   
>     if (info->lo_flags & LO_FLAGS_BLOCKSIZE)
> 
>   condition?
> 
>   Yes, result will be backwardly incompatible, but the current
>   situation (all is 512) does not describe reality. It's legacy from
>   time where all in kernel was 512...

I went back and forth on this. Yeah, the kernel is lying, and using the
backing block size makes more sense, but backwards compatability is
exactly why I didn't change this. Then again, the physical block size is
more of a hint, so it might be safe to change this.
