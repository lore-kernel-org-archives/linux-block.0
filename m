Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39158 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751272AbdHXMZM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 08:25:12 -0400
Subject: Re: [PATCH 3/4] loop: add ioctl for changing logical block size
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Ming Lei <ming.lei@redhat.com>,
        Karel Zak <kzak@redhat.com>, Milan Broz <gmazyland@gmail.com>
References: <cover.1503558155.git.osandov@fb.com>
 <f82c988df9c0e3c543089360e3d562c751b63d0f.1503558155.git.osandov@fb.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6f76b055-7b89-91e8-4f8b-120f2dd48e3e@suse.de>
Date: Thu, 24 Aug 2017 14:25:10 +0200
MIME-Version: 1.0
In-Reply-To: <f82c988df9c0e3c543089360e3d562c751b63d0f.1503558155.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/24/2017 09:03 AM, Omar Sandoval wrote:
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
> +
> +	blk_mq_freeze_queue(lo->lo_queue);
> +
> +	blk_queue_logical_block_size(lo->lo_queue, arg);
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
>  	default:
>  		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
>  	}
> diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
> index c8125ec1f4f2..23158dbe2424 100644
> --- a/include/uapi/linux/loop.h
> +++ b/include/uapi/linux/loop.h
> @@ -88,6 +88,7 @@ struct loop_info64 {
>  #define LOOP_CHANGE_FD		0x4C06
>  #define LOOP_SET_CAPACITY	0x4C07
>  #define LOOP_SET_DIRECT_IO	0x4C08
> +#define LOOP_SET_BLOCK_SIZE	0x4C09
>  
>  /* /dev/loop-control interface */
>  #define LOOP_CTL_ADD		0x4C80
> 
Hmm.

If the losetup / util-linux maintainers are on board with this, okay.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
