Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: testing io.low limit for blk-throttle
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <4c6b86d9-1668-43c3-c159-e6e23ffb04b4@gmail.com>
Date: Mon, 23 Apr 2018 09:35:04 +0200
Cc: linux-block <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 Shaohua Li <shli@fb.com>,
 Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Message-Id: <A0424504-2778-41F4-B1C6-BE1B0253E524@linaro.org>
References: <A749046B-BEB9-4278-ABEF-3007817D59DD@linaro.org>
 <4c6b86d9-1668-43c3-c159-e6e23ffb04b4@gmail.com>
To: Joseph Qi <jiangqi903@gmail.com>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 23 apr 2018, alle ore 08:05, Joseph Qi =
<jiangqi903@gmail.com> ha scritto:
>=20
> Hi Paolo,

Hi Joseph,
thanks for chiming in.

> What's your idle and latency config?

I didn't set them at all, as the only (explicit) requirement in my
basic test is that one of the group is guaranteed a minimum bps.


> IMO, io.low will allow others run more bandwidth if cgroup's average
> idle time is high or latency is low.

What you say here makes me think that I simply misunderstood the
purpose of io.low.  So, here is my problem/question: "I only need to
guarantee at least a minimum bandwidth, in bps, to a group.  Is the
io.low limit the way to go?"

I know that I can use just io.max (unless I misunderstood the goal of
io.max too :( ), but my extra purpose would be to not waste bandwidth
when some group is idle.  Yet, as for now, io.low is not working even
for the first, simpler goal, i.e., guaranteeing a minimum bandwidth to
one group when all groups are active.

Am I getting something wrong?

Otherwise, if there are some special values for idle and latency
parameters that would make throttle work for my test, I'll be of
course happy to try them.

Thanks,
Paolo

> In such cases, low limit won't get
> guaranteed.
>=20
> Thanks,
> Joseph
>=20
> On 18/4/22 17:23, Paolo Valente wrote:
>> Hi Shaohua, all,
>> at last, I started testing your io.low limit for blk-throttle.  One =
of
>> the things I'm interested in is how good throttling is in achieving a
>> high throughput in the presence of realistic, variable workloads.
>>=20
>> However, I seem to have bumped into a totally different problem.  The
>> io.low parameter doesn't seem to guarantee what I understand it is =
meant
>> to guarantee: minimum per-group bandwidths.  For example, with
>> - one group, the interfered, containing one process that does =
sequential
>>  reads with fio
>> - io.low set to 100MB/s for the interfered
>> - six other groups, the interferers, with each interferer containing =
one
>>  process doing sequential read with fio
>> - io.low set to 10MB/s for each interferer
>> - the workload executed on an SSD, with a 500MB/s of overall =
throughput
>> the interfered gets only 75MB/s.
>>=20
>> In particular, the throughput of the interfered becomes lower and
>> lower as the number of interferers is increased.  So you can make it
>> become even much lower than the 75MB/s in the example above.  There
>> seems to be no control on bandwidth.
>>=20
>> Am I doing something wrong?  Or did I simply misunderstand the goal =
of
>> io.low, and the only parameter for guaranteeing the desired bandwidth =
to
>> a group is io.max (to be used indirectly, by limiting the bandwidth =
of
>> the interferers)?
>>=20
>> If useful for you, you can reproduce the above test very quickly, by
>> using the S suite [1] and typing:
>>=20
>> cd thr-lat-with-interference
>> sudo ./thr-lat-with-interference.sh -b t -w 100000000 -W "10000000 =
10000000 10000000 10000000 10000000 10000000" -n 6 -T "read read read =
read read read" -R "0 0 0 0 0 0"
>>=20
>> Looking forward to your feedback,
>> Paolo
>>=20
>> [1]=20
>>=20
