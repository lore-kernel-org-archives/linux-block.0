Return-Path: <obuil.liubo@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1529550424-105210-1-git-send-email-bo.liu@linux.alibaba.com>
References: <1529550424-105210-1-git-send-email-bo.liu@linux.alibaba.com>
From: Liu Bo <obuil.liubo@gmail.com>
Date: Fri, 29 Jun 2018 12:50:35 -0700
Message-ID: <CANQeFDAmOKH31CWzC6p=Uqy2NYW1rTzkjx+tppCPAOMtQubjxw@mail.gmail.com>
Subject: Re: [PATCH] Block: initialize bio_cnt_ret_time for the first time
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Liu Bo <bo.liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

This one is kind of obvious, could you please also take it thru your tree?

thanks,
liubo


On Wed, Jun 20, 2018 at 8:07 PM, Liu Bo <bo.liu@linux.alibaba.com> wrote:
> When a new tg is created, tg->bio_cnt_ret_time is 0, so if the first
> IO going thru this tg turns out to be a bad one, we fail to record it
> in tg->bad_bio_cnt as
>
> if (jiffies > bio_cnt_ret_time) {
>         tg->bad_bio_cnt /= 2;
> }
>
> Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> ---
>  block/blk-throttle.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 82282e6fdcf8..8bd54118dc0a 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -2329,6 +2329,8 @@ void blk_throtl_bio_endio(struct bio *bio)
>                 tg->bio_cnt++;
>         }
>
> +       if (unlikely(!tg->bio_cnt_reset_time))
> +               tg->bio_cnt_reset_time = jiffies;
>         if (time_after(jiffies, tg->bio_cnt_reset_time) || tg->bio_cnt > 1024) {
>                 tg->bio_cnt_reset_time = tg->td->throtl_slice + jiffies;
>                 tg->bio_cnt /= 2;
> --
> 1.8.3.1
>
