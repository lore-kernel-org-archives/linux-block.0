Return-Path: <jiangqi903@gmail.com>
Return-Path: <jiangqi903@gmail.com>
Subject: Re: testing io.low limit for blk-throttle
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Shaohua Li <shli@fb.com>, Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <A749046B-BEB9-4278-ABEF-3007817D59DD@linaro.org>
 <4c6b86d9-1668-43c3-c159-e6e23ffb04b4@gmail.com>
 <A0424504-2778-41F4-B1C6-BE1B0253E524@linaro.org>
From: Joseph Qi <jiangqi903@gmail.com>
Message-ID: <18accc1e-c7b3-86a7-091b-1d4b631fcd4a@gmail.com>
Date: Mon, 23 Apr 2018 17:01:42 +0800
MIME-Version: 1.0
In-Reply-To: <A0424504-2778-41F4-B1C6-BE1B0253E524@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 18/4/23 15:35, Paolo Valente wrote:
> 
> 
>> Il giorno 23 apr 2018, alle ore 08:05, Joseph Qi <jiangqi903@gmail.com> ha scritto:
>>
>> Hi Paolo,
> 
> Hi Joseph,
> thanks for chiming in.
> 
>> What's your idle and latency config?
> 
> I didn't set them at all, as the only (explicit) requirement in my
> basic test is that one of the group is guaranteed a minimum bps.
> 
> 
>> IMO, io.low will allow others run more bandwidth if cgroup's average
>> idle time is high or latency is low.
> 
> What you say here makes me think that I simply misunderstood the
> purpose of io.low.  So, here is my problem/question: "I only need to
> guarantee at least a minimum bandwidth, in bps, to a group.  Is the
> io.low limit the way to go?"
> 
> I know that I can use just io.max (unless I misunderstood the goal of
> io.max too :( ), but my extra purpose would be to not waste bandwidth
> when some group is idle.  Yet, as for now, io.low is not working even
> for the first, simpler goal, i.e., guaranteeing a minimum bandwidth to
> one group when all groups are active.
> 
> Am I getting something wrong?
> 
> Otherwise, if there are some special values for idle and latency
> parameters that would make throttle work for my test, I'll be of
> course happy to try them.
> 
I think you can try idle time with 1000us for all cgroups, and latency
target 100us for cgroup with low limit 100MB/s and 2000us for cgroups
with low limit 10MB/s. That means cgroup with low latency target will
be preferred.
BTW, from my expeierence the parameters are not easy to set because
they are strongly correlated to the cgroup IO behavior.

Thanks,
Joseph
