Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: testing io.low limit for blk-throttle
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <18accc1e-c7b3-86a7-091b-1d4b631fcd4a@gmail.com>
Date: Tue, 24 Apr 2018 14:12:51 +0200
Cc: linux-block <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 Shaohua Li <shli@fb.com>,
 Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Tejun Heo <tj@kernel.org>
Message-Id: <536A1B1D-575F-4193-ADA6-BA832AEC7179@linaro.org>
References: <A749046B-BEB9-4278-ABEF-3007817D59DD@linaro.org>
 <4c6b86d9-1668-43c3-c159-e6e23ffb04b4@gmail.com>
 <A0424504-2778-41F4-B1C6-BE1B0253E524@linaro.org>
 <18accc1e-c7b3-86a7-091b-1d4b631fcd4a@gmail.com>
To: Joseph Qi <jiangqi903@gmail.com>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 23 apr 2018, alle ore 11:01, Joseph Qi =
<jiangqi903@gmail.com> ha scritto:
>=20
>=20
>=20
> On 18/4/23 15:35, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 23 apr 2018, alle ore 08:05, Joseph Qi =
<jiangqi903@gmail.com> ha scritto:
>>>=20
>>> Hi Paolo,
>>=20
>> Hi Joseph,
>> thanks for chiming in.
>>=20
>>> What's your idle and latency config?
>>=20
>> I didn't set them at all, as the only (explicit) requirement in my
>> basic test is that one of the group is guaranteed a minimum bps.
>>=20
>>=20
>>> IMO, io.low will allow others run more bandwidth if cgroup's average
>>> idle time is high or latency is low.
>>=20
>> What you say here makes me think that I simply misunderstood the
>> purpose of io.low.  So, here is my problem/question: "I only need to
>> guarantee at least a minimum bandwidth, in bps, to a group.  Is the
>> io.low limit the way to go?"
>>=20
>> I know that I can use just io.max (unless I misunderstood the goal of
>> io.max too :( ), but my extra purpose would be to not waste bandwidth
>> when some group is idle.  Yet, as for now, io.low is not working even
>> for the first, simpler goal, i.e., guaranteeing a minimum bandwidth =
to
>> one group when all groups are active.
>>=20
>> Am I getting something wrong?
>>=20
>> Otherwise, if there are some special values for idle and latency
>> parameters that would make throttle work for my test, I'll be of
>> course happy to try them.
>>=20
> I think you can try idle time with 1000us for all cgroups, and latency
> target 100us for cgroup with low limit 100MB/s and 2000us for cgroups
> with low limit 10MB/s. That means cgroup with low latency target will
> be preferred.
> BTW, from my expeierence the parameters are not easy to set because
> they are strongly correlated to the cgroup IO behavior.
>=20

+Tejun (I guess he might be interested in the results below)

Hi Joseph,
thanks for chiming in. Your suggestion did work!

At first, I thought I had also understood the use of latency from the
outcome of your suggestion: "want low limit really guaranteed for a
group?  set target latency to a low value for it." But then, as a
crosscheck, I repeated the same exact test, but reversing target
latencies: I gave 2000 to the interfered (the group with 100MB/s
limit) and 100 to the interferers.  And the interfered still got more
than 100MB/s!  So I exaggerated: 20000 to the interfered.
Same outcome :(

I tried really many other combinations, to try to figure this out, but
results seemed more or less random w.r.t. to latency values.  I
didn't even start to test different values for idle.

So, the only sound lesson that I seem to have learned is: if I want
low limits to be enforced, I have to set target latency and idle
explicitly.  The actual values of latencies matter little, or not at
all. At least this holds for my simple tests.

At any rate, thanks to your help, Joseph, I could move to the most
interesting part for me: how effective is blk-throttle with low
limits?  I could well be wrong again, but my results do not seem that
good.  With the simplest type of non-toy example I considered, I
recorded throughput losses, apparently caused mainly by blk-throttle,
and ranging from 64% to 75%.

Here is a worst-case example.  For each step, I'm reporting below the
command by which you can reproduce that step with the
thr-lat-with-interference benchmark of the S suite [1].  I just split
bandwidth equally among five groups, on my SSD.  The device showed a
peak rate of ~515MB/s in this test, so I set rpbs to 100MB/s for each
group (and tried various values, and combinations of values, for the
target latency, without any effect on the results).  To begin, I made
every group do sequential reads.  Everything worked perfectly fine.

But then I made one group do random I/O [2], and troubles began.  Even
if the group doing random I/O was given a target latency of 100usec
(or lower), while the other had a target latency of 2000usec, the poor
random-I/O group got only 4.7 MB/s!  (A single process doing 4k sync
random I/O reaches 25MB/s on my SSD.)

I guess things broke because low limits did not comply any longer with
the lower speed that device reached with the new, mixed workload: the
device reached 376MB/s, while the sum of the low limits was 500MB/s.
BTW the 'fault' for this loss of throughput was not only of the device
and the workload: if I switched throttling off, then the device still
reached its peak rate, although granting only 1.3MB/s to the
random-I/O group.

So, to comply with the 376MB/s, I lowered the low limits to 74MB/s per
group (to avoid a too tight 75MB/s) [3].  A little better: the
random-I/O group got 7.2 MB/s.  But the total throughput went down
further, to 289MB/s, and became again lower than the sum of the low
limits.  Most certainly, this time the throughput went down mainly
because blk-throttling was serving the random I/O more than before.

To make a long story short, I arrived to setting just 12MB/s as low
limit for each group [4].  The random-I/O group was finally happy,
with a revitalizing 12.77MB/s.  But the total throughput dropped down
to 127MB/s, i.e., ~25% of the peak rate of the device.  Now the
'fault' for the throughput loss seemed undoubtedly of blk-throttle.
The latter was evidently over-throttling some group.

To sum up, for my device, 12MB/s seems to be the highest value for
which low limits can be guaranteed.  But setting these limits entails
a high cost: if just one group really does random I/O, then 75% of the
throughput is lost.

There would be other issues too.  For example, 12MB/s might be too
little for the needs of some group in some time period.  This fact would
make it extremely difficult, if ever possible, to set low limits that
comply with the needs of more dynamic (and probably more
realistic) workloads than the above one.

I think this is all, sorry for the long mail, I tried to shrink it as
much as possible.  Looking forward to some feedback.

Thanks,
Paolo

[1] https://github.com/Algodev-github/S
[2] sudo ./thr-lat-with-interference.sh -b t -n 4 -w 100M -W 100M -t =
randread -L 2000
[3] sudo ./thr-lat-with-interference.sh -b t -n 4 -w 74M -W 74M -t =
randread -L 2000
[4] sudo ./thr-lat-with-interference.sh -b t -n 4 -w 12M -W 12M -t =
randread -L 2000
