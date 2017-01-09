Return-Path: <jack@suse.cz>
Date: Mon, 9 Jan 2017 21:20:18 +0100
From: Jan Kara <jack@suse.cz>
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: axboe@kernel.dk, jack@suse.cz, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	anton@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] do_direct_IO: Use inode->i_blkbits to compute block
 count to be cleaned
Message-ID: <20170109202018.GD18524@quack2.suse.cz>
References: <1483886830-23878-1-git-send-email-chandan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1483886830-23878-1-git-send-email-chandan@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On Sun 08-01-17 20:17:10, Chandan Rajendra wrote:
> The code currently uses sdio->blkbits to compute the number of blocks to
> be cleaned. However sdio->blkbits is derived from the logical block size
> of the underlying block device (Refer to the definition of
> do_blockdev_direct_IO()). Due to this, generic/299 test would rarely
> fail when executed on an ext4 filesystem with 64k as the block size and
> when using a virtio based disk (having 512 byte as the logical block
> size) inside a kvm guest.
> 
> This commit fixes the bug by using inode->i_blkbits to compute the
> number of blocks to be cleaned.

Ah, good catch. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> ---
>  fs/direct-io.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index aeae8c0..b20adf9 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -905,6 +905,7 @@ static inline void dio_zero_block(struct dio *dio, struct dio_submit *sdio,
>  static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
>  			struct buffer_head *map_bh)
>  {
> +	const unsigned i_blkbits = dio->inode->i_blkbits;
>  	const unsigned blkbits = sdio->blkbits;
>  	int ret = 0;
>  
> @@ -949,7 +950,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
>  					clean_bdev_aliases(
>  						map_bh->b_bdev,
>  						map_bh->b_blocknr,
> -						map_bh->b_size >> blkbits);
> +						map_bh->b_size >> i_blkbits);
>  				}
>  
>  				if (!sdio->blkfactor)
> -- 
> 2.5.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
