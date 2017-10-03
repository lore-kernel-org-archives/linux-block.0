Return-Path: <shli@kernel.org>
Date: Tue, 3 Oct 2017 14:54:22 -0700
From: Shaohua Li <shli@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Shaohua Li <shli@fb.com>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] null_blk: change configfs dependency to select
Message-ID: <20171003215422.tbgko6kmvjm2skde@kernel.org>
References: <5aa79539-200c-c67b-5a28-d1d557036317@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5aa79539-200c-c67b-5a28-d1d557036317@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 03, 2017 at 03:50:16PM -0600, Jens Axboe wrote:
> A recent commit made null_blk depend on configfs, which is kind of
> annoying since you now have to find this dependency and enable that
> as well. Discovered this since I no longer had null_blk available
> on a box I needed to debug, since it got killed when the config
> updated after the configfs change was merged.
> 
> Fixes: 3bf2bd20734e ("nullb: add configfs interface")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Shaohua Li <shli@fb.com> 
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 4a438b8abe27..2dfe99b328f8 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -17,7 +17,7 @@ if BLK_DEV
>  
>  config BLK_DEV_NULL_BLK
>  	tristate "Null test block driver"
> -	depends on CONFIGFS_FS
> +	select CONFIGFS_FS
>  
>  config BLK_DEV_FD
>  	tristate "Normal floppy disk support"
> 
