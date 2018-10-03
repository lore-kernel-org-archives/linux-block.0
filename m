Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <C7FEB750-D993-44EC-B3CB-0639DF68CD26@linaro.org>
Date: Wed, 3 Oct 2018 19:22:20 +0200
Cc: Bart Van Assche <bvanassche@acm.org>,
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
 linux-kernel <linux-kernel@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Mark Brown <broonie@kernel.org>
Message-Id: <11FFD0AF-4A08-4565-B4BE-FF80EA5BB5E6@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538582091.205649.20.camel@acm.org>
 <C7FEB750-D993-44EC-B3CB-0639DF68CD26@linaro.org>
To: 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 03 ott 2018, alle ore 18:02, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 03 ott 2018, alle ore 17:54, Bart Van Assche =
<bvanassche@acm.org> ha scritto:
>>=20
>> On Wed, 2018-10-03 at 08:29 +0200, Paolo Valente wrote:
>>> [1] https://lkml.org/lkml/2017/2/21/791
>>> [2] http://algo.ing.unimo.it/people/paolo/disk_sched/results.php
>>> [3] https://lwn.net/Articles/763603/
>>=20
>> =46rom [2]: "BFQ loses about 18% with only random readers, because =
the number
>> of IOPS becomes so high that the execution time and parallel =
efficiency of
>> the schedulers becomes relevant." Since the number of I/O patterns =
for which
>> results are available on [2] is limited and since the number of =
devices for
>> which test results are available on [2] is limited (e.g. RAID is =
missing),
>> there might be other cases in which configuring BFQ as the default =
would
>> introduce a regression.
>>=20
>=20
> =46rom [3]: none with throttling loses 80% of the throughput when used
> to control I/O. On any drive. And this is really only one example =
among a ton.
>=20

I forgot to add that the same 80% loss happens with mq-deadline plus
throttling, sorry.  In addition, mq-deadline suffers from much more
than a 18% loss of throughput, w.r.t. bfq, exactly in the same figure
you cited, if there are random writes too.

> In addition, the test you mention, designed by me, was meant exactly
> to find and show the worst breaking point of BFQ.  If your main
> workload of interest is really made only of tens of parallel thread
> doing only sync random I/O, and you care only about throughput,
> without any concern for your system becoming so unresponsive to be
> unusable during the test, then, yes, mq-deadline is a better option
> for you.
>=20

Some more detail on this.  The fact that bfq reaches a lower
throughput than none in this test is actually still puzzling me,
because the process rate of I/O with bfq is one order of magnitude
higher than the IOPS of this device.  So, I still don't understand
why, with bfq, the queue of the device does not get as full as with
none, and thus why the throughput with bfq is not the same as with
none.

To further test this issue, I replaced sync I/O with async I/O (with a
very high depth).  And, nonsensically (for me), throughput dropped
with both bfq and none!  I already meant to to report this issue,
after investigating it more.  Anyway, this is a different story w.r.t.
this thread.

Thanks,
Paolo


> So, are you really sure the balance is in favor of mq-deadline?
>=20
> Thanks,
> Paolo
>=20
>> I agree with Jens that it's best to leave it to the Linux =
distributors to
>> select a default I/O scheduler.
>>=20
>> Bart.
>=20
> --=20
> You received this message because you are subscribed to the Google =
Groups "bfq-iosched" group.
> To unsubscribe from this group and stop receiving emails from it, send =
an email to bfq-iosched+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
