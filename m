Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1538582091.205649.20.camel@acm.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Bart Van Assche <bvanassche@acm.org>
To: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-block
 <linux-block@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
 linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Ulf Hansson
 <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, Artem
 Bityutskiy <dedekind1@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Jan Kara <jack@suse.cz>, Andreas Herrmann <aherrmann@suse.com>, Mel Gorman
 <mgorman@suse.com>, Chunyan Zhang <zhang.chunyan@linaro.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, 'Paolo Valente' via bfq-iosched
 <bfq-iosched@googlegroups.com>, Oleksandr Natalenko
 <oleksandr@natalenko.name>,  Mark Brown <broonie@kernel.org>
Date: Wed, 03 Oct 2018 08:54:51 -0700
In-Reply-To: <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
	 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
	 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-10-03 at 08:29 +-0200, Paolo Valente wrote:
+AD4 +AFs-1+AF0 https://lkml.org/lkml/2017/2/21/791
+AD4 +AFs-2+AF0 http://algo.ing.unimo.it/people/paolo/disk+AF8-sched/results.php
+AD4 +AFs-3+AF0 https://lwn.net/Articles/763603/

>From +AFs-2+AF0: +ACI-BFQ loses about 18+ACU with only random readers, because the number
of IOPS becomes so high that the execution time and parallel efficiency of
the schedulers becomes relevant.+ACI Since the number of I/O patterns for which
results are available on +AFs-2+AF0 is limited and since the number of devices for
which test results are available on +AFs-2+AF0 is limited (e.g. RAID is missing),
there might be other cases in which configuring BFQ as the default would
introduce a regression.

I agree with Jens that it's best to leave it to the Linux distributors to
select a default I/O scheduler.

Bart.
