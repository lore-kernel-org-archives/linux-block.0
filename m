Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337E2610D;
	Sun, 27 Jul 2025 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753639626; cv=none; b=mMD6DSF/q8u/EjhFy75eZ8KLD4BMlOdTUKwocxJbrC5It0LaW5mSZLcbn1R/JlmUs4FZN7t4Wdt/9N8s7hFYALpAwKpEm7Owq8AcU84dAjBkWPLdb1vS2wPQqOD0cHSjmzwnydECzpkD23pggKqI+pQh7jyEIy9gQhEmFCj8Bgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753639626; c=relaxed/simple;
	bh=rxy5AtOA9YI2ntRYRRHv0o/jTlcOwky9zSWQX1Wu7yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqr2khzyfBAEimu7BZTMfVIkRehPNpn5FnEVRsezbdsVKZyb88bblpEPYEqIOq22ZWwVZ1VkkcB8Rb2R6mAlrbf5QNIGmnjYFPZ4PxhgZtfwSoJ0BbbG19hwyBivaoKh9nmQG9bKjZ5Lu2bN6J8bfMzgEVfUzk29cvJSPX49vqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffgMjDhw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffgMjDhw"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23ffdea3575so3781005ad.2;
        Sun, 27 Jul 2025 11:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753639624; x=1754244424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4oiLiNhkaxO8LsaSDMqBsw/x7dqCcdqZ5zoC67WtB4=;
        b=ffgMjDhw7LLRScXUuq6PQbUutfhUw21cjtriMhwd7i+iOyz877d9JpHj+PAaJmYNXr
         Af8/ROnRfs9Y/yVr6vXXCppO/Zz8k6Cs5FtG/nvecqf4Rd1p1WZ8qhy1McQJd1tBDFeZ
         rjPOFNFMoSdP8XAo7QMVF+U4ErBqzjYJHXBtmWYf/k9yEByvEJxzdYRQod6I0f6UmRhf
         pw0JpnkLAtuLD3Sei1QArNKP/uWWkUhVadOyGvKDwjEkROQNzugEUBl6Vwz5/8g8ZMtW
         oTw0sSVRX4wdsP0ypt+oEIK0l6AQosDM/4NO/aSlUlRg1I+M+M/4VZ9hTGvL1NIcRQkZ
         oS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753639624; x=1754244424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4oiLiNhkaxO8LsaSDMqBsw/x7dqCcdqZ5zoC67WtB4=;
        b=raMWH6WgzYpnK3E9BY+UAKEZw/7r1YjAPnAHWoiv7F69JEDv/woH3LNJPjqd2SJs89
         UewtAgES6bmrQfBT1/+4goQBRjQi4y2+QFmgT5H6wnOxEfBUyFy9xkcqw2wbR6Rp5H9n
         t9wTreZsXmDF8Lz/30xsjsxSKmYdoYeSTHEeQk5XrCvhyQMG5iUdWVCMc7JJgDr0wWT5
         xP+htla0VFNi4GFXqCGo9yMbprI6YVvOHfwO5NQHGK4nelhySS9OUAkTgzYMWarz5Shc
         r3ksjcQhsxpRreYToQlBkatwyp3fwh/6TxLlxVeSffT7K8Wdt09yT30CspBpfvmw/Mta
         0heg==
X-Forwarded-Encrypted: i=1; AJvYcCWfycLh+gsnSIDmvSzKzeDdB5CWGXhIbuZc47hGhgi5H9yjdsQH9qE2otBHk0j+BNRXL7iNrSI5ItZNTw==@vger.kernel.org, AJvYcCXPn7YNU67L7Kfr89Boz18dJ5EjoDXeRfQuMCdkZNRGN/hbhxvDsXrXKI+c0VLIUXR758z6viFRn3Wkllos@vger.kernel.org
X-Gm-Message-State: AOJu0YyndLLeIUP17lH+6A/OROT+DNPBbo6cWghmN0XdcuozSV3UkQa9
	eBBVgGxjkteWrT894opmQMUI9z4UpKpRIAK4kBygAHPeL4TnOu77co8g9c8RZhpLPIlgBNBHUE1
	NQ4rmclz9xHLf4kfxGzbw8H7xdr/dy7I=
X-Gm-Gg: ASbGncv+SDLBzoBp6SkaNHs8t1R94u+CMdrGv3B6tPxc/he6FMpu/MFHLoPRhzkO9xF
	Xr5Ao6DqXY7gJ6/2SXem4dqnndNS4MSVHwpCN4cpMBtXayn2DboXK0OeRndmlTltTgddA1GewyY
	fu5M5cM0stm8FGyTSha0dg7WcOd+EMZw1+RvsEYZzCH0DTBuuKAmSRz10RE6x6kJmCui8RycPnp
	Rgl/YA=
X-Google-Smtp-Source: AGHT+IHDw4e18MwM3meieNDv6CyNEIjw6RRBDQryjWtH7pCQyrFXbTQq3bN9ZLXfqefKAQAlrwduhDR/5zPd4XrD1jE=
X-Received: by 2002:a17:902:e74f:b0:234:8c64:7885 with SMTP id
 d9443c01a7336-23fb3197732mr126319445ad.53.1753639624238; Sun, 27 Jul 2025
 11:07:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727112142.604373-1-sau525@gmail.com>
In-Reply-To: <20250727112142.604373-1-sau525@gmail.com>
From: Yizhou Tang <tangyeechou@gmail.com>
Date: Mon, 28 Jul 2025 02:06:52 +0800
X-Gm-Features: Ac12FXzK89vxpSMC_5d__53ArdIcigzyoFYha3x__B2dA6SneSrQeWzSSRbUr1s
Message-ID: <CAOB9oOZtKOSLw8YDyLB8Vepcpv3z9oJw+CQX16XKA_JJ4o7uew@mail.gmail.com>
Subject: Re: [PATCH] blk-wbt: use fast inverse square root to optimize window
 size calculation
To: Meng Shao Liu <sau525@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 7:22=E2=80=AFPM Meng Shao Liu <sau525@gmail.com> wr=
ote:
>
> Optimize the computation of cur_win_nsec =3D win_nsec / sqrt(scale_step +=
 1)
> in blk-wbt by introducing a fast inverse square root algorithm.
> This approach replaces the original use of int_sqrt and division with a
> more efficient and accurate approximation method.
>
> Signed-off-by: Meng Shao Liu <sau525@gmail.com>
> ---
> Since this fast inverse square root algorithm now appears in three locati=
ons
> (blk-wbt, sch_cake, codel), it might be worth considering refactoring
> the implementation into a shared helper to reduce duplication and ensure =
consistency.
> However, this patch focuses solely on introducing the optimization in blk=
-wbt.
>
>  block/blk-wbt.c | 60 +++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 51 insertions(+), 9 deletions(-)
>
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index a50d4cd55..1fd5af3ba 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -80,6 +80,8 @@ struct rq_wb {
>         u64 win_nsec;                           /* default window size */
>         u64 cur_win_nsec;                       /* current window size */
>
> +       u32 rec_inv_sqrt;   /* reciprocal value of sqrt(scaling step + 1)=
 */
>         struct blk_stat_callback *cb;
>
>         u64 sync_issue;
> @@ -130,6 +132,11 @@ enum {
>          */
>         RWB_WINDOW_NSEC         =3D 100 * 1000 * 1000ULL,
>
> +       /*
> +        * Initial reciprocal value of sqrt(scaling step + 1)
> +        */
> +       RWB_REC_INV_SQRT    =3D 0,

Hi Meng,

As the initial value of scale_step is 0, then sqrt(0 + 1) =3D 1, which is n=
ot 0.

> +
>         /*
>          * Disregard stats, if we don't meet this minimum
>          */
> @@ -395,20 +402,55 @@ static void scale_down(struct rq_wb *rwb, bool hard=
_throttle)
>         rwb_trace_step(rwb, tracepoint_string("scale down"));
>  }
>
> +#define REC_INV_SQRT_CACHE (16)
> +static const u32 inv_sqrt_cache[REC_INV_SQRT_CACHE] =3D {
> +               ~0,         ~0, 3037000500, 2479700525,
> +       2147483647, 1920767767, 1753413056, 1623345051,
> +       1518500250, 1431655765, 1358187914, 1294981364,
> +       1239850263, 1191209601, 1147878294, 1108955788
> +};
> +
> +/* http://en.wikipedia.org/wiki/Methods_of_computing_square_roots
> + * new_invsqrt =3D (invsqrt / 2) * (3 - count * invsqrt^2)
> + *
> + * Here, invsqrt is a fixed point number (< 1.0), 32bit mantissa, aka Q0=
.32
> + */
> +
> +static void rwb_newton_step(struct rq_wb *rwb)
> +{
> +       struct rq_depth *rqd =3D &rwb->rq_depth;
> +       u32 invsqrt, invsqrt2;
> +       u64 val;
> +
> +       invsqrt =3D rwb->rec_inv_sqrt;
> +       invsqrt2 =3D ((u64)invsqrt * invsqrt) >> 32;
> +       val =3D (3LL << 32) - ((u64)(rqd->scale_step + 1) * invsqrt2);
> +
> +       val >>=3D 2; /* avoid overflow in following multiply */
> +       val =3D (val * invsqrt) >> (32 - 2 + 1);
> +
> +       rwb->rec_inv_sqrt =3D val;
> +}
> +
> +static void rwb_invsqrt(struct rq_wb *rwb)
> +{
> +       struct rq_depth *rqd =3D &rwb->rq_depth;
> +
> +       if (rqd->scale_step + 1 < REC_INV_SQRT_CACHE)
> +               rwb->rec_inv_sqrt =3D inv_sqrt_cache[rqd->scale_step + 1]=
;
> +       else
> +               rwb_newton_step(rwb);
> +}
> +
>  static void rwb_arm_timer(struct rq_wb *rwb)
>  {
>         struct rq_depth *rqd =3D &rwb->rq_depth;
>
>         if (rqd->scale_step > 0) {
> -               /*
> -                * We should speed this up, using some variant of a fast
> -                * integer inverse square root calculation. Since we only=
 do
> -                * this for every window expiration, it's not a huge deal=
,
> -                * though.
> -                */
> -               rwb->cur_win_nsec =3D div_u64(rwb->win_nsec << 4,
> -                                       int_sqrt((rqd->scale_step + 1) <<=
 8));
> -       } else {
> +               rwb_invsqrt(rwb);
> +               rwb->cur_win_nsec =3D reciprocal_scale(rwb->win_nsec,
> +                                            rwb->rec_inv_sqrt);

I think placing the two lines of code involving mathematical formulas
directly in a core wbt code path is not a good idea. I suggest you
encapsulate them in a separate function and document its purpose.

Thanks,
Yi

> +       } else {
>                 /*
>                  * For step < 0, we don't want to increase/decrease the
>                  * window size.
> @@ -911,6 +953,7 @@ int wbt_init(struct gendisk *disk)
>
>         rwb->last_comp =3D rwb->last_issue =3D jiffies;
>         rwb->win_nsec =3D RWB_WINDOW_NSEC;
> +       rwb->rec_inv_sqrt =3D RWB_REC_INV_SQRT;
>         rwb->enable_state =3D WBT_STATE_ON_DEFAULT;
>         rwb->rq_depth.default_depth =3D RWB_DEF_DEPTH;
>         rwb->min_lat_nsec =3D wbt_default_latency_nsec(q);
> --
> 2.50.1
>
>
