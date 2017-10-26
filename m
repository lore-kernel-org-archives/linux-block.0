Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <0ab6b0b7-74e7-f7d3-9137-baf259282914@intel.com>
References: <20171026125757.10200-1-linus.walleij@linaro.org> <0ab6b0b7-74e7-f7d3-9137-baf259282914@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Oct 2017 16:20:13 +0200
Message-ID: <CACRpkdb_ZN+3YKYJ2L-5JNt1SgUqyCS3G-HER4e+LRcV64Jfag@mail.gmail.com>
Subject: Re: [PATCH 00/12 v4] multiqueue for MMC/SD
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 26, 2017 at 3:34 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 26/10/17 15:57, Linus Walleij wrote:

>> I have now worked on it for more than a year. I was side
>> tracked to clean up some code, move request allocation to
>> be handled by the block layer, delete bounce buffer handling
>> and refactoring the RPMB support. With the changes to request
>> allocation, the patch set is a better fit and has shrunk
>> from 16 to 12 patches as a result.
>
> None of which was necessary for blk-mq support.

I was not smart enough to realize that it was possible to do what
you did in
commit d685f5d5fcf75c30ef009771d3067f7438cd8baf
"mmc: core: Introduce host claiming by context"
this simple and clever solution simply didn't occur to me
at all.

And now it uses that solution, as you can see :)

But since I didn't have that simple solution, the other
solution was to get rid of the lock altogether (which we should
anyways...) getting rid of the RPMB "partition" for example
removes some locks. (I guess I still will have to go on and
find a solution for the boot and generic partitions but it's no
blocker for MQ anymore.)

My patch set was dependent on solving that. As I already wrote
to you on sep 13:
https://marc.info/?l=linux-mmc&m=150607944524752&w=2

My patches for allocating the struct mmc_queue_req from the
block layer was actually originally a part of this series
so the old patches
  mmc: queue: issue struct mmc_queue_req items
  mmc: queue: get/put struct mmc_queue_req
was doing a stupid homebrewn solution to what the block
layer already can do, mea culpa. (Yeah I was educating
myself in the block layer too...)

Anyways, all of this happened in the context of moving
forward with my MQ patch set, not as random activity.

Now it looks like I'm defending myself from a project leader,
haha :D

Well for better or worse, this was how I was working.

>> We use the trick to set the queue depth to 2 to get two
>> parallel requests pushed down to the host. I tried to set this
>> to 4, the code survives it, the queue just have three items
>> waiting to be submitted all the time.
>
> The queue depth also sets the number of requests, so you are strangling the
> I/O scheduler.

Yup. Just did it to see if it survives.

>> In my opinion this is also a better fit for command queueuing.
>
> Not true.  CQE support worked perfectly before blk-mq and did not depend on
> blk-mq in any way.  Obviously the current CQE patch set actually implements
> the CQE requirements for blk-mq - which this patch set does not.

What I mean is that the CQE code will likely look better on top
of these refactorings.

But as I say it is a matter of taste. I just love the looks of my own code
as much as the next programmer so I can't judge that. Let's see what
the reviewers say.

>> Handling command queueing needs to happen in the asynchronous
>> submission codepath, so instead of waiting on a pending
>> areq, we just stack up requests in the command queue.
>
> That is how CQE has always worked.  It worked that way just fine without blk-mq.

Okay nice.

>> It sounds simple but I bet this drives a truck through Adrians
>> patch series. Sorry. :(
>
> I waited a long time for your patches but I had to give up waiting when Ulf
> belated insisted on blk-mq before CQE.  I am not sure what you are expecting
> now it seems too late.

Too late for what? It's just a patch set, I don't really have a deadline
for this or anything. As I explained above I have
been working on this all the time, the problem was that I was/am not
smart enough to find that solution for host claiming by context.

The host claiming by context was merged a month ago and now I have
understood that I can use that and rebased my patches on it. Slow
learner, I guess.

If you feel it is ungrateful that you have put in so much work and things
are not getting merged, and you feel your patches deserve to be
merged first (because of human nature reasons) I can empathize with
that. It's sad that your patches are at v12. Also I see that patch 4 bears
the signoffs of a significant team at CodeAurora, so they are likely
as impatient.

I would just rebase my remaining work on top of the CQE patches if
they end up being merged first, no big deal, just work.

Yours,
Linus Walleij
