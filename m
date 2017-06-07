Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbdFGEY5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Jun 2017 00:24:57 -0400
Date: Tue, 6 Jun 2017 21:24:54 -0700
From: Shaohua Li <shli@kernel.org>
To: Joseph Qi <jiangqi903@gmail.com>
Cc: linux-block@vger.kernel.org, axboe@fb.com,
        Shaohua Li <shli@fb.com>, boyu.mt@taobao.com,
        wenqing.lz@taobao.com, qijiang.qj@alibaba-inc.com
Subject: Re: [PATCH] blk-throttle: fix NULL pointer dereference in
 throtl_schedule_pending_timer
Message-ID: <20170607042454.q5nkqggitwcqrym7@kernel.org>
References: <ba25ffe3-9db7-2311-51c7-91fce0ce8cfa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ba25ffe3-9db7-2311-51c7-91fce0ce8cfa@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 07, 2017 at 11:36:14AM +0800, Joseph Qi wrote:
> From: Joseph Qi <qijiang.qj@alibaba-inc.com>
> 
> I have encountered a NULL pointer dereference in
> throtl_schedule_pending_timer:
>   [  413.735396] BUG: unable to handle kernel NULL pointer dereference at 0000000000000038
>   [  413.735535] IP: [<ffffffff812ebbbf>] throtl_schedule_pending_timer+0x3f/0x210
>   [  413.735643] PGD 22c8cf067 PUD 22cb34067 PMD 0
>   [  413.735713] Oops: 0000 [#1] SMP
>   ......
> 
> This is caused by the following case:
>   blk_throtl_bio
>     throtl_schedule_next_dispatch  <= sq is top level one without parent
>       throtl_schedule_pending_timer
>         sq_to_tg(sq)->td->throtl_slice  <= sq_to_tg(sq) returns NULL
> 
> Fix it by using sq_to_td instead of sq_to_tg(sq)->td, which will always
> return a valid td.
> 
> Fixes: 297e3d854784 ("blk-throttle: make throtl_slice tunable")
> Signed-off-by: Joseph Qi <qijiang.qj@alibaba-inc.com>

Thanks!

Reviewed-by: Shaohua Li <shli@fb.com>
> ---
>  block/blk-throttle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index fc13dd0..3b751f7 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -698,7 +698,7 @@ static void throtl_dequeue_tg(struct throtl_grp *tg)
>  static void throtl_schedule_pending_timer(struct throtl_service_queue *sq,
>  					  unsigned long expires)
>  {
> -	unsigned long max_expire = jiffies + 8 * sq_to_tg(sq)->td->throtl_slice;
> +	unsigned long max_expire = jiffies + 8 * sq_to_td(sq)->throtl_slice;
>  
>  	/*
>  	 * Since we are adjusting the throttle limit dynamically, the sleep
> -- 
> 1.9.4
