Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "tj@kernel.org" <tj@kernel.org>, "paolo.valente@linaro.org"
	<paolo.valente@linaro.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"fchecconi@gmail.com" <fchecconi@gmail.com>, "avanzini.arianna@gmail.com"
	<avanzini.arianna@gmail.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH V2 04/16] block, bfq: modify the peak-rate estimator
Date: Fri, 31 Mar 2017 15:31:44 +0000
Message-ID: <1490974279.2587.5.camel@sandisk.com>
References: <20170331124743.3530-1-paolo.valente@linaro.org>
	 <20170331124743.3530-5-paolo.valente@linaro.org>
In-Reply-To: <20170331124743.3530-5-paolo.valente@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-03-31 at 14:47 +0200, Paolo Valente wrote:
> -static bool bfq_update_peak_rate(struct bfq_data *bfqd, struct bfq_queue=
 *bfqq,
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 bool compensate)
> +static bool bfq_bfqq_is_slow(struct bfq_data *bfqd, struct bfq_queue *bf=
qq,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 bool compensate, enum bfqq_expiration reason,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 unsigned long *delta_ms)
> =A0{
> -=A0=A0=A0=A0=A0=A0=A0u64 bw, usecs, expected, timeout;
> -=A0=A0=A0=A0=A0=A0=A0ktime_t delta;
> -=A0=A0=A0=A0=A0=A0=A0int update =3D 0;
> +=A0=A0=A0=A0=A0=A0=A0ktime_t delta_ktime;
> +=A0=A0=A0=A0=A0=A0=A0u32 delta_usecs;
> +=A0=A0=A0=A0=A0=A0=A0bool slow =3D BFQQ_SEEKY(bfqq); /* if delta too sho=
rt, use seekyness */
> =A0
> -=A0=A0=A0=A0=A0=A0=A0if (!bfq_bfqq_sync(bfqq) || bfq_bfqq_budget_new(bfq=
q))
> +=A0=A0=A0=A0=A0=A0=A0if (!bfq_bfqq_sync(bfqq))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return false;
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0if (compensate)
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0delta =3D bfqd->last_idling=
_start;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0delta_ktime =3D bfqd->last_=
idling_start;
> =A0=A0=A0=A0=A0=A0=A0=A0else
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0delta =3D ktime_get();
> -=A0=A0=A0=A0=A0=A0=A0delta =3D ktime_sub(delta, bfqd->last_budget_start)=
;
> -=A0=A0=A0=A0=A0=A0=A0usecs =3D ktime_to_us(delta);
> -
> -=A0=A0=A0=A0=A0=A0=A0/* Don't trust short/unrealistic values. */
> -=A0=A0=A0=A0=A0=A0=A0if (usecs < 100 || usecs >=3D LONG_MAX)
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return false;
> -
> -=A0=A0=A0=A0=A0=A0=A0/*
> -=A0=A0=A0=A0=A0=A0=A0 * Calculate the bandwidth for the last slice.=A0 W=
e use a 64 bit
> -=A0=A0=A0=A0=A0=A0=A0 * value to store the peak rate, in sectors per use=
c in fixed
> -=A0=A0=A0=A0=A0=A0=A0 * point math.=A0 We do so to have enough precision=
 in the estimate
> -=A0=A0=A0=A0=A0=A0=A0 * and to avoid overflows.
> -=A0=A0=A0=A0=A0=A0=A0 */
> -=A0=A0=A0=A0=A0=A0=A0bw =3D (u64)bfqq->entity.service << BFQ_RATE_SHIFT;
> -=A0=A0=A0=A0=A0=A0=A0do_div(bw, (unsigned long)usecs);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0delta_ktime =3D ktime_get()=
;
> +=A0=A0=A0=A0=A0=A0=A0delta_ktime =3D ktime_sub(delta_ktime, bfqd->last_b=
udget_start);
> +=A0=A0=A0=A0=A0=A0=A0delta_usecs =3D ktime_to_us(delta_ktime);
> +

This patch changes the type of the variable in which the result of ktime_to=
_us()
is stored from u64 into u32 and next compares that result with LONG_MAX. Si=
nce
ktime_to_us() returns a signed 64-bit number, are you sure you want to stor=
e that
result in a 32-bit variable? If ktime_to_us() would e.g. return 0xffffffff0=
0000100
or 0x100000100 then the assignment will truncate these numbers to 0x100.

Bart.=
