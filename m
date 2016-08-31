Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 31 Aug 2016 16:32:58 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/8] writeback: add wbc_to_write_flags()
Message-ID: <20160831233258.GA24440@vader>
References: <1472663151-18560-1-git-send-email-axboe@fb.com>
 <1472663151-18560-3-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472663151-18560-3-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 31, 2016 at 11:05:45AM -0600, Jens Axboe wrote:
> Add wbc_to_write_flags(), which returns the write modifier flags to use,
> based on a struct writeback_control. No functional changes in this
> patch, but it prepares us for factoring other wbc fields for write type.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

[snip]

> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index fc1e16c25a29..e1fc25172397 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -100,6 +100,14 @@ struct writeback_control {
>  #endif
>  };
>  
> +static inline int wbc_to_write_flags(struct writeback_control *wbc)
> +{
> +	if (wbc->sync_mode == WB_SYNC_ALL)
> +		return WRITE_SYNC;
> +
> +	return WRITE;

I think this should be `return 0;` after the op/flags split. WRITE == 1,
so this would get interpreted as REQ_FAILFAST_DEV in bi_opf.

>From 2a222ca992c3 ("fs: have submit_bh users pass in op and flags
separately"):

@@ -1697,7 +1697,7 @@ static int __block_write_full_page(struct inode *inode, struct page *page,
        struct buffer_head *bh, *head;
        unsigned int blocksize, bbits;
        int nr_underway = 0;
-       int write_op = (wbc->sync_mode == WB_SYNC_ALL ? WRITE_SYNC : WRITE);
+       int write_flags = (wbc->sync_mode == WB_SYNC_ALL ? WRITE_SYNC : 0);

-- 
Omar
