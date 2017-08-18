Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55799 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750920AbdHRHUf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2017 03:20:35 -0400
Subject: Re: [PATCH 2/2] loop: fix hang if LOOP_SET_STATUS gets invalid
 blocksize or encrypt type
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Ming Lei <ming.lei@redhat.com>
References: <cover.1503036471.git.osandov@fb.com>
 <1ae3e2efdaf3f16bfdd4cf12b1350d49bb6a9026.1503036471.git.osandov@fb.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <9a7fac37-1833-1546-b308-2a0e15bef6e7@suse.de>
Date: Fri, 18 Aug 2017 09:20:33 +0200
MIME-Version: 1.0
In-Reply-To: <1ae3e2efdaf3f16bfdd4cf12b1350d49bb6a9026.1503036471.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/18/2017 08:15 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> In both of these error cases, we need to make sure to unfreeze the queue
> before we return.
> 
> Fixes: ecdd09597a57 ("block/loop: fix race between I/O and set_status")
> Fixes: f2c6df7dbf9a ("loop: support 4k physical blocksize")
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  drivers/block/loop.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 39fa7f48e0c7..6c7609b3305d 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1125,11 +1125,15 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  	if (info->lo_encrypt_type) {
>  		unsigned int type = info->lo_encrypt_type;
>  
> -		if (type >= MAX_LO_CRYPT)
> -			return -EINVAL;
> +		if (type >= MAX_LO_CRYPT) {
> +			err = -EINVAL;
> +			goto exit;
> +		}
>  		xfer = xfer_funcs[type];
> -		if (xfer == NULL)
> -			return -EINVAL;
> +		if (xfer == NULL) {
> +			err = -EINVAL;
> +			goto exit;
> +		}
>  	} else
>  		xfer = NULL;
>  
> @@ -1142,10 +1146,14 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  		if (lo_logical_blocksize != 512 &&
>  		    lo_logical_blocksize != 1024 &&
>  		    lo_logical_blocksize != 2048 &&
> -		    lo_logical_blocksize != 4096)
> -			return -EINVAL;
> -		if (lo_logical_blocksize > lo->lo_blocksize)
> -			return -EINVAL;
> +		    lo_logical_blocksize != 4096) {
> +			err = -EINVAL;
> +			goto exit;
> +		}
> +		if (lo_logical_blocksize > lo->lo_blocksize) {
> +			err = -EINVAL;
> +			goto exit;
> +		}
>  	} else {
>  		lo_logical_blocksize = lo->lo_logical_blocksize;
>  	}
> Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
