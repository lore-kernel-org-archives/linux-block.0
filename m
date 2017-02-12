Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <9BEFCB713C10BF4B91D714797ECA5EEA117E08F5@ULS-OP-MBXIP04.sdcorp.global.sandisk.com>
References: <20170209153403.9730-1-linus.walleij@linaro.org> <9BEFCB713C10BF4B91D714797ECA5EEA117E08F5@ULS-OP-MBXIP04.sdcorp.global.sandisk.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 12 Feb 2017 17:16:59 +0100
Message-ID: <CACRpkdZ_jK+NiyZk_JKAejHvwWgNjorK6-4SgZsS3AB4Po4TAg@mail.gmail.com>
Subject: Re: [PATCH 00/16] multiqueue for MMC/SD third try
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Paolo Valente <paolo.valente@linaro.org>,
	Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Sat, Feb 11, 2017 at 2:03 PM, Avri Altman <Avri.Altman@sandisk.com> wrote:
>>
>> The iozone results seem a bit consistent and all values seem to be noisy and
>> not say much. I don't know why really, maybe the test is simply not relevant,
>> the tests don't seem to be significantly affected by any of the patches, so
>> let's focus on the dd and find tests.
>
> Maybe use a more selective testing mode instead of -az.
> Also maybe you want to clear the cache between the sequential and random tests:
> #sync
> #echo 3 > /proc/sys/vm/drop_caches
> #sync
> It helps to obtain a more robust results.

OK I'll try that. I actually cold booted the system between each test to
avoid cache effects.

>> What immediately jumps out at you is that linear read/writes perform just as
>> nicely or actually better with MQ than with the old block layer.
>
> How come 22.7MB/s before vs. 22.1MB/s after is better?  or did I misunderstand the output?
> Also as dd is probably using the buffer cache, unlike the iozone test  in which you properly used -I
> for direct mode to isolate the blk-mq effect - does it really say much?

Sorry I guess I was a bit too enthusiastic there. The difference is in
the error margin, it is just based on a single test. I guess I should re-run
them with a few iterations, then drop caches iterate drop caches iterate
and get some more stable figures.

We need to understand what is meant by "better" too:
quicker compared to wall clock time (real), user
or sys.

So for the dd command:

                    real     user     sys
Before patches:     45.13    0.02     7.60
Move asynch pp      52.17    0.01     6.96
Issue in parallel   49.31    0.00     7.11
Multiqueue          46.25    0.03     6.42

For these pure kernel patches only the last figure (sys) is really relevant
IIUC. The other figures are just system noise, but still the eventual
throughput figure from dd is including the time spent on other processes
in the system etc, so that value is not relevant.

But I guess Paolo may need to beat me up a bit here: what the user
percieves in the end if of course the most relevant for any human ...

Nevertheless if we just look at sys then MQ is already winning this test.
I just think there is too little tested here.

I think 1GiB is maybe too little. Maybe I need to read the entire card
a few times or something?

Since dd is just using sequenctially blocks from mmcblk0 on a cold
booted system I think the buffer cache is empty except for maybe
the partition table blocks. But I dunno. I will use your trick the next
time to drop caches.

Yours,
Linus Walleij
