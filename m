Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF12C18A;
	Mon, 28 Jul 2025 04:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753678446; cv=none; b=tSVb1JVp0RvWLztpkPmBj1CCCuRuB4fYtjcyCd7TVdf2Ig/uuqgNgccsoY7BILdcFWcPpqzPb9xR6aEKn+E4sNudAXGlIx1Sf5uI18bUk5rluIQN/jU1e+S6wu9yHXF/aTD0sLr1G+pCD4mGLSPZn0dbfZusAni2D8sjSUynnmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753678446; c=relaxed/simple;
	bh=1nRrmjtwPRa/2PaskDZ7LTokMtcKhN7RDoEQKD/sGM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiXAAvjlrF4a+8JVo+oaFx2+tCfuS1sihH4ooONBHUXkyv5wsXChuHlMz5CNpszNM6G6q3tztPkjro/nO213LtoOnV4EbcvUH6/CHEeSLpL0AgKTDHy89qqCuMYriBZGoNmx7HbI0ZL8g1fCP1SmOHV1NUgyTPGxI1xM5wiZQBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mO+VA9Jq; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mO+VA9Jq"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3190fbe8536so3570846a91.3;
        Sun, 27 Jul 2025 21:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753678444; x=1754283244; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zzQWmN4dgFJtb8rMGxCdf6MbWNN67ggtokQ5t4pFxJY=;
        b=mO+VA9JqydM6b5mGNIWKwbzDHvhEgVgXKlsnKYQuJod04wiXG46IRyQ2Ga+1o0ysAK
         P3xFtxcvEEDvfu8hlB+QvGtooKnRtwMja2u/7AXXlBg6l+uFGJW6286qt0Q0akuY5flA
         YWyquow83XcSwihRqYRnvnZhm1g1Ms5KRLs4lKO040fGaxwyO301WEQrMgTxJ68DG9Q6
         txNjcIllEwm4f0ne3s/a3rA9G1WybO6Bdw6xqTG1aUSkJyvGc3TAviJaXOrzYPCEHljV
         cpDvGlKr2gSKPVQ8gMSUAOD1U/g6tROjvJbEE45/tWnDqUrGcYkLJpg3pFF5aEoZ9ftA
         eCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753678444; x=1754283244;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzQWmN4dgFJtb8rMGxCdf6MbWNN67ggtokQ5t4pFxJY=;
        b=jzMlmBxwmGN9NQGmahmg9bAMKX6Ao0cKqOwyUd8ZTjwUFhYZRw0SPmmHsMVFLheKfS
         noCCxfDUp4+T9hI+X21sbMvCQOwmhXA0J4XOtobLBPHG6OThyNdirW7xNP42s6zlWxq4
         id7v4b+HxLz+o0c/oomB1r1am9CRF1z8ZlRwe4tVX9OFTNrRdedfC8TjVXwJOgzGPnS1
         u74aRy7jUKfFo0GNQ80r37zHTrSlNNyvL/sqyHs70ntsBf7G9cUu2kZ6nJO42eItByET
         2rtxIUAkneorwCZH3eUtGX3XK+N86baOtSnLAt8kIhZ7lSgPkzDIRZd71nmO5/0K2tVp
         Yu1w==
X-Forwarded-Encrypted: i=1; AJvYcCVWfBxbFBggc1i5QDoakbotcEisKwmosKi2u1MAhQoZnzbGIqbJQsyZdkps9lH9jvhZzo76Mt6hmF8EH2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ0bmz5zc1a1ClDX8UynYxUYRsPWZ/O+7CGcLwltLw38ShltgM
	z5ljJnyJkHdGdurmhkHuhGSMvRuD5KzNx7H1z/0nxX8CS4oWghAhHjPmfSyinKw=
X-Gm-Gg: ASbGncsSe5G29xO0CG2haRoL3kBwOW4ADHq/qOezp3z8XjMpzHWGaclCUptttQC3yk+
	gX7RIasFxzuByMWN/pCZhtyNTahpbRCk2QZytY+a9kxIJyU3fL7wLeVWnpur6iBI7KlbwZWJduH
	TJhOPygniR7vSJJPjfOlVacISa9XAtIaMu6vUOOWpvp6zURLOCPFV9CNuu8f2nJaCdQ3Y+YW57Q
	xhJwrLT+BgabOuvXmhutkalTVKkBqO+9miAwXzhXSEApWuAZl5UKBJbtXfBwiN4rgMa6FIOWQhQ
	b5kY8Wwo3u7ddYmbcfSe5jBR99hgwkfwCwwEF+50BkR8+rk4qNWtW3NfHIwpdpm0KyZ4qObSTT5
	9OsNbGg37IwENkG+LG/WLZDkJwQVynvwg+ql8GUpXU7Zfsht3glmcBlGLyuOn08ZAzDd0Y5ECPV
	4d896CCpPl0IyAsQ==
X-Google-Smtp-Source: AGHT+IEoOS2gP+gRv6P2IQF8Ow5kilj7AjufMJiKyHDsPVUHMjWvUr3tfTdNOgWgrxcB2AlCV+K8Cw==
X-Received: by 2002:a17:90b:54c5:b0:31e:d9f0:9b96 with SMTP id 98e67ed59e1d1-31ed9f09d22mr4069234a91.14.1753678443590;
        Sun, 27 Jul 2025 21:54:03 -0700 (PDT)
Received: from maxserver (2001-b011-e009-e772-79bd-fe51-8340-5cfc.dynamic-ip6.hinet.net. [2001:b011:e009:e772:79bd:fe51:8340:5cfc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e83545d23sm4693958a91.31.2025.07.27.21.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 21:54:03 -0700 (PDT)
Date: Mon, 28 Jul 2025 00:54:00 -0400
From: Meng Shao Liu <sau525@gmail.com>
To: Yizhou Tang <tangyeechou@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-wbt: use fast inverse square root to optimize window
 size calculation
Message-ID: <aIcCaJWMX37SCLiu@maxserver>
References: <20250727112142.604373-1-sau525@gmail.com>
 <CAOB9oOZtKOSLw8YDyLB8Vepcpv3z9oJw+CQX16XKA_JJ4o7uew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOB9oOZtKOSLw8YDyLB8Vepcpv3z9oJw+CQX16XKA_JJ4o7uew@mail.gmail.com>

On Mon, Jul 28, 2025 at 02:06:52AM +0800, Yizhou Tang wrote:
> On Sun, Jul 27, 2025 at 7:22 PM Meng Shao Liu <sau525@gmail.com> wrote:
> >
> > Optimize the computation of cur_win_nsec = win_nsec / sqrt(scale_step + 1)
> > in blk-wbt by introducing a fast inverse square root algorithm.
> > This approach replaces the original use of int_sqrt and division with a
> > more efficient and accurate approximation method.
> >
> > Signed-off-by: Meng Shao Liu <sau525@gmail.com>
> > ---
> > Since this fast inverse square root algorithm now appears in three locations
> > (blk-wbt, sch_cake, codel), it might be worth considering refactoring
> > the implementation into a shared helper to reduce duplication and ensure consistency.
> > However, this patch focuses solely on introducing the optimization in blk-wbt.
> >
> >  block/blk-wbt.c | 60 +++++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 51 insertions(+), 9 deletions(-)
> >
> > diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> > index a50d4cd55..1fd5af3ba 100644
> > --- a/block/blk-wbt.c
> > +++ b/block/blk-wbt.c
> > @@ -80,6 +80,8 @@ struct rq_wb {
> >         u64 win_nsec;                           /* default window size */
> >         u64 cur_win_nsec;                       /* current window size */
> >
> > +       u32 rec_inv_sqrt;   /* reciprocal value of sqrt(scaling step + 1) */
> >         struct blk_stat_callback *cb;
> >
> >         u64 sync_issue;
> > @@ -130,6 +132,11 @@ enum {
> >          */
> >         RWB_WINDOW_NSEC         = 100 * 1000 * 1000ULL,
> >
> > +       /*
> > +        * Initial reciprocal value of sqrt(scaling step + 1)
> > +        */
> > +       RWB_REC_INV_SQRT    = 0,
> 
> Hi Meng,
> 
> As the initial value of scale_step is 0, then sqrt(0 + 1) = 1, which is not 0.
> 
Thanks for pointing out the problem.
> > +
> >         /*
> >          * Disregard stats, if we don't meet this minimum
> >          */
> > @@ -395,20 +402,55 @@ static void scale_down(struct rq_wb *rwb, bool hard_throttle)
> >         rwb_trace_step(rwb, tracepoint_string("scale down"));
> >  }
> >
> > +#define REC_INV_SQRT_CACHE (16)
> > +static const u32 inv_sqrt_cache[REC_INV_SQRT_CACHE] = {
> > +               ~0,         ~0, 3037000500, 2479700525,
> > +       2147483647, 1920767767, 1753413056, 1623345051,
> > +       1518500250, 1431655765, 1358187914, 1294981364,
> > +       1239850263, 1191209601, 1147878294, 1108955788
> > +};
> > +
> > +/* http://en.wikipedia.org/wiki/Methods_of_computing_square_roots
> > + * new_invsqrt = (invsqrt / 2) * (3 - count * invsqrt^2)
> > + *
> > + * Here, invsqrt is a fixed point number (< 1.0), 32bit mantissa, aka Q0.32
> > + */
> > +
> > +static void rwb_newton_step(struct rq_wb *rwb)
> > +{
> > +       struct rq_depth *rqd = &rwb->rq_depth;
> > +       u32 invsqrt, invsqrt2;
> > +       u64 val;
> > +
> > +       invsqrt = rwb->rec_inv_sqrt;
> > +       invsqrt2 = ((u64)invsqrt * invsqrt) >> 32;
> > +       val = (3LL << 32) - ((u64)(rqd->scale_step + 1) * invsqrt2);
> > +
> > +       val >>= 2; /* avoid overflow in following multiply */
> > +       val = (val * invsqrt) >> (32 - 2 + 1);
> > +
> > +       rwb->rec_inv_sqrt = val;
> > +}
> > +
> > +static void rwb_invsqrt(struct rq_wb *rwb)
> > +{
> > +       struct rq_depth *rqd = &rwb->rq_depth;
> > +
> > +       if (rqd->scale_step + 1 < REC_INV_SQRT_CACHE)
> > +               rwb->rec_inv_sqrt = inv_sqrt_cache[rqd->scale_step + 1];
> > +       else
> > +               rwb_newton_step(rwb);
> > +}
> > +
> >  static void rwb_arm_timer(struct rq_wb *rwb)
> >  {
> >         struct rq_depth *rqd = &rwb->rq_depth;
> >
> >         if (rqd->scale_step > 0) {
> > -               /*
> > -                * We should speed this up, using some variant of a fast
> > -                * integer inverse square root calculation. Since we only do
> > -                * this for every window expiration, it's not a huge deal,
> > -                * though.
> > -                */
> > -               rwb->cur_win_nsec = div_u64(rwb->win_nsec << 4,
> > -                                       int_sqrt((rqd->scale_step + 1) << 8));
> > -       } else {
> > +               rwb_invsqrt(rwb);
> > +               rwb->cur_win_nsec = reciprocal_scale(rwb->win_nsec,
> > +                                            rwb->rec_inv_sqrt);
> 
> I think placing the two lines of code involving mathematical formulas
> directly in a core wbt code path is not a good idea. I suggest you
> encapsulate them in a separate function and document its purpose.
> 
> Thanks,
> Yi
> 
Got it!
> > +       } else {
> >                 /*
> >                  * For step < 0, we don't want to increase/decrease the
> >                  * window size.
> > @@ -911,6 +953,7 @@ int wbt_init(struct gendisk *disk)
> >
> >         rwb->last_comp = rwb->last_issue = jiffies;
> >         rwb->win_nsec = RWB_WINDOW_NSEC;
> > +       rwb->rec_inv_sqrt = RWB_REC_INV_SQRT;
> >         rwb->enable_state = WBT_STATE_ON_DEFAULT;
> >         rwb->rq_depth.default_depth = RWB_DEF_DEPTH;
> >         rwb->min_lat_nsec = wbt_default_latency_nsec(q);
> > --
> > 2.50.1
> >
> >
