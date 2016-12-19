Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCHSET v4] blk-mq-scheduling framework
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <dd9501e9-5fc2-66d3-5c62-f8b727a6b6c9@fb.com>
Date: Mon, 19 Dec 2016 19:21:10 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Omar Sandoval <osandov@fb.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>
Message-Id: <CF1D593B-8BD0-4B59-9193-9D1D4E8BE3E4@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com> <7A8A5078-E9B8-4EBF-BAB1-9E8EEBF3A043@linaro.org> <dd9501e9-5fc2-66d3-5c62-f8b727a6b6c9@fb.com>
To: Jens Axboe <axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 19 dic 2016, alle ore 16:20, Jens Axboe <axboe@fb.com> ha =
scritto:
>=20
> On 12/19/2016 04:32 AM, Paolo Valente wrote:
>>=20
>>> Il giorno 17 dic 2016, alle ore 01:12, Jens Axboe <axboe@fb.com> ha =
scritto:
>>>=20
>>> This is version 4 of this patchset, version 3 was posted here:
>>>=20
>>> https://marc.info/?l=3Dlinux-block&m=3D148178513407631&w=3D2
>>>=20
>>> =46rom the discussion last time, I looked into the feasibility of =
having
>>> two sets of tags for the same request pool, to avoid having to copy
>>> some of the request fields at dispatch and completion time. To do =
that,
>>> we'd have to replace the driver tag map(s) with our own, and augment
>>> that with tag map(s) on the side representing the device queue =
depth.
>>> Queuing IO with the scheduler would allocate from the new map, and
>>> dispatching would acquire the "real" tag. We would need to change
>>> drivers to do this, or add an extra indirection table to map a real
>>> tag to the scheduler tag. We would also need a 1:1 mapping between
>>> scheduler and hardware tag pools, or additional info to track it.
>>> Unless someone can convince me otherwise, I think the current =
approach
>>> is cleaner.
>>>=20
>>> I wasn't going to post v4 so soon, but I discovered a bug that led
>>> to drastically decreased merging. Especially on rotating storage,
>>> this release should be fast, and on par with the merging that we
>>> get through the legacy schedulers.
>>>=20
>>=20
>> I'm to modifying bfq.  You mentioned other missing pieces to come.  =
Do
>> you already have an idea of what they are, so that I am somehow
>> prepared to what won't work even if my changes are right?
>=20
> I'm mostly talking about elevator ops hooks that aren't there in the =
new
> framework, but exist in the old one. There should be no hidden
> surprises, if that's what you are worried about.
>=20
> On the ops side, the only ones I can think of are the activate and
> deactivate, and those can be done in the dispatch_request hook for
> activate, and put/requeue for deactivate.
>=20

You mean that there is no conceptual problem in moving the code of the
activate interface function into the dispatch function, and the code
of the deactivate into the put_request? (for a requeue it is a little
less clear to me, so one step at a time)  Or am I missing
something more complex?

> Outside of that, some of them have been renamed, and some have been
> collapsed (like activate/deactivate), and yet others again work a =
little
> differently (like merging). See the mq-deadline conversion, and just
> work through them one at the time.
>=20

That's how I'm proceeding, thanks.

Thank you,
Paolo

> --=20
> Jens Axboe
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
