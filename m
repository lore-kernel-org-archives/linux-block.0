Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:41196 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdK0LXQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Nov 2017 06:23:16 -0500
Received: by mail-it0-f46.google.com with SMTP id x28so20523464ita.0
        for <linux-block@vger.kernel.org>; Mon, 27 Nov 2017 03:23:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1d7de4aa-f528-c3f8-bfc4-7d69301f8591@intel.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
 <1511271770-3444-14-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFrA5NVQ2Ei7rf7o7N0iHCHLHkntObnPP9hjToKrLr-TAg@mail.gmail.com> <1d7de4aa-f528-c3f8-bfc4-7d69301f8591@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 27 Nov 2017 12:23:14 +0100
Message-ID: <CAPDyKFr8tiJXSL-weQjGJ3DfRrfv8ZAFY8=ZECLNgSe_43S8Rw@mail.gmail.com>
Subject: Re: [PATCH V14 13/24] mmc: block: Add blk-mq support
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
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 27 November 2017 at 11:20, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 24/11/17 12:12, Ulf Hansson wrote:
>> [...]
>>
>>> +/* Single sector read during recovery */
>>> +static void mmc_blk_ss_read(struct mmc_queue *mq, struct request *req)
>>
>> Nitpick: I think mmc_blk_read_single() would be better as it is a more
>> clear name. Would you mind changing it?
>>
>>> +{
>>> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>>> +       blk_status_t status;
>>> +
>>> +       while (1) {
>>> +               mmc_blk_rw_rq_prep(mqrq, mq->card, 1, mq);
>>> +
>>> +               mmc_wait_for_req(mq->card->host, &mqrq->brq.mrq);
>>> +
>>> +               /*
>>> +                * Not expecting command errors, so just give up in that case.
>>> +                * If there are retries remaining, the request will get
>>> +                * requeued.
>>> +                */
>>> +               if (mqrq->brq.cmd.error)
>>> +                       return;
>>
>> What happens here if the reason to the error is because the card was removed?
>
> Assuming the rescan is waiting for the host claim, the next read / write
> request will end up calling mmc_detect_card_removed() in the recovery.
> After that all following requests will error immediately because
> mmc_mq_queue_rq() calls mmc_card_removed().

Yep, that seems reasonable. I have also tested this, so it seems to
work as expected and similar as before.

>
>>
>> I guess next time __blk_err_check() is called from the
>> mmc_blk_mq_rw_recovery(), this will be detected and managed?
>>
>>> +
>>> +               if (blk_rq_bytes(req) <= 512)
>>
>> Shouldn't you check "if (blk_rq_bytes(req) <  512)"? How would you
>> otherwise read the last 512 bytes block?
>
> At this point we have read the last sector but not updated the request, so
> the number of bytes left should be 512.  The reason we don't update the
> request is so that the logic in mmc_blk_mq_complete_rq() will work.  I will
> add a comment.

Not sure I get that, but I assume the comment will help me understand. :-)

>
>>
>>> +                       break;
>>> +
>>> +               status = mqrq->brq.data.error ? BLK_STS_IOERR : BLK_STS_OK;
>>> +
>>> +               blk_update_request(req, status, 512);
>>
>> Shouldn't we actually bail out, unless the error is a data ECC error?
>> On the other hand, I guess if it a more severe error, cmd.error will
>> anyway be set above!?
>>
>> One more question, if there is a data error, we may want to try to
>> recover by sending a stop command? How do we manage that?
>
> I was thinking a single-block read would not need a stop.  I will think
> some more about error handling here.

Great!

Anyway, you may be right -  and perhaps it may not be worth adding
error handling, especially if it complicates the code a lot.

[...]

>>> +static void mmc_blk_mq_acct_req_done(struct mmc_queue *mq, struct request *req)
>>
>> Nitpick: Can we please try to find a better name for this function. I
>> don't think "acct" is good abbreviation because, to me, it's not
>> self-explaining.
>
> What about mmc_blk_mq_decrement_in_flight() ?

Looks good, or perhaps even: mmc_blk_mq_dec_in_flight().

>
>>
>>> +{
>>> +       struct request_queue *q = req->q;
>>> +       unsigned long flags;
>>> +       bool put_card;
>>> +
>>> +       spin_lock_irqsave(q->queue_lock, flags);
>>> +
>>> +       mq->in_flight[mmc_issue_type(mq, req)] -= 1;
>>> +
>>> +       put_card = (mmc_tot_in_flight(mq) == 0);
>>> +
>>> +       spin_unlock_irqrestore(q->queue_lock, flags);
>>> +
>>> +       if (put_card)
>>> +               mmc_put_card(mq->card, &mq->ctx);
>>
>> I have tried to convince myself that the protection of calling
>> mmc_get|put_card() is safe, but I am not sure.
>>
>> I am wondering whether there could be races for mmc_get|put_card().
>> Please see some more related comments below.
>
> mmc_put_card() is safe and necessary if we have seen mmc_tot_in_flight(mq)
> == 0.  When the next request arrives it will have to do a mmc_get_card()
> because it is changing the number of requests in flight from 0 to 1.  It
> doesn't matter if that mmc_get_card() comes before or after or during this
> mmc_put_card().
>
>>
>> [...]

[...]

>>
>> Anyway, then if using a queue_depth of 64, how will you make sure that
>> you not end up having > 1 requests being prepared at the same time
>> (not counting the one that may be in transfer)?
>
> We are currently single-threaded since every request goes through
> hctx->run_work when BLK_MQ_F_BLOCKING and nr_hw_queues == 1.  It might be
> worth adding a mutex to ensure that never changes.
>
> This point also answers some of the questions below, since there can be no
> parallel dispatches.

Yeah, it clearly does. Thanks!

>>> +
>>> +enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
>>> +{
>>> +       struct mmc_blk_data *md = mq->blkdata;
>>> +       struct mmc_card *card = md->queue.card;
>>> +       struct mmc_host *host = card->host;
>>> +       int ret;
>>> +
>>> +       ret = mmc_blk_part_switch(card, md->part_type);
>>
>> What if there is an ongoing request, shouldn't you wait for that to
>> complete before switching partition?
>
> Two requests on the same queue cannot be on different partitions because we
> have a different queue (and block device) for each partition.

That's not true for RPMB anymore I am afraid.

RPMB shares the same queue as for the main eMMC partition, which is
because we strive towards fair I/O scheduling across the hole device.

>
>>
>>> +       if (ret)
>>> +               return MMC_REQ_FAILED_TO_START;
>>> +
>>> +       switch (mmc_issue_type(mq, req)) {
>>> +       case MMC_ISSUE_SYNC:
>>> +               ret = mmc_blk_wait_for_idle(mq, host);
>>> +               if (ret)
>>> +                       return MMC_REQ_BUSY;
>>
>> Wouldn't it be possible that yet a new SYNC request becomes queued in
>> parallel with this current one. Then, when reaching this point, how do
>> you make sure that new request waits for the current "SYNC" request?
>
> As mentioned above, there are no parallel dispatches.
>
>>
>> I mean is the above mmc_blk_wait_for_idle(), really sufficient to deal
>> with synchronization?
>
> So long as there are no parallel dispatches.
>
>>
>> I guess we could use mmc_claim_host(no-ctx) in some clever way to deal
>> with this, or perhaps there is a better option?
>
> We are relying on there being no parallel dispatches.  That is the case now,
> but if it weren't we could use a mutex in mmc_mq_queue_rq().
>

Yeah, but then leave that until needed.

>>
>> BTW, I guess the problem is also present if there is SYNC request
>> ongoing and then is a new ASYNC request coming in. Is the ASYNC
>> request really waiting for the SYNC request to finish?
>
> With no parallel dispatches, the SYNC request runs to completion before
> another request can be dispatched.

Yes, I get it now. Thanks for clarifying this!

[...]

>>> +static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>>> +                                   const struct blk_mq_queue_data *bd)
>>> +{
>>> +       struct request *req = bd->rq;
>>> +       struct request_queue *q = req->q;
>>> +       struct mmc_queue *mq = q->queuedata;
>>> +       struct mmc_card *card = mq->card;
>>> +       enum mmc_issue_type issue_type;
>>> +       enum mmc_issued issued;
>>> +       bool get_card;
>>> +       int ret;
>>> +
>>> +       if (mmc_card_removed(mq->card)) {
>>> +               req->rq_flags |= RQF_QUIET;
>>> +               return BLK_STS_IOERR;
>>> +       }
>>> +
>>> +       issue_type = mmc_issue_type(mq, req);
>>> +
>>> +       spin_lock_irq(q->queue_lock);
>>> +
>>> +       switch (issue_type) {
>>> +       case MMC_ISSUE_ASYNC:
>>> +               break;
>>> +       default:
>>> +               /*
>>> +                * Timeouts are handled by mmc core, and we don't have a host
>>> +                * API to abort requests, so we can't handle the timeout anyway.
>>> +                * However, when the timeout happens, blk_mq_complete_request()
>>> +                * no longer works (to stop the request disappearing under us).
>>> +                * To avoid racing with that, set a large timeout.
>>> +                */
>>> +               req->timeout = 600 * HZ;
>>> +               break;
>>> +       }
>>> +
>>> +       mq->in_flight[issue_type] += 1;
>>> +       get_card = (mmc_tot_in_flight(mq) == 1);
>>> +
>>> +       spin_unlock_irq(q->queue_lock);
>>> +
>>> +       if (!(req->rq_flags & RQF_DONTPREP)) {
>>> +               req_to_mmc_queue_req(req)->retries = 0;
>>> +               req->rq_flags |= RQF_DONTPREP;
>>> +       }
>>> +
>>> +       if (get_card)
>>
>> Coming back to the get_card() thingy, which I wonder if it's fragile.
>>
>> A request that finds get_card == true here, doesn't necessarily have
>> to reach to this point first (the task may be preempted), in case
>> there is another request being queued in parallel (or that can't
>> happen?).
>>
>> That could then lead to that the following steps become executed for
>> the other requests, prior anybody calling mmc_get_card().
>
> You are right, this logic does not support parallel dispatches.
>

This do raises a question, don't you think it would be beneficial,
especially for CQE to allow parallel dispatches?

I am not saying we should change this at this point, just that we may
consider changing this for future improvements.

[...]

Kind regards
Uffe
