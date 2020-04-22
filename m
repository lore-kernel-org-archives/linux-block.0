Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF20C38A30
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 06:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98FAE206CD
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 06:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgDVGTX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 02:19:23 -0400
Received: from verein.lst.de ([213.95.11.211]:50389 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgDVGTW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 02:19:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3DDF768C4E; Wed, 22 Apr 2020 08:19:19 +0200 (CEST)
Date:   Wed, 22 Apr 2020 08:19:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com
Subject: Re: [PATCH 4/4] loop: Add LOOP_SET_FD_AND_STATUS ioctl.
Message-ID: <20200422061919.GA22819@lst.de>
References: <20200420080409.111693-1-maco@android.com> <20200420080409.111693-5-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420080409.111693-5-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 20, 2020 at 10:04:09AM +0200, Martijn Coenen wrote:
> This allows userspace to completely setup a loop device with a single
> ioctl, removing the in-between state where the device can be partially
> configured - eg the loop device has a backing file associated with it,
> but is reading from the wrong offset.
> 
> Besides removing the intermediate state, another big benefit of this
> ioctl is that LOOP_SET_STATUS can be slow; the main reason for this
> slowness is that LOOP_SET_STATUS(64) calls blk_mq_freeze_queue() to
> freeze the associated queue; this requires waiting for RCU
> synchronization, which I've measured can take about 15-20ms on this
> device on average.
> 
> Here's setting up ~70 regular loop devices with an offset on an x86
> Android device, using LOOP_SET_FD and LOOP_SET_STATUS:
> 
> vsoc_x86:/system/apex # time for i in `seq 30 100`;
> do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done
>     0m03.40s real     0m00.02s user     0m00.03s system
> 
> Here's configuring ~70 devices in the same way, but using a modified
> losetup that uses the new LOOP_SET_FD_AND_STATUS ioctl:
> 
> vsoc_x86:/system/apex # time for i in `seq 30 100`;
> do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done
>     0m01.94s real     0m00.01s user     0m00.01s system
> 
> Signed-off-by: Martijn Coenen <maco@android.com>
> ---
>  drivers/block/loop.c      | 47 ++++++++++++++++++++++++++++++---------
>  include/uapi/linux/loop.h |  6 +++++
>  2 files changed, 42 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 6e656390b285..e1dbd70d6d6e 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1065,8 +1065,9 @@ loop_set_from_status(struct loop_device *lo, const struct loop_info64 *info)
>  	return 0;
>  }
>  
> -static int loop_set_fd(struct loop_device *lo, fmode_t mode,
> -		       struct block_device *bdev, unsigned int arg)
> +static int loop_set_fd_and_status(struct loop_device *lo, fmode_t mode,
> +				  struct block_device *bdev, unsigned int fd,
> +				  const struct loop_info64 *info)
>  {
>  	struct file	*file;
>  	struct inode	*inode;
> @@ -1081,7 +1082,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>  	__module_get(THIS_MODULE);
>  
>  	error = -EBADF;
> -	file = fget(arg);
> +	file = fget(fd);
>  	if (!file)
>  		goto out;
>  
> @@ -1090,7 +1091,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>  	 * here to avoid changing device under exclusive owner.
>  	 */
>  	if (!(mode & FMODE_EXCL)) {
> -		claimed_bdev = bd_start_claiming(bdev, loop_set_fd);
> +		claimed_bdev = bd_start_claiming(bdev, loop_set_fd_and_status);
>  		if (IS_ERR(claimed_bdev)) {
>  			error = PTR_ERR(claimed_bdev);
>  			goto out_putf;
> @@ -1117,9 +1118,24 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>  		lo_flags |= LO_FLAGS_READ_ONLY;
>  
>  	error = -EFBIG;
> -	size = get_loop_size(lo, file);
> +	if (info)
> +		size = get_size(info->lo_offset, info->lo_sizelimit,
> +				file);
> +	else
> +		size = get_loop_size(lo, file);
>  	if ((loff_t)(sector_t)size != size)
>  		goto out_unlock;
> +
> +	if (info) {
> +		error = loop_set_from_status(lo, info);
> +		if (error)
> +			goto out_unlock;
> +	} else {
> +		lo->transfer = NULL;
> +		lo->ioctl = NULL;
> +		lo->lo_sizelimit = 0;
> +		lo->lo_offset = 0;
> +	}

Just curious:  Can't we just pass in an on-stack info for the legacy
case and avoid all these conditionals?

>  out:
> @@ -1653,7 +1666,18 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
>  
>  	switch (cmd) {
>  	case LOOP_SET_FD:
> -		return loop_set_fd(lo, mode, bdev, arg);
> +		return loop_set_fd_and_status(lo, mode, bdev, arg, NULL);
> +	case LOOP_SET_FD_AND_STATUS: {
> +		struct loop_fd_and_status fds;
> +
> +		if (copy_from_user(&fds,
> +				   (struct loop_fd_and_status __user *) arg,
> +				   sizeof(fds)))
> +			return -EFAULT;
> +
> +		return loop_set_fd_and_status(lo, mode, bdev, fds.fd,
> +					      &fds.info);
> +	}

Can you throw in another prep patch that adds a:

	void __user *argp = (void __user *)arg;

line at the top of lo_compat_ioctl, and switches the LOOP_SET_STATUS
and LOOP_GET_STATUS case to it?

The nhere you can just do:

		if (copy_from_user(&p, argp, sizeof(fds)))
			return -EFAULT;
		return loop_set_fd_and_status(lo, mode, bdev, p.fd, &p.info);

and be done.

> +struct loop_fd_and_status {
> +	struct loop_info64	info;
> +	__u32			fd;

This should grow a

	__u32	__pad;

to avoid different struct sizes on x86-32 vs x86-64.
