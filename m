Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:49452 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbdJ0Nob (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Oct 2017 09:44:31 -0400
Received: by mail-io0-f171.google.com with SMTP id n137so12807522iod.6
        for <linux-block@vger.kernel.org>; Fri, 27 Oct 2017 06:44:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <39cc79f4-9272-cf4d-7843-a9752c9f624b@intel.com>
References: <1508834428-4360-1-git-send-email-adrian.hunter@intel.com>
 <1508834428-4360-3-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFrunZ9q6vHZLDX3ZkH+0jgZQqD6=8Qj4LTJ+4J5yYstMg@mail.gmail.com> <39cc79f4-9272-cf4d-7843-a9752c9f624b@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 27 Oct 2017 15:44:30 +0200
Message-ID: <CAPDyKFqJBx6OoYZO-=wcyrhAhQvVgWp67eruRJKOYCrf=H2c3A@mail.gmail.com>
Subject: Re: [PATCH V12 2/5] mmc: block: Add blk-mq support
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>
>>> -#define CMD_ERRORS                                                     \
>>> -       (R1_OUT_OF_RANGE |      /* Command argument out of range */     \
>>> -        R1_ADDRESS_ERROR |     /* Misaligned address */                \
>>> +#define CMD_ERRORS_EXCL_OOR                                            \
>>> +       (R1_ADDRESS_ERROR |     /* Misaligned address */                \
>>
>> This looks unrelated to blkmq support.
>
> No, it is preserving existing oor functionality.

So why change it in this patch?

[...]

>>> +       /*
>>> +        * Do not assume data transferred correctly if there are any error bits
>>> +        * set.
>>> +        */
>>> +       if (!err && status & mmc_blk_stop_err_bits(&mqrq->brq)) {
>>> +               mqrq->brq.data.bytes_xfered = 0;
>>> +               err = -EIO;
>>> +       }
>>> +
>>> +       /* Copy the exception bit so it will be seen later on */
>>> +       if (mmc_card_mmc(card) && status & R1_EXCEPTION_EVENT)
>>> +               mqrq->brq.cmd.resp[0] |= R1_EXCEPTION_EVENT;
>>> +
>>> +       return err;
>>> +}
>>> +
>>> +static inline void mmc_blk_rw_reset_success(struct mmc_queue *mq,
>>> +                                           struct request *req)
>>> +{
>>> +       int type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
>>> +
>>> +       mmc_blk_reset_success(mq->blkdata, type);
>>> +}
>>
>> I understand that all the above new line and code (around 300 lines)
>> is something you need for the blkmq support, in the rest of this
>> patch.
>>
>> However, it looks like you are adding completely new code that either
>> already exists in the legacy request path (in some slightly different
>> format), or could serve as clean up/re-factorization of the legacy
>> request path.
>
> The legacy error handling is a non-starter.  Messy and convoluted.  There is
> no reason to keep using it.  Structurally it doesn't fit with blk-mq because
> it is split in different places and mixes in logic that is not related with
> error-handling.

No matter you like it or not, the legacy request error path is what we got now.

The way forward is not to just through it away and start over, but
instead to take small steps and make parts useful also for blkmq.

Yes, it's more work, but on the other hand, small changes which moves
things in the right direction are also more easy to review.

So, no, sorry, I don't buy it!

>
>>
>> This is not the way you should format a path for converting to blkmq.
>> The reasons are:
>> *) It makes it hard to review.
>
> But the few comments in this email suggest you have spent maybe 30 minutes.
> It really looks like you haven't tried.  Where are the questions?

On this version, I spent a few hours on it, but really, it isn't easy
to look at ~1000 new lines in one single patch, especially changes
that re-implements the entire mmc request layer.

>
>> **) There is no need to through away *all* old mmc blk/core code,
>> which I assume is your plan for next step. Instead the proper way is
>> to re-factor it, an make it possible to re-use those parts that makes
>> sense.
>
> That is just nonsense.  We definitely want to throw away the messy
> convoluted legacy code.  The new code is much simpler.  Did you read it?

Yes, the new code is simpler, but as stated, re-factoring some of the
old code that can be re-used, is the way forward.

[...]

>>> +static bool mmc_blk_urgent_bkops_needed(struct mmc_queue *mq,
>>> +                                       struct mmc_queue_req *mqrq)
>>> +{
>>> +       return mmc_card_mmc(mq->card) &&
>>> +              (mqrq->brq.cmd.resp[0] & R1_EXCEPTION_EVENT ||
>>> +               mqrq->brq.stop.resp[0] & R1_EXCEPTION_EVENT);
>>> +}
>>> +
>>> +static void mmc_blk_urgent_bkops(struct mmc_queue *mq,
>>> +                                struct mmc_queue_req *mqrq)
>>> +{
>>> +       if (mmc_blk_urgent_bkops_needed(mq, mqrq))
>>> +               mmc_start_bkops(mq->card, true);
>>> +}
>>
>> Ditto for the two above functions.
>
> Again it is the same functionality.  In what way is it different?

These checks are being done also in the legacy path, so in principle
adding these and not using them there, means open-coding to me.

>
>>
>>> +
>>> +void mmc_blk_mq_complete(struct request *req)
>>> +{
>>> +       struct mmc_queue *mq = req->q->queuedata;
>>> +
>>> +       mmc_blk_mq_complete_rq(mq, req);
>>> +}
>>> +
>>> +static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
>>> +                                      struct request *req)
>>> +{
>>> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>>> +       struct mmc_host *host = mq->card->host;
>>> +       bool failed;
>>> +
>>> +       failed = mmc_blk_rq_error(&mqrq->brq) ||
>>> +                mmc_blk_card_busy(mq->card, req);
>>> +
>>> +       if (!mmc_queue_direct_complete(host))
>>
>> Can you please make the changes related to completing the request in
>> the mmc_request_done() into a separate patch.
>>
>> It's better to first get the default behavior in place, then we can
>> improve things on top. Again, that also makes it easier to review.
>
> I am not sure what you mean.  Did you read the code?
> mmc_queue_direct_complete() is a capability that is not yet used, the
> default behavior is preserved the way you asked.  You can keep asked for the
> same lines of code to be in different patches, but it isn't going to change
> the code.

Let me try to make this more clear then.

This is about keeping patches reviewable and about making one change per patch.

More precisely, move all code related to MMC_CAP_DIRECT_COMPLETE (the
new cap which you introduce in this patch), into a separate patch on
top of this one. That makes it both easy to review this patch, but
also the one that introduces the new cap.

>
>>
>> No I am giving up reaching this point. I didn't even get the actual
>> blkmq converting part, which is the core part I should be spending my
>> time to review. Sorry!
>
> It looks much more like you are not trying.  Not a single technical issue
> raised!  Not a single technical question!
>
>>
>> Some final comments around the system-wide PM support below.
>>
>> [...]
>>
>>>
>>> +static void mmc_mq_queue_suspend(struct mmc_queue *mq)
>>> +{
>>> +       blk_mq_quiesce_queue(mq->queue);
>>> +
>>> +       /*
>>> +        * The host remains claimed while there are outstanding requests, so
>>> +        * simply claiming and releasing here ensures there are none.
>>> +        */
>>> +       mmc_claim_host(mq->card->host);
>>> +       mmc_release_host(mq->card->host);
>>
>> This looks fragile.
>
> It isn't.  The driver would already be broken if we could have requests in
> flight but not have the host claimed.

Yes, but this boils done to that I am not sure what
blk_mq_quiesce_queue() really means from dispatching point of view.

Would it possible that a dispatched request became preempted just
before we was about to call mmc_claim_host() for it, thus the above
mmc_claim_host() claims the host before?

Are you sure that can't happen?

>
>>
>> Seems like an interface in blkmq with flushes the queue and suspend it
>> is missing, however there are of course reasons why it doesn't exist.
>>
>> I assume the blk_mq_quiesce_queue() guarantees no new requests is
>> being pushed to us after calling it, but it still seem a bit racy to
>> rely on the host claim/release thing.
>
> Race with what?

See above.

>
>>
>> Let's bring this up as question for the block people experts.
>
> You have had almost a year to learn about blk-mq.  What have you been doing?

Sorry, I haven't looked closely enough at the PM support. Obviously my bad.

>
> And what are you going to do to get an answer from "the block people
> experts" - there is a good chance few of those cc'ed will read this.
>
> This all looks like a weak excuse to do nothing.
>
> You need to stop playing games.  If you are not prepared to put the effort
> in, then let the CQE code go in.  After all the dependency is a figment of
> your imagination.  CQE has been ready to go for ages.  Why are you making up
> reasons for delaying it?
>
> Another possibility is to make me maintainer of the block driver since it
> seems I am the one that knows most about it.

Adrian, I have appreciated your contributions to mmc under a very long
time, and I still am. I don't doubt your expertise in the area!

However, it seems like you don't want to listen to peoples opinions
regarding this series - and I really don't get what's the deal. A man
of your skills should easily be able to address those comments, but
you have mostly been arguing and chosen to ignore them.

As long as I have something to say in this community, I will never
accept poorly written patches, at least that goes for the mmc core
layer.

That said, if other people think are better suited than me, please go
ahead and make a formal suggestion.

Kind regards
Uffe
