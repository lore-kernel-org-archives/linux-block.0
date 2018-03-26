Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] block, bfq: keep peak_rate estimation within range
 1..2^32-1
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <E810B04D-CEC3-4D98-A52A-08509E7CE417@linaro.org>
Date: Mon, 26 Mar 2018 10:01:03 +0200
Cc: linux-block <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>,
 Mark Brown <broonie@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>
Message-Id: <17F0A3D1-29A6-4688-96F3-6776AF1DB7A4@linaro.org>
References: <152025413365.161046.7757556276366364549.stgit@buzz>
 <FE5352B7-CAFC-466C-BA07-F1B7427AA309@linaro.org>
 <ff761610-4a37-f239-a491-cf2a04c44574@yandex-team.ru>
 <E9AC28A6-848D-420F-8DAB-8B1FC709BA38@linaro.org>
 <38320074-d1e6-96bc-e832-e535efc07e81@yandex-team.ru>
 <E810B04D-CEC3-4D98-A52A-08509E7CE417@linaro.org>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 21 mar 2018, alle ore 00:49, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 20 mar 2018, alle ore 15:41, Konstantin Khlebnikov =
<khlebnikov@yandex-team.ru> ha scritto:
>>=20
>> On 20.03.2018 06:00, Paolo Valente wrote:
>>>> Il giorno 19 mar 2018, alle ore 14:28, Konstantin Khlebnikov =
<khlebnikov@yandex-team.ru> ha scritto:
>>>>=20
>>>> On 19.03.2018 09:03, Paolo Valente wrote:
>>>>>> Il giorno 05 mar 2018, alle ore 04:48, Konstantin Khlebnikov =
<khlebnikov@yandex-team.ru> ha scritto:
>>>>>>=20
>>>>>> Rate should never overflow or become zero because it is used as =
divider.
>>>>>> This patch accumulates it with saturation.
>>>>>>=20
>>>>>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>>>>> ---
>>>>>> block/bfq-iosched.c |    8 +++++---
>>>>>> 1 file changed, 5 insertions(+), 3 deletions(-)
>>>>>>=20
>>>>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>>>>> index aeca22d91101..a236c8d541b5 100644
>>>>>> --- a/block/bfq-iosched.c
>>>>>> +++ b/block/bfq-iosched.c
>>>>>> @@ -2546,7 +2546,8 @@ static void =
bfq_reset_rate_computation(struct bfq_data *bfqd,
>>>>>>=20
>>>>>> static void bfq_update_rate_reset(struct bfq_data *bfqd, struct =
request *rq)
>>>>>> {
>>>>>> -	u32 rate, weight, divisor;
>>>>>> +	u32 weight, divisor;
>>>>>> +	u64 rate;
>>>>>>=20
>>>>>> 	/*
>>>>>> 	 * For the convergence property to hold (see comments on
>>>>>> @@ -2634,9 +2635,10 @@ static void bfq_update_rate_reset(struct =
bfq_data *bfqd, struct request *rq)
>>>>>> 	 */
>>>>>> 	bfqd->peak_rate *=3D divisor-1;
>>>>>> 	bfqd->peak_rate /=3D divisor;
>>>>>> -	rate /=3D divisor; /* smoothing constant alpha =3D =
1/divisor */
>>>>>> +	do_div(rate, divisor);	/* smoothing constant alpha =3D =
1/divisor */
>>>>>>=20
>>>>>> -	bfqd->peak_rate +=3D rate;
>>>>>> +	/* rate should never overlow or become zero */
>>>>> It is bfqd->peak_rate that is used as a divider, and =
bfqd->peak_rate doesn't risk to be zero even if the variable 'rate' is =
zero here.
>>>>> So I guess the reason why you consider the possibility that =
bfqd->peak_rate becomes zero is because of an overflow when summing =
'rate'. But, according to my calculations, this should be impossible =
with devices with sensible speeds.
>>>>> These are the reasons why I decided I could make it with a 32-bit =
variable, without any additional clamping. Did I make any mistake in my =
evaluation?
>>>>=20
>>>> According to Murphy's law this is inevitable..
>>>>=20
>>> Yep.  Actually Murphy has been even clement this time, by making the
>>> failure occur to a kernel expert :)
>>>> I've seen couple division by zero crashes in bfq_wr_duration.
>>>> Unfortunately logs weren't recorded.
>>>>=20
>>>>> Anyway, even if I made some mistake about the maximum possible =
value of the device rate, and the latter may be too high for =
bfqd->peak_rate to contain it, then I guess the right solution would not =
be to clamp the actual rate to U32_MAX, but to move bfqd->peak_rate to =
64 bits. Or am I missing something else?
>>>>>>> +	bfqd->peak_rate =3D clamp_t(u64, rate + bfqd->peak_rate, =
1, U32_MAX);
>>>>=20
>>>> 32-bit should be enough and better for division.
>>>> My patch makes sure it never overflows/underflows.
>>>> That's cheaper than full 64-bit/64-bit division.
>>>> Anyway 64-bit speed could overflow too. =3D)
>>>>=20
>>> I see your point.  Still, if the mistake is not in sizing, then you
>>> bumped into some odd bug.  In this respect, I don't like much the =
idea
>>> of sweeping the dust under the carpet.  So, let me ask you for a
>>> little bit more help.  With your patch applied, and thus with no =
risk
>>> of crashes, what about adding, right before your clamp_t, something
>>> like:
>>> if (!bfqd->peak_rate)
>>> 	pr_crit(<dump of all the variables involved in updating =
bfqd->peak_rate>);
>>> Once the failure shows up (Murphy permitting), we might have hints =
to
>>> the bug causing it.
>>> Apart from that, I have no problem with patches that make bfq more
>>> robust, even in a sort of black-box way.
>>=20
>> This rate estimator is already works as a black-box with smoothing =
and
>> low-pass filter inside.
>=20
> Actually, it is just what you say: a low-pass filter, which works by
> deflating two non-null quantities (the previous and the current rate
> rate), by and adding these quantities to each other (to get the new
> estimated rate).  In addition to being larger than 0, both quantities
> are much lower than U32_MAX, so this computation should never yield
> zero because of an overflow.=20
>=20
> Even some occasional zeros read for the sampled rate (because of the
> suspicion you express below), cannot lead to a null estimated rate.
> In fact, this is a low-pass filter, meant to cut off occasional
> spurious values.
>=20
> I'm insisting on this part, just because, maybe, you say that it "acts
> as a black-box" because there is something more, which I'm overlooking
> here, and maybe the bug is exactly in the part I'm overlooking.  But,
> if this is not the case, I'll just stop now for this point.
>=20
>> It has limitations thus this is ok to declare
>> range of expected\sane results.
>>=20
>=20
> Correct, but if the odd value you cut off is a random value that
> follows from a bug (and I see no other possibility, in view of the
> above arguments), then the result may still be completely wrong.  For
> example:
> - the device may have a rate of, say, 200 MB/s
> - the computation of the new estimated rate yields 0
> - you limit this result to ~0 MB/s but >0 MB/s; this avoids division
> errors, but still leaves you with a completely wrong rate, and a
> consequently inconsistent behavior of the scheduler
>=20
>> It would be nice to show estimated rate in sysfs to let user
>> diagnose whenever it is wrong for a long period of time.
>=20
> Absolutely.  This is actually already shown indirectly, through the
> budget_max parameter, which is the number of sectors served at peak
> rate during slice_sync.
>=20
>> Printing message all the time even ratelimited is a wrong idea.
>> If this should never happens - WARN_ONCE is more than enough.
>>=20
>=20
> I'm sorry, I was totally unclear here.  My proposal for you is:
> since this failure does occur in your system, please add, temporarily, =
the
> printing of all involved values *all the times*, so that you can track =
down
> the bug, and fix the actual problem leading to this division by zero.
>=20
> What do you think?
>=20
>> I suspect crashes might be caused by bumpy timer which was affected =
by smi/nmi from mce.
>=20
> Yep.  The problem is that, for the estimated rate to go to zero, a
> null value must be sampled for several consecutive times.
>=20
>> I'll try to find evidence.
>=20
> Getting to the bottom of this would be really great.
>=20
> Looking forward to your findings,

I guess no news yet.  Anyway, your bug report has pushed me to think
over the representation of the rate.  And I may have found a problem,
which might be the cause of the zeros you have seen.

With a little math, it comes out that, for a sampled rate below about
5 KB/s, 0 is stored in the variable 'rate'.  The reason is that such
low values cannot be represented with the maximum precision currently
available in BFQ for rates.  So, if these very low values are sampled
for a few consecutive times, then the estimated peak rate may actually
become zero.

In the system in which you have seen null estimated rates, may the
virtual or physical storage device be occasionally so slow?

Thanks,
Paolo



> Paolo
>=20
>>=20
>>> Thanks a lot,
>>> Paolo
>>>>=20
>>>>>> 	update_thr_responsiveness_params(bfqd);
>>>>>>=20
>>>>>> reset_computation:
