Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1538692972.8223.7.camel@acm.org>
Date: Fri, 5 Oct 2018 11:28:07 +0200
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
 Jens Axboe <axboe@kernel.dk>,
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
 linux-kernel <linux-kernel@vger.kernel.org>
Message-Id: <A76F98D4-4D3E-4DFA-BF24-C64AD8BF8169@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538582091.205649.20.camel@acm.org> <20181004202553.71c2599c@alans-desktop>
 <1538683746.230807.9.camel@acm.org>
 <A017CAC7-41E6-4BB3-AC31-5EB524276138@linaro.org>
 <1538692972.8223.7.camel@acm.org>
To: Bart Van Assche <bvanassche@acm.org>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 05 ott 2018, alle ore 00:42, Bart Van Assche =
<bvanassche@acm.org> ha scritto:
>=20
> On Thu, 2018-10-04 at 22:39 +0200, Paolo Valente wrote:
>> No, kernel build is, for evident reasons, one of the workloads I =
cared
>> most about.  Actually, I tried to focus on all my main
>> kernel-development tasks, such as also git checkout, git merge, git
>> grep, ...
>>=20
>> According to my test results, with BFQ these tasks are at least as
>> fast as, or, in most system configurations, much faster than with the
>> other schedulers.  Of course, at the same time the system also =
remains
>> responsive with BFQ.
>>=20
>> You can repeat these tests using one of my first scripts in the S
>> suite: kern_dev_tasks_vs_rw.sh (usually, the older the tests, the =
more
>> hypertrophied the names I gave :) ).
>>=20
>> I stopped sharing also my kernel-build results years ago, because I
>> went on obtaining the same, identical good results for years, and I'm
>> aware that I tend to show and say too much stuff.
>=20
> On my test setup building the kernel is slightly slower when using the =
BFQ
> scheduler compared to using scheduler "none" (kernel 4.18.12, NVMe =
SSD,
> single CPU with 6 cores, hyperthreading disabled). I am aware that the
> proposal at the start of this thread was to make BFQ the default for =
devices
> with a single hardware queue and not for devices like NVMe SSDs that =
support
> multiple hardware queues.
>=20

I miss your point: as you yourself note, the proposal is limited to
single-queue devices, exactly because BFQ is not ready for
multiple-queue devices yet.

> What I think is missing is measurement results for BFQ on a system =
with
> multiple CPU sockets and against a fast storage medium.

It is not missing.  As I happened to report in previous threads, we
made a script to measure that too [1], using fio and null block.

I have reported the results we obtained, for three classes of
processors, in the in-kernel BFQ documentation [2].

In particular, BFQ reached 400KIOPS with the fastest CPU mentioned in
that document (Intel i7-4850HQ).

So, since the speed of that single-socket commodity CPU is most likely
lower than the total speed of a multi-socket system, we have that, on
such a system and with BFQ, you should be conservatively ok with
single-queue devices in the range 300-500 KIOPS.

[1] https://github.com/Algodev-github/IOSpeed
[2] https://www.kernel.org/doc/Documentation/block/bfq-iosched.txt

> =20

> Eliminating
> the host lock from the SCSI core yielded a significant performance
> improvement for such storage devices. Since the BFQ scheduler locks =
and
> unlocks bfqd->lock for every dispatch operation it is very likely that =
BFQ
> will slow down I/O for fast storage devices, even if their driver only
> creates a single hardware queue.
>=20

One of the main motivations behind NVMe, and blk-mq itself, is that it
is hard to reach the above IOPS, and more, with a single I/O queue as
bottleneck.

So, I wouldn't expect that systems
- equipped with single-queue drives reaching more than 500 KIOPS
- using SATA or some other non-NVMe as protocol
- so fast to push these drives to their maximum speeds
constitute more than a negligible percentage of devices.

So, by sticking to mq-deadline, we would sacrifice 99% of systems, to
make sure, basically, that those very few systems on steroids reach
maximum throughput with random I/O (while however still suffering from
responsiveness problems).  I think it makes much more sense to have as
default what is best for 99% of the single-queue systems, with those
super systems properly reconfigured by their users.  For sure, other
defaults are to be changed too, to get the most out of those systems.

Thanks,
Paolo


> Bart.
