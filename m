Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
Date: Wed, 3 Oct 2018 08:29:10 +0200
Cc: Linus Walleij <linus.walleij@linaro.org>,
 linux-block <linux-block@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 linux-mtd@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Jan Kara <jack@suse.cz>,
 Andreas Herrmann <aherrmann@suse.com>,
 Mel Gorman <mgorman@suse.com>,
 Chunyan Zhang <zhang.chunyan@linaro.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Mark Brown <broonie@kernel.org>
Message-Id: <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 02 ott 2018, alle ore 16:31, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 10/2/18 6:43 AM, Linus Walleij wrote:
>> This sets BFQ as the default scheduler for single queue
>> block devices (nr_hw_queues =3D=3D 1) if it is available. This
>> affects notably MMC/SD-cards but notably also UBI and
>> the loopback device.
>>=20
>> I have been running it for a while without any negative
>> effects on my pet systems and I want some wider testing
>> so let's throw it out there and see what people say.
>> Admittedly my use cases are limited.
>>=20
>> I talked to Pavel a bit back and it turns out he has a
>> usecase for BFQ as well and I bet he also would like it
>> as default scheduler for that system (Pavel tell us more,
>> I don't remember what it was!)
>>=20
>> Intuitively I could understand that maybe we want to
>> leave the loop device (possibly others? nbd? rbd?) as
>> "none", as it is probably relying on a scheduler on the
>> device below it, so I'm open to passing in a scheduler hint
>> from the respective subsystem in say struct blk_mq_tag_set.
>> However that makes for a bit of syntactic dissonance
>> with the struct member ".nr_hw_queues" (I wonder how
>> the loop device can have 1 "hardware queue"?) so
>> maybe we should in that case also rename that struct
>> member to ".nr_queues" fair and square before we start
>> making adjustments for treating queues differently whether
>> they are in hardware or actually not.
>=20
> I think this should just be done with udev rules, and I'd
> prefer if the distros would lead the way on this, as they
> are the ones that will most likely see the most bug reports
> on a change like this.
>=20

Hi Jens,
I see your point, but I doubt this is the way to go, because of the
following flaws.

As also Linus Torvalds complained [1], people feel lost among
I/O-scheduler options.  Actual differences across I/O schedulers are
basically obscure to non experts.  In this respect, Linux-kernel
'users' are way more than a few top-level distros that can afford a
strong performance team, and that, basing on the input of such a team,
might venture light-heartedly to change a critical component like an
I/O scheduler.  Plus, as Linus Walleij pointed out, some users simply
are not distros that use udev.

So, probably 99% of Linux-kernel users will just stick to the default
I/O scheduler, mq-deadline, assuming that the algorithm by which that
scheduler was chosen was not "pick the scheduler with the longest
name", but "pick the best scheduler for most cases".  The problem is
that, for single-queue devices with a speed below 400/500 KIOPS, the
default scheduler is apparently incomparably worse than bfq in terms
of responsiveness and latency for time-sensitive applications [2], and
in terms of throughput reached while controlling I/O [3].  And, in all
other tests ran so far, by any entity or group I'm aware of, bfq
results basically on par with or better than mq-deadline.

So, I do understand your need for conservativeness, but, after so much
evidence on single-queue devices, and so many years! :), what's the
point in keeping Linux worse for virtually everybody, by default?

Thanks,
Paolo

[1] https://lkml.org/lkml/2017/2/21/791
[2] http://algo.ing.unimo.it/people/paolo/disk_sched/results.php
[3] https://lwn.net/Articles/763603/



> --=20
> Jens Axboe
