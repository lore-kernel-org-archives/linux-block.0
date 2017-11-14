Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpaeRpqea6dy+3nxEtYwBTLUTYoRsYrRHrvfmNX_afxwg@mail.gmail.com>
References: <20171110100143.12256-1-linus.walleij@linaro.org> <CAPDyKFpaeRpqea6dy+3nxEtYwBTLUTYoRsYrRHrvfmNX_afxwg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Nov 2017 22:17:41 +0100
Message-ID: <CACRpkdZ-_1vFLLUcRTXWPYdDomP8Pen9wBwEMUGgr2cd_y3eBQ@mail.gmail.com>
Subject: Re: [PATCH 00/12 v5] Multiqueue for MMC/SD
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Nov 10, 2017 at 4:24 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 10 November 2017 at 11:01, Linus Walleij <linus.walleij@linaro.org> wrote:
>> This is the fifth iteration of this patch set.
>>
>> I *HOPE* that we can scrap this patch set and merge Adrian's
>> patches instead, because they also bring CQE support which is
>> nice. I had some review comments on his series, mainly that
>> it needs to kill off the legacy block layer code path that
>> noone likes anyway.
>>
>> So this is mainly an academic and inspirational exercise.
>> Whatever remains of this refactoring, if anything, I can
>> certainly do on top of Adrian's patches as well.
>>
>> What changed since v4 is the error path, since Adrian pointed
>> out that the error handling seems to be fragile. It was indeed
>> fragile... To make sure things work properly I have run long
>> test rounds with fault injection, essentially:
>
> Please correct me if I am wrong, the issues was observed already in
> patch 11, before the actual switch to mq was done, right?

Yes. That's where I fixed it up mostly.

> Moreover, for reasons brought up while reviewing Adrian's series,
> regarding if mq is "ready", and because I see that the diff for patch
> 12 is small, I suggest that we just skip the step adding a Kconfig
> option to allow an opt-in of the mq path. In other words, *the* patch
> that makes the switch to mq, should also remove the entire left over
> of rubbish code, from the legacy request path. That's also what you do
> in patch12, nice!

Partly true.

Adrian also pointed out the rubbishness of the error handling code
in the old stack, and my patch set does *not* fix that. It is also a part
of his patch set I like very much and a reason why I would prefer to
use Adrian's patches if possible.

We have the following risk factors:

- Observed performance degradation of 1% (on x86 SDHI I guess)
- The kernel crashes if SD card is removed (both patch sets)
- The risk of something nasty happening we don't know of

> Finally, I understand that you would be happy to scrap this series,
> but instead let Adrian's series, when re-posted, to go first. Could
> you perhaps re-consider that, because I wonder if it may not be
> smother and less risky, to actually apply everything up to patch 11 in
> this series?

This is possible.

But I think it is preferred to proceed with Adrian's patches.
I really like the looks of the code. He says he's coming back with
a set that also kills off the old block layer, and I am pretty
positive I will just ACK the whole thing.

I optimistically think we can jointly fix the card removal issue
and possible also mitigate or root-cause the performance
degradation observed by Adrian

In the best of worlds, Ming Lei's patches will just fix this too
(we'll see, we can probably get a branch from the block people
to try it) else we can use tracing and perf to drill into it I guess.

> I noticed that you reported issues with card removal during I/O (for
> both yours and Adrian's mq patch), but does those problems exists at
> patch 11 - or is those explicitly introduced with the mk patch (patch
> 12)?

I tested it and it is present earlier in the series. I would have to
revisit and hash it out.

> Of course, I realize that if we apply everything up to patch11, that
> would require a massive re-base of Adrian's mq/CQE series, but on the
> other hand, then matter which mq patch we decide to go with, it should
> be a rather small diff, thus easy to review and less risky.

At this point I would prefer to use Adrian's series. He has explained
pretty well his reasoning and when I tested the code it was performing
well. I have some outstanding thingies, but this I can just as well do
on top of his patches.

Yours,
Linus Walleij
