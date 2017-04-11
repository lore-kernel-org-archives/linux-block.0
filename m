Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Fix list corruption of blk stats callback list
To: Jan Kara <jack@suse.cz>
References: <20170411092901.5974-1-jack@suse.cz>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7bacae93-53ec-1af1-4038-1c32765db181@kernel.dk>
Date: Tue, 11 Apr 2017 08:09:51 -0600
MIME-Version: 1.0
In-Reply-To: <20170411092901.5974-1-jack@suse.cz>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/11/2017 03:29 AM, Jan Kara wrote:
> When CFQ calls wbt_disable_default(), it will call
> blk_stat_remove_callback() to stop gathering IO statistics for the
> purposes of writeback throttling. Later, when request_queue is
> unregistered, wbt_exit() will call blk_stat_remove_callback() again
> which will try to delete callback from the list again and possibly cause
> list corruption.
> 
> Fix the problem by making wbt_disable_default() called wbt_exit() which
> is properly guarded against being called multiple times.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  block/blk-wbt.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> So this fixes the list debug errors reported by 0-day for me. It was a
> pre-existing problem with wbt_disable_default().

Thanks Jan, added for 4.12.

-- 
Jens Axboe
