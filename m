Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1538683746.230807.9.camel@acm.org>
Date: Thu, 4 Oct 2018 22:39:20 +0200
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
Message-Id: <A017CAC7-41E6-4BB3-AC31-5EB524276138@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538582091.205649.20.camel@acm.org> <20181004202553.71c2599c@alans-desktop>
 <1538683746.230807.9.camel@acm.org>
To: Bart Van Assche <bvanassche@acm.org>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 04 ott 2018, alle ore 22:09, Bart Van Assche =
<bvanassche@acm.org> ha scritto:
>=20
> On Thu, 2018-10-04 at 20:25 +0100, Alan Cox wrote:
>>> I agree with Jens that it's best to leave it to the Linux =
distributors to
>>> select a default I/O scheduler.
>>=20
>> That assumes such a thing exists. The kernel knows what devices it is
>> dealing with. The kernel 'default' ought to be 'whatever is usually =
best
>> for this device'. A distro cannot just pick a correct single default
>> because NVME and USB sticks are both normal and rather different in =
needs.
>=20
> Which I/O scheduler works best also depends which workload the user =
will run.
> BFQ has significant advantages for interactive workloads like video =
replay
> with concurrent background I/O but probably slows down kernel builds.

No, kernel build is, for evident reasons, one of the workloads I cared
most about.  Actually, I tried to focus on all my main
kernel-development tasks, such as also git checkout, git merge, git
grep, ...

According to my test results, with BFQ these tasks are at least as
fast as, or, in most system configurations, much faster than with the
other schedulers.  Of course, at the same time the system also remains
responsive with BFQ.

You can repeat these tests using one of my first scripts in the S
suite: kern_dev_tasks_vs_rw.sh (usually, the older the tests, the more
hypertrophied the names I gave :) ).

I stopped sharing also my kernel-build results years ago, because I
went on obtaining the same, identical good results for years, and I'm
aware that I tend to show and say too much stuff.

Thanks,
Paolo

> That's
> why I'm not sure whether the kernel should select the default I/O =
scheduler.
>=20
> Bart.
