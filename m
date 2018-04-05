Return-Path: <axboe@kernel.dk>
Subject: Re: 4.15.15: BFQ stalled at blk_mq_get_tag
To: Paolo Valente <paolo.valente@linaro.org>,
 Sami Farin <hvtaifwkbgefbaei@gmail.com>
Cc: linux-block <linux-block@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>
References: <20180405131515.3zzav2x7kp5z7uax@m.mifar.in>
 <AC25D412-BFFD-4011-8EC7-A701EF52153A@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <aa5bf074-d976-9b81-f47b-530ad8303808@kernel.dk>
Date: Thu, 5 Apr 2018 08:56:26 -0600
MIME-Version: 1.0
In-Reply-To: <AC25D412-BFFD-4011-8EC7-A701EF52153A@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/5/18 8:45 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 05 apr 2018, alle ore 15:15, Sami Farin <hvtaifwkbgefbaei@gmail.com> ha scritto:
>>
>> I was using chacharand to fill 32 GB SD card (VFAT fs) (maybe 30 MiB/s)
>> with random data, it froze halfway.  There was 400 MiB Dirty data.
>> After reboot the filling operation went OK when I used kyber scheduler.
>> System is Fedora 27 on Core i5 2500K / 16 GiB.
>>
> 
> I'm afraid this crash is caused by a bug fixed for 4.16 [1].  In the
> same thread [1], Oleksander (in CC) proposed to backport this and
> other fixes and improvements to 4.15.  But Jens (in CC) didn't accept,
> because too general stuff was included in the batch.  Maybe this bug
> report could be the opportunity to reconsider that backport or part of
> it?

I never objected to back porting the single fix. What I did object
to was a huge list of other fixes. I'm also fine with back porting
a set of fixes, if they are all relevant to back port. I don't
want a whole sale list of "these are all the changes we did to BFQ,
let's back port them".

-- 
Jens Axboe
