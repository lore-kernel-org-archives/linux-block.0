Return-Path: <jack@suse.cz>
Date: Thu, 4 Oct 2018 09:38:09 +0200
From: Jan Kara <jack@suse.cz>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
	Jens Axboe <axboe@kernel.dk>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-mmc <linux-mmc@vger.kernel.org>,
	linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Richard Weinberger <richard@nod.at>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Jan Kara <jack@suse.cz>,
	Andreas Herrmann <aherrmann@suse.com>,
	Mel Gorman <mgorman@suse.com>,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
Message-ID: <20181004073809.GD29482@quack2.suse.cz>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
 <6AF8CEDE-2720-4206-900A-1A9B914A8FF0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6AF8CEDE-2720-4206-900A-1A9B914A8FF0@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Wed 03-10-18 17:55:41, Paolo Valente wrote:
> > On 03.10.2018 08:29, Paolo Valente wrote:
> >> As also Linus Torvalds complained [1], people feel lost among
> >> I/O-scheduler options.  Actual differences across I/O schedulers are
> >> basically obscure to non experts.  In this respect, Linux-kernel
> >> 'users' are way more than a few top-level distros that can afford a
> >> strong performance team, and that, basing on the input of such a team,
> >> might venture light-heartedly to change a critical component like an
> >> I/O scheduler.  Plus, as Linus Walleij pointed out, some users simply
> >> are not distros that use udev.
> > 
> > I feel a contradiction in this counter-argument. On one hand, there are lots of, let's call them, home users, that use major distributions with udev, so the distribution maintainers can reasonably decide which scheduler to use for which type of device based on the udev rule and common sense provided via Documentation/ by linux-block devs. Moreover, most likely, those rules should be similar or the same across all the major distros and available via some (systemd?) upstream.
> > 
> 
> Let me basically repeat Mark's answer here, with my words.
> 
> Unfortunately, facts mismatch with your optimistic view: after so many
> years and concordant test results, only very few distributions
> switched to bfq, no major distribution did (AFAIK).  As I already
> wrote, the reason is the one pointed out by Torvalds [1].  Do you want
> a simple example?  Take the last sentence in Jan's email in this
> thread: "I *personally would* consider bfq a safer default ...  but *I
> don't feel too strongly* about it." And he is definitely a storage
> expert.

Yeah, but let me add that currently all our released kernels still use legacy
block stack for SCSI by default and thus CFQ/deadline. And once we feel
scsi-mq + BFQ is comparable enough for rotating disks (which may be after
your latest changes, Andreas will be running some larger evaluation), we
are going to switch to that instead of scsi + CFQ. So it's not like for us
it is a question between deadline-mq and BFQ, it is rather between scsi +
CFQ vs scsi-mq + BFQ.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
