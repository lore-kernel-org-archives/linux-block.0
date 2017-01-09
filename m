Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: axboe@kernel.dk, jack@suse.cz, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        anton@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] do_direct_IO: Use inode->i_blkbits to compute block count to be cleaned
References: <1483886830-23878-1-git-send-email-chandan@linux.vnet.ibm.com>
Date: Mon, 09 Jan 2017 11:04:15 -0500
In-Reply-To: <1483886830-23878-1-git-send-email-chandan@linux.vnet.ibm.com>
	(Chandan Rajendra's message of "Sun, 8 Jan 2017 20:17:10 +0530")
Message-ID: <x49fuksi5j4.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Chandan Rajendra <chandan@linux.vnet.ibm.com> writes:

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
>
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

NAK.  Please see commit ab73857e354 ("direct-io: don't read
inode->i_blkbits multiple times").

I think you want:

	const unsigned i_blkbits = sdio->blkbits + sdio->blkfactor;

as is used elsewhere in the code.

Cheers,
Jeff
