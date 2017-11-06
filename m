Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: high overhead of functions blkg_*stats_* in bfq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <CAPDyKFpm_+cii6OVfgpVkww7raURE4bJmpyvWU1c_AKFhTRpZw@mail.gmail.com>
Date: Mon, 6 Nov 2017 12:20:10 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>,
 linux-block <linux-block@vger.kernel.org>,
 Luca Miccio <lucmiccio@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 Akinobu Mita <akinobu.mita@gmail.com>,
 hpa@zytor.com,
 David Howells <dhowells@redhat.com>
Message-Id: <B6718E47-3974-4FBB-8390-183ABB0330F8@linaro.org>
References: <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org> <20171018131918.GB1302522@devbig577.frc2.facebook.com> <76CAD24C-BE7A-4AE0-A207-0FDD0E6506DD@linaro.org> <83aaaeb1-2e04-33ed-193a-7d36024fc9dd@kernel.dk> <CAPDyKFqoNUZtobsg1W=N=oaZ2BtdV-Ax9wjgs539Z83RQi69OQ@mail.gmail.com> <A43A2541-10EB-4914-B033-8D2CE2442477@linaro.org> <CAPDyKFpm_+cii6OVfgpVkww7raURE4bJmpyvWU1c_AKFhTRpZw@mail.gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 06 nov 2017, alle ore 11:48, Ulf Hansson =
<ulf.hansson@linaro.org> ha scritto:
>=20
> On 6 November 2017 at 10:49, Paolo Valente <paolo.valente@linaro.org> =
wrote:
>>=20
>>> Il giorno 06 nov 2017, alle ore 10:22, Ulf Hansson =
<ulf.hansson@linaro.org> ha scritto:
>>>=20
>>> On 6 November 2017 at 03:21, Jens Axboe <axboe@kernel.dk> wrote:
>>>> On 11/05/2017 01:39 AM, Paolo Valente wrote:
>>>>>=20
>>>>>> Il giorno 18 ott 2017, alle ore 15:19, Tejun Heo <tj@kernel.org> =
ha scritto:
>>>>>>=20
>>>>>> Hello, Paolo.
>>>>>>=20
>>>>>> On Tue, Oct 17, 2017 at 12:11:01PM +0200, Paolo Valente wrote:
>>>>>> ...
>>>>>>> protected by a per-device scheduler lock.  To give you an idea, =
on an
>>>>>>> Intel i7-4850HQ, and with 8 threads doing random I/O in parallel =
on
>>>>>>> null_blk (configured with 0 latency), if the update of groups =
stats is
>>>>>>> removed, then the throughput grows from 260 to 404 KIOPS.  This =
and
>>>>>>> all the other results we might share in this thread can be =
reproduced
>>>>>>> very easily with a (useful) script made by Luca Miccio [1].
>>>>>>=20
>>>>>> I don't think the old request_queue is ever built for multiple =
CPUs
>>>>>> hitting on a mem-backed device.
>>>>>>=20
>>>>>=20
>>>>> Hi,
>>>>> from our measurements, the code and the comments received so far =
in
>>>>> this thread, I guess that reducing the execution time of =
blkg_*stats_*
>>>>> functions is not an easy task, and is unlikely to be accomplished =
in
>>>>> the short term.  In this respect, we have unfortunately found out =
that
>>>>> executing these functions causes a very high reduction of the
>>>>> sustainable throughput on some CPUs.  For example, -70% on an ARM
>>>>> CortexTM-A53 Octa-core.
>>>>>=20
>>>>> Thus, to deal with such a considerable slowdown, until the =
overhead of
>>>>> these functions gets reduced, it may make more sense to switch the
>>>>> update of these statistics off, in all cases where these =
statistics
>>>>> are not used, while higher performance (or lower power =
consumption) is
>>>>> welcome/needed.
>>>>>=20
>>>>> We wondered, however, how hazardous it might be to switch the =
update
>>>>> of these statistics off.  To answer this question, we investigated =
the
>>>>> extent at which these statistics are used by applications and
>>>>> services.  Mainly, we tried to survey relevant people or
>>>>> forums/mailing lists for involved communities: Linux =
distributions,
>>>>> systemd, containers and other minor communities.  Nobody reported =
any
>>>>> application or service using these statistics (either the variant
>>>>> updated by bfq, or that updated by cfq).
>>>>>=20
>>>>> So, one of the patches we are working on gives the user the
>>>>> possibility to disable the update of these statistics online.
>>>>=20
>>>> If you want help with this, provide an easy way to reproduce this,
>>>> and/or some decent profiling output. There was one flamegraph =
posted,
>>>> but that was basically useless. Just do:
>>>>=20
>>>> perf record -g -- whatever test
>>>> perf report -g --no-children
>>>>=20
>>>> and post the top 10 entries from the perf report.
>>>>=20
>>>> It's pointless to give up on this so soon, when no effort has =
apparently
>>>> been dedicated to figuring out what the actual issue is yet. So no, =
no
>>>> patch that will just disable the stats is going to be accepted.
>>>>=20
>>>> That said, I have no idea who uses these stats. Surely someone can
>>>> answer that question. Tejun?
>>>=20
>>> Jens, Tejun, apologize for side-tracking the discussion.
>>>=20
>>> It sounds to me that these stats should have been put into debugfs,
>>> rather than sysfs from the beginning.
>>>=20
>>=20
>> Ulf,
>> let me just add a bit of info, if useful: four of those stat files =
are
>> explicitly meant for debugging (as per the documentation), and =
created
>> if CONFIG_DEBUG_BLK_CGROUP=3Dy.
>>=20
>> Paolo
>=20
> Right, so it's a mixture of debugfs/sysfs then.
>=20
> In the BFQ case, it seems like CONFIG_DEBUG_BLK_CGROUP isn't checked.
> I assume that should be changed,

Yes, it's in the patch series that we would like to propose.

> which would remove at least some of
> the computation overhead when when this Kconfig is unset.
>=20

Yes. My concern is the following.

If, as our one-month survey apparently confirms, there is no code
using these bfq stats, in particular the DEBUG_BLK_CGROUP ones,
then it sounds unfair to make a bfq user suffer from up to 70% loss
of sustainable throughput, just because, for reasons that the
user may even ignore, the 'wrong' options are set for his/her system =
(for
example, because DEBUG_BLK_CGROUP stats happen or happened to be used
for cfq in that system, and in legacy blk one can't even tell the
difference between switching on or off the update of those stats).

Of course, this is just a point of view, and hold only until those
update functions get possibly optimized.

Thanks,
Paolo

> Perhaps one may even consider moving all stats for BFQ within that
> Kconfig (and for other mq-schedulers if those ever intends to
> implement support for the stats).
>=20
> Kind regards
> Uffe
