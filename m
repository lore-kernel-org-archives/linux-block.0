Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34695 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbdHaKFD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 06:05:03 -0400
Received: by mail-oi0-f43.google.com with SMTP id w10so1800584oie.1
        for <linux-block@vger.kernel.org>; Thu, 31 Aug 2017 03:05:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b7d28123-ecc1-8b24-28bd-18e87c475fc5@intel.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com>
 <1502366898-23691-12-git-send-email-adrian.hunter@intel.com>
 <CACRpkdZ2=D2tLD0L0M1T_z0_5gMhiPKqUHuOcMgdA72PHLHG8A@mail.gmail.com> <b7d28123-ecc1-8b24-28bd-18e87c475fc5@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 31 Aug 2017 12:05:02 +0200
Message-ID: <CACRpkdbbWUDrOWJQ-nZ+0mLgZEVdoWAZ=fbgW1Q1UNJD5wnqZQ@mail.gmail.com>
Subject: Re: [PATCH V5 11/13] mmc: block: Add CQE support
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-block@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 21, 2017 at 11:27 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 20/08/17 15:13, Linus Walleij wrote:
>> On Thu, Aug 10, 2017 at 2:08 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>>> Add CQE support to the block driver, including:
>>>         - optionally using DCMD for flush requests
>>>         - manually issuing discard requests
>>
>> "Manually" has no place in computer code IMO since there is no
>> man there. But I may be especially grumpy. But I don't understand the
>> comment anyway.
>
> CQE automatically sends the commands to complete requests.  However it only
> supports reads / writes and so-called "direct commands" (DCMD).  Furthermore
> DCMD is limited to one command at a time, but discards require 3 commands.
> That makes issuing discards through CQE very awkward, but some CQE's don't
> support DCMD anyway.  So for discards, the existing non-CQE approach is
> taken, where the mmc core code issues the 3 commands one at a time i.e.
> mmc_erase().

Ah that's a great deal of good technical detail (I think I might have
even understood
what is going on) can we please make sure to get this text into the commit.

>> So adding a new (in effect) invasive block driver needs to at least
>> be CC:ed to the block maintainers so we don't sneak anything like
>> that in under the radar.
>>
>> This duplicates the "thread that sucks out requests" from the
>> MMC core, and doubles the problem of replacing it with
>> something like blk-mq.
>
> We need to start with a legacy API because people want to backport CQ to
> earlier kernels (we really need to get features upstream more quickly), but
> blk-mq has been evolving a lot (e.g. elevator support), so backporters face
> having either something quite different from upstream or trying to backport
> great chunks of the block layer.

I hope I do not come across as rude to a senior kernel developer if I just
reference this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-api-nonsense.rst

My position is that any attempts to push around the community due
to internal product development falls under the "argument ti moderation"
fallacy. Even for huge enterprises.
https://en.wikipedia.org/wiki/Argument_to_moderation

> We also don't know how blk-mq will perform so it would be prudent to start
> with support for both the legacy API and blk-mq (as scsi does) so that we
> can find out first.

As far as I have understood, that is not the position of the block layer
maintainers, who are quickly phasing out the old block layer in favor
of the new mq scheduler.

Example: they did not accept the new BFQ scheduling policy until it was
rewritten as a plugin to mq.

> A loop to remove requests from the queue is normal e.g. scsi_request_fn()
> and taking a consistent approach with the existing mmc thread does not
> double the the problem of blk-mq implementation, since the same approach can
> be used for both.

If the two threads are so similar, why do we need two threads?

My general feeling is that this part of the code is duct-taped on the side
of the old request poll loop instead of refactoring and integrating the new
code with the existing poll loop.

I need a clear argument as to why that is not possible if this solution
should persist.

>>> +               if (!kthread_should_stop())
>>> +                       req = blk_peek_request(q);
>>
>> Why are you using blk_peek_request() instead of blk_fetch_request()
>> when the other thread just goes with fetch?
>
> Because we are not always able to start the request.

OK I understand this now, sorry for my ignorance.

>> Am I right in assuming that also this request queue replies on the
>> implicit semantic that blk_peek_request(q) shall return NULL
>> if there are no requests in the queue, and that it is pulling out a
>> few NULLs to flush the request-handling machinery? Or did it
>> fix this? (Put that in the commit message in that case.)
>
> CQ is different.  Because read / write requests are processed asynchronously
> we can keep preparing and issuing more requests until the hardware queue is
> full.  That is, we don't have to wait for the first request to complete
> before preparing and issuing the second request, and so on.
>
> However, the existing thread's need to issue a "null" is not because it is a
> thread.  It is because of the convoluted design of mmc_start_areq().

Yeah that is true :(

> However, you still need a way to issue the prepared request when the current
> request completes.  Either wake-up the thread to do it, or in the past I
> have suggested that should be done in the completion path, but that needs
> changes to the host controller API.

We might have to do that then? It is anyways necessary for MQ
which (in my implementation) sets the queue depth to 2 and get the
same issue with two outstanding requests.

>>> +                               break;
>>> +                       default:
>>> +                               /*
>>> +                                * Timeouts are handled by mmc core, so set a
>>> +                                * large value to avoid races.
>>> +                                */
>>> +                               req->timeout = 600 * HZ;
>>> +                               blk_start_request(req);
>>
>> And here it just starts.
>
> This is the path for requests that the CQE cannot process.  They don't need
> to be tagged because there is no command queue - no way to do more than one
> request at a time.

OK I get it.

>>> +                       switch (issued) {
>>> +                       case MMC_REQ_STARTED:
>>> +                               break;
>>> +                       case MMC_REQ_BUSY:
>>> +                               blk_requeue_request(q, req);
>>
>> Here it is requeued.
>
> Any request that is started has to be either re-queued or completed.

Yup I get it.

>>> +                               goto finished;
>>> +                       case MMC_REQ_FAILED_TO_START:
>>> +                               __blk_end_request_all(req, BLK_STS_IOERR);
>>
>> Or ended.
>
> Any request that is started has to be either re-queued or completed.

Yup.

So why can't we do all this in the existing thread instead of a new
thread?

>> I think I said in the beginning maybe not in response to this series but
>> another that I don't like the idea of making a second copy of the
>> whole request thread. I would much rather see that ONE request thread
>> is used for both regular requests and CQE.
>
> They issue requests in completely different ways.  There is essentially no
> common code.

That sounds a bit handwavy, sorry.

I need to know exactly why.

Will it also have to be two separate MQ paths when we migrate
to that?

>> Atleast I wanna see a serious rebuttal of why my claim that we should
>> keep this code down is such a pipe dream that we just have to go ahead
>> and make a second instance of all the core request mechanics.
>> And that this should be part of the commit message: "I'm duplicating
>> the queue thread because (...)" etc.
>
> As I wrote above, we need to start with the legacy API, because of
> backporting and because we don't know how blk-mq will perform.

Sorry I do not buy it. (See the above references.)

We need to agree to disagree and leave this to
the higher authority then.

>> I'm sorry for being so conservative, but I am plain scared, I had serious
>> trouble refactoring this code already, and I got the feeling that several
>> people think the MMC stack has grown unapproachable for average
>> developers (my Googledoc where I tried to pry it apart got very popular
>> with developers I respect), and this is making that situation worse. Soon
>> only you and Ulf will understand this piece of code.
>
> The mmc block driver has problems, but the thread isn't one of them.

The pulling out of NULLs from the end of the request queue to
flush the request pipeline is definately an abuse of the API and
that is a big problem.

> mmc_start_areq() is very convoluted.  However, getting rid of
> mmc_start_areq() is only the first step.

We are in violent agreement, at last.

> Step two: have the host controller
> complete requests without the need of block driver polling i.e.
> card_busy_detect() must not be called in the normal completion path.

I agree on this too.

> Step
> three: make it possible to issue the prepared request in the completion path
> of the current request.

I actually did patches to do that.

OK the patches suck for several reasons. But I have a proof of concept:
https://marc.info/?l=linux-mmc&m=148665460925587&w=2

Despite the convoluted subject this is what that patch does and
what the series try to build up to.

> Steps two and three need host controller driver
> changes.

I don't know about that. I think I kind of pulled off three.

Yours,
Linus Walleij
