Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
Date: Wed, 3 Oct 2018 17:55:41 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 Linus Walleij <linus.walleij@linaro.org>,
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
 Mark Brown <broonie@kernel.org>
Message-Id: <6AF8CEDE-2720-4206-900A-1A9B914A8FF0@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 03 ott 2018, alle ore 13:49, Oleksandr Natalenko =
<oleksandr@natalenko.name> ha scritto:
>=20
> Hi.
>=20
> On 03.10.2018 08:29, Paolo Valente wrote:
>> As also Linus Torvalds complained [1], people feel lost among
>> I/O-scheduler options.  Actual differences across I/O schedulers are
>> basically obscure to non experts.  In this respect, Linux-kernel
>> 'users' are way more than a few top-level distros that can afford a
>> strong performance team, and that, basing on the input of such a =
team,
>> might venture light-heartedly to change a critical component like an
>> I/O scheduler.  Plus, as Linus Walleij pointed out, some users simply
>> are not distros that use udev.
>=20
> I feel a contradiction in this counter-argument. On one hand, there =
are lots of, let's call them, home users, that use major distributions =
with udev, so the distribution maintainers can reasonably decide which =
scheduler to use for which type of device based on the udev rule and =
common sense provided via Documentation/ by linux-block devs. Moreover, =
most likely, those rules should be similar or the same across all the =
major distros and available via some (systemd?) upstream.
>=20

Let me basically repeat Mark's answer here, with my words.

Unfortunately, facts mismatch with your optimistic view: after so many
years and concordant test results, only very few distributions
switched to bfq, no major distribution did (AFAIK).  As I already
wrote, the reason is the one pointed out by Torvalds [1].  Do you want
a simple example?  Take the last sentence in Jan's email in this
thread: "I *personally would* consider bfq a safer default ...  but *I
don't feel too strongly* about it." And he is definitely a storage
expert.

The problem, in particular, is that bfq is a complex beast, fighting
against a jungle of I/O issues.  You have to be really into bfq, even
to just know all of its features!

> On another hand, the users of embedded devices, mentioned by Linus, =
should already know what scheduler to choose because dealing with =
embedded world assumes the person can decide this on their own, or with =
the help of abovementioned udev scripts and/or Documentation/ as a =
reference point.
>=20

Same situation for embedded devices, if not even worse.  Again for the
same reasons above.  In the end, it is hard even for a kernel expert
to be an in-depth expert of every possible complex component.

> So I see no obstacles here, and the choice to rely on udev by default =
sounds reasonable.
>=20
> The question that remain is whether it is really important to mount a =
root partition while already using some specific scheduler? Why it =
cannot be done with "none", for instance?
>=20
>> So, probably 99% of Linux-kernel users will just stick to the default
>> I/O scheduler, mq-deadline, assuming that the algorithm by which that
>> scheduler was chosen was not "pick the scheduler with the longest
>> name", but "pick the best scheduler for most cases".  The problem is
>> that, for single-queue devices with a speed below 400/500 KIOPS, the
>> default scheduler is apparently incomparably worse than bfq in terms
>> of responsiveness and latency for time-sensitive applications [2], =
and
>> in terms of throughput reached while controlling I/O [3].  And, in =
all
>> other tests ran so far, by any entity or group I'm aware of, bfq
>> results basically on par with or better than mq-deadline.
>=20
> And that's why major distributions are likely to default to BFQ via =
udev. No one argues with BFQ superiority here =E2=98=BA.
>=20
>> So, I do understand your need for conservativeness, but, after so =
much
>> evidence on single-queue devices, and so many years! :), what's the
>> point in keeping Linux worse for virtually everybody, by default?
>=20
> =46rom my point of view this is not a conservative approach at all. On =
contrary, offloading decisions to userspace aligns pretty well with =
recent trends like pressure metrics/userspace OOM killer, eBPF etc. The =
less unnecessary logic the kernel handles, the more flexibility it =
affords.
>=20

To not answer too seriously here, let me answer with a quote that is
still missing a clear paternity: "Everything should be made as simple
as possible, but not simpler." :)

Thanks,
Paolo

> --=20
>  Oleksandr Natalenko (post-factum)
