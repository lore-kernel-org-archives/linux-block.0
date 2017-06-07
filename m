Subject: Re: [PATCH] blk-throttle: fix NULL pointer dereference in
 throtl_schedule_pending_timer
To: Joseph Qi <jiangqi903@gmail.com>, linux-block@vger.kernel.org
Cc: Shaohua Li <shli@fb.com>, boyu.mt@taobao.com, wenqing.lz@taobao.com,
 qijiang.qj@alibaba-inc.com
References: <ba25ffe3-9db7-2311-51c7-91fce0ce8cfa@gmail.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <3bb46db6-4395-194d-84ab-334a2eb4f99f@fb.com>
Date: Wed, 7 Jun 2017 08:12:05 -0600
MIME-Version: 1.0
In-Reply-To: <ba25ffe3-9db7-2311-51c7-91fce0ce8cfa@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/06/2017 09:36 PM, Joseph Qi wrote:
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

Applied, thanks.

-- 
Jens Axboe
