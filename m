Return-Path: <jack@suse.cz>
Date: Sat, 5 Nov 2016 23:26:37 +0100
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	jack@suse.cz, hch@lst.de
Subject: Re: [PATCH 3/8] writeback: mark background writeback as such
Message-ID: <20161105222637.GC32353@quack2.suse.cz>
References: <1478034531-28559-1-git-send-email-axboe@fb.com>
 <1478034531-28559-4-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478034531-28559-4-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Tue 01-11-16 15:08:46, Jens Axboe wrote:
> If we're doing background type writes, then use the appropriate
> background write flags for that.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/writeback.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 50c96ee8108f..c78f9f0920b5 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -107,6 +107,8 @@ static inline int wbc_to_write_flags(struct writeback_control *wbc)
>  {
>  	if (wbc->sync_mode == WB_SYNC_ALL)
>  		return REQ_SYNC;
> +	else if (wbc->for_kupdate || wbc->for_background)
> +		return REQ_BACKGROUND;
>  
>  	return 0;
>  }
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
