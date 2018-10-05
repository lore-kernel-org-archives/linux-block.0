Return-Path: <jack@suse.cz>
Date: Fri, 5 Oct 2018 11:16:26 +0200
From: Jan Kara <jack@suse.cz>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Paolo Valente <paolo.valente@linaro.org>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@kernel.dk>,
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
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
Message-ID: <20181005091626.GA9686@quack2.suse.cz>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538582091.205649.20.camel@acm.org>
 <20181004202553.71c2599c@alans-desktop>
 <1538683746.230807.9.camel@acm.org>
 <A017CAC7-41E6-4BB3-AC31-5EB524276138@linaro.org>
 <1538692972.8223.7.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1538692972.8223.7.camel@acm.org>
List-ID: <linux-block@vger.kernel.org>

On Thu 04-10-18 15:42:52, Bart Van Assche wrote:
> On Thu, 2018-10-04 at 22:39 +0200, Paolo Valente wrote:
> > No, kernel build is, for evident reasons, one of the workloads I cared
> > most about.  Actually, I tried to focus on all my main
> > kernel-development tasks, such as also git checkout, git merge, git
> > grep, ...
> > 
> > According to my test results, with BFQ these tasks are at least as
> > fast as, or, in most system configurations, much faster than with the
> > other schedulers.  Of course, at the same time the system also remains
> > responsive with BFQ.
> > 
> > You can repeat these tests using one of my first scripts in the S
> > suite: kern_dev_tasks_vs_rw.sh (usually, the older the tests, the more
> > hypertrophied the names I gave :) ).
> > 
> > I stopped sharing also my kernel-build results years ago, because I
> > went on obtaining the same, identical good results for years, and I'm
> > aware that I tend to show and say too much stuff.
> 
> On my test setup building the kernel is slightly slower when using the BFQ
> scheduler compared to using scheduler "none" (kernel 4.18.12, NVMe SSD,
> single CPU with 6 cores, hyperthreading disabled). I am aware that the
> proposal at the start of this thread was to make BFQ the default for devices
> with a single hardware queue and not for devices like NVMe SSDs that support
> multiple hardware queues.
> 
> What I think is missing is measurement results for BFQ on a system with
> multiple CPU sockets and against a fast storage medium. Eliminating
> the host lock from the SCSI core yielded a significant performance
> improvement for such storage devices. Since the BFQ scheduler locks and
> unlocks bfqd->lock for every dispatch operation it is very likely that BFQ
> will slow down I/O for fast storage devices, even if their driver only
> creates a single hardware queue.

Well, I'm not sure why that is missing. I don't think anyone proposed to
default to BFQ for such setup? Neither was anyone claiming that BFQ is
better in such situation... The proposal has been: Default to BFQ for slow
storage, leave it to deadline-mq otherwise.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
