Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <363DA0ED52042842948283D2FC38E4649BF396BD@IRSMSX106.ger.corp.intel.com>
References: <20171026125757.10200-1-linus.walleij@linaro.org>
 <0ab6b0b7-74e7-f7d3-9137-baf259282914@intel.com> <CACRpkdb_ZN+3YKYJ2L-5JNt1SgUqyCS3G-HER4e+LRcV64Jfag@mail.gmail.com>
 <363DA0ED52042842948283D2FC38E4649BF396BD@IRSMSX106.ger.corp.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 27 Oct 2017 13:25:02 +0200
Message-ID: <CACRpkdb795LnNkpo=Jg_fnn1mJwnE0A+FXwj5NjcUqCDhp32Ww@mail.gmail.com>
Subject: Re: [PATCH 00/12 v4] multiqueue for MMC/SD
To: "Hunter, Adrian" <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 26, 2017 at 9:27 PM, Hunter, Adrian <adrian.hunter@intel.com> w=
rote:
> On Thu, Oct 26, 2017 at 3:34 PM, Adrian Hunter <adrian.hunter@intel.com>

>> What I mean is that the CQE code will likely look better on top of these
>> refactorings.
>>
>> But as I say it is a matter of taste. I just love the looks of my own co=
de as
>> much as the next programmer so I can't judge that. Let's see what the
>> reviewers say.
>
> It doesn't look ready.  There seems still to be 2 task switches between
> each transfer.

IIUC there is a task in blk-mq submitting the requests, and that goes
all the way to starting it on the host. Then as an interrupt comes back
I kick the worker and that reports back to the block layer. So that
is one task switch per request and then one switch back to the MQ
layer.

But I am experimenting as we speak to get rid of the worker
for all simple cases that don't require retune or BKOPS and that's
pretty cool if it can be made to work :)

> mmc_blk_rw_done_error() is still using the messy error
> handling and doesn=E2=80=99t handle retries e.g. 'retry' is a local varia=
ble so it can't
> count the number of retries now that there is no loop.

Right! Nice catch.

I will update the patch and put that in the struct mmc_async_req so
it survives the retry rounds.

>> >> It sounds simple but I bet this drives a truck through Adrians patch
>> >> series. Sorry. :(
>> >
>> > I waited a long time for your patches but I had to give up waiting
>> > when Ulf belated insisted on blk-mq before CQE.  I am not sure what
>> > you are expecting now it seems too late.
>>
>> Too late for what? It's just a patch set, I don't really have a deadline=
 for this or
>> anything. As I explained above I have been working on this all the time,=
 the
>> problem was that I was/am not smart enough to find that solution for hos=
t
>> claiming by context.
>
> Too late to go before CQE.  All the blk-mq work is now in the CQE patchse=
t.

You seem to have an either/or stance.

Mine if more of a both/and.

It is not even necessary to have one set of these patches on
top of each other, they can also be mixed in some order.

A lot of factors influence this I think, like structure of code and
maintainability, performance, block layer interaction semantics,
etc etc.

We definately need input from Ulf and Bartlomiej (who was actually
the first to work on MQ for MMC/SD).

>> The host claiming by context was merged a month ago and now I have
>> understood that I can use that and rebased my patches on it. Slow learne=
r, I
>> guess.
>>
>> If you feel it is ungrateful that you have put in so much work and thing=
s are
>> not getting merged, and you feel your patches deserve to be merged first
>> (because of human nature reasons) I can empathize with that. It's sad th=
at
>> your patches are at v12. Also I see that patch 4 bears the signoffs of a
>> significant team at CodeAurora, so they are likely as impatient.
>
> It is important that you understand that this has nothing to do with
> "human nature reasons".

You do come across as a bit hard-headed.

But I think it is better to focus on the code per se.

I would suggest we go and review each others patch series to
learn from each codebase what was done in a good way for the
MMC/SD stack and what was not, you tossed out a nice review
comment above for example.

>  Linux distributions use upstream kernels.
> ChromeOS  has an "upstream first" policy.  Delaying features for long
> periods has real-world consequences.  When people ask, what kernel
> should they use, we expect to reply, just use mainline.

We are in violent agreement.

I take it that you are working on ChromeOS context and that since
they have this policy, they, through their influence over Intel as a
supplier is putting heavy pressure on you personally to get this
merged.

Is that correctly understood?

That would explain your increasing pushing to get this
upstream pretty well, especially if you have tech leads and
managers hovering over your shoulder every week asking how
the CQE upstream work is progressing.

It is indeed tough to juggle this with the pressure to "upstream
first" the BFQ scheduler policy that we are working on in Linaro
to increase interactivity. We need to enable this on devices
pronto and that means migrating MMC/SD to MQ and MQ only.
I have shared this motivation since the start, so it should come
as no surprise.

So I also have some pressure to "Get This Feature In Now".

Yours,
Linus Walleij
