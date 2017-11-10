Return-Path: <ulf.hansson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20171110100143.12256-1-linus.walleij@linaro.org>
References: <20171110100143.12256-1-linus.walleij@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 10 Nov 2017 16:24:04 +0100
Message-ID: <CAPDyKFpaeRpqea6dy+3nxEtYwBTLUTYoRsYrRHrvfmNX_afxwg@mail.gmail.com>
Subject: Re: [PATCH 00/12 v5] Multiqueue for MMC/SD
To: Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On 10 November 2017 at 11:01, Linus Walleij <linus.walleij@linaro.org> wrote:
> This is the fifth iteration of this patch set.
>
> I *HOPE* that we can scrap this patch set and merge Adrian's
> patches instead, because they also bring CQE support which is
> nice. I had some review comments on his series, mainly that
> it needs to kill off the legacy block layer code path that
> noone likes anyway.
>
> So this is mainly an academic and inspirational exercise.
> Whatever remains of this refactoring, if anything, I can
> certainly do on top of Adrian's patches as well.
>
> What changed since v4 is the error path, since Adrian pointed
> out that the error handling seems to be fragile. It was indeed
> fragile... To make sure things work properly I have run long
> test rounds with fault injection, essentially:

Please correct me if I am wrong, the issues was observed already in
patch 11, before the actual switch to mq was done, right?

>
> Enable FAULT_INJECTION, FAULT_INJECTION_DEBUG_FS,
>        FAIL_MMC_REQUEST
> cd /debug/mmc3/fail_mmc_request/
> echo 1 > probability
> echo -1 > times
>
> Then running a dd to the card, also increased the error rate
> to 10% and completed tests successfully, but at this error
> rate the MMC stack sometimes exceeds the retry limit and the
> dd command fails (as is appropriate).

That's great. I really appreciate that you have run these tests, that
gives me a good confidence from an overall point of view.

>
> Removing a card during I/O does not work well however :/
> So I guess I would need to work on that if this series should
> continue. (Hopefully unlikely.)

Yeah, this has actually been rather cumbersome to deal with also in
the legacy request path. Let's dive into this in more detail as soon
as possible.

>
>
> Linus Walleij (12):
>   mmc: core: move the asynchronous post-processing
>   mmc: core: add a workqueue for completing requests
>   mmc: core: replace waitqueue with worker
>   mmc: core: do away with is_done_rcv
>   mmc: core: do away with is_new_req
>   mmc: core: kill off the context info
>   mmc: queue: simplify queue logic
>   mmc: block: shuffle retry and error handling
>   mmc: queue: stop flushing the pipeline with NULL
>   mmc: queue/block: pass around struct mmc_queue_req*s
>   mmc: block: issue requests in massive parallel
>   mmc: switch MMC/SD to use blk-mq multiqueueing v5
>
>  drivers/mmc/core/block.c    | 557 +++++++++++++++++++++++---------------------
>  drivers/mmc/core/block.h    |   5 +-
>  drivers/mmc/core/bus.c      |   1 -
>  drivers/mmc/core/core.c     | 217 ++++++++++-------
>  drivers/mmc/core/core.h     |  11 +-
>  drivers/mmc/core/host.c     |   1 -
>  drivers/mmc/core/mmc_test.c |  31 +--
>  drivers/mmc/core/queue.c    | 252 ++++++++------------
>  drivers/mmc/core/queue.h    |  16 +-
>  include/linux/mmc/core.h    |   3 +-
>  include/linux/mmc/host.h    |  31 +--
>  11 files changed, 557 insertions(+), 568 deletions(-)

First, I haven't yet commented on the latest version of the mq patch
(patch12 in this series) and neither on Adrians (patch 3 in his
series), but before doing that, let me share my overall view of how we
could move forward, as to see if all of us can agree on that path.

So, what I really like in $subject series is the step by step method,
moving slowly forward enables an easy review, then the actual switch
to mq gets a diff of "3 files changed, 156 insertions(+), 181
deletions(-)". This shows to me, that it can be done! Great work!
Of course, I do realize that you may not have considered all
preparations needed for CQE, which Adrian may have thought of in his
mq patch from his series (patch 3), but still.

Moreover, for reasons brought up while reviewing Adrian's series,
regarding if mq is "ready", and because I see that the diff for patch
12 is small, I suggest that we just skip the step adding a Kconfig
option to allow an opt-in of the mq path. In other words, *the* patch
that makes the switch to mq, should also remove the entire left over
of rubbish code, from the legacy request path. That's also what you do
in patch12, nice!

Finally, I understand that you would be happy to scrap this series,
but instead let Adrian's series, when re-posted, to go first. Could
you perhaps re-consider that, because I wonder if it may not be
smother and less risky, to actually apply everything up to patch 11 in
this series?

I noticed that you reported issues with card removal during I/O (for
both yours and Adrian's mq patch), but does those problems exists at
patch 11 - or is those explicitly introduced with the mk patch (patch
12)?

Of course, I realize that if we apply everything up to patch11, that
would require a massive re-base of Adrian's mq/CQE series, but on the
other hand, then matter which mq patch we decide to go with, it should
be a rather small diff, thus easy to review and less risky.

Adrian, Linus - what do you think?

Kind regards
Uffe
