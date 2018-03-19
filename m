Return-Path: <khlebnikov@yandex-team.ru>
Subject: Re: [PATCH] block, bfq: keep peak_rate estimation within range
 1..2^32-1
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>
References: <152025413365.161046.7757556276366364549.stgit@buzz>
 <FE5352B7-CAFC-466C-BA07-F1B7427AA309@linaro.org>
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <ff761610-4a37-f239-a491-cf2a04c44574@yandex-team.ru>
Date: Mon, 19 Mar 2018 09:28:25 +0300
MIME-Version: 1.0
In-Reply-To: <FE5352B7-CAFC-466C-BA07-F1B7427AA309@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 19.03.2018 09:03, Paolo Valente wrote:
> 
> 
>> Il giorno 05 mar 2018, alle ore 04:48, Konstantin Khlebnikov <khlebnikov@yandex-team.ru> ha scritto:
>>
>> Rate should never overflow or become zero because it is used as divider.
>> This patch accumulates it with saturation.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> ---
>> block/bfq-iosched.c |    8 +++++---
>> 1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index aeca22d91101..a236c8d541b5 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -2546,7 +2546,8 @@ static void bfq_reset_rate_computation(struct bfq_data *bfqd,
>>
>> static void bfq_update_rate_reset(struct bfq_data *bfqd, struct request *rq)
>> {
>> -	u32 rate, weight, divisor;
>> +	u32 weight, divisor;
>> +	u64 rate;
>>
>> 	/*
>> 	 * For the convergence property to hold (see comments on
>> @@ -2634,9 +2635,10 @@ static void bfq_update_rate_reset(struct bfq_data *bfqd, struct request *rq)
>> 	 */
>> 	bfqd->peak_rate *= divisor-1;
>> 	bfqd->peak_rate /= divisor;
>> -	rate /= divisor; /* smoothing constant alpha = 1/divisor */
>> +	do_div(rate, divisor);	/* smoothing constant alpha = 1/divisor */
>>
>> -	bfqd->peak_rate += rate;
>> +	/* rate should never overlow or become zero */
> 
> It is bfqd->peak_rate that is used as a divider, and bfqd->peak_rate doesn't risk to be zero even if the variable 'rate' is zero here.
> 
> So I guess the reason why you consider the possibility that bfqd->peak_rate becomes zero is because of an overflow when summing 'rate'. But, according to my calculations, this should be impossible with devices with sensible speeds.
> 
> These are the reasons why I decided I could make it with a 32-bit variable, without any additional clamping. Did I make any mistake in my evaluation?

According to Murphy's law this is inevitable..

I've seen couple division by zero crashes in bfq_wr_duration.
Unfortunately logs weren't recorded.

> 
> Anyway, even if I made some mistake about the maximum possible value of the device rate, and the latter may be too high for bfqd->peak_rate to contain it, then I guess the right solution would not be to clamp the actual rate to U32_MAX, but to move bfqd->peak_rate to 64 bits. Or am I missing something else?
 >>> +	bfqd->peak_rate = clamp_t(u64, rate + bfqd->peak_rate, 1, U32_MAX);

32-bit should be enough and better for division.
My patch makes sure it never overflows/underflows.
That's cheaper than full 64-bit/64-bit division.
Anyway 64-bit speed could overflow too. =)


>> 	update_thr_responsiveness_params(bfqd);
>>
>> reset_computation:
>>
> 
