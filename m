Return-Path: <oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 03 Oct 2018 13:49:25 +0200
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Linus Walleij <linus.walleij@linaro.org>,
 linux-block <linux-block@vger.kernel.org>, linux-mmc
 <linux-mmc@vger.kernel.org>, linux-mtd@lists.infradead.org, Pavel Machek
 <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger
 <richard@nod.at>, Artem Bityutskiy <dedekind1@gmail.com>, Adrian Hunter
 <adrian.hunter@intel.com>, Jan Kara <jack@suse.cz>, Andreas Herrmann
 <aherrmann@suse.com>, Mel Gorman <mgorman@suse.com>, Chunyan Zhang
 <zhang.chunyan@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>, Mark Brown
 <broonie@kernel.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
In-Reply-To: <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
Message-ID: <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
List-ID: <linux-block@vger.kernel.org>

Hi.

On 03.10.2018 08:29, Paolo Valente wrote:
> As also Linus Torvalds complained [1], people feel lost among
> I/O-scheduler options.  Actual differences across I/O schedulers are
> basically obscure to non experts.  In this respect, Linux-kernel
> 'users' are way more than a few top-level distros that can afford a
> strong performance team, and that, basing on the input of such a team,
> might venture light-heartedly to change a critical component like an
> I/O scheduler.  Plus, as Linus Walleij pointed out, some users simply
> are not distros that use udev.

I feel a contradiction in this counter-argument. On one hand, there are 
lots of, let's call them, home users, that use major distributions with 
udev, so the distribution maintainers can reasonably decide which 
scheduler to use for which type of device based on the udev rule and 
common sense provided via Documentation/ by linux-block devs. Moreover, 
most likely, those rules should be similar or the same across all the 
major distros and available via some (systemd?) upstream.

On another hand, the users of embedded devices, mentioned by Linus, 
should already know what scheduler to choose because dealing with 
embedded world assumes the person can decide this on their own, or with 
the help of abovementioned udev scripts and/or Documentation/ as a 
reference point.

So I see no obstacles here, and the choice to rely on udev by default 
sounds reasonable.

The question that remain is whether it is really important to mount a 
root partition while already using some specific scheduler? Why it 
cannot be done with "none", for instance?

> So, probably 99% of Linux-kernel users will just stick to the default
> I/O scheduler, mq-deadline, assuming that the algorithm by which that
> scheduler was chosen was not "pick the scheduler with the longest
> name", but "pick the best scheduler for most cases".  The problem is
> that, for single-queue devices with a speed below 400/500 KIOPS, the
> default scheduler is apparently incomparably worse than bfq in terms
> of responsiveness and latency for time-sensitive applications [2], and
> in terms of throughput reached while controlling I/O [3].  And, in all
> other tests ran so far, by any entity or group I'm aware of, bfq
> results basically on par with or better than mq-deadline.

And that's why major distributions are likely to default to BFQ via 
udev. No one argues with BFQ superiority here ☺.

> So, I do understand your need for conservativeness, but, after so much
> evidence on single-queue devices, and so many years! :), what's the
> point in keeping Linux worse for virtually everybody, by default?

 From my point of view this is not a conservative approach at all. On 
contrary, offloading decisions to userspace aligns pretty well with 
recent trends like pressure metrics/userspace OOM killer, eBPF etc. The 
less unnecessary logic the kernel handles, the more flexibility it 
affords.

-- 
   Oleksandr Natalenko (post-factum)
