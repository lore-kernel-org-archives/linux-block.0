Return-Path: <m.tretter@pengutronix.de>
Date: Thu, 15 Mar 2018 11:00:57 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <jbacik@fb.com>, kernel@pengutronix.de, axboe@kernel.dk
Subject: Re: [PATCH] nbd: do not update block size if file system is mounted
Message-ID: <20180315110057.13eecda6@litschi.hi.pengutronix.de>
In-Reply-To: <20180228095456.31472-1-m.tretter@pengutronix.de>
References: <20180228095456.31472-1-m.tretter@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Wed, 28 Feb 2018 10:54:56 +0100, Michael Tretter wrote:
> If a file system is mounted on the nbd during a disconnect, resetting
> the size to 0, might change the block size and destroy the buffer_head
> mappings. This will cause a infinite loop when the file system looks for
> the buffer_heads for flushing.
> 
> Only set the file size to 0, if we are the only opener of the nbd.
> 
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> ---
>  drivers/block/nbd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 5f2a4240a204..0d1dbb60430b 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1118,7 +1118,8 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
>  	if (ret)
>  		sock_shutdown(nbd);
>  	mutex_lock(&nbd->config_lock);
> -	bd_set_size(bdev, 0);
> +	if (bdev->bd_openers <= 1)
> +		bd_set_size(bdev, 0);
>  	/* user requested, ignore socket errors */
>  	if (test_bit(NBD_DISCONNECT_REQUESTED, &config->runtime_flags))
>  		ret = 0;

Are there any comments on this patch?

Michael
