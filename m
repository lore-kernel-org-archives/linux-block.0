Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: testing io.low limit for blk-throttle
To: Tejun Heo <tj@kernel.org>, Joseph Qi <jiangqi903@gmail.com>
Cc: Paolo Valente <paolo.valente@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <A749046B-BEB9-4278-ABEF-3007817D59DD@linaro.org>
 <4c6b86d9-1668-43c3-c159-e6e23ffb04b4@gmail.com>
 <A0424504-2778-41F4-B1C6-BE1B0253E524@linaro.org>
 <18accc1e-c7b3-86a7-091b-1d4b631fcd4a@gmail.com>
 <536A1B1D-575F-4193-ADA6-BA832AEC7179@linaro.org>
 <20180426183200.GK1911913@devbig577.frc2.facebook.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <9aee3b22-2600-b16b-d944-f3a09089664f@oracle.com>
Date: Fri, 27 Apr 2018 10:09:55 +0800
MIME-Version: 1.0
In-Reply-To: <20180426183200.GK1911913@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Tejun and Joseph

On 04/27/2018 02:32 AM, Tejun Heo wrote:
> Hello,
> 
> On Tue, Apr 24, 2018 at 02:12:51PM +0200, Paolo Valente wrote:
>> +Tejun (I guess he might be interested in the results below)
> 
> Our experiments didn't work out too well either.  At this point, it
> isn't clear whether io.low will ever leave experimental state.  We're
> trying to find a working solution.

Would you please take a look at the following two patches.

https://marc.info/?l=linux-block&m=152325456307423&w=2
https://marc.info/?l=linux-block&m=152325457607425&w=2

In addition, when I tested blk-throtl io.low on NVMe card, I always got
even if the iops has been lower than io.low limit for a while, but the
due to group is not idle, the downgrade always fails.

       tg->latency_target && tg->bio_cnt &&
		tg->bad_bio_cnt * 5 < tg->bio_cn

the latency always looks well even the sum of two groups's iops has reached the top.
so I disable this check on my test, plus the 2 patches above, the io.low
could basically works.

My NVMe card's max bps is ~600M, and max iops is ~160k.
Here is my config
io.low riops=50000 wiops=50000 rbps=209715200 wbps=209715200 idle=200 latency=10
io.max riops=150000
There are two cgroups in my test, both of them have same config.

In addition, saying "basically work" is due to the iops of the two cgroup will jump up and down.
such as, I launched one fio test per cgroup, the iops will wave as following:

group0   30k  50k   70k   60k  40k
group1   120k 100k  80k   90k  110k

however, if I launched two fio tests only in one cgroup, the iops of two test could stay 
about 70k~80k.

Could help to explain this scenario ?

Thanks in advance
Jianchao
