Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:39219 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751506AbdK0KUv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Nov 2017 05:20:51 -0500
From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V14 13/24] mmc: block: Add blk-mq support
To: Ulf Hansson <ulf.hansson@linaro.org>
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
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
 <1511271770-3444-14-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFrA5NVQ2Ei7rf7o7N0iHCHLHkntObnPP9hjToKrLr-TAg@mail.gmail.com>
Message-ID: <1d7de4aa-f528-c3f8-bfc4-7d69301f8591@intel.com>
Date: Mon, 27 Nov 2017 12:20:28 +0200
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrA5NVQ2Ei7rf7o7N0iHCHLHkntObnPP9hjToKrLr-TAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 24/11/17 12:12, Ulf Hansson wrote:
> [...]
> 
>> +/* Single sector read during recovery */
>> +static void mmc_blk_ss_read(struct mmc_queue *mq, struct request *req)
> 
> Nitpick: I think mmc_blk_read_single() would be better as it is a more
> clear name. Would you mind changing it?
> 
>> +{
>> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>> +       blk_status_t status;
>> +
>> +       while (1) {
>> +               mmc_blk_rw_rq_prep(mqrq, mq->card, 1, mq);
>> +
>> +               mmc_wait_for_req(mq->card->host, &mqrq->brq.mrq);
>> +
>> +               /*
>> +                * Not expecting command errors, so just give up in that case.
>> +                * If there are retries remaining, the request will get
>> +                * requeued.
>> +                */
>> +               if (mqrq->brq.cmd.error)
>> +                       return;
> 
> What happens here if the reason to the error is because the card was removed?

Assuming the rescan is waiting for the host claim, the next read / write
request will end up calling mmc_detect_card_removed() in the recovery.
After that all following requests will error immediately because
mmc_mq_queue_rq() calls mmc_card_removed().

> 
> I guess next time __blk_err_check() is called from the
> mmc_blk_mq_rw_recovery(), this will be detected and managed?
> 
>> +
>> +               if (blk_rq_bytes(req) <= 512)
> 
> Shouldn't you check "if (blk_rq_bytes(req) <  512)"? How would you
> otherwise read the last 512 bytes block?

At this point we have read the last sector but not updated the request, so
the number of bytes left should be 512.  The reason we don't update the
request is so that the logic in mmc_blk_mq_complete_rq() will work.  I will
add a comment.

> 
>> +                       break;
>> +
>> +               status = mqrq->brq.data.error ? BLK_STS_IOERR : BLK_STS_OK;
>> +
>> +               blk_update_request(req, status, 512);
> 
> Shouldn't we actually bail out, unless the error is a data ECC error?
> On the other hand, I guess if it a more severe error, cmd.error will
> anyway be set above!?
> 
> One more question, if there is a data error, we may want to try to
> recover by sending a stop command? How do we manage that?

I was thinking a single-block read would not need a stop.  I will think
some more about error handling here.

> 
>> +       }
>> +
>> +       mqrq->retries = MMC_NO_RETRIES;
>> +}
>> +
>> +static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
>> +{
>> +       int type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
>> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>> +       struct mmc_blk_request *brq = &mqrq->brq;
>> +       struct mmc_blk_data *md = mq->blkdata;
>> +       struct mmc_card *card = mq->card;
>> +       static enum mmc_blk_status status;
>> +
>> +       brq->retune_retry_done = mqrq->retries;
>> +
>> +       status = __mmc_blk_err_check(card, mqrq);
>> +
>> +       mmc_retune_release(card->host);
>> +
>> +       /*
>> +        * Requests are completed by mmc_blk_mq_complete_rq() which sets simple
>> +        * policy:
>> +        * 1. A request that has transferred at least some data is considered
>> +        * successful and will be requeued if there is remaining data to
>> +        * transfer.
>> +        * 2. Otherwise the number of retries is incremented and the request
>> +        * will be requeued if there are remaining retries.
>> +        * 3. Otherwise the request will be errored out.
>> +        * That means mmc_blk_mq_complete_rq() is controlled by bytes_xfered and
>> +        * mqrq->retries. So there are only 4 possible actions here:
>> +        *      1. do not accept the bytes_xfered value i.e. set it to zero
>> +        *      2. change mqrq->retries to determine the number of retries
>> +        *      3. try to reset the card
>> +        *      4. read one sector at a time
>> +        */
>> +       switch (status) {
>> +       case MMC_BLK_SUCCESS:
>> +       case MMC_BLK_PARTIAL:
>> +               /* Reset success, and accept bytes_xfered */
>> +               mmc_blk_reset_success(md, type);
>> +               break;
>> +       case MMC_BLK_CMD_ERR:
>> +               /*
>> +                * For SD cards, get bytes written, but do not accept
>> +                * bytes_xfered if that fails. For MMC cards accept
>> +                * bytes_xfered. Then try to reset. If reset fails then
>> +                * error out the remaining request, otherwise retry
>> +                * once (N.B mmc_blk_reset() will not succeed twice in a
>> +                * row).
>> +                */
>> +               if (mmc_card_sd(card)) {
>> +                       u32 blocks;
>> +                       int err;
>> +
>> +                       err = mmc_sd_num_wr_blocks(card, &blocks);
>> +                       if (err)
>> +                               brq->data.bytes_xfered = 0;
>> +                       else
>> +                               brq->data.bytes_xfered = blocks << 9;
>> +               }
>> +               if (mmc_blk_reset(md, card->host, type))
>> +                       mqrq->retries = MMC_NO_RETRIES;
>> +               else
>> +                       mqrq->retries = MMC_MAX_RETRIES - 1;
>> +               break;
>> +       case MMC_BLK_RETRY:
>> +               /*
>> +                * Do not accept bytes_xfered, but retry up to 5 times,
>> +                * otherwise same as abort.
>> +                */
>> +               brq->data.bytes_xfered = 0;
>> +               if (mqrq->retries < MMC_MAX_RETRIES)
>> +                       break;
>> +               /* Fall through */
>> +       case MMC_BLK_ABORT:
>> +               /*
>> +                * Do not accept bytes_xfered, but try to reset. If
>> +                * reset succeeds, try once more, otherwise error out
>> +                * the request.
>> +                */
>> +               brq->data.bytes_xfered = 0;
>> +               if (mmc_blk_reset(md, card->host, type))
>> +                       mqrq->retries = MMC_NO_RETRIES;
>> +               else
>> +                       mqrq->retries = MMC_MAX_RETRIES - 1;
>> +               break;
>> +       case MMC_BLK_DATA_ERR: {
>> +               int err;
>> +
>> +               /*
>> +                * Do not accept bytes_xfered, but try to reset. If
>> +                * reset succeeds, try once more. If reset fails with
>> +                * ENODEV which means the partition is wrong, then error
>> +                * out the request. Otherwise attempt to read one sector
>> +                * at a time.
>> +                */
>> +               brq->data.bytes_xfered = 0;
>> +               err = mmc_blk_reset(md, card->host, type);
>> +               if (!err) {
>> +                       mqrq->retries = MMC_MAX_RETRIES - 1;
>> +                       break;
>> +               }
>> +               if (err == -ENODEV) {
>> +                       mqrq->retries = MMC_NO_RETRIES;
>> +                       break;
>> +               }
>> +               /* Fall through */
>> +       }
>> +       case MMC_BLK_ECC_ERR:
>> +               /*
>> +                * Do not accept bytes_xfered. If reading more than one
>> +                * sector, try reading one sector at a time.
>> +                */
>> +               brq->data.bytes_xfered = 0;
>> +               /* FIXME: Missing single sector read for large sector size */
>> +               if (brq->data.blocks > 1 && !mmc_large_sector(card)) {
>> +                       /* Redo read one sector at a time */
>> +                       pr_warn("%s: retrying using single block read\n",
>> +                               req->rq_disk->disk_name);
>> +                       mmc_blk_ss_read(mq, req);
>> +               } else {
>> +                       mqrq->retries = MMC_NO_RETRIES;
>> +               }
>> +               break;
>> +       case MMC_BLK_NOMEDIUM:
>> +               /* Do not accept bytes_xfered. Error out the request */
>> +               brq->data.bytes_xfered = 0;
>> +               mqrq->retries = MMC_NO_RETRIES;
>> +               break;
>> +       default:
>> +               /* Do not accept bytes_xfered. Error out the request */
>> +               brq->data.bytes_xfered = 0;
>> +               mqrq->retries = MMC_NO_RETRIES;
>> +               pr_err("%s: Unhandled return value (%d)",
>> +                      req->rq_disk->disk_name, status);
>> +               break;
>> +       }
>> +}
>> +
> 
> [...]
> 
>> +
>> +static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
>> +                                      struct request *req)
>> +{
>> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>> +
>> +       mmc_blk_mq_rw_recovery(mq, req);
>> +
>> +       mmc_blk_urgent_bkops(mq, mqrq);
>> +}
>> +
>> +static void mmc_blk_mq_acct_req_done(struct mmc_queue *mq, struct request *req)
> 
> Nitpick: Can we please try to find a better name for this function. I
> don't think "acct" is good abbreviation because, to me, it's not
> self-explaining.

What about mmc_blk_mq_decrement_in_flight() ?

> 
>> +{
>> +       struct request_queue *q = req->q;
>> +       unsigned long flags;
>> +       bool put_card;
>> +
>> +       spin_lock_irqsave(q->queue_lock, flags);
>> +
>> +       mq->in_flight[mmc_issue_type(mq, req)] -= 1;
>> +
>> +       put_card = (mmc_tot_in_flight(mq) == 0);
>> +
>> +       spin_unlock_irqrestore(q->queue_lock, flags);
>> +
>> +       if (put_card)
>> +               mmc_put_card(mq->card, &mq->ctx);
> 
> I have tried to convince myself that the protection of calling
> mmc_get|put_card() is safe, but I am not sure.
> 
> I am wondering whether there could be races for mmc_get|put_card().
> Please see some more related comments below.

mmc_put_card() is safe and necessary if we have seen mmc_tot_in_flight(mq)
== 0.  When the next request arrives it will have to do a mmc_get_card()
because it is changing the number of requests in flight from 0 to 1.  It
doesn't matter if that mmc_get_card() comes before or after or during this
mmc_put_card().

> 
> [...]
> 
>> +static void mmc_blk_mq_req_done(struct mmc_request *mrq)
>> +{
>> +       struct mmc_queue_req *mqrq = container_of(mrq, struct mmc_queue_req,
>> +                                                 brq.mrq);
>> +       struct request *req = mmc_queue_req_to_req(mqrq);
>> +       struct request_queue *q = req->q;
>> +       struct mmc_queue *mq = q->queuedata;
>> +       unsigned long flags;
>> +       bool waiting;
>> +
>> +       spin_lock_irqsave(q->queue_lock, flags);
>> +       mq->complete_req = req;
>> +       mq->rw_wait = false;
>> +       waiting = mq->waiting;
> 
> The synchronization methods is one of the most complex part of
> $subject patch, yet also very elegant!
> 
> Anyway, would you mind adding some more comments here and there in the
> code, to explain a bit about what goes on and why?

Ok

> 
>> +       spin_unlock_irqrestore(q->queue_lock, flags);
>> +
>> +       if (waiting)
>> +               wake_up(&mq->wait);
> 
> For example, a comment here about: "In case there is a new request
> prepared, leave it to that, to deal with finishing and post processing
> of the request, else schedule a work to do it - and see what comes
> first."

Ok

> 
>> +       else
>> +               kblockd_schedule_work(&mq->complete_work);
>> +}
>> +
>> +static bool mmc_blk_rw_wait_cond(struct mmc_queue *mq, int *err)
>> +{
>> +       struct request_queue *q = mq->queue;
>> +       unsigned long flags;
>> +       bool done;
>> +
>> +       spin_lock_irqsave(q->queue_lock, flags);
>> +       done = !mq->rw_wait;
>> +       mq->waiting = !done;
> 
> Also here it would be nice with some comments about the
> synchronization. I stop from mentioning this from now on, because it
> applies to a couple of more places.
> 
> I leave it to you to decide how and where it makes sense to add these
> kind of comments.
> 
>> +       spin_unlock_irqrestore(q->queue_lock, flags);
>> +
>> +       return done;
>> +}
>> +
>> +static int mmc_blk_rw_wait(struct mmc_queue *mq, struct request **prev_req)
>> +{
>> +       int err = 0;
>> +
>> +       wait_event(mq->wait, mmc_blk_rw_wait_cond(mq, &err));
>> +
>> +       mmc_blk_mq_complete_prev_req(mq, prev_req);
>> +
>> +       return err;
>> +}
>> +
>> +static int mmc_blk_mq_issue_rw_rq(struct mmc_queue *mq,
>> +                                 struct request *req)
>> +{
>> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>> +       struct mmc_host *host = mq->card->host;
>> +       struct request *prev_req = NULL;
>> +       int err = 0;
>> +
>> +       mmc_blk_rw_rq_prep(mqrq, mq->card, 0, mq);
>> +
>> +       mqrq->brq.mrq.done = mmc_blk_mq_req_done;
>> +
>> +       mmc_pre_req(host, &mqrq->brq.mrq);
> 
> To be honest, using a queue_depth of 64, puzzles me! According to my
> understanding we should use a queue_depth of 2, in case the host
> implements the ->pre|post_req() callbacks, else we should set it to 1.
> 
> Although I may be missing some information about how to really use
> this, because for example UBI (mtd) also uses 64 as queue depth!?
> 
> My interpretation of the queue_depth is that the blkmq layer will use
> it to understand the maximum number of request a block device are able
> to operate on simultaneously (when having one HW queue), thus the
> number of outstanding dispatched requests for the block evice driver,
> may be as close as possible to the queue_depth, but never above. I may
> be totally wrong about this. :-)

For blk-mq, the queue_depth also defines the default nr_requests, which will
be 2 times the queue_depth if there is an elevator.  The old nr_requests was
128, so setting 64 gives the same nr_requests as before.

Otherwise the queue_depth is the size of the tag set.

A very low queue_depth might be a problem for I/O schedulers like kyber
which seems to try to limit the number of tags available for asynchronous
requests.

> 
> Anyway, then if using a queue_depth of 64, how will you make sure that
> you not end up having > 1 requests being prepared at the same time
> (not counting the one that may be in transfer)?

We are currently single-threaded since every request goes through
hctx->run_work when BLK_MQ_F_BLOCKING and nr_hw_queues == 1.  It might be
worth adding a mutex to ensure that never changes.

This point also answers some of the questions below, since there can be no
parallel dispatches.

> 
>>
>> +       err = mmc_blk_rw_wait(mq, &prev_req);
>> +       if (err)
>> +               goto out_post_req;
>> +
>> +       mq->rw_wait = true;
>> +
>> +       err = mmc_start_request(host, &mqrq->brq.mrq);
>> +
>> +       if (prev_req)
>> +               mmc_blk_mq_post_req(mq, prev_req);
>> +
>> +       if (err) {
>> +               mq->rw_wait = false;
>> +               mmc_retune_release(host);
>> +       }
>> +
>> +out_post_req:
>> +       if (err)
>> +               mmc_post_req(host, &mqrq->brq.mrq, err);
>> +
>> +       return err;
>> +}
>> +
>> +static int mmc_blk_wait_for_idle(struct mmc_queue *mq, struct mmc_host *host)
>> +{
>> +       return mmc_blk_rw_wait(mq, NULL);
>> +}
>> +
>> +enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
>> +{
>> +       struct mmc_blk_data *md = mq->blkdata;
>> +       struct mmc_card *card = md->queue.card;
>> +       struct mmc_host *host = card->host;
>> +       int ret;
>> +
>> +       ret = mmc_blk_part_switch(card, md->part_type);
> 
> What if there is an ongoing request, shouldn't you wait for that to
> complete before switching partition?

Two requests on the same queue cannot be on different partitions because we
have a different queue (and block device) for each partition.

> 
>> +       if (ret)
>> +               return MMC_REQ_FAILED_TO_START;
>> +
>> +       switch (mmc_issue_type(mq, req)) {
>> +       case MMC_ISSUE_SYNC:
>> +               ret = mmc_blk_wait_for_idle(mq, host);
>> +               if (ret)
>> +                       return MMC_REQ_BUSY;
> 
> Wouldn't it be possible that yet a new SYNC request becomes queued in
> parallel with this current one. Then, when reaching this point, how do
> you make sure that new request waits for the current "SYNC" request?

As mentioned above, there are no parallel dispatches.

> 
> I mean is the above mmc_blk_wait_for_idle(), really sufficient to deal
> with synchronization?

So long as there are no parallel dispatches.

> 
> I guess we could use mmc_claim_host(no-ctx) in some clever way to deal
> with this, or perhaps there is a better option?

We are relying on there being no parallel dispatches.  That is the case now,
but if it weren't we could use a mutex in mmc_mq_queue_rq().

> 
> BTW, I guess the problem is also present if there is SYNC request
> ongoing and then is a new ASYNC request coming in. Is the ASYNC
> request really waiting for the SYNC request to finish?

With no parallel dispatches, the SYNC request runs to completion before
another request can be dispatched.

> 
> Or maybe I just missed these parts in $subject patch.
> 
>> +               switch (req_op(req)) {
>> +               case REQ_OP_DRV_IN:
>> +               case REQ_OP_DRV_OUT:
>> +                       mmc_blk_issue_drv_op(mq, req);
>> +                       break;
>> +               case REQ_OP_DISCARD:
>> +                       mmc_blk_issue_discard_rq(mq, req);
>> +                       break;
>> +               case REQ_OP_SECURE_ERASE:
>> +                       mmc_blk_issue_secdiscard_rq(mq, req);
>> +                       break;
>> +               case REQ_OP_FLUSH:
>> +                       mmc_blk_issue_flush(mq, req);
>> +                       break;
>> +               default:
>> +                       WARN_ON_ONCE(1);
>> +                       return MMC_REQ_FAILED_TO_START;
>> +               }
>> +               return MMC_REQ_FINISHED;
>> +       case MMC_ISSUE_ASYNC:
>> +               switch (req_op(req)) {
>> +               case REQ_OP_READ:
>> +               case REQ_OP_WRITE:
>> +                       ret = mmc_blk_mq_issue_rw_rq(mq, req);
>> +                       break;
>> +               default:
>> +                       WARN_ON_ONCE(1);
>> +                       ret = -EINVAL;
>> +               }
>> +               if (!ret)
>> +                       return MMC_REQ_STARTED;
>> +               return ret == -EBUSY ? MMC_REQ_BUSY : MMC_REQ_FAILED_TO_START;
>> +       default:
>> +               WARN_ON_ONCE(1);
>> +               return MMC_REQ_FAILED_TO_START;
>> +       }
>> +}
>> +
> 
> [...]
> 
>> +static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>> +                                   const struct blk_mq_queue_data *bd)
>> +{
>> +       struct request *req = bd->rq;
>> +       struct request_queue *q = req->q;
>> +       struct mmc_queue *mq = q->queuedata;
>> +       struct mmc_card *card = mq->card;
>> +       enum mmc_issue_type issue_type;
>> +       enum mmc_issued issued;
>> +       bool get_card;
>> +       int ret;
>> +
>> +       if (mmc_card_removed(mq->card)) {
>> +               req->rq_flags |= RQF_QUIET;
>> +               return BLK_STS_IOERR;
>> +       }
>> +
>> +       issue_type = mmc_issue_type(mq, req);
>> +
>> +       spin_lock_irq(q->queue_lock);
>> +
>> +       switch (issue_type) {
>> +       case MMC_ISSUE_ASYNC:
>> +               break;
>> +       default:
>> +               /*
>> +                * Timeouts are handled by mmc core, and we don't have a host
>> +                * API to abort requests, so we can't handle the timeout anyway.
>> +                * However, when the timeout happens, blk_mq_complete_request()
>> +                * no longer works (to stop the request disappearing under us).
>> +                * To avoid racing with that, set a large timeout.
>> +                */
>> +               req->timeout = 600 * HZ;
>> +               break;
>> +       }
>> +
>> +       mq->in_flight[issue_type] += 1;
>> +       get_card = (mmc_tot_in_flight(mq) == 1);
>> +
>> +       spin_unlock_irq(q->queue_lock);
>> +
>> +       if (!(req->rq_flags & RQF_DONTPREP)) {
>> +               req_to_mmc_queue_req(req)->retries = 0;
>> +               req->rq_flags |= RQF_DONTPREP;
>> +       }
>> +
>> +       if (get_card)
> 
> Coming back to the get_card() thingy, which I wonder if it's fragile.
> 
> A request that finds get_card == true here, doesn't necessarily have
> to reach to this point first (the task may be preempted), in case
> there is another request being queued in parallel (or that can't
> happen?).
> 
> That could then lead to that the following steps become executed for
> the other requests, prior anybody calling mmc_get_card().

You are right, this logic does not support parallel dispatches.

> 
>> +               mmc_get_card(card, &mq->ctx);
>> +
>> +       blk_mq_start_request(req);
>> +
>> +       issued = mmc_blk_mq_issue_rq(mq, req);
>> +
>> +       switch (issued) {
>> +       case MMC_REQ_BUSY:
>> +               ret = BLK_STS_RESOURCE;
>> +               break;
>> +       case MMC_REQ_FAILED_TO_START:
>> +               ret = BLK_STS_IOERR;
>> +               break;
>> +       default:
>> +               ret = BLK_STS_OK;
>> +               break;
>> +       }
>> +
>> +       if (issued != MMC_REQ_STARTED) {
>> +               bool put_card = false;
>> +
>> +               spin_lock_irq(q->queue_lock);
>> +               mq->in_flight[issue_type] -= 1;
>> +               if (mmc_tot_in_flight(mq) == 0)
>> +                       put_card = true;
>> +               spin_unlock_irq(q->queue_lock);
>> +               if (put_card)
>> +                       mmc_put_card(card, &mq->ctx);
> 
> For the similar reasons as above, this also looks fragile.
> 
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static const struct blk_mq_ops mmc_mq_ops = {
>> +       .queue_rq       = mmc_mq_queue_rq,
>> +       .init_request   = mmc_mq_init_request,
>> +       .exit_request   = mmc_mq_exit_request,
>> +       .complete       = mmc_blk_mq_complete,
>> +       .timeout        = mmc_mq_timed_out,
>> +};
> 
> [...]
> 
>> +#define MMC_QUEUE_DEPTH 64
>> +
>> +static int mmc_mq_init(struct mmc_queue *mq, struct mmc_card *card,
>> +                        spinlock_t *lock)
>> +{
>> +       int q_depth;
>> +       int ret;
>> +
>> +       q_depth = MMC_QUEUE_DEPTH;
> 
> I already mentioned my thoughts around the queue_depth... and again I
> may be totally wrong. :-)
> 
>> +
>> +       ret = mmc_mq_init_queue(mq, q_depth, &mmc_mq_ops, lock);
>> +       if (ret)
>> +               return ret;
>> +
>> +       blk_queue_rq_timeout(mq->queue, 60 * HZ);
>> +
>> +       mmc_setup_queue(mq, card);
>> +
>> +       return 0;
>>  }
> 
> [...]
> 
> Kind regards
> Uffe
> 
