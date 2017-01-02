Return-Path: <jack@suse.cz>
Date: Mon, 2 Jan 2017 16:58:03 +0100
From: Jan Kara <jack@suse.cz>
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: axboe@kernel.dk, jack@suse.cz, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clean_bdev_aliases: Prevent cleaning blocks that are not
 in block range
Message-ID: <20170102155803.GH18058@quack2.suse.cz>
References: <1482672663-17122-1-git-send-email-chandan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1482672663-17122-1-git-send-email-chandan@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On Sun 25-12-16 19:01:03, Chandan Rajendra wrote:
> The first block to be cleaned may start at a non-zero page offset. In
> such a scenario clean_bdev_aliases() will end up cleaning blocks that
> do not fall in the range of blocks to be cleaned. This commit fixes the
> issue by skipping blocks that do not fall in valid block range.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>

Ah, very good catch! How did you spot this?

The patch looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

Jens, please merge this fix quickly as we may end up discarding changes to
innocent metadata blocks due to this... Thanks!

								Honza
> ---
>  fs/buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 1df2bd5..28484b3 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1660,7 +1660,7 @@ void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
>  			head = page_buffers(page);
>  			bh = head;
>  			do {
> -				if (!buffer_mapped(bh))
> +				if (!buffer_mapped(bh) || (bh->b_blocknr < block))
>  					goto next;
>  				if (bh->b_blocknr >= block + len)
>  					break;
> -- 
> 2.5.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
