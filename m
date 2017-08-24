Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbdHXIHF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 04:07:05 -0400
Date: Thu, 24 Aug 2017 10:06:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH 3/4] loop: add ioctl for changing logical block size
Message-ID: <20170824080657.wtgydfatbbirm34b@ws.net.home>
References: <cover.1503558155.git.osandov@fb.com>
 <f82c988df9c0e3c543089360e3d562c751b63d0f.1503558155.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f82c988df9c0e3c543089360e3d562c751b63d0f.1503558155.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 24, 2017 at 12:03:43AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This is a different approach from the first attempt in f2c6df7dbf9a
> ("loop: support 4k physical blocksize"). Rather than extending
> LOOP_{GET,SET}_STATUS, add a separate ioctl just for setting the block
> size.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  drivers/block/loop.c      | 24 ++++++++++++++++++++++++
>  include/uapi/linux/loop.h |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 1a5b4ecf54ec..6b1d932028e3 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1047,6 +1047,7 @@ static int loop_clr_fd(struct loop_device *lo)
>  	memset(lo->lo_encrypt_key, 0, LO_KEY_SIZE);
>  	memset(lo->lo_crypt_name, 0, LO_NAME_SIZE);
>  	memset(lo->lo_file_name, 0, LO_NAME_SIZE);
> +	blk_queue_logical_block_size(lo->lo_queue, 512);
>  	if (bdev) {
>  		bdput(bdev);
>  		invalidate_bdev(bdev);
> @@ -1330,6 +1331,24 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
>  	return error;
>  }
>  
> +static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
> +{
> +	if (lo->lo_state != Lo_bound)
> +		return -ENXIO;
> +
> +	if (arg < 512 || arg > PAGE_SIZE || !is_power_of_2(arg))
> +		return -EINVAL;

I'm not sure if the PAGE_SIZE is the right limit for the use-case
where backing file is a block device ...but it's nothing important.

> +	blk_mq_freeze_queue(lo->lo_queue);
> +
> +	blk_queue_logical_block_size(lo->lo_queue, arg);

Just note that this function also updates physical_block_size if the
'arg' is greater than the current setting. That's good thing :-)

> +	loop_update_dio(lo);
> +
> +	blk_mq_unfreeze_queue(lo->lo_queue);
> +
> +	return 0;
> +}
> +
>  static int lo_ioctl(struct block_device *bdev, fmode_t mode,
>  	unsigned int cmd, unsigned long arg)
>  {
> @@ -1378,6 +1397,11 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
>  		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
>  			err = loop_set_dio(lo, arg);
>  		break;
> +	case LOOP_SET_BLOCK_SIZE:
> +		err = -EPERM;
> +		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
> +			err = loop_set_block_size(lo, arg);
> +		break;

I like it this ioctl idea. It makes loop based tests more comfortable
as we can change sector size on the fly without loop device reset.

I did not test it yet, but this implementation seems the best. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
