Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 2 Jul 2018 16:43:07 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Evan Green <evgreen@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sam Hurst <shurst@google.com>
Subject: Re: [PATCH] loop: Add LOOP_SET_BLOCK_SIZE in compat ioctl
Message-ID: <20180702234307.GA27810@vader>
References: <20180702230346.72350-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180702230346.72350-1-evgreen@chromium.org>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 02, 2018 at 04:03:46PM -0700, Evan Green wrote:
> This change adds LOOP_SET_BLOCK_SIZE as one of the supported ioctls
> in lo_compat_ioctl. It only takes an unsigned long argument, and
> in practice a 32-bit value works fine.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>  drivers/block/loop.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index d6b6f434fd4b..4cb1d1be3cfb 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1613,6 +1613,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
>  		arg = (unsigned long) compat_ptr(arg);
>  	case LOOP_SET_FD:
>  	case LOOP_CHANGE_FD:
> +	case LOOP_SET_BLOCK_SIZE:
>  		err = lo_ioctl(bdev, mode, cmd, arg);
>  		break;
>  	default:
> -- 
> 2.16.4
> 
