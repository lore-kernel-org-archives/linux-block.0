Return-Path: <axboe@kernel.dk>
Subject: Re: high overhead of functions blkg_*stats_* in bfq
To: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>,
 Luca Miccio <lucmiccio@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>
References: <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org>
 <20171018131918.GB1302522@devbig577.frc2.facebook.com>
 <76CAD24C-BE7A-4AE0-A207-0FDD0E6506DD@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <83aaaeb1-2e04-33ed-193a-7d36024fc9dd@kernel.dk>
Date: Sun, 5 Nov 2017 19:21:01 -0700
MIME-Version: 1.0
In-Reply-To: <76CAD24C-BE7A-4AE0-A207-0FDD0E6506DD@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/05/2017 01:39 AM, Paolo Valente wrote:
> 
>> Il giorno 18 ott 2017, alle ore 15:19, Tejun Heo <tj@kernel.org> ha scritto:
>>
>> Hello, Paolo.
>>
>> On Tue, Oct 17, 2017 at 12:11:01PM +0200, Paolo Valente wrote:
>> ...
>>> protected by a per-device scheduler lock.  To give you an idea, on an
>>> Intel i7-4850HQ, and with 8 threads doing random I/O in parallel on
>>> null_blk (configured with 0 latency), if the update of groups stats is
>>> removed, then the throughput grows from 260 to 404 KIOPS.  This and
>>> all the other results we might share in this thread can be reproduced
>>> very easily with a (useful) script made by Luca Miccio [1].
>>
>> I don't think the old request_queue is ever built for multiple CPUs
>> hitting on a mem-backed device.
>>
> 
> Hi,
> from our measurements, the code and the comments received so far in
> this thread, I guess that reducing the execution time of blkg_*stats_*
> functions is not an easy task, and is unlikely to be accomplished in
> the short term.  In this respect, we have unfortunately found out that
> executing these functions causes a very high reduction of the
> sustainable throughput on some CPUs.  For example, -70% on an ARM
> CortexTM-A53 Octa-core.
> 
> Thus, to deal with such a considerable slowdown, until the overhead of
> these functions gets reduced, it may make more sense to switch the
> update of these statistics off, in all cases where these statistics
> are not used, while higher performance (or lower power consumption) is
> welcome/needed.
> 
> We wondered, however, how hazardous it might be to switch the update
> of these statistics off.  To answer this question, we investigated the
> extent at which these statistics are used by applications and
> services.  Mainly, we tried to survey relevant people or
> forums/mailing lists for involved communities: Linux distributions,
> systemd, containers and other minor communities.  Nobody reported any
> application or service using these statistics (either the variant
> updated by bfq, or that updated by cfq).
> 
> So, one of the patches we are working on gives the user the
> possibility to disable the update of these statistics online.

If you want help with this, provide an easy way to reproduce this,
and/or some decent profiling output. There was one flamegraph posted,
but that was basically useless. Just do:

perf record -g -- whatever test
perf report -g --no-children

and post the top 10 entries from the perf report.

It's pointless to give up on this so soon, when no effort has apparently
been dedicated to figuring out what the actual issue is yet. So no, no
patch that will just disable the stats is going to be accepted.

That said, I have no idea who uses these stats. Surely someone can
answer that question. Tejun?

-- 
Jens Axboe
