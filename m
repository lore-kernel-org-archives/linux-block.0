Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1538582091.205649.20.camel@acm.org>
Date: Wed, 3 Oct 2018 18:02:36 +0200
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
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Mark Brown <broonie@kernel.org>
Message-Id: <C7FEB750-D993-44EC-B3CB-0639DF68CD26@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538582091.205649.20.camel@acm.org>
To: Bart Van Assche <bvanassche@acm.org>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 03 ott 2018, alle ore 17:54, Bart Van Assche =
<bvanassche@acm.org> ha scritto:
>=20
> On Wed, 2018-10-03 at 08:29 +0200, Paolo Valente wrote:
>> [1] https://lkml.org/lkml/2017/2/21/791
>> [2] http://algo.ing.unimo.it/people/paolo/disk_sched/results.php
>> [3] https://lwn.net/Articles/763603/
>=20
> =46rom [2]: "BFQ loses about 18% with only random readers, because the =
number
> of IOPS becomes so high that the execution time and parallel =
efficiency of
> the schedulers becomes relevant." Since the number of I/O patterns for =
which
> results are available on [2] is limited and since the number of =
devices for
> which test results are available on [2] is limited (e.g. RAID is =
missing),
> there might be other cases in which configuring BFQ as the default =
would
> introduce a regression.
>=20

=46rom [3]: none with throttling loses 80% of the throughput when used
to control I/O. On any drive. And this is really only one example among =
a ton.

In addition, the test you mention, designed by me, was meant exactly
to find and show the worst breaking point of BFQ.  If your main
workload of interest is really made only of tens of parallel thread
doing only sync random I/O, and you care only about throughput,
without any concern for your system becoming so unresponsive to be
unusable during the test, then, yes, mq-deadline is a better option
for you.

So, are you really sure the balance is in favor of mq-deadline?

Thanks,
Paolo

> I agree with Jens that it's best to leave it to the Linux distributors =
to
> select a default I/O scheduler.
>=20
> Bart.
