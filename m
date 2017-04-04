Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V2 04/16] block, bfq: modify the peak-rate estimator
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1490974279.2587.5.camel@sandisk.com>
Date: Tue, 4 Apr 2017 12:42:24 +0200
Cc: "tj@kernel.org" <tj@kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "fchecconi@gmail.com" <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "broonie@kernel.org" <broonie@kernel.org>
Message-Id: <867BBC1E-080B-4A4B-88CE-BD103610BA6C@linaro.org>
References: <20170331124743.3530-1-paolo.valente@linaro.org> <20170331124743.3530-5-paolo.valente@linaro.org> <1490974279.2587.5.camel@sandisk.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 31 mar 2017, alle ore 17:31, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>=20
> On Fri, 2017-03-31 at 14:47 +0200, Paolo Valente wrote:
>> -static bool bfq_update_peak_rate(struct bfq_data *bfqd, struct =
bfq_queue *bfqq,
>> -                                bool compensate)
>> +static bool bfq_bfqq_is_slow(struct bfq_data *bfqd, struct bfq_queue =
*bfqq,
>> +                                bool compensate, enum =
bfqq_expiration reason,
>> +                                unsigned long *delta_ms)
>>  {
>> -       u64 bw, usecs, expected, timeout;
>> -       ktime_t delta;
>> -       int update =3D 0;
>> +       ktime_t delta_ktime;
>> +       u32 delta_usecs;
>> +       bool slow =3D BFQQ_SEEKY(bfqq); /* if delta too short, use =
seekyness */
>> =20
>> -       if (!bfq_bfqq_sync(bfqq) || bfq_bfqq_budget_new(bfqq))
>> +       if (!bfq_bfqq_sync(bfqq))
>>                 return false;
>> =20
>>         if (compensate)
>> -               delta =3D bfqd->last_idling_start;
>> +               delta_ktime =3D bfqd->last_idling_start;
>>         else
>> -               delta =3D ktime_get();
>> -       delta =3D ktime_sub(delta, bfqd->last_budget_start);
>> -       usecs =3D ktime_to_us(delta);
>> -
>> -       /* Don't trust short/unrealistic values. */
>> -       if (usecs < 100 || usecs >=3D LONG_MAX)
>> -               return false;
>> -
>> -       /*
>> -        * Calculate the bandwidth for the last slice.  We use a 64 =
bit
>> -        * value to store the peak rate, in sectors per usec in fixed
>> -        * point math.  We do so to have enough precision in the =
estimate
>> -        * and to avoid overflows.
>> -        */
>> -       bw =3D (u64)bfqq->entity.service << BFQ_RATE_SHIFT;
>> -       do_div(bw, (unsigned long)usecs);
>> +               delta_ktime =3D ktime_get();
>> +       delta_ktime =3D ktime_sub(delta_ktime, =
bfqd->last_budget_start);
>> +       delta_usecs =3D ktime_to_us(delta_ktime);
>> +
>=20
> This patch changes the type of the variable in which the result of =
ktime_to_us()
> is stored from u64 into u32 and next compares that result with =
LONG_MAX. Since
> ktime_to_us() returns a signed 64-bit number, are you sure you want to =
store that
> result in a 32-bit variable? If ktime_to_us() would e.g. return =
0xffffffff00000100
> or 0x100000100 then the assignment will truncate these numbers to =
0x100.
>=20

The instruction above the assignment you highlight stores in
delta_ktime the difference between 'now' and the last budget start.
The latter may have happened at most about 100 ms before 'now'.  So
there should be no overflow issue.

Thanks,
Paolo

> Bart.
